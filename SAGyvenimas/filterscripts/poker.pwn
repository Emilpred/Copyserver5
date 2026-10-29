/*
    ============================================================
     TEXAS HOLD'EM POKER  -  standalone SA:MP filterscript
    ------------------------------------------------------------
     Extracted from the LSG gamemode (github.com/vsbenas/LSG):
       gamemodes/LSG/Activities/poker.inc      (game engine + textdraws)
       gamemodes/LSG.pwn                        (queues, H key, timer, ESC, disconnect)
       gamemodes/LSG/Callbacks/dialogs.inc      (buy-in + raise dialogs)
       gamemodes/LSG/Callbacks/admin_commands.inc (/pzutable, /blinds)
       gamemodes/LSG/constants.inc              (tables, seats, cameras, blinds)
       gamemodes/LSG/objektai.inc               (poker table objects)
       gamemodes/LSG/init.inc                   (3D labels)

     Requirements: streamer plugin (streamer.inc) in pawno/include.  Player statistics are stored in its own
     SQLite database  scriptfiles/poker.db  (created automatically,
     uses the built-in SA:MP db_* natives - no MySQL needed).
     Money is the EURO inventory item (via Poker_* publics in arizona.pwn).  Compile with pawncc, put poker.amx in
     filterscripts/ and add it to server.cfg / config.json.

     Carpeted floor slabs are created under all 5 tables so they work
     even outside the stock casino interiors (height: /pokerfloor).
     The 5 tables are in Caligula's Casino (interior 1) and the
     Four Dragons Casino (interior 10).  Walk up to a table and
     press the join key (see POKER_KEY), type /pokeris, or /pokeris <amount>.
     ESC leaves the table.  /pokeris away from a table teleports you
     to the poker room.  /pokerstats shows your stats.
    ============================================================
*/
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>
// Commands: if your server runs the Pawn.CMD plugin (yours does), commands MUST be
// registered through it - plain OnPlayerCommandText is bypassed. Put Pawn.CMD.inc in
// pawno/include. If you do not use Pawn.CMD, comment the next line out and the
// script falls back to OnPlayerCommandText.
#define POKER_USE_PAWNCMD
#if defined POKER_USE_PAWNCMD
	#include <Pawn.CMD>
#endif

// ---------------- configuration ----------------
#define POKER_MIN_SCORE          0        // original LSG required 100 XP (GetPlayerScore)
// Writes "[POKER-DEBUG] ..." lines to the server console / server_log.txt for
// every join step. Set to 0 once everything works.
#define POKER_DEBUG              1
// Key that opens the buy-in prompt when standing next to a table.
// LSG used H (KEY_CTRL_BACK) but most gamemodes bind H to something else (shop,
// engine, ...) and a filterscript cannot stop the gamemode from reacting too.
// Default is Y. Other options: KEY_NO (N), KEY_SECONDARY_ATTACK (Enter/F), KEY_WALK (Alt).
// POKER_KEY_NAME is only what is shown to players in labels and messages.
// NOTE: SA-MP scripts cannot see letter keys like K - only bound game controls
// (KEY_YES=Y, KEY_NO=N, KEY_CTRL_BACK=H, KEY_SECONDARY_ATTACK=Enter/F, KEY_WALK=Alt ...).
#define POKER_KEY                KEY_NO
#define POKER_KEY_NAME           "N"
// /pokeris next to a table does the same thing as the key.

// Dialog IDs. Must not be used by the gamemode or any other script.
// (7781/7782 were used before and collided with the gamemode's Discord/VK login
// dialogs - 7782 kicked the player with "Discord: ... neteisinga autorizavimo koda".)
// 32701/32702 are verified unused in arizona.pwn, library/ and filterscripts/.
// They must match POKER_DIALOG_BUYIN / POKER_DIALOG_RAISE in the gamemode.
#define POKER_DIALOG_BUYIN       32701
#define POKER_DIALOG_RAISE       32702
// Nex-AC kicks a player (cheat #39 "dialog hack") when the dialog he answers is not
// the one it last recorded for him. It records dialogs shown by the gamemode, and it
// exports a public for filterscripts to register theirs:
//     public ac_ShowPlayerDialog(playerid, dialogid)        (Nex-AC 1.9.54)
//     public ac_ShowPlayerDialog(playerid, dialogid, next)  (1.9.56 and newer)
// Every poker dialog is registered that way right before it is shown, so the
// anticheat accepts the answer. Nothing in the anticheat is disabled.
#if !defined POKER_NEXAC_REGISTER
	#define POKER_NEXAC_REGISTER 1
#endif
// Alternative route (only if your gamemode's own OnDialogResponse swallows answers to
// unknown dialogs): 1 = the gamemode shows the poker dialogs and forwards the answers.
// Requires #include "poker_gm" in the gamemode. Leave at 0 otherwise.
#if !defined POKER_DIALOGS_VIA_GAMEMODE
	#define POKER_DIALOGS_VIA_GAMEMODE 0
#endif
#if POKER_DEBUG
	#define PokerLog(%0) printf("[POKER-DEBUG] " %0)
#else
	#define PokerLog(%0)
#endif
// Which poker dialog is currently open for the player (-1 = none). An answer is only
// accepted for the dialog that is open, and closes it - so an answer that reaches this
// script twice (direct callback AND forwarded by the gamemode) is processed once, and
// stale/repeated submissions are ignored.
new PokerOpenDialog[MAX_PLAYERS] = {-1, ...};
stock PokerShowDialog(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	PokerOpenDialog[playerid] = dialogid;
	#if POKER_DIALOGS_VIA_GAMEMODE
	// SA-MP crashes the server if CallRemoteFunction gets an EMPTY string argument,
	// so every string passed here must be at least one character long.
	new b2[32]; format(b2, sizeof(b2), "%s", (button2[0] == EOS) ? (" ") : (button2));
	return CallRemoteFunction("PokerShowDialog", "iiissss", playerid, dialogid, style, caption, info, button1, b2);
	#else
	#if POKER_NEXAC_REGISTER
	// Register the dialog with Nex-AC (lives in the gamemode). Returns 0 harmlessly
	// if the gamemode has no Nex-AC. The 3rd argument is ignored by 1.9.54 and is
	// "next=0" for newer versions.
	new reg = CallRemoteFunction("ac_ShowPlayerDialog", "idi", playerid, dialogid, 0);
	PokerLog("dialog %d registered with Nex-AC for player %d: %s", dialogid, playerid, reg ? ("yes") : ("no (ac_ShowPlayerDialog not found)"));
	#endif
	return ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
	#endif
}
// closes any open dialog for the player (through the gamemode when configured so)
stock PokerHideDialog(playerid)
{
	return PokerShowDialog(playerid, -1, DIALOG_STYLE_MSGBOX, " ", " ", " ", " ");
}

// ---------------- money: the EURO inventory item ----------------
// Buy-ins are taken from the player's EURO item (inventory) and the table balance is
// returned as EURO when he leaves. The inventory lives in the gamemode, so these call
// the publics Poker_GetEuro / Poker_TakeEuro / Poker_GiveEuro added to arizona.pwn.
// Anything that cannot be credited (inventory full, player already logged out) is
// saved in scriptfiles/poker.db and paid automatically later - never lost.
#define POKER_API_VERSION 1
stock bool:PokerApiOK()
{
	return CallRemoteFunction("Poker_ApiVersion", "i", 0) == POKER_API_VERSION;
}
// EURO in the player's inventory; -1 if he is not logged in (or the gamemode lacks the API)
stock PokerCash(playerid)
{
	if(!PokerApiOK()) return -1;
	return CallRemoteFunction("Poker_GetEuro", "i", playerid);
}

// gamemode admin level of the player (0 = not an admin). Calls Poker_GetAdmin in arizona.pwn,
// so admin-only poker commands use the server's own admin system (level 1+), not RCON.
stock PokerAdminLevel(playerid)
{
	if(!PokerApiOK()) return 0;
	return CallRemoteFunction("Poker_GetAdmin", "i", playerid);
}
// removes EURO from the inventory; returns 1 only if exactly that amount was removed
stock PokerTake(playerid, amount)
{
	if(amount <= 0 || !PokerApiOK()) return 0;
	return CallRemoteFunction("Poker_TakeEuro", "ii", playerid, amount);
}
new PokerOwed[MAX_PLAYERS];       // EURO this player is still owed (see PokerPay)
forward PokerDB_SaveOwed(playerid);
// adds EURO to the inventory; whatever could not be added is kept as "owed"
stock PokerPay(playerid, amount)
{
	if(amount <= 0) return 1;
	new paid = 0;
	if(PokerApiOK()) paid = CallRemoteFunction("Poker_GiveEuro", "ii", playerid, amount);
	if(paid < 0) paid = 0;
	if(paid > amount) paid = amount;
	PokerLog("pay %d EURO to player %d: credited %d", amount, playerid, paid);
	if(paid < amount)
	{
		PokerOwed[playerid] += amount - paid;
		PokerDB_SaveOwed(playerid);
		printf("[POKER] %d EURO owed to player %d (inventory full or not logged in) - saved, will be paid later", amount - paid, playerid);
		if(IsPlayerConnected(playerid))
		{
			new m[144];
			format(m, sizeof(m), "[POKER] %s EURO netilpo i inventoriu - jie issaugoti ir bus grazinti automatiskai, kai atsiras vietos.", FormatNumber(amount - paid));
			SendClientMessage(playerid, 0xFFFFFFFF, m);
		}
	}
	return 1;
}

// Achievements existed in LSG; no-op here (hook your own system if you have one).
stock ProcessAchievement(playerid, achievement)
{
	#pragma unused playerid, achievement
	return 1;
}

#if !defined isnull
	#define isnull(%0) ((!(%0[0])) || (((%0[0]) == '\1') && (!(%0[1]))))
#endif
#define IsPlayerInRangeOfPointEx(%0,%1,%2,%3,%4) IsPlayerInRangeOfPoint(%1,%0,%2,%3,%4)

#define TEXTCOL_WHITE 0xFFFFFF30
#define TEXTCOL_GREEN 0x98B13490
#define TEXTCOL_GOLD  0xE3B92430
#define COLOR_PILKA   0xB4B5B7FF

// ---------------- original poker.inc defines ----------------
#define POKERLAPS 52 // 4 * 13 laps (2, 3 ... K, A
#define SOUND_CHECK 1163
#define SOUND_FOLD 1085
#define SOUND_CALL 1054
#define SOUND_RAISE 1083
#define SOUND_WIN 5448 // 5449 5450
#define SOUND_BYE 5453 // 5454
#define SOUND_NEBERA 5405// - "Sir doesn't have sufficient money to back another bet."
#define SOUND_NETURI 5406// - neturi pakankamai pinigu
#define TEXTDRAW_FOLD -1431655851
#define TEXDRAW_DEFAULT -1
#define POKER_ROUND_TIME 20
#define notstock:%0(%1) forward %0(%1); public %0(%1)

// ---------------- state that lived in playerDB / LSG.pwn ----------------
new PlayingPoker[MAX_PLAYERS];
new PokerPromptTable[MAX_PLAYERS]; // table the buy-in prompt was opened for
// Dialog-free fallback: for POKER_CHAT_BUYIN_TIME ms after the prompt is shown, a plain
// number typed into chat is taken as the buy-in (and not broadcast). Needed on servers
// where another script or anticheat swallows dialog responses before this one sees them.
#define POKER_CHAT_BUYIN_TIME 60000
new PokerChatBuyInUntil[MAX_PLAYERS];
new PokerChatRaiseUntil[MAX_PLAYERS]; // same idea for the raise amount
new PlayerText:InfoTD[MAX_PLAYERS];
new InfoTimer[MAX_PLAYERS];

#define MAX_POKER_GAMES 5
#define MAX_POKER_WAITING 25
new PokerQue[MAX_POKER_GAMES][2];
new PokerQueUsed[MAX_POKER_GAMES][2];
new PokerQueSuma[MAX_POKER_GAMES][2];
new PokerWaitQue[MAX_POKER_GAMES][MAX_POKER_WAITING];
new PokerWaitQueSuma[MAX_POKER_GAMES][MAX_POKER_WAITING];
new PlayerPokerWaitQue[MAX_PLAYERS]; // tableid
new Text3D:PokerBlindsTD[MAX_POKER_GAMES];
new PokerTimer;
// Height tuning: the floor slabs are placed at (table floor level + offset).
// Use /pokerfloor <offset> in game (RCON admin) to move them live, e.g.
// /pokerfloor -0.5  then copy the value you like into POKER_FLOOR_OFFSET.
#define POKER_FLOOR_OFFSET  -0.5
new Float:PokerFloorOffset = POKER_FLOOR_OFFSET;
new PokerFloorObj[3] = {INVALID_STREAMER_ID, ...};

// ---------------- table data (constants.inc) ----------------
// {small blind, big blind, min buy-in, max buy-in}
new PokerBlinds[MAX_POKER_GAMES][4] = 
{
	{100,200,5000,20000},
	{500,1000,20000,100000},
	{2500,5000,100000,500000},
	{12500,25000,500000,2500000},
	{75000,150000,3000000,15000000}
};

// Interior a player is moved into when sitting down.
// Tables 1-4 are in Caligula's (1), table 5 in Four Dragons (10).
// Set an entry to -1 to leave the player in whatever interior they are in
// (useful if you placed the tables in your own map / interior 0).
new const PokerInterior[MAX_POKER_GAMES] = {-1,-1,-1,-1,10};
stock PokerSetInterior(playerid, table)
{
	if(PokerInterior[table] != -1) SetPlayerInterior(playerid, PokerInterior[table]);
}

new const Float:PokerTables[MAX_POKER_GAMES][3] =
{
	{2258.2293,-793.8401,1407.6275},
	{2260.2730,-801.5500,1407.6275},
	{2274.6075,-793.8313,1407.6275},
	{2272.5494,-801.5431,1407.6275},
	{1992.9943,1017.9153,994.7951}
};

new const Float:SeatCoords[MAX_POKER_GAMES][][] =
{
	{
		{2257.0996,-792.0580,1407.5872,227.1454},
		{2259.1279,-791.7931,1407.5872,139.7245},
		{2259.8206,-793.1002,1407.5872,84.2640},
		{2259.8125,-794.5108,1407.5872,90.8441},
		{2259.2590,-795.5986,1407.5872,40.3969},
		{2257.2214,-795.7034,1407.5872,329.2696}
	},
	{
		{2259.1433,-799.7679,1407.5872,227.1454},
		{2261.1716,-799.5030,1407.5872,139.7245},
		{2261.8643,-800.8101,1407.5872,84.2640},
		{2261.8562,-802.2207,1407.5872,90.8441},
		{2261.3027,-803.3085,1407.5872,40.3969},
		{2259.2651,-803.4133,1407.5872,329.2696}
	},
	{
		{2273.4778,-792.0492,1407.5872,227.1454},
		{2275.5061,-791.7843,1407.5872,139.7245},
		{2276.1988,-793.0914,1407.5872,84.2640},
		{2276.1907,-794.5020,1407.5872,90.8441},
		{2275.6372,-795.5898,1407.5872,40.3969},
		{2273.5996,-795.6946,1407.5872,329.2696}
	},
	{
		{2271.4197,-799.7610,1407.5872,227.1454},
		{2273.4480,-799.4961,1407.5872,139.7245},
		{2274.1407,-800.8032,1407.5872,84.2640},
		{2274.1326,-802.2138,1407.5872,90.8441},
		{2273.5791,-803.3016,1407.5872,40.3969},
		{2271.5415,-803.4064,1407.5872,329.2696}
	},
	{
			{1995.1005,1019.1570,995.3851,130.1119}, // 1
			{1995.0652,1016.8177,995.3851,49.4122}, // 2
			{1993.4253,1016.2899,995.3851,352.9594}, // 3
			{1992.2183,1016.3945,995.3851,353.9478}, // 4
			{1990.8904,1016.9421,995.3851,298.2379}, // 5
			{1991.2410,1019.1536,995.3851,219.2107} // 6
		}
};

new const Float:PokerCameras[MAX_POKER_GAMES][] = 
{
	{2261.8113,-793.7202,1410.7532,2258.2293,-793.8401,1407.6275},
	{2263.8550,-801.4301,1410.7532,2260.2730,-801.5500,1407.6275},
	{2278.1895,-793.7114,1410.7532,2274.6075,-793.8313,1407.6275},
	{2276.1314,-801.4232,1410.7532,2272.5494,-801.5431,1407.6275},
	{2239.4792,1633.1999,1012.0594,2235.7026,1633.1932,1008.9337}
};

// ============================================================
//      poker database  (SQLite, scriptfiles/poker.db)
//      Standalone - created automatically on first start.
//      Stores per-player statistics by player name.
// ============================================================
#define POKER_DB_FILE "poker.db"
new DB:PokerDB;
new PokerBuyIn[MAX_PLAYERS];   // total cash a player put on the table this sitting

stock PokerDB_Open()
{
	PokerDB = db_open(POKER_DB_FILE);
	db_query(PokerDB, "CREATE TABLE IF NOT EXISTS poker_players (\
		name TEXT PRIMARY KEY,\
		hands INTEGER DEFAULT 0,\
		wins INTEGER DEFAULT 0,\
		money_won INTEGER DEFAULT 0,\
		money_lost INTEGER DEFAULT 0,\
		biggest_pot INTEGER DEFAULT 0,\
		last_played INTEGER DEFAULT 0)");
	db_query(PokerDB, "CREATE TABLE IF NOT EXISTS poker_owed (name TEXT PRIMARY KEY, amount INTEGER DEFAULT 0)");
	return 1;
}
public PokerDB_SaveOwed(playerid)
{
	new q[160];
	if(PokerOwed[playerid] > 0)
		format(q, sizeof(q), "INSERT OR REPLACE INTO poker_owed (name, amount) VALUES ('%s', %d)", PokerDB_Name(playerid), PokerOwed[playerid]);
	else
		format(q, sizeof(q), "DELETE FROM poker_owed WHERE name = '%s'", PokerDB_Name(playerid));
	db_query(PokerDB, q);
	return 1;
}
stock PokerDB_LoadOwed(playerid)
{
	new q[128], DBResult:r, v[16];
	PokerOwed[playerid] = 0;
	format(q, sizeof(q), "SELECT amount FROM poker_owed WHERE name = '%s'", PokerDB_Name(playerid));
	r = db_query(PokerDB, q);
	if(db_num_rows(r)) { db_get_field(r, 0, v, sizeof(v)); PokerOwed[playerid] = strval(v); }
	db_free_result(r);
	return PokerOwed[playerid];
}
// pays out owed EURO once the player is logged in and has inventory space
stock PokerTryPayOwed(playerid)
{
	if(PokerOwed[playerid] <= 0 || PlayingPoker[playerid] || PokerCash(playerid) < 0) return 0;
	new amount = PokerOwed[playerid];
	new paid = CallRemoteFunction("Poker_GiveEuro", "ii", playerid, amount);
	if(paid <= 0) return 0;
	if(paid > amount) paid = amount;
	PokerOwed[playerid] -= paid;
	PokerDB_SaveOwed(playerid);
	new m[128];
	format(m, sizeof(m), "[POKER] Jums grazinta %s EURO is pokerio stalo.", FormatNumber(paid));
	SendClientMessage(playerid, TEXTCOL_GOLD, m);
	printf("[POKER] paid %d owed EURO to player %d (%d still owed)", paid, playerid, PokerOwed[playerid]);
	return paid;
}
stock PokerDB_Close()
{
	db_close(PokerDB);
	return 1;
}
// SA:MP names cannot contain quotes, but escape anyway
stock PokerDB_Name(playerid)
{
	new name[MAX_PLAYER_NAME*2];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	for(new i; name[i] != EOS; i++)
	{
		if(name[i] == '\'') { strins(name, "'", i); i++; }
	}
	return name;
}
stock PokerDB_Ensure(playerid)
{
	new q[160];
	format(q, sizeof(q), "INSERT OR IGNORE INTO poker_players (name) VALUES ('%s')", PokerDB_Name(playerid));
	db_query(PokerDB, q);
}
// called once per dealt hand for every seated player
stock PokerDB_Hand(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	PokerDB_Ensure(playerid);
	new q[200];
	format(q, sizeof(q), "UPDATE poker_players SET hands = hands + 1, last_played = %i WHERE name = '%s'", gettime(), PokerDB_Name(playerid));
	db_query(PokerDB, q);
	return 1;
}
// called when a player wins a pot (or a share of it)
stock PokerDB_Win(playerid, amount)
{
	if(!IsPlayerConnected(playerid)) return 0;
	PokerDB_Ensure(playerid);
	new q[220];
	format(q, sizeof(q), "UPDATE poker_players SET wins = wins + 1, biggest_pot = MAX(biggest_pot, %i) WHERE name = '%s'", amount, PokerDB_Name(playerid));
	db_query(PokerDB, q);
	return 1;
}
// called when a player leaves the table: net = cash out - cash in
stock PokerDB_Settle(playerid, cashout)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new net = cashout - PokerBuyIn[playerid];
	PokerBuyIn[playerid] = 0;
	if(net == 0) return 1;
	PokerDB_Ensure(playerid);
	new q[220];
	if(net > 0)
		format(q, sizeof(q), "UPDATE poker_players SET money_won = money_won + %i WHERE name = '%s'", net, PokerDB_Name(playerid));
	else
		format(q, sizeof(q), "UPDATE poker_players SET money_lost = money_lost + %i WHERE name = '%s'", -net, PokerDB_Name(playerid));
	db_query(PokerDB, q);
	return 1;
}
stock PokerDB_ShowStats(playerid, targetid)
{
	new q[160], DBResult:r;
	format(q, sizeof(q), "SELECT * FROM poker_players WHERE name = '%s'", PokerDB_Name(targetid));
	r = db_query(PokerDB, q);
	if(!db_num_rows(r))
	{
		db_free_result(r);
		return SendClientMessage(playerid, TEXTCOL_WHITE, "[POKER] Statistikos dar nera - suzaisk bent viena ranka.");
	}
	new hands[12], wins[12], won[16], lost[16], big[16];
	db_get_field_assoc(r, "hands", hands, sizeof(hands));
	db_get_field_assoc(r, "wins", wins, sizeof(wins));
	db_get_field_assoc(r, "money_won", won, sizeof(won));
	db_get_field_assoc(r, "money_lost", lost, sizeof(lost));
	db_get_field_assoc(r, "biggest_pot", big, sizeof(big));
	db_free_result(r);
	new msg[144];
	format(msg, sizeof(msg), "[POKER] %s: ranku %s, laimeta %s, +%sEUR / -%sEUR, didziausias bankas %sEUR",
		ReturnName(targetid), hands, wins, FormatNumber(strval(won)), FormatNumber(strval(lost)), FormatNumber(strval(big)));
	SendClientMessage(playerid, TEXTCOL_GOLD, msg);
	return 1;
}

// ---------------- helpers that lived in LSG.pwn / functions.inc ----------------
stock ReturnName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	return name;
}
stock IsNumeric(const string[])
{
	if(strlen(string) > 9 || strval(string) < 0) return 0;
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
// "100k" -> 100000, "1.2m" -> 1200000 (original used sscanf, rewritten with floatstr)
stock GetPokerNumber(const string[])
{
	new len = strlen(string);
	if(len > 9 || len < 2) return 0;
	new letter = string[len-1];
	new tmp[12];
	strmid(tmp, string, 0, len-1);
	for(new i; tmp[i] != EOS; i++)
	{
		if(!(('0' <= tmp[i] <= '9') || tmp[i] == '.')) return 0;
	}
	new Float:num = floatstr(tmp);
	if(num < 0.0 || num >= 1000.0) return 0;
	if(letter == 'k' || letter == 'K') num = num * 1000.0;
	else if(letter == 'm' || letter == 'M') num = num * 1000000.0;
	else return 0;
	return floatround(num);
}
forward HideInfoMessage(playerid);
public HideInfoMessage(playerid)
{
	InfoTimer[playerid] = 0;
	if(IsPlayerConnected(playerid)) PlayerTextDrawHide(playerid, InfoTD[playerid]);
	return 1;
}
stock SendInfoMessage(playerid,Message[],time=200)
{
	#pragma unused time
	if(!IsPlayerConnected(playerid)) return 1;
	PlayerTextDrawSetString(playerid, InfoTD[playerid], Message);
	PlayerTextDrawShow(playerid, InfoTD[playerid]);
	// also to chat, with the textdraw colour codes (~r~, ~n~ ...) stripped
	new chat[256], j;
	for(new i; Message[i] != EOS && j < 250; i++)
	{
		if(Message[i] == '~' && Message[i+1] != EOS && Message[i+2] == '~') { if(Message[i+1]=='n') chat[j++]=' '; i += 2; continue; }
		chat[j++] = Message[i];
	}
	chat[j] = EOS;
	SendClientMessage(playerid, TEXTCOL_WHITE, chat);
	if(InfoTimer[playerid]) KillTimer(InfoTimer[playerid]);
	InfoTimer[playerid] = SetTimerEx("HideInfoMessage", 4000, false, "i", playerid);
	return 1;
}
stock CreateInfoTextDraw(playerid)
{
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 320.0, 395.0, "_");
	PlayerTextDrawAlignment(playerid, InfoTD[playerid], 2);
	PlayerTextDrawFont(playerid, InfoTD[playerid], 2);
	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.33, 1.4);
	PlayerTextDrawColor(playerid, InfoTD[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 255);
	PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, InfoTD[playerid], 0);
}

// Re-applies the seat position a moment after sitting down, in case the gamemode
// (anti-teleport, spawn logic, ...) moved the player back after our SetPlayerPos.
forward PokerReseat(playerid, table, seat);
public PokerReseat(playerid, table, seat)
{
	if(!IsPlayerConnected(playerid) || !PlayingPoker[playerid]) return 0;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	PokerLog("reseat check player %d: at %.2f %.2f %.2f, seat %d of table %d is %.2f %.2f %.2f", playerid, x, y, z, seat, table, SeatCoords[table][seat][0], SeatCoords[table][seat][1], SeatCoords[table][seat][2]);
	PokerSetInterior(playerid, table);
	SetPlayerPos(playerid, SeatCoords[table][seat][0], SeatCoords[table][seat][1], SeatCoords[table][seat][2]);
	SetPlayerFacingAngle(playerid, SeatCoords[table][seat][3]);
	ApplyAnimation(playerid,"INT_OFFICE", "FF_Dam_Fwd",4.0,0,0,0,1,0,1);
	return 1;
}
// forward declarations (poker.inc calls these before they are defined)
forward CreatePokerFloor(Float:offset);
forward AddPokerQuePlayer(table);
forward AddToPokerQue(playerid,id,suma);
forward RemovePlayerFromPokerWaitQue(playerid, table);

// ============================================================
//              gamemodes/LSG/Activities/poker.inc
// ============================================================
enum
{
	TWO = 2,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING,
	ACE
};

new
	LD_POKE[POKERLAPS][] =
{
	{ "LD_POKE:cd2c" }, { "LD_POKE:cd3c" }, { "LD_POKE:cd4c" }, { "LD_POKE:cd5c" }, { "LD_POKE:cd6c" }, { "LD_POKE:cd7c" }, { "LD_POKE:cd8c" },
	{ "LD_POKE:cd9c" }, { "LD_POKE:cd10c" }, { "LD_POKE:cd11c" }, { "LD_POKE:cd12c" }, { "LD_POKE:cd13c" }, { "LD_POKE:cd1c" },

	{ "LD_POKE:cd2d" }, { "LD_POKE:cd3d" }, { "LD_POKE:cd4d" }, { "LD_POKE:cd5d" }, { "LD_POKE:cd6d" }, { "LD_POKE:cd7d" }, { "LD_POKE:cd8d" },
	{ "LD_POKE:cd9d" }, { "LD_POKE:cd10d" }, { "LD_POKE:cd11d" }, { "LD_POKE:cd12d" }, { "LD_POKE:cd13d" }, { "LD_POKE:cd1d" },

	{ "LD_POKE:cd2h" }, { "LD_POKE:cd3h" }, { "LD_POKE:cd4h" }, { "LD_POKE:cd5h" }, { "LD_POKE:cd6h" }, { "LD_POKE:cd7h" }, { "LD_POKE:cd8h" },
	{ "LD_POKE:cd9h" }, { "LD_POKE:cd10h" }, { "LD_POKE:cd11h" }, { "LD_POKE:cd12h" }, { "LD_POKE:cd13h" }, { "LD_POKE:cd1h" },

	{ "LD_POKE:cd2s" }, { "LD_POKE:cd3s" }, { "LD_POKE:cd4s" }, { "LD_POKE:cd5s" }, { "LD_POKE:cd6s" }, { "LD_POKE:cd7s" }, { "LD_POKE:cd8s" },
	{ "LD_POKE:cd9s" }, { "LD_POKE:cd10s" }, { "LD_POKE:cd11s" }, { "LD_POKE:cd12s" }, { "LD_POKE:cd13s" }, { "LD_POKE:cd1s" }
};

// ---------------- card rendering ----------------
// The original LSG draws cards with GTA's built-in sprites (LD_POKE:cd..). Those
// pictures come from each player's own game files, so a Russian texture pack shows
// Cyrillic rank letters (T for ace etc.) and nothing on the server can change that.
// 1 = draw the cards ourselves: white card, rank + suit letter, red/black, blue back.
//     Same look on every client.
// 0 = original LD_POKE sprites.
#define POKER_TEXT_CARDS 0
#if POKER_TEXT_CARDS
	#define CARD_BACK          " "
	#define CARD_COLOR_DEFAULT 0x000000FF   // black text on the white card
	#define CARD_BOX_FACE      0xFFFFFFFF   // white card
	#define CARD_BOX_BACK      0x1E3C8CFF   // blue back
	new const CardRankText[13][3] = { "2","3","4","5","6","7","8","9","10","J","Q","K","A" };
	// suit letters: C(lubs) D(iamonds) H(earts) S(pades) - hearts/diamonds in red
	new const CardSuitText[4][6]  = { "C", "~r~D", "~r~H", "S" };
#else
	#define CARD_BACK          "LD_POKE:cdback"
	#define CARD_COLOR_DEFAULT TEXDRAW_DEFAULT
#endif
#if POKER_TEXT_CARDS
	#pragma unused LD_POKE
#endif
// string shown on a card textdraw for a given rank (0..12) and suit (0..3)
stock CardFace(rankas, suitas)
{
	new str[24];
	#if POKER_TEXT_CARDS
	format(str, sizeof(str), "%s~n~%s", CardRankText[rankas], CardSuitText[suitas]);
	#else
	format(str, sizeof(str), "%s", LD_POKE[rankas + suitas*13]);
	#endif
	return str;
}
stock Text:CreateCardTextDraw(Float:x, Float:y)
{
	new Text:td = TextDrawCreate(x, y, CARD_BACK);
	TextDrawBackgroundColor(td, 255);
	TextDrawSetProportional(td, 1);
	TextDrawUseBox(td, 1);
	#if POKER_TEXT_CARDS
	TextDrawFont(td, 1);
	TextDrawLetterSize(td, 0.30, 1.25);
	TextDrawAlignment(td, 2);
	TextDrawColor(td, CARD_COLOR_DEFAULT);
	TextDrawSetOutline(td, 0);
	TextDrawSetShadow(td, 0);
	TextDrawBoxColor(td, CARD_BOX_BACK);
	TextDrawTextSize(td, 33.0, 30.0); // with alignment 2: height, width
	#else
	TextDrawFont(td, 4);
	TextDrawLetterSize(td, 0.5, 1.0);
	TextDrawColor(td, -1);
	TextDrawSetOutline(td, 0);
	TextDrawSetShadow(td, 1);
	TextDrawBoxColor(td, 255);
	TextDrawTextSize(td, 34.0, 33.0);
	#endif
	return td;
}
stock PlayerText:CreatePlayerCardTextDraw(playerid, Float:x, Float:y)
{
	new PlayerText:td = CreatePlayerTextDraw(playerid, x, y, CARD_BACK);
	PlayerTextDrawBackgroundColor(playerid, td, 255);
	PlayerTextDrawSetProportional(playerid, td, 1);
	PlayerTextDrawUseBox(playerid, td, 1);
	#if POKER_TEXT_CARDS
	PlayerTextDrawFont(playerid, td, 1);
	PlayerTextDrawLetterSize(playerid, td, 0.30, 1.25);
	PlayerTextDrawAlignment(playerid, td, 2);
	PlayerTextDrawColor(playerid, td, CARD_COLOR_DEFAULT);
	PlayerTextDrawSetOutline(playerid, td, 0);
	PlayerTextDrawSetShadow(playerid, td, 0);
	PlayerTextDrawBoxColor(playerid, td, CARD_BOX_BACK);
	PlayerTextDrawTextSize(playerid, td, 33.0, 30.0);
	#else
	PlayerTextDrawFont(playerid, td, 4);
	PlayerTextDrawLetterSize(playerid, td, 0.5, 1.0);
	PlayerTextDrawColor(playerid, td, -1);
	PlayerTextDrawSetOutline(playerid, td, 0);
	PlayerTextDrawSetShadow(playerid, td, 1);
	PlayerTextDrawBoxColor(playerid, td, 255);
	PlayerTextDrawTextSize(playerid, td, 34.0, 33.0);
	#endif
	return td;
}
// --- setting a card's face / back (box colour follows in text mode) ---
stock SetTableCardFace(Text:td, rankas, suitas)
{
	TextDrawSetString(td, CardFace(rankas, suitas));
	#if POKER_TEXT_CARDS
	TextDrawBoxColor(td, CARD_BOX_FACE);
	#endif
}
stock SetTableCardBack(Text:td)
{
	TextDrawSetString(td, CARD_BACK);
	#if POKER_TEXT_CARDS
	TextDrawBoxColor(td, CARD_BOX_BACK);
	#endif
}
stock SetPlayerCardFace(playerid, PlayerText:td, rankas, suitas)
{
	PlayerTextDrawSetString(playerid, td, CardFace(rankas, suitas));
	#if POKER_TEXT_CARDS
	PlayerTextDrawBoxColor(playerid, td, CARD_BOX_FACE);
	PlayerTextDrawShow(playerid, td); // box colour only applies on (re)show
	#endif
}
stock SetPlayerCardBack(playerid, PlayerText:td)
{
	PlayerTextDrawSetString(playerid, td, CARD_BACK);
	#if POKER_TEXT_CARDS
	PlayerTextDrawBoxColor(playerid, td, CARD_BOX_BACK);
	#endif
}


/*
new ranks[13][3] = 
{
"2",
"3",
"4",
"5",
"6",
"7",
"8",
"9",
"10",
"J",
"Q",
"K",
"A"	
};

new suits[4] =
{
'C', // kryziai
'D',
'H',
'S' 
};
*/

//new ranks[13];
enum card
{
	rank,
	suit
};
#define MAX_POKER_GAMES 5
enum TheGame
{
	GameUsed=0,
	players[6],
	watching,
	//Cards[Card],
	CardsR[52],
	CardsS[52],
	TableR[5],
	TableS[5],
	CardsUsed,
	Bankas,
	DabartinisStat,
	Eile,
	Playing[6],
	PStatymas[6],
	LastSmall,
	SmallBlind,
	BigBlind,
	FirstTurn,
	PFondas[6],
	TheStep,
	handPoints[6],
	Text:TableKorta[5],
	Text:JusuEile,
	Text:BankTD,
	Text:PokerName[6],
	Text:PokerMoney[6],
	Text:PokerAction[6],
	PBankai[6],
	TimeLeft,
	PlayerCombo[6],
	PlayerComboCard[6],
	PlayerSecond[6],
	PlayerKicker1[6],
	PlayerKicker2[6],
	PlayerKicker3[6]
};
/*


*/
new Poker[MAX_POKER_GAMES][TheGame];
// Incremented every time a game starts or ends at a table. Timer callbacks carry the
// generation they were created in and ignore themselves if the game has changed since.
// (Fixes a bug in the original: timers from a finished game acting on the next one.)
new PokerGen[MAX_POKER_GAMES];
//new 
new PHand[MAX_PLAYERS][2][card];
new hand[5][card] = 
{ {0,0},{0,0},{0,0},{0,0},{0,0}
};

new PlayerText:Korta[MAX_PLAYERS][6][2];
new PlayerText:Mygtukas[5][MAX_PLAYERS];
//new Text:JusuEile;
//new Text:TableKorta[5];

stock shuffle(id)
{
	for (new i=0;i<4;i++)
	{
		for (new j=0;j<13;j++)
		{
			Poker[id][CardsS][i*13+j] = i;
			Poker[id][CardsR][i*13+j] = j;
		}
	}	
		
	
	//sleep(2);
	new tempCard[2];
	new x;
	for (new z;z<2;z++)
	{
		for (new i=0;i<52;i++)
		{
			x = random(52);
			tempCard[0] = Poker[id][CardsR][i];
			tempCard[1] = Poker[id][CardsS][i];
			Poker[id][CardsR][i] = Poker[id][CardsR][x];
			Poker[id][CardsS][i] = Poker[id][CardsS][x];
			Poker[id][CardsR][x] = tempCard[0];
			Poker[id][CardsS][x] = tempCard[1];
		}
	}
}

stock evaluateHands(id)
{
	//printf("Pradzia: %i",GetTickCount());
//	new handas[7][card];
	//new array[7][Card];
	new combo,combocard,second,kicker1,kicker2,kicker3;
	// senas: [7][6][5][4][3] = 2520
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
		{
			for(new a;a<5;a++)
			{
				for(new b;b<5;b++)
				{
					if(b != a)
					{
						for(new c;c<5;c++)
						{
							if(c != a && c != b)
							{
								hand[0][rank]=Poker[id][TableR][a];
								hand[0][suit]=Poker[id][TableS][a];
								hand[1][rank]=Poker[id][TableR][b];
								hand[1][suit]=Poker[id][TableS][b];
								hand[2][rank]=Poker[id][TableR][c];
								hand[2][suit]=Poker[id][TableS][c];
								hand[3]=PHand[Poker[id][players][i]][0];
								hand[4]=PHand[Poker[id][players][i]][1];
								//currentPoints = getScore(Poker[id][players][i],Poker[id][PlayerCombo][i],Poker[id][PlayerSecond][i],Poker[id][PlayerKicker1][i],Poker[id][PlayerKicker2][i],Poker[id][PlayerKicker3][i]);
								getScore(Poker[id][players][i],combo,combocard,second,kicker1,kicker2,kicker3);
								if (combo > Poker[id][PlayerCombo][i])
								{
									Poker[id][PlayerCombo][i]=combo;
									Poker[id][PlayerComboCard][i]=combocard;
									Poker[id][PlayerSecond][i]=second;
									Poker[id][PlayerKicker1][i]=kicker1;
									Poker[id][PlayerKicker2][i]=kicker2;
									Poker[id][PlayerKicker3][i]=kicker3;
								}
								else if(combo == Poker[id][PlayerCombo][i])
								{
									if(combocard > Poker[id][PlayerComboCard][i])
									{
										Poker[id][PlayerComboCard][i]=combocard;
										Poker[id][PlayerSecond][i]=second;
										Poker[id][PlayerKicker1][i]=kicker1;
										Poker[id][PlayerKicker2][i]=kicker2;
										Poker[id][PlayerKicker3][i]=kicker3;
									}
									else if(combocard == Poker[id][PlayerComboCard][i])
									{
										if(second > Poker[id][PlayerSecond][i])
										{
											Poker[id][PlayerSecond][i]=second;
											Poker[id][PlayerKicker1][i]=kicker1;
											Poker[id][PlayerKicker2][i]=kicker2;
											Poker[id][PlayerKicker3][i]=kicker3;
										}
										else if(second == Poker[id][PlayerSecond][i])
										{
											if(kicker1 > Poker[id][PlayerKicker1][i])
											{
												Poker[id][PlayerKicker1][i]=kicker1;
												Poker[id][PlayerKicker2][i]=kicker2;
												Poker[id][PlayerKicker3][i]=kicker3;			
											}
											else if(kicker1==Poker[id][PlayerKicker1][i])
											{
												if(kicker2>Poker[id][PlayerKicker2][i])
												{
													Poker[id][PlayerKicker2][i]=kicker2;
													Poker[id][PlayerKicker3][i]=kicker3;	
												}
												else if(kicker2 == Poker[id][PlayerKicker2][i])
												{
													if(kicker3 > Poker[id][PlayerKicker3][i])
													{
														Poker[id][PlayerKicker3][i]=kicker3;
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			// [5][4][3] = 60
			for(new a;a<2;a++)
			{
				for(new b;b<5;b++)
				{
					for(new x;x<5;x++)
					{
						hand[x][rank]=Poker[id][TableR][x];
						hand[x][suit]=Poker[id][TableS][x];
					}
					//temp=hand[b];
					hand[b]=PHand[Poker[id][players][i]][a];
					getScore(Poker[id][players][i],combo,combocard,second,kicker1,kicker2,kicker3);
					if (combo > Poker[id][PlayerCombo][i])
					{
						Poker[id][PlayerCombo][i]=combo;
						Poker[id][PlayerComboCard][i]=combocard;
						Poker[id][PlayerSecond][i]=second;
						Poker[id][PlayerKicker1][i]=kicker1;
						Poker[id][PlayerKicker2][i]=kicker2;
						Poker[id][PlayerKicker3][i]=kicker3;
					}
					else if(combo == Poker[id][PlayerCombo][i])
					{
						if(combocard > Poker[id][PlayerComboCard][i])
						{
							Poker[id][PlayerComboCard][i]=combocard;
							Poker[id][PlayerSecond][i]=second;
							Poker[id][PlayerKicker1][i]=kicker1;
							Poker[id][PlayerKicker2][i]=kicker2;
							Poker[id][PlayerKicker3][i]=kicker3;
						}
						else if(combocard == Poker[id][PlayerComboCard][i])
						{
							if(second > Poker[id][PlayerSecond][i])
							{
								Poker[id][PlayerSecond][i]=second;
								Poker[id][PlayerKicker1][i]=kicker1;
								Poker[id][PlayerKicker2][i]=kicker2;
								Poker[id][PlayerKicker3][i]=kicker3;
							}
							else if(second == Poker[id][PlayerSecond][i])
							{
								if(kicker1 > Poker[id][PlayerKicker1][i])
								{
									Poker[id][PlayerKicker1][i]=kicker1;
									Poker[id][PlayerKicker2][i]=kicker2;
									Poker[id][PlayerKicker3][i]=kicker3;			
								}
								else if(kicker1==Poker[id][PlayerKicker1][i])
								{
									if(kicker2>Poker[id][PlayerKicker2][i])
									{
										Poker[id][PlayerKicker2][i]=kicker2;
										Poker[id][PlayerKicker3][i]=kicker3;	
									}
									else if(kicker2 == Poker[id][PlayerKicker2][i])
									{
										if(kicker3 > Poker[id][PlayerKicker3][i])
										{
											Poker[id][PlayerKicker3][i]=kicker3;
										}
									}
								}
							}
						}
					}
				}
			} 
			// [5]*2 = 10
			for(new x;x<5;x++)
			{
				hand[x][rank]=Poker[id][TableR][x];
				hand[x][suit]=Poker[id][TableS][x];
			}
			getScore(Poker[id][players][i],combo,combocard,second,kicker1,kicker2,kicker3);
			if (combo > Poker[id][PlayerCombo][i])
			{
				Poker[id][PlayerCombo][i]=combo;
				Poker[id][PlayerComboCard][i]=combocard;
				Poker[id][PlayerSecond][i]=second;
				Poker[id][PlayerKicker1][i]=kicker1;
				Poker[id][PlayerKicker2][i]=kicker2;
				Poker[id][PlayerKicker3][i]=kicker3;
			}
			else if(combo == Poker[id][PlayerCombo][i])
			{
				if(combocard > Poker[id][PlayerComboCard][i])
				{
					Poker[id][PlayerComboCard][i]=combocard;
					Poker[id][PlayerSecond][i]=second;
					Poker[id][PlayerKicker1][i]=kicker1;
					Poker[id][PlayerKicker2][i]=kicker2;
					Poker[id][PlayerKicker3][i]=kicker3;
				}
				else if(combocard == Poker[id][PlayerComboCard][i])
				{
					if(second > Poker[id][PlayerSecond][i])
					{
						Poker[id][PlayerSecond][i]=second;
						Poker[id][PlayerKicker1][i]=kicker1;
						Poker[id][PlayerKicker2][i]=kicker2;
						Poker[id][PlayerKicker3][i]=kicker3;
					}
					else if(second == Poker[id][PlayerSecond][i])
					{
						if(kicker1 > Poker[id][PlayerKicker1][i])
						{
							Poker[id][PlayerKicker1][i]=kicker1;
							Poker[id][PlayerKicker2][i]=kicker2;
							Poker[id][PlayerKicker3][i]=kicker3;			
						}
						else if(kicker1==Poker[id][PlayerKicker1][i])
						{
							if(kicker2>Poker[id][PlayerKicker2][i])
							{
								Poker[id][PlayerKicker2][i]=kicker2;
								Poker[id][PlayerKicker3][i]=kicker3;	
							}
							else if(kicker2 == Poker[id][PlayerKicker2][i])
							{
								if(kicker3 > Poker[id][PlayerKicker3][i])
								{
									Poker[id][PlayerKicker3][i]=kicker3;
								}
							}
						}
					}
				}
			}
		}
	}
	// 5
	// suma: 75 < 2520
	/*
	for(new i;i<5;i++)
	{
		handas[i][rank]=Poker[id][TableR][i];
		handas[i][suit]=Poker[id][TableS][i];
	}
	for(new i;i<6;i++)
	{
		currentPoints=0;
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
		{
			for(new x;x<2;x++)
			{
				handas[x+5] = PHand[Poker[id][players][i]][x];
			}
			for(new a;a<7;a++) // 1 korta
			{
				for(new b;b<7;b++) // 2 korta
				{
					if(b != a)
					{
						for(new c;c<7;c++) // 3 korta
						{
							if(c != a && c != b)
							{
								for(new d;d<7;d++) // 4 korta
								{
									if(d != a && d != b && d != c)
									{
										for(new e;e<7;e++) // 5 korta
										{
											if(e != a && e != b && e != c && e != d)
											{
												hand[0]=handas[a];
												hand[1]=handas[b];
												hand[2]=handas[c];
												hand[3]=handas[d];
												hand[4]=handas[e];
												
												currentPoints = getScore(Poker[id][players][i]);
												if (currentPoints>Poker[id][handPoints][i])
												{
													Poker[id][handPoints][i] = currentPoints;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	*/
	//printf("/: %i",GetTickCount());
}

//1 2 3 4 5


/*
stock evaluateHands(id)
{
	new stack[10],k;
	new currentPoints;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
		{
			// keiciam 2 kortas
			stack[0]=-1; 
			new x=0;
			k=0;
			while(x==0)
			{
				if (stack[k]<4){
					stack[k+1] = stack[k] + 1;
					k++;
				}
				else{
					stack[k-1]++;
					k--;
				}

				if (k==0)
					x=1;

				if (k==3)
				{
					currentPoints = tryHand(stack,i,id);
					if (currentPoints>Poker[id][handPoints][i]){
						Poker[id][handPoints][i] = currentPoints;
					}
				}
			}
			// keiciam 1 korta
			x=0;
			k=0;
			stack[0]=-1; 
			while(x==0)
			{
				if (stack[k]<4)
				{
					stack[k+1] = stack[k] + 1;
					k++;
				}
				else
				{
					stack[k-1]++;
					k--;
				}

				if (k==0)
					x=1;

				if (k==4)
				{
					currentPoints = tryHandEx(stack,i,id);
					if (currentPoints>Poker[id][handPoints][i]){
						Poker[id][handPoints][i] = currentPoints;
					}
				}
			}
		}
	}

}
*/
/*
stock tryHand(array[],player,id)
{

	for (new i=1;i<4;i++)
	{
		//hand[i-1] = Table[array[i]];
		hand[i-1][rank] = Poker[id][TableR][array[i]];
		hand[i-1][suit] = Poker[id][TableS][array[i]];
	}
	for (new i=0;i<2;i++)
		hand[i+3] = PHand[Poker[id][players][player]][i];

	return getScore(Poker[id][players][player]);
	
}
*/
forward EndGame(id, gen);
public EndGame(id, gen)
{
	if(gen != PokerGen[id] || !Poker[id][GameUsed]) return 0;
	for(new i;i<5;i++)
	{
		TextDrawHideForAll(Poker[id][TableKorta][i]);
		//TextDrawDestroy(TableKorta[i]);
	}
	//TextDrawDestroy(JusuKortos);
	new z;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1)
		{
			z++;
			new playerid = Poker[id][players][i];
			for(new y;y<6;y++)
			{
				for(new x;x<2;x++)
					PlayerTextDrawHide(playerid,Korta[playerid][y][x]);
			}
			for(new x;x<5;x++)
				PlayerTextDrawHide(playerid,Mygtukas[x][playerid]);
		}
	}
	if(z > 1)
		NewSet(id);
	else
		EndPokerGame(id);
	return 1;
}
stock LeaveGame(playerid,id,pid,esc=0,ending=0)
{
	PlaySoundForPoker(id,playerid,SOUND_BYE+random(2));
	for(new i;i<5;i++)
	{
		TextDrawHideForPlayer(playerid,Poker[id][TableKorta][i]);
		//TextDrawDestroy(TableKorta[i]);
	}
	TextDrawSetString(Poker[id][PokerAction][pid],"Leave");
	//TextDrawDestroy(JusuKortos);
	TextDrawHideForPlayer(playerid,Poker[id][BankTD]);
	TextDrawHideForPlayer(playerid,Poker[id][JusuEile]);
	for(new y;y<6;y++)
	{
		TextDrawHideForPlayer(playerid,Poker[id][PokerAction][y]);
		TextDrawHideForPlayer(playerid,Poker[id][PokerMoney][y]);
		TextDrawHideForPlayer(playerid,Poker[id][PokerName][y]);
		for(new x;x<2;x++)
		{
			PlayerTextDrawHide(playerid,Korta[playerid][y][x]);
			PlayerTextDrawDestroy(playerid,Korta[playerid][y][x]);
		}
	}
	for(new x;x<5;x++)
	{
		PlayerTextDrawHide(playerid,Mygtukas[x][playerid]);
		PlayerTextDrawDestroy(playerid,Mygtukas[x][playerid]);
	}
	PokerDB_Settle(playerid, Poker[id][PFondas][pid]);
	PokerPay(playerid, Poker[id][PFondas][pid]);
	Poker[id][PFondas][pid] = 0;
	Poker[id][Playing][pid]=0;
	Poker[id][players][pid]=-1;
	Streamer_ToggleItem(playerid, STREAMER_TYPE_3D_TEXT_LABEL, PokerBlindsTD[id], true); // grazinti stalo info atsikelus
	//Poker[id][PFondas][pid]=0;
	Poker[id][Bankas]+=Poker[id][PStatymas][pid];
	Poker[id][PBankai][pid]+=Poker[id][PStatymas][pid];
	Poker[id][PStatymas][pid]=0;
	PlayingPoker[playerid]=0;
	SetCameraBehindPlayer(playerid);
	if(!esc) 
		CancelSelectTextDraw(playerid);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
	if(!ending)
	{
		if(Poker[id][Eile]==pid)
		{
			Poker[id][Eile]=NextTurn(id,pid);
			Poker[id][Playing][pid]=0;
			NextPlayer(id);
		}
		else
		{
			new var, last=-1;
			for(new x;x<6;x++)
			{
				if(Poker[id][players][x] != -1) var++, last=x;
			}
			if(var < 2)
			{
				// Only one player is left: he takes everything on the table (pot + all
				// outstanding stakes). The original called GivePrize here, which refunded
				// the leaver's stake into his now-empty seat and never collected the
				// remaining player's stake - that money vanished.
				if(last != -1)
				{
					for(new x;x<6;x++)
					{
						Poker[id][Bankas]+=Poker[id][PStatymas][x];
						Poker[id][PStatymas][x]=0;
					}
					Poker[id][PFondas][last]+=Poker[id][Bankas];
					Poker[id][Bankas]=0;
					new msgx[128];
					format(msgx,sizeof(msgx),"[POKER] Nugaletojas: %s",ReturnName(Poker[id][players][last]));
					SendMessageToPokerTable(id,TEXTCOL_GOLD,msgx);
				}
				return EndPokerGame(id);
			}
		}
		if(Poker[id][FirstTurn]==pid)
		{
			Poker[id][FirstTurn] = NextTurn(id,pid);
		}
	}
	
	AddPokerQuePlayer(id);
	/*
	new da,dx,leid;
	for(new x;x<6;x++)
	{
		if(Poker[id][players][x] != -1) da++;
		if(Poker[id][Playing][x])
		{
			dx++;
			leid=x;
		}
	}
	if(da==1) { EndPokerGame(id); return 0;}
	else if(dx == 1)
	{
		Poker[id][PFondas][leid]+=Poker[id][Bankas];
		Poker[id][Bankas]=0;
		NewSet(id);
	}*/
	return 1;
}
stock InitPokerGame(id,small,big,plone,pltwo)
{
	/*new id=-1;
	for(new i;i<MAX_POKER_GAMES;i++)
	{
		if(!Poker[i][GameUsed])
		{
			Poker[i][GameUsed]=1,id=i;
			break;
		}
	}
	if(id==-1) return 0; */
	PokerGen[id]++;
	Poker[id][watching]=-1;
	Poker[id][Bankas]=0;
	Poker[id][GameUsed]=1;
	Poker[id][DabartinisStat]=0;
	Poker[id][CardsUsed]=0;
	Poker[id][Eile]=0;
	Poker[id][SmallBlind]=small;
	Poker[id][BigBlind]=big;
	Poker[id][TimeLeft]=POKER_ROUND_TIME+5;
	shuffle(id);
	//new playerid[6] = {-1,...};
	for(new i;i<6;i++)
	{
		Poker[id][players][i]=-1;
		
	}
	Poker[id][players][0]=plone;
	Poker[id][players][1]=pltwo;
	Streamer_ToggleItem(plone, STREAMER_TYPE_3D_TEXT_LABEL, PokerBlindsTD[id], false); // paslepti stalo info pradejusiems zaidima
	Streamer_ToggleItem(pltwo, STREAMER_TYPE_3D_TEXT_LABEL, PokerBlindsTD[id], false);
	Streamer_Update(plone, STREAMER_TYPE_3D_TEXT_LABEL); // priverstinai perkrauti srauta, kad paslepimas suveiktu ir stovinciam
	Streamer_Update(pltwo, STREAMER_TYPE_3D_TEXT_LABEL);
	Poker[id][Playing][0]=1;
	Poker[id][Playing][1]=1;
	CreatePlayerTextDraws(plone);
	CreatePlayerTextDraws(pltwo);

	CreatePokerTextDraws(id);
	NewSet(id);
	return id;
}
stock EndPokerGame(id,prize=0)
{
	if(!Poker[id][GameUsed]) return 0; // already ended (e.g. by a stale timer)
	if(prize) GivePrize(id, PokerGen[id]);
	Poker[id][GameUsed]=0;
	PokerGen[id]++;

	if(Poker[id][watching] != -1)
	{
		new playerid = Poker[id][watching];
		Poker[id][watching]=-1;
		for(new i;i<5;i++)
		{
			TextDrawHideForPlayer(playerid,Poker[id][TableKorta][i]);
			//TextDrawDestroy(TableKorta[i]);
		}
		//TextDrawDestroy(JusuKortos);
		TextDrawHideForPlayer(playerid,Poker[id][BankTD]);
		TextDrawHideForPlayer(playerid,Poker[id][JusuEile]);
		for(new y;y<6;y++)
		{
			TextDrawHideForPlayer(playerid,Poker[id][PokerAction][y]);
			TextDrawHideForPlayer(playerid,Poker[id][PokerMoney][y]);
			TextDrawHideForPlayer(playerid,Poker[id][PokerName][y]);
			for(new z;z<2;z++)
			{
				PlayerTextDrawHide(playerid,Korta[playerid][y][z]);
				PlayerTextDrawDestroy(playerid,Korta[playerid][y][z]);
			}
		}
		for(new z;z<5;z++)
		{
			PlayerTextDrawHide(playerid,Mygtukas[z][playerid]);
			PlayerTextDrawDestroy(playerid,Mygtukas[z][playerid]);
		}
	}
	for(new i;i<5;i++)
	{
		TextDrawDestroy(Poker[id][TableKorta][i]);
	}
	TextDrawDestroy(Poker[id][JusuEile]);
	TextDrawDestroy(Poker[id][BankTD]);
	for(new i;i<6;i++)
	{
		TextDrawDestroy(Poker[id][PokerName][i]);
		TextDrawDestroy(Poker[id][PokerAction][i]);
		TextDrawDestroy(Poker[id][PokerMoney][i]);
		if(Poker[id][players][i] != -1)
		{
			new playerid = Poker[id][players][i];
			LeaveGame(playerid,id,i,0,1);
		}
	}
	return 1;

}
stock NewSet(id)
{
	//Poker[id][handPoints][i]
	Poker[id][TimeLeft]=POKER_ROUND_TIME+5;
	Poker[id][CardsUsed]=0;
	Poker[id][TheStep]=0;
	shuffle(id);
	TextDrawSetString(Poker[id][BankTD],"0EUR");
	new txt[128];
	new txt2[128];
	format(txt,sizeof(txt),"S.Blind(%iEUR)",Poker[id][SmallBlind]);
	format(txt2,sizeof(txt2),"B.Blind(%iEUR)",Poker[id][BigBlind]);
//	TextDrawSetString(Poker[id][PokerAction][x],txt);
//	TextDrawShowForPlayer(playerid,Poker[id][PokerAction][x]);
	for(new i;i<6;i++)
	{
		Poker[id][PBankai][i]=0;
		if(Poker[id][players][i] == -1) continue;
		ProcessAchievement(Poker[id][players][i],60);
		PokerDB_Hand(Poker[id][players][i]);
		if(Poker[id][PFondas][i] < Poker[id][BigBlind])
		{
			if(!LeaveGame(Poker[id][players][i],id,i))
				break;
			continue;
		}
		Poker[id][PlayerCombo][i]=0;
		Poker[id][PlayerComboCard][i]=0;
		Poker[id][PlayerSecond][i]=0;
		Poker[id][PlayerKicker1][i]=0;
		Poker[id][PlayerKicker2][i]=0;
		Poker[id][PlayerKicker3][i]=0;
		Poker[id][handPoints][i]=0;
		Poker[id][Playing][i]=1;
		Poker[id][PStatymas][i]=0;
		for(new x;x<2;x++)
		{
			PHand[Poker[id][players][i]][x][rank]=Poker[id][CardsR][Poker[id][CardsUsed]];
			PHand[Poker[id][players][i]][x][suit]=Poker[id][CardsS][Poker[id][CardsUsed]];
			for(new y;y<6;y++)
				SetPlayerCardBack(Poker[id][players][i],Korta[Poker[id][players][i]][y][x]);
				
			Poker[id][CardsUsed]++;
		}
		TextDrawShowForPlayer(Poker[id][players][i],Poker[id][BankTD]);
		TextDrawSetString(Poker[id][PokerAction][i],"-");
		
		//TextDrawShowForPlayer(playerid,Poker[id][PokerAction][x]);
		//Poker[id][CardsUsed]-
	}
	if(Poker[id][watching] != -1)
		TextDrawShowForPlayer(Poker[id][watching],Poker[id][BankTD]);
	
	new pid = NextTurn(id,Poker[id][LastSmall]-1);
	if(pid != -1) Poker[id][PStatymas][pid]=Poker[id][SmallBlind];
	Poker[id][LastSmall] = pid;
	new pid2 = NextTurn(id,pid);
	if(pid2 != -1) Poker[id][PStatymas][pid2]=Poker[id][BigBlind];
	Poker[id][Eile] = NextTurn(id,pid2);
	Poker[id][FirstTurn]=Poker[id][Eile];
	if(pid != -1)TextDrawSetString(Poker[id][PokerAction][pid],txt);
	if(pid2 != -1) TextDrawSetString(Poker[id][PokerAction][pid2],txt2);
	if(Poker[id][Eile] != -1) ShowJusuEile(Poker[id][players][Poker[id][Eile]], id);
	//TextDrawSetString(Poker[id][PokerName][x],"Action");
	//TextDraw
	//TextDrawShowForPlayer(playerid,Poker[id][PokerAction][x]);
	//TextDrawSetTring
	//Poker[id][FirstTurn]=Poker[id][Eile];
	for(new i;i<6;i++)
	{
		if(Poker[id][PStatymas][i])
		{
			Poker[id][PFondas][i]-=Poker[id][PStatymas][i];
		}
	}
	//Poker[id][Bankas]+=small+big;
	Poker[id][DabartinisStat]+=Poker[id][SmallBlind]+Poker[id][BigBlind];
	
	Poker[id][LastSmall]++;
	if(Poker[id][LastSmall] == 6) Poker[id][LastSmall]=0;
							//Poker[id][BankTD] = TextDrawCreate(321.000000, 221.000000, "1,000,000LT");
	
	SetTimerEx("CardsUnpack",1000,false,"iiii",id,0,0,PokerGen[id]);
	return 1;
}
stock NextPlayer(id,first=0)
{
	Poker[id][TimeLeft]=POKER_ROUND_TIME;
	if(Poker[id][Eile]==-1)
	{
		new pid=-1,idx=-1;
		for(new i;i<6;i++)
		{
			
			if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
			{
				TextDrawHideForPlayer(Poker[id][players][i],Poker[id][JusuEile]);
				Poker[id][Bankas]+=Poker[id][PStatymas][i];
				Poker[id][PBankai][i]+=Poker[id][PStatymas][i];
				Poker[id][PStatymas][i]=0;
				pid=Poker[id][players][i]; 
				idx=i;
			}
		}
		if(pid==-1) return EndPokerGame(id);//;
		Poker[id][Eile]=0;
		PlaySoundForPoker(id,pid,SOUND_WIN+random(3));
		Poker[id][PFondas][idx]+=Poker[id][Bankas];
		Poker[id][Bankas]=0;
		new msgx[128];
		format(msgx,sizeof(msgx),"[POKER] Nugaletojas: %s",ReturnName(Poker[id][players][idx]));
		SendMessageToPokerTable(id,TEXTCOL_GOLD,msgx);
		EndGame(id, PokerGen[id]);
		//NewSet(id);
		return 1;
	}
	new playerid = Poker[id][players][Poker[id][Eile]];
	new maxstafke,stafkininkas;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1)
		{
			TextDrawHideForPlayer(Poker[id][players][i],Poker[id][JusuEile]);
			if(Poker[id][PStatymas][i] > maxstafke)
			{
				maxstafke=Poker[id][PStatymas][i];
				stafkininkas=i;
			}
			/*new playa=Poker[id][players][i];
			for(new x;x<5;x++)
			{
				PlayerTextDrawShow(playa, Mygtukas[x][playa]);
				//PlayerTextDrawSetSelectable(playa, Mygtukas[x][playa], 0);
			} */
		}
		
	}
	ShowJusuEile(playerid, id);
	new bool:ending=false;
	if(!first)
	{
		if(Poker[id][FirstTurn] == Poker[id][Eile] && Poker[id][PStatymas][Poker[id][Eile]] == maxstafke)
		{
			for(new i;i<6;i++)
			{
				if(Poker[id][players][i] != -1)
				{
					Poker[id][Bankas]+=Poker[id][PStatymas][i];
					Poker[id][PBankai][i]+=Poker[id][PStatymas][i];
					Poker[id][PStatymas][i]=0;
				}
			}
			new txt[128];
			format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][Bankas]));
			TextDrawSetString(Poker[id][BankTD],txt);
			if(Poker[id][TheStep]==3) ending=true;
			Flop(id,Poker[id][TheStep]);
			Poker[id][FirstTurn]=Poker[id][Eile];
			Poker[id][TheStep]++;
			
		}
		for(new x;x<6;x++)
		{
			new pid = Poker[id][players][x];
			if(pid != -1 && x != Poker[id][Eile])
			{
				for(new y;y<5;y++)
				{
//					PlayerTextDrawHide(pid, Mygtukas[y][pid]);
					PlayerTextDrawSetSelectable(pid, Mygtukas[y][pid], 0);
					PlayerTextDrawShow(pid, Mygtukas[y][pid]);
				}
			}
		}
	}
	//else
		//Poker[id][TheStep]=0;
	if(ending) return 1;
	maxstafke=0;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
		{
			if(Poker[id][PStatymas][i] > maxstafke)
			{
				maxstafke=Poker[id][PStatymas][i];
				stafkininkas=i;
			}
		}
		
	}
	if(playerid != -1)
	{
		if(Poker[id][Eile]==stafkininkas || Poker[id][PStatymas][Poker[id][Eile]] >= maxstafke)
		{
			SetPVarInt(playerid, "CanCheck", 1);
			PlayerTextDrawSetSelectable(playerid, Mygtukas[0][playerid], 1); // check
			PlayerTextDrawSetSelectable(playerid, Mygtukas[2][playerid], 1); // raise
			PlayerTextDrawSetSelectable(playerid, Mygtukas[3][playerid], 1); // fold
			PlayerTextDrawSetSelectable(playerid, Mygtukas[4][playerid], 1); // leave
			for(new x;x<5;x++)
				PlayerTextDrawShow(playerid, Mygtukas[x][playerid]);
			
		}
		else if(Poker[id][PStatymas][Poker[id][Eile]] < maxstafke)
		{
			SetPVarInt(playerid, "CanCheck", 0);
			PlayerTextDrawSetSelectable(playerid, Mygtukas[1][playerid], 1); // call
			if(Poker[id][PFondas][Poker[id][Eile]] > maxstafke)
			{
				PlayerTextDrawSetSelectable(playerid, Mygtukas[2][playerid], 1); // raise
			}
			PlayerTextDrawSetSelectable(playerid, Mygtukas[3][playerid], 1); // fold
			PlayerTextDrawSetSelectable(playerid, Mygtukas[4][playerid], 1); // leave
			for(new x;x<5;x++)
				PlayerTextDrawShow(playerid, Mygtukas[x][playerid]);
		}
	}
	return 1;
	//SelectTextDraw(playerid, 0xACCBF1FF);
	/*for(new x;x<5;x++)
	{
		PlayerTextDrawSetSelectable(playerid, Mygtukas[x], true);
	} */
}
stock OnPlayerClickPoker(playerid, PlayerText:playertextid)
{
	new id=-1,pid=-1;
	for(new i;i<MAX_POKER_GAMES;i++)
	{
		for(new x;x<6;x++)
		{
			if(Poker[i][players][x]==playerid)
			{
				pid=x;
				id=i;
				break;
			}
		}
	}
	if(id==-1) return 0;
	if(playertextid == Mygtukas[4][playerid]) // leave
	{
	//	CancelSelectTextDraw(playerid);
		LeaveGame(playerid,id,pid);
		
		return 1;
	}
	if(Poker[id][Eile] != pid) return SendInfoMessage(playerid,"Dabar ne jusu eile!");
	if(playertextid == Mygtukas[0][playerid]) // check
	{
		//CancelSelectTextDraw(playerid);
		if(GetPVarInt(playerid, "CanCheck") == 0)
		{
			return SendInfoMessage(playerid,"~r~Dabar checkinti negali!");
		}
		PlaySoundForPoker(id,-1,SOUND_CHECK);
		new msg[128];
		format(msg,sizeof(msg),"[POKER] %s: Check",ReturnName(Poker[id][players][pid]));
		SendMessageToPokerTable(id,-1,msg);
		new txt[128];
		for(new x;x<6;x++)
		{
			if(Poker[id][players][x] != -1 && Poker[id][Playing][x])
			{
				new ppid = Poker[id][players][x];
				format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][Poker[id][Eile]]));
				TextDrawSetString(Poker[id][PokerMoney][Poker[id][Eile]],txt);
				TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][Poker[id][Eile]]);
				TextDrawSetString(Poker[id][PokerAction][Poker[id][Eile]],"Check");
				TextDrawShowForPlayer(ppid,Poker[id][PokerAction][Poker[id][Eile]]);
			}
		}
		if(Poker[id][watching] != -1)
		{
			new ppid = Poker[id][watching];
			format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][Poker[id][Eile]]));
			TextDrawSetString(Poker[id][PokerMoney][Poker[id][Eile]],txt);
			TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][Poker[id][Eile]]);
			TextDrawSetString(Poker[id][PokerAction][Poker[id][Eile]],"Check");
			TextDrawShowForPlayer(ppid,Poker[id][PokerAction][Poker[id][Eile]]);
	
		}
		Poker[id][Eile] = NextTurn(id,pid);
		NextPlayer(id);
		return 1;
	}
	else if(playertextid == Mygtukas[1][playerid]) // call
	{
		//CancelSelectTextDraw(playerid);
		PlaySoundForPoker(id,-1,SOUND_CALL);
		new amount;
		for(new i;i<6;i++)
		{
			if(Poker[id][players][i] != -1 && Poker[id][players][i] != playerid)
			{
				if(Poker[id][PStatymas][i] > amount)
				{
					amount = Poker[id][PStatymas][i];
				}
			}
		}
		new bool:allined=false;
		amount-=Poker[id][PStatymas][Poker[id][Eile]];
		if(Poker[id][PFondas][Poker[id][Eile]] < amount)
		{
			allined=true;
			Poker[id][PStatymas][Poker[id][Eile]]+=Poker[id][PFondas][Poker[id][Eile]];
			amount=Poker[id][PFondas][Poker[id][Eile]];
			Poker[id][PFondas][Poker[id][Eile]]=0;
		}
		else
		{
			Poker[id][PStatymas][Poker[id][Eile]]+=amount;
			Poker[id][PFondas][Poker[id][Eile]]-=amount;
		}
		new txt[128];
		for(new x;x<6;x++)
		{
			if(Poker[id][players][x] != -1 && Poker[id][Playing][x])
			{
				new ppid = Poker[id][players][x];
				format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][Poker[id][Eile]]));
				TextDrawSetString(Poker[id][PokerMoney][Poker[id][Eile]],txt);
				TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][Poker[id][Eile]]);
				if(allined)
					format(txt,sizeof(txt),"All_In(%sEUR)",FormatNumber(amount));
				else if(!amount)
					format(txt,sizeof(txt),"Check");
				else
					format(txt,sizeof(txt),"Call(%sEUR)",FormatNumber(amount));
				TextDrawSetString(Poker[id][PokerAction][Poker[id][Eile]],txt);
				TextDrawShowForPlayer(ppid,Poker[id][PokerAction][Poker[id][Eile]]);
			}
		}
		if(Poker[id][watching] != -1)
		{
			new ppid = Poker[id][watching];
			format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][Poker[id][Eile]]));
			TextDrawSetString(Poker[id][PokerMoney][Poker[id][Eile]],txt);
			TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][Poker[id][Eile]]);
			if(allined)
				format(txt,sizeof(txt),"All_In(%sEUR)",FormatNumber(amount));
			else if(!amount)
				format(txt,sizeof(txt),"Check");
			else
				format(txt,sizeof(txt),"Call(%sEUR)",FormatNumber(amount));
			TextDrawSetString(Poker[id][PokerAction][Poker[id][Eile]],txt);
			TextDrawShowForPlayer(ppid,Poker[id][PokerAction][Poker[id][Eile]]);
		}
		/*new Array[6]={-1,...};
		new playerstotal;
		for(new i;i<6;i++)
		{
			if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
			{
				Array[playerstotal]=i;
				playerstotal++;
			}
		} */
//		new pid = Poker[id][Eile];
		Poker[id][Eile] = NextTurn(id,pid);
		NextPlayer(id);
		new msg[128];
		if(allined)
			format(msg,sizeof(msg),"[POKER] %s: All in(%sEUR)",ReturnName(Poker[id][players][pid]),FormatNumber(amount));
		else if(!amount)
			format(msg,sizeof(msg),"[POKER] %s: Check",ReturnName(Poker[id][players][pid]));
		else
			format(msg,sizeof(msg),"[POKER] %s: Call(%sEUR)",ReturnName(Poker[id][players][pid]),FormatNumber(amount));
		if(amount > 100000)
			ProcessAchievement(Poker[id][players][pid],61);
		SendMessageToPokerTable(id,-1,msg);
		return 1;
	}
	else if(playertextid == Mygtukas[2][playerid]) // raise
	{
		//CancelSelectTextDraw(playerid);
		new text[256];
		new maxstafke,currentbid;
		new x;
		for(new i;i<6;i++)
		{
			if(Poker[id][players][i] != -1)
			{
				if(Poker[id][players][i]==playerid) x=i;
				if(Poker[id][Playing][i] && Poker[id][players][i] != playerid )
				{
					if(Poker[id][PFondas][i] + Poker[id][PStatymas][i] > maxstafke)
					{
						maxstafke=Poker[id][PFondas][i] + Poker[id][PStatymas][i];
					}
					if(Poker[id][PStatymas][i] > currentbid)
					{
						currentbid=Poker[id][PStatymas][i];
					}
				}

			}
		}
		currentbid*=2;
		if(currentbid > maxstafke) currentbid=maxstafke;
		if(Poker[id][PFondas][x] < currentbid)
		{
			return SendInfoMessage(playerid,"Jus neturite daugiau pinigu!");
		}
		else if(Poker[id][PFondas][x] < maxstafke)
		{
			maxstafke=Poker[id][PFondas][x];
		}
		PokerLog("raise button clicked by %d (seat %d), may raise %s..%s", playerid, x, FormatNumber(currentbid), FormatNumber(maxstafke));
		format(text,sizeof(text),"Irasykite suma, kuria norite raisinti.\nGalite naudoti trumpinius pvz.: 100k, 1.2m\n\nSiuo metu galite didinti nuo %s iki %s EUR.",FormatNumber(currentbid),FormatNumber(maxstafke));
		strcat(text, "\n\nJei langas neveikia - parasykite suma i chata (pvz. 2000 arba 2k).");
		PokerChatRaiseUntil[playerid] = GetTickCount() + POKER_CHAT_BUYIN_TIME;
		SendClientMessage(playerid,TEXTCOL_WHITE,"[POKER] Raise: irasykite suma i langa arba tiesiog i chata (pvz. 2000 arba 2k).");
		PokerShowDialog(playerid,POKER_DIALOG_RAISE,DIALOG_STYLE_INPUT,"Raise",text,"Gerai","Atsaukti");
		return 1;
	}
	else if(playertextid == Mygtukas[3][playerid]) // folded
	{
		//CancelSelectTextDraw(playerid);
		PlaySoundForPoker(id,-1,SOUND_FOLD);
//		new pid;
		new txt[128];
		for(new x;x<6;x++)
		{
			if(Poker[id][players][x] != -1)
			{
				new pa=Poker[id][players][x];
				PlayerTextDrawColor(pa,Korta[pa][pid][0], TEXTDRAW_FOLD);
				PlayerTextDrawColor(pa,Korta[pa][pid][1], TEXTDRAW_FOLD);
				PlayerTextDrawShow(pa,Korta[pa][pid][0]);
				PlayerTextDrawShow(pa,Korta[pa][pid][1]);
				
			}
			if(Poker[id][players][x] != -1 && Poker[id][Playing][x])
			{
				new ppid = Poker[id][players][x];
				format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][Poker[id][Eile]]));
				TextDrawSetString(Poker[id][PokerMoney][Poker[id][Eile]],txt);
				TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][Poker[id][Eile]]);
				TextDrawSetString(Poker[id][PokerAction][Poker[id][Eile]],"Fold");
				TextDrawShowForPlayer(ppid,Poker[id][PokerAction][Poker[id][Eile]]);
			}
		}
		if(Poker[id][watching] != -1)
		{
			new pa = Poker[id][watching];
			PlayerTextDrawColor(pa,Korta[pa][pid][0], TEXTDRAW_FOLD);
			PlayerTextDrawColor(pa,Korta[pa][pid][1], TEXTDRAW_FOLD);
			PlayerTextDrawShow(pa,Korta[pa][pid][0]);
			PlayerTextDrawShow(pa,Korta[pa][pid][1]);
			new ppid = Poker[id][watching];
			format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][Poker[id][Eile]]));
			TextDrawSetString(Poker[id][PokerMoney][Poker[id][Eile]],txt);
			TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][Poker[id][Eile]]);
			TextDrawSetString(Poker[id][PokerAction][Poker[id][Eile]],"Fold");
			TextDrawShowForPlayer(ppid,Poker[id][PokerAction][Poker[id][Eile]]);
		}
		


		Poker[id][Bankas]+=Poker[id][PStatymas][pid];
		Poker[id][PBankai][pid]+=Poker[id][PStatymas][pid];
		Poker[id][PStatymas][pid]=0;
		Poker[id][Playing][pid]=0;
		Poker[id][Eile] = NextTurn(id,pid);
		if(Poker[id][FirstTurn]==pid)
		{
			Poker[id][FirstTurn] = Poker[id][Eile];
			NextPlayer(id,1);
		}
		else 
			NextPlayer(id);
		

		new msg[128];
		format(msg,sizeof(msg),"[POKER] %s: Fold",ReturnName(Poker[id][players][pid]));
		SendMessageToPokerTable(id,-1,msg);
		return 1;
	}
	return 0;
}
stock NextTurn(id,player)
{
	new left;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
			left++;
	}
	if(left < 2) return -1;
	if(player == 5)
	{
		for(new i;i<6;i++)
		{
			if(Poker[id][players][i] != -1 && Poker[id][Playing][i]) return i;
		}
	}
	else
	{
		for(new i=player+1;i<6;i++)
		{
			if(Poker[id][players][i] != -1 && Poker[id][Playing][i]) return i;
		}
		for(new i=0;i<6;i++)
		{
			if(Poker[id][players][i] != -1 && Poker[id][Playing][i]) return i;
		}
	}
	return -1;
	/*
	new playersleft;
	new currentslot=-1,array[6]={-1,-1,...};
	new curentslotex=-1;
	for(new i;i<6;i++)
	{
		if(i==player)
		{
			curentslotex=playersleft;
		
		}
		//if(i==player) currentslot=playersleft;
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
		{
			array[playersleft]=i;
			if(i==player) currentslot=playersleft;
			playersleft++;
		}
	}
	if(currentslot == -1 && curentslotex != -1)
	{
		if(array[curen
	}
	if(playersleft==1) return -1;
	if(currentslot != -1)
	{
		if(currentslot == 5)
		{
			return array[0];
		}
		if(array[currentslot+1] != -1) return array[currentslot+1];
	}
	return array[0];
	*/
}
stock Raising(playerid,amount)
{	

	new id=-1;
	for(new i;i<MAX_POKER_GAMES;i++)
	{
		for(new x;x<6;x++)
		{
			if(Poker[i][players][x]==playerid)
			{
				id=i;
				break;
			}
		}
	}
	if(id==-1) return 0;
	PokerLog("Raising(%d, %d) called", playerid, amount);
	new maxstafke,pley=-1,currentbid;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
		{
			if(Poker[id][players][i] == playerid) pley=i;
			if(Poker[id][Playing][i] && Poker[id][players][i] != playerid )
			{
				if(Poker[id][PFondas][i] + Poker[id][PStatymas][i] > maxstafke)
				{
					maxstafke=Poker[id][PFondas][i] + Poker[id][PStatymas][i];
				}
				if(Poker[id][PStatymas][i] > currentbid)
				{
					currentbid=Poker[id][PStatymas][i];
				}
			}
		}
	}
	if(pley == -1) return 0;
	if(Poker[id][Eile] != pley) return 0;
	currentbid*=2;
	if(currentbid > maxstafke) currentbid=maxstafke;
	if(amount < currentbid)
		return SendInfoMessage(playerid,"Tiek jau pastatyta!");
	if(Poker[id][PFondas][pley] < amount)
		return SendInfoMessage(playerid,"Jus tiek neturite!");
	else if(amount > maxstafke || !amount)
	{
		return SendInfoMessage(playerid,"Tiek statyti negalite!");
	}
	else
	{
		Poker[id][PStatymas][pley]+=amount;
		Poker[id][PFondas][pley]-=amount;
		//Poker[id][Bankas]+=Poker[id][PStatymas][pley];
	}
	if(amount > 100000)
		ProcessAchievement(playerid,61);
	Poker[id][FirstTurn]=pley;
	new txt[128];
	for(new x;x<6;x++)
	{
		if(Poker[id][players][x] != -1 && Poker[id][Playing][x])
		{	
			new ppid = Poker[id][players][x];
			format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][pley]));
			TextDrawSetString(Poker[id][PokerMoney][pley],txt);
			TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][pley]);
			if(maxstafke == amount || Poker[id][PFondas][pley] == 0)
				format(txt,sizeof(txt),"All_In(%sEUR)",FormatNumber(amount));
			else
				format(txt,sizeof(txt),"Raise(%sEUR)",FormatNumber(amount));
			TextDrawSetString(Poker[id][PokerAction][pley],txt);
			TextDrawShowForPlayer(ppid,Poker[id][PokerAction][pley]);
		}
	}
	if(Poker[id][watching] != -1)
	{
		new ppid = Poker[id][watching];
		format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][pley]));
		TextDrawSetString(Poker[id][PokerMoney][pley],txt);
		TextDrawShowForPlayer(ppid,Poker[id][PokerMoney][pley]);
		if(maxstafke == amount || Poker[id][PFondas][pley] == 0)
			format(txt,sizeof(txt),"All_In(%sEUR)",FormatNumber(amount));
		else
			format(txt,sizeof(txt),"Raise(%sEUR)",FormatNumber(amount));
		TextDrawSetString(Poker[id][PokerAction][pley],txt);
		TextDrawShowForPlayer(ppid,Poker[id][PokerAction][pley]);
	}
	//CancelSelectTextDraw(playerid);
	PlaySoundForPoker(id,-1,SOUND_RAISE);
	new msg[128];
	format(msg,sizeof(msg),"[POKER] %s: Raise(%sEUR)",ReturnName(Poker[id][players][pley]),FormatNumber(amount));
	SendMessageToPokerTable(id,-1,msg);
	Poker[id][Eile] = NextTurn(id,pley);
	NextPlayer(id);
	return 1;
}
stock Flop(id,flop)
{
	if(!flop)
	{	
		for(new x;x<3;x++)
		{
			Poker[id][TableR][x]=Poker[id][CardsR][Poker[id][CardsUsed]];
			Poker[id][TableS][x]=Poker[id][CardsS][Poker[id][CardsUsed]];
			Poker[id][CardsUsed]++;
			SetTableCardBack(Poker[id][TableKorta][x]);
		}
		SetTimerEx("CardsUnpack",500,false,"iiii",id,1,0,PokerGen[id]);
		SendMessageToPokerTable(id,TEXTCOL_GREEN,"[POKER] FLOP");
	}
	else if(flop == 1)
	{
		Poker[id][TableR][3]=Poker[id][CardsR][Poker[id][CardsUsed]];
		Poker[id][TableS][3]=Poker[id][CardsS][Poker[id][CardsUsed]];
		Poker[id][CardsUsed]++;
		SetTableCardBack(Poker[id][TableKorta][3]);
		SetTimerEx("CardsUnpack",1000,false,"iiii",id,2,0,PokerGen[id]);
		SendMessageToPokerTable(id,TEXTCOL_GREEN,"[POKER] TURN");
	}
	else if(flop == 2)
	{
		Poker[id][TableR][4]=Poker[id][CardsR][Poker[id][CardsUsed]];
		Poker[id][TableS][4]=Poker[id][CardsS][Poker[id][CardsUsed]];
		Poker[id][CardsUsed]++;
		SetTableCardBack(Poker[id][TableKorta][4]);
		SetTimerEx("CardsUnpack",1000,false,"iiii",id,3,0,PokerGen[id]);
		SendMessageToPokerTable(id,TEXTCOL_GREEN,"[POKER] RIVER");
	}
	else if(flop == 3)
	{
		Poker[id][TheStep]=0;
		Poker[id][Eile]=-1;
		SetTimerEx("FinishGame",1000,false,"ii",id,PokerGen[id]);
		//FinishGame(id);
	}
	
}
forward FinishGame(id, gen);
public FinishGame(id, gen)
{
	if(gen != PokerGen[id] || !Poker[id][GameUsed]) return 0;
	for(new i;i<7;i++)
	{
		new playerid;
		if(i < 6)
			playerid=Poker[id][players][i];
		else
			playerid = Poker[id][watching];
		
		if(playerid != -1)
		{
			for(new x;x<6;x++)
			{
				// i==6 is the admin spectator (Poker[id][watching]); never flip hole cards face-up for him
				if(Poker[id][Playing][x] && i != 6)
				{
					new pid =Poker[id][players][x];
					SetPlayerCardFace(playerid,Korta[playerid][x][0],PHand[pid][0][rank],PHand[pid][0][suit]);
					SetPlayerCardFace(playerid,Korta[playerid][x][1],PHand[pid][1][rank],PHand[pid][1][suit]);
				}
			}
		}
	}
	SetTimerEx("GivePrize",2000,false,"ii",id,PokerGen[id]);
	return 1;
}
new const ComboArray[10][] = 
{
	"HIGH CARD",
	"ONE PAIR",
	"TWO PAIRS",
	"THREE OF A KIND",
	"STRAIGHT",
	"FLUSH",
	"FULL HOUSE",
	"FOUR OF A KIND",
	"STRAIGHT FLUSH",
	"ROYAL FLUSH"
};
forward GivePrize(id, gen);
public GivePrize(id, gen)
{
	if(gen != PokerGen[id] || Poker[id][GameUsed]==0) return;
	evaluateHands(id);
	new hcombo,hcombocard,hsecond,hkicker1,hkicker2,hkicker3;
	new winner[6],winners,maxplayer;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i])
		{
			if(Poker[id][PlayerCombo][i] > hcombo)
				hcombo=Poker[id][PlayerCombo][i];
		}
	}
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i] && Poker[id][PlayerCombo][i]==hcombo)
		{
			if(Poker[id][PlayerComboCard][i] > hcombocard)
				hcombocard=Poker[id][PlayerComboCard][i];
		}
	}
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i] && Poker[id][PlayerCombo][i]==hcombo && hcombocard==Poker[id][PlayerComboCard][i])
		{
			if(Poker[id][PlayerSecond][i] > hsecond)
				hsecond=Poker[id][PlayerSecond][i];
		}
	}
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i] && Poker[id][PlayerCombo][i]==hcombo && hcombocard==Poker[id][PlayerComboCard][i] && hsecond==Poker[id][PlayerSecond][i])
		{
			if(Poker[id][PlayerKicker1][i] > hkicker1)
				hkicker1=Poker[id][PlayerKicker1][i];
		}
	}
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i] && Poker[id][PlayerCombo][i]==hcombo && hcombocard==Poker[id][PlayerComboCard][i] && hsecond==Poker[id][PlayerSecond][i] && hkicker1==Poker[id][PlayerKicker1][i])
		{
			if(Poker[id][PlayerKicker2][i] > hkicker2)
				hkicker2=Poker[id][PlayerKicker2][i];
		}
	}
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i] && Poker[id][PlayerCombo][i]==hcombo && hcombocard==Poker[id][PlayerComboCard][i] && hsecond==Poker[id][PlayerSecond][i] && hkicker1==Poker[id][PlayerKicker1][i] && hkicker2==Poker[id][PlayerKicker2][i])
		{
			if(Poker[id][PlayerKicker3][i] > hkicker3)
				hkicker3=Poker[id][PlayerKicker3][i];
		}
	}
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][Playing][i] && Poker[id][PlayerCombo][i]==hcombo && hcombocard==Poker[id][PlayerComboCard][i] && hsecond==Poker[id][PlayerSecond][i] && hkicker1==Poker[id][PlayerKicker1][i] && hkicker2==Poker[id][PlayerKicker2][i] && hkicker3==Poker[id][PlayerKicker3][i])
		{
			winner[i]=1;
			maxplayer=i;
			//winners++;
		}
	}

	new howmanyppl;
	new biggestbank;
	new Suma;
	for(new x;x<6;x++)
	{
		if(Poker[id][players][x] != -1)
		{
			if(Poker[id][Playing][x])
				howmanyppl++;
			//howmanyppl++;
			if(winner[x])
			{
				Suma+=Poker[id][PBankai][x];
				if(Poker[id][PBankai][x] > biggestbank)
				{
					biggestbank=Poker[id][PBankai][x];
				}
				winners++;
			}
			else
			{
				for(new y;y<6;y++)
				{
					if(Poker[id][players][y] != -1)
					{
						new pid = Poker[id][players][y];
						PlayerTextDrawColor(pid,Korta[pid][x][0], TEXTDRAW_FOLD);
						PlayerTextDrawColor(pid,Korta[pid][x][1], TEXTDRAW_FOLD);
						PlayerTextDrawShow(pid,Korta[pid][x][0]);
						PlayerTextDrawShow(pid,Korta[pid][x][1]);
					}
					
				}
				if(Poker[id][watching] != -1)
				{
					new pid = Poker[id][watching];
					PlayerTextDrawColor(pid,Korta[pid][x][0], TEXTDRAW_FOLD);
					PlayerTextDrawColor(pid,Korta[pid][x][1], TEXTDRAW_FOLD);
					PlayerTextDrawShow(pid,Korta[pid][x][0]);
					PlayerTextDrawShow(pid,Korta[pid][x][1]);
				}
			}
		}
	}
	new msga[128]; 
	new Win=0;
	for(new i;i<6;i++) if(Poker[id][PBankai][i] > 0)
	{
		if(Poker[id][PBankai][i] <= biggestbank)
		{
			Win+=Poker[id][PBankai][i];
			if(!winner[i]) Poker[id][PBankai][i]=0;
			//Poker[id][PBankai][i]=0;
		}
		else
		{
			Win+=biggestbank;
			if(Poker[id][Playing][i])
			{
				new diff = Poker[id][PBankai][i]-biggestbank;
				format(msga,sizeof(msga),"[POKER] Jums grazinama %iEUR suma.",diff);
				SendClientMessage(Poker[id][players][i],TEXTCOL_WHITE,msga);
				Poker[id][PFondas][i]+=diff;
			}
			if(!winner[i]) Poker[id][PBankai][i]=0;
		}
	}
	
	if(winners == 1)
	{
		
		format(msga,sizeof(msga),"[POKER] Laimejo %s, turedamas %s",ReturnName(Poker[id][players][maxplayer]),ComboArray[Poker[id][PlayerCombo][maxplayer]]);
		SendMessageToPokerTable(id,TEXTCOL_GOLD,msga);
		new msgas[127];
		format(msgas,sizeof(msgas),"[POKER] Jus laimejote %iEUR.",Win);
		if(Win >= 1000000)
			ProcessAchievement(Poker[id][players][maxplayer],95);
		SendClientMessage(Poker[id][players][maxplayer],TEXTCOL_WHITE,msgas);
		Poker[id][PFondas][maxplayer]+=Win;
		PokerDB_Win(Poker[id][players][maxplayer], Win);
		Poker[id][Bankas]=0;
		/*if(Poker[id][PFondas][maxplayer] == 0 && biggestbank > Poker[id][PBankai][maxplayer])
		{
			new howmanyget = Poker[id][PBankai][maxplayer]*howmanyppl;
			if(Poker[id][Bankas] < howmanyget) howmanyget = Poker[id][Bankas];
			Poker[id][PFondas][maxplayer]+=howmanyget;
			Poker[id][Bankas]-=howmanyget;
			
			for(new x;x<6;x++)
			{
				if(Poker[id][Bankas])
				{
					if(Poker[id][players][x] != -1 && Poker[id][Playing][x] && x != maxplayer)
					{
						if(Poker[id][PBankai][x] > Poker[id][PBankai][maxplayer])
						{
							new moneys=Poker[id][PBankai][x] - Poker[id][PBankai][maxplayer];
							Poker[id][PFondas][x]+=moneys;
							Poker[id][Bankas]-=moneys;
						}
					}
				}
			}
			Poker[id][Bankas]=0;
		}
		else
		{
			Poker[id][PFondas][maxplayer]+=Poker[id][Bankas];
			Poker[id][Bankas]=0;
		}*/
	}
	else
	{
		format(msga,sizeof(msga),"[POKER] Laimejo:");
		new Float:wratio;
		//new maximum[6];
		for(new x;x<6;x++)
		{
			if(winner[x])
			{
				format(msga,sizeof(msga),"%s %s,",msga,ReturnName(Poker[id][players][x]));
				wratio=((Float:Poker[id][PBankai][x])/(Float:Suma)); // suma tai kiek laimetojai pastate
				new msgas[127];
				new winas=floatround(wratio*Win,floatround_floor);
				format(msgas,sizeof(msgas),"[POKER] Jus laimejote %iEUR.",winas);
				if(winas >= 1000000)
					ProcessAchievement(Poker[id][players][x],95);
				SendClientMessage(Poker[id][players][x],TEXTCOL_WHITE,msgas);
				Poker[id][PFondas][x]+=winas;
				PokerDB_Win(Poker[id][players][x], winas);
				/*new howmanyget = Poker[id][PBankai][x]*howmanyppl;
				maximum[x]=howmanyget;*/
				
			}
			//Poker[id][PBankai][x]=0;
		}
		/*new oldsplitas = -1;
		while(Poker[id][Bankas] > 10)
		{
			new splitas = floatround(Poker[id][Bankas]/winners);
			if(splitas == oldsplitas) break;
			oldsplitas = splitas;
			new left;
			for(new x;x<6;x++)
			{
				if(winner[x])
				{
					left++;
					if(splitas > maximum[x])
					{
						Poker[id][Bankas]-=maximum[x];
						Poker[id][PFondas][x]+=maximum[x];
						winner[x]=0;
						Poker[id][PBankai][x]=0;
					}
					else
					{
						Poker[id][Bankas]-=splitas;
						Poker[id][PFondas][x]+=splitas;
						maximum[x]-=splitas;
					}
				}
				
			}
			if(!left) break;
		}*/
		Poker[id][Bankas]=0;
		
		format(msga,sizeof(msga),"%s turedami %s",msga,ComboArray[Poker[id][PlayerCombo][maxplayer]]);
		SendMessageToPokerTable(id,TEXTCOL_GOLD,msga);
		Poker[id][Bankas]=0;
		
	
	}
	for(new i;i<6;i++) Poker[id][PBankai][i]=0;
	SetTimerEx("EndGame",5000,false,"ii",id,PokerGen[id]);
	//EndGame(id);
	//NewSet(id);
	
}
forward CardsUnpack(id,unpack,step,gen);
public CardsUnpack(id,unpack,step,gen)
{
	if(gen != PokerGen[id] || !Poker[id][GameUsed]) return 0; // game ended / restarted: stop the chain

	for(new i;i<7;i++)
	{
		new playerid;
		if(i < 6) playerid = Poker[id][players][i];
		else playerid=Poker[id][watching];
		if(playerid != -1)
		{
			if(!unpack) // gavo kortas
			{
				if(!step)
				{
					new txt[20];
					TextDrawHideForPlayer(playerid,Poker[id][JusuEile]);
					for(new x;x<6;x++)
					{
						if(Poker[id][players][x] != -1 && Poker[id][Playing][x])
						{
							new name[MAX_PLAYER_NAME];
							GetPlayerName(Poker[id][players][x],name,MAX_PLAYER_NAME);
							TextDrawSetString(Poker[id][PokerName][x],name);
							TextDrawShowForPlayer(playerid,Poker[id][PokerName][x]);
							format(txt,sizeof(txt),"%sEUR",FormatNumber(Poker[id][PFondas][x]));
							TextDrawSetString(Poker[id][PokerMoney][x],txt);
							
							TextDrawShowForPlayer(playerid,Poker[id][PokerMoney][x]);
							SetPlayerCardBack(playerid,Korta[playerid][x][0]);
							SetPlayerCardBack(playerid,Korta[playerid][x][1]);
							PlayerTextDrawColor(playerid,Korta[playerid][x][0],CARD_COLOR_DEFAULT);
							PlayerTextDrawColor(playerid,Korta[playerid][x][1],CARD_COLOR_DEFAULT);
							PlayerTextDrawShow(playerid, Korta[playerid][x][0]);
							PlayerTextDrawShow(playerid, Korta[playerid][x][1]);
							TextDrawShowForPlayer(playerid,Poker[id][PokerAction][x]);
						}
						else if(Poker[id][players][x] == -1)
						{
							TextDrawHideForPlayer(playerid,Poker[id][PokerAction][x]);
							TextDrawHideForPlayer(playerid,Poker[id][PokerMoney][x]);
							TextDrawHideForPlayer(playerid,Poker[id][PokerName][x]);
							for(new z;z<2;z++)
							{
								PlayerTextDrawHide(playerid,Korta[playerid][x][z]);
							}
						}
					}
				}
				else if(step == 1 && i != 6)
				{
					SetPlayerCardFace(playerid,Korta[playerid][i][0],PHand[playerid][0][rank],PHand[playerid][0][suit]);
				}
				else if(step == 2 && i != 6)
				{
					SetPlayerCardFace(playerid,Korta[playerid][i][1],PHand[playerid][1][rank],PHand[playerid][1][suit]);
				}
				else if(step == 3) return 1;
			}
			else if(unpack == 1)
			{
				if(step < 3)
				{
					TextDrawShowForPlayer(playerid, Poker[id][TableKorta][step]);
				}
				else if(step < 6)
				{
					SetTableCardFace(Poker[id][TableKorta][step-3],Poker[id][TableR][step-3],Poker[id][TableS][step-3]);
					TextDrawShowForPlayer(playerid, Poker[id][TableKorta][step-3]);
				}
				else return 1;
			}
			else if(unpack == 2)
			{
				if(!step)
				{
					TextDrawShowForPlayer(playerid, Poker[id][TableKorta][3]);
				}
				else if(step == 1)
				{
					SetTableCardFace(Poker[id][TableKorta][3],Poker[id][TableR][3],Poker[id][TableS][3]);
					TextDrawShowForPlayer(playerid, Poker[id][TableKorta][3]);
				}
				else return 1;
			}
			else if(unpack == 3)
			{
				if(!step)
				{
					TextDrawShowForPlayer(playerid, Poker[id][TableKorta][4]);
				}
				else if(step == 1)
				{
					SetTableCardFace(Poker[id][TableKorta][4],Poker[id][TableR][4],Poker[id][TableS][4]);
					TextDrawShowForPlayer(playerid, Poker[id][TableKorta][4]);
				}
				else return 1;
			}
		}
	}
	if(!unpack)
		SetTimerEx("CardsUnpack",1000,false,"iiii",id,unpack,step+1,gen);
	if(!unpack && step == 2) NextPlayer(id,1);
	else if(unpack == 1 || unpack == 2 || unpack == 3)
		SetTimerEx("CardsUnpack",500,false,"iiii",id,unpack,step+1,gen);
	return 1;
}

stock ShowJusuEile(playerid, id)
{
	new amount;
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1 && Poker[id][players][i] != playerid)
		{
			if(Poker[id][PStatymas][i] > amount)
			{
				amount = Poker[id][PStatymas][i];
			}
		}
	}
	amount-=Poker[id][PStatymas][Poker[id][Eile]];
	
	new msg[256];
	if(amount > 0)
	{
		format(msg,sizeof(msg),"jusu eile~n~~n~~n~~n~~n~               %s",shortformat(amount));
	}
	else
	{
		format(msg,sizeof(msg),"jusu eile");
	}
	TextDrawSetString(Poker[id][JusuEile], msg);
	TextDrawShowForPlayer(playerid,Poker[id][JusuEile]);
}

stock shortformat(number)
{
	new str[25];
	if(number < 1000) 
	{
		format(str,sizeof(str),"%i",number);
	}
	else if(number < 10000)
	{
		format(str,sizeof(str),"%.1fk",(number/1000.0));
	}
	else if(number < 1000000)
	{
		new thousands = floatround(number / 1000, floatround_ceil);
		format(str,sizeof(str),"%ik",thousands);
	}
	else
	{
		format(str,sizeof(str),"%.1fm",(number / 1000000.0));
	}
	return str;
}

/*
0- high card/no pair
1- one pair
2- two pair
3- three of a kind
4- straight
5- flush
6- full house
7- four of a kind
8- straight flush
9- royal flush
*/

stock getScore(player,&combo,&combocard,&combosecond,&kicker1,&kicker2,&kicker3)
{
	#pragma unused player
	//quickSort(hand,0, sizeof(hand) - 1);
	quickSort(hand, 0, sizeof(hand) - 1); // sort the 5 cards by rank, ascending
	combo=0;
	combocard=0;
	combosecond=0;
	kicker1=0;
	kicker2=0;
	kicker3=0;
	new straight,flush,four;
	new k;
	/*checks for flush*/
	while (k<4&&hand[k][suit]==hand[k+1][suit])
		k++;
	if (k==4)
	{
		combo=5; // flush
		combocard=hand[k][rank];
		combosecond=hand[k-1][rank];
		kicker1=hand[k-2][rank];
		kicker2=hand[k-3][rank];
		kicker3=hand[k-4][rank];
		flush=1;
	}

	/* checks for straight*/
	k=0;
	while (k<4&&hand[k][rank]==hand[k+1][rank]-1)
		k++;
	if (k==4)
	{
		combo=4; // straight
		combocard=hand[k][rank];
		combosecond=hand[k-1][rank];
		kicker1=hand[k-2][rank];
		kicker2=hand[k-3][rank];
		kicker3=hand[k-4][rank];
		straight=1;
	}
	if(hand[4][rank] == 12 && hand[0][rank] == 0 && hand[1][rank] == 1 && hand[2][rank]== 2 && hand[3][rank] == 3)
	{
		combo=4; // straight
		combocard=hand[3][rank];
		combosecond=hand[2][rank];
		kicker1=hand[1][rank];
		kicker2=hand[0][rank];
		kicker3=hand[4][rank];
		straight=1;
	}
	if(straight && flush)
	{
		combo=8; // straight flush
		combocard=hand[4][rank];
		combosecond=hand[3][rank];
		kicker1=hand[2][rank];
		kicker2=hand[1][rank];
		kicker3=hand[0][rank];

		if(hand[4][rank] == 12)
		{
			combo=9; // royal
			combocard=hand[4][rank];
			combosecond=hand[3][rank];
			kicker1=hand[2][rank];
			kicker2=hand[1][rank];
			kicker3=hand[0][rank];
		}
	}
	/* checks for fours */
	k=0;
	for (new i=0;i<2;i++)
	{
		k = i;
		while (k<i+3&&hand[k][rank]==hand[k+1][rank])
			k++;
		if (k==i+3)
		{
			combo=7; // four of a kind
			four=1;
			if(i==0)
			{	
				kicker1=hand[4][rank];
				kicker2=0;
				kicker3=0;
			}
			else
			{
				kicker1=hand[0][rank];
				kicker2=0;
				kicker3=0;
			}
			combocard=hand[2][rank];
			combosecond=0;
		}
	}

	/*checks for threes and fullhouse*/
	if (!four)
	{
		for (new i=0;i<3;i++)
		{
			k = i;
			while (k<i+2&&hand[k][rank]==hand[k+1][rank])
				k++;
			if (k==i+2)
			{
				combo=3; // three of a kind
				combocard=hand[k][rank];
				combosecond=0;
				kicker1=hand[2][rank];
				kicker2=hand[1][rank];
				kicker3=hand[0][rank];
				if (i==0)
				{
					if (hand[3][rank]==hand[4][rank])
					{
						combo=6;//full house
						combosecond=hand[3][rank];
						kicker1=0;
						kicker2=0;
						kicker3=0;
						//kickers+=hand[3][rank]*10;
					}
					else
					{
						kicker1=hand[4][rank];
						kicker2=hand[3][rank];
						kicker3=0;
					}
				}
				else if(i==1)
				{
					if (hand[0][rank]==hand[4][rank])
					{
						combo=6;//full house
						combosecond=hand[0][rank];
						kicker1=0;
						kicker2=0;
						kicker3=0;
					}
					else
					{
						kicker1=hand[4][rank];
						kicker2=hand[0][rank];
						kicker3=0;
					}
				}
				else
				{
					if (hand[0][rank]==hand[1][rank])
					{
						combo=6;//full house
						combosecond=hand[0][rank];
						kicker1=0;
						kicker2=0;
						kicker3=0;
					}
					else
					{
						kicker1=hand[1][rank];
						kicker2=hand[0][rank];
						kicker3=0;
					}
				}

			}
		}
	}
	if(combo) return combo;
	/* checks for pairs*/
	new inpair[5];
	combo=0;
	for (k=0;k<4;k++)
	{
		if (hand[k][rank]==hand[k+1][rank])
		{
			inpair[k]=1;
			inpair[k+1]=1;
			combo++; // pair
			if(combo==1)
			{
				combocard=hand[k][rank];
				combosecond=0;
			}
			else
			{
				if(combocard < hand[k][rank])
				{
					combosecond=combocard;
					combocard=hand[k][rank];
				}
				else
				{
					combosecond=hand[k][rank];
				}
			}
		}
	}
	new slot[3];
	//new highestslot=-1;
	if(combo)
	{
		for(new i;i<5;i++)
		{
			if(!inpair[i])
			{
				if(hand[i][rank] >= slot[0])
				{
					slot[2]=slot[1];
					slot[1]=slot[0];
					slot[0]=hand[i][rank];
				}
				else if(hand[i][rank] >= slot[1])
				{
					slot[2]=slot[1];
					slot[1]=hand[i][rank];
				}
				else
				{
					slot[2]=hand[i][rank];
				}
				//kickers+=((hand[i][rank])*(i+1));
			}
		}
	}
	kicker1=slot[0];
	kicker2=slot[1];
	kicker3=slot[2];
	if(!combo)
	{
		combocard=hand[4][rank];
		combosecond=hand[3][rank];
		kicker1=hand[2][rank];
		kicker2=hand[1][rank];
		kicker3=hand[0][rank];
	}
	return combo;
	/*
	//high*=10;
	if (pairs==2)
		return 5000 + high + secondhigh + kickers;
	else if(pairs)
		return 3000 + high + kickers;
	high = hand[4][rank]*100;
	secondhigh = hand[3][rank]*10;
	new thirdhigh,fourthhigh,fifthhigh;
	thirdhigh = hand[2][rank]*5;
	fourthhigh = hand[1][rank]*2;
	fifthhigh = hand[0][rank];
	//for(new i;i<3;i++)
	//	kickers+=hand[i][rank]*(10^(i+1));
	return high+secondhigh+thirdhigh+fourthhigh+fifthhigh;*/
}
/*
stock mysort(array[][Card])
{
	new temparray[Card];
	for(new i;i<5;i++)
	{
		if(array[i][
	
	}

} */
stock quickSort(array[][card], left, right)
{
    new
        tempLeft = left,
        tempRight = right,
        pivot = array[(left + right) / 2][rank],
        tempVar,
		tempsuit
    ;
    while(tempLeft <= tempRight)
    {
        while(array[tempLeft][rank] < pivot) tempLeft++;
        while(array[tempRight][rank] > pivot) tempRight--;
        
        if(tempLeft <= tempRight)
        {
            tempVar = array[tempLeft][rank], array[tempLeft][rank] = array[tempRight][rank], array[tempRight][rank] = tempVar;
			tempsuit = array[tempLeft][suit], array[tempLeft][suit] = array[tempRight][suit], array[tempRight][suit] = tempsuit;
            tempLeft++, tempRight--;
        }
    }
    if(left < tempRight) quickSort(array, left, tempRight);
    if(tempLeft < right) quickSort(array, tempLeft, right);
}

stock GetTDName(rankas,suitas)
{
	return (rankas+(suitas*13));
}
//#include <zcmd>

stock PlaySoundForPoker(id,playerid,soundid)
{
	//new falsas=0;
	//if(!falsas) return 0;
	new Float:Coo[3];
	if(playerid == -1)
	{
		for(new i;i<6;i++)
		{
			if(Poker[id][players][i] != -1)
			{
				GetPlayerPos(Poker[id][players][i],Coo[0],Coo[1],Coo[2]);
				PlayerPlaySound(Poker[id][players][i],soundid,Coo[0],Coo[1],Coo[2]);
			}
		}
	}
	else
	{
		GetPlayerPos(playerid,Coo[0],Coo[1],Coo[2]);
		PlayerPlaySound(playerid,soundid,Coo[0],Coo[1],Coo[2]);
	}

	return 1;
}

stock CreatePokerTextDraws(id)
{
	Poker[id][PokerName][0] = TextDrawCreate(465.000000, 176.000000, "Vardenis_Pavardenis");
	TextDrawAlignment(Poker[id][PokerName][0], 2);
	TextDrawBackgroundColor(Poker[id][PokerName][0], 255);
	TextDrawFont(Poker[id][PokerName][0], 1);
	TextDrawLetterSize(Poker[id][PokerName][0], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerName][0], -1);
	TextDrawSetOutline(Poker[id][PokerName][0], 0);
	TextDrawSetProportional(Poker[id][PokerName][0], 1);
	TextDrawSetShadow(Poker[id][PokerName][0], 0);
	TextDrawUseBox(Poker[id][PokerName][0], 1);
	TextDrawBoxColor(Poker[id][PokerName][0], 842202980);
	TextDrawTextSize(Poker[id][PokerName][0], 232.000000, -80.000000);

	Poker[id][PokerName][1] = TextDrawCreate(562.000000, 318.000000, "Vardenis_Pavardenis");
	TextDrawAlignment(Poker[id][PokerName][1], 2);
	TextDrawBackgroundColor(Poker[id][PokerName][1], 255);
	TextDrawFont(Poker[id][PokerName][1], 1);
	TextDrawLetterSize(Poker[id][PokerName][1], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerName][1], -1);
	TextDrawSetOutline(Poker[id][PokerName][1], 0);
	TextDrawSetProportional(Poker[id][PokerName][1], 1);
	TextDrawSetShadow(Poker[id][PokerName][1], 0);
	TextDrawUseBox(Poker[id][PokerName][1], 1);
	TextDrawBoxColor(Poker[id][PokerName][1], 842202980);
	TextDrawTextSize(Poker[id][PokerName][1], 232.000000, -80.000000);

	Poker[id][PokerName][2] = TextDrawCreate(375.000000, 366.000000, "Vardenis_Pavardenis");
	TextDrawAlignment(Poker[id][PokerName][2], 2);
	TextDrawBackgroundColor(Poker[id][PokerName][2], 255);
	TextDrawFont(Poker[id][PokerName][2], 1);
	TextDrawLetterSize(Poker[id][PokerName][2], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerName][2], -1);
	TextDrawSetOutline(Poker[id][PokerName][2], 0);
	TextDrawSetProportional(Poker[id][PokerName][2], 1);
	TextDrawSetShadow(Poker[id][PokerName][2], 0);
	TextDrawUseBox(Poker[id][PokerName][2], 1);
	TextDrawBoxColor(Poker[id][PokerName][2], 842202980);
	TextDrawTextSize(Poker[id][PokerName][2], 232.000000, -80.000000);

	Poker[id][PokerName][3] = TextDrawCreate(235.000000, 366.000000, "Vardenis_Pavardenis");
	TextDrawAlignment(Poker[id][PokerName][3], 2);
	TextDrawBackgroundColor(Poker[id][PokerName][3], 255);
	TextDrawFont(Poker[id][PokerName][3], 1);
	TextDrawLetterSize(Poker[id][PokerName][3], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerName][3], -1);
	TextDrawSetOutline(Poker[id][PokerName][3], 0);
	TextDrawSetProportional(Poker[id][PokerName][3], 1);
	TextDrawSetShadow(Poker[id][PokerName][3], 0);
	TextDrawUseBox(Poker[id][PokerName][3], 1);
	TextDrawBoxColor(Poker[id][PokerName][3], 842202980);
	TextDrawTextSize(Poker[id][PokerName][3], 232.000000, -80.000000);

	Poker[id][PokerName][4] = TextDrawCreate(101.000000, 316.000000, "Vardenis_Pavardenis");
	TextDrawAlignment(Poker[id][PokerName][4], 2);
	TextDrawBackgroundColor(Poker[id][PokerName][4], 255);
	TextDrawFont(Poker[id][PokerName][4], 1);
	TextDrawLetterSize(Poker[id][PokerName][4], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerName][4], -1);
	TextDrawSetOutline(Poker[id][PokerName][4], 0);
	TextDrawSetProportional(Poker[id][PokerName][4], 1);
	TextDrawSetShadow(Poker[id][PokerName][4], 0);
	TextDrawUseBox(Poker[id][PokerName][4], 1);
	TextDrawBoxColor(Poker[id][PokerName][4], 842202980);
	TextDrawTextSize(Poker[id][PokerName][4], 232.000000, -80.000000);

	Poker[id][PokerName][5] = TextDrawCreate(175.000000, 176.000000, "Vardenis_Pavardenis");
	TextDrawAlignment(Poker[id][PokerName][5], 2);
	TextDrawBackgroundColor(Poker[id][PokerName][5], 255);
	TextDrawFont(Poker[id][PokerName][5], 1);
	TextDrawLetterSize(Poker[id][PokerName][5], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerName][5], -1);
	TextDrawSetOutline(Poker[id][PokerName][5], 0);
	TextDrawSetProportional(Poker[id][PokerName][5], 1);
	TextDrawSetShadow(Poker[id][PokerName][5], 0);
	TextDrawUseBox(Poker[id][PokerName][5], 1);
	TextDrawBoxColor(Poker[id][PokerName][5], 842202980);
	TextDrawTextSize(Poker[id][PokerName][5], 232.000000, -80.000000);

	Poker[id][PokerMoney][0] = TextDrawCreate(465.000000, 186.000000, "0EUR");
	TextDrawAlignment(Poker[id][PokerMoney][0], 2);
	TextDrawBackgroundColor(Poker[id][PokerMoney][0], 255);
	TextDrawFont(Poker[id][PokerMoney][0], 1);
	TextDrawLetterSize(Poker[id][PokerMoney][0], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerMoney][0], -1);
	TextDrawSetOutline(Poker[id][PokerMoney][0], 0);
	TextDrawSetProportional(Poker[id][PokerMoney][0], 1);
	TextDrawSetShadow(Poker[id][PokerMoney][0], 0);
	TextDrawUseBox(Poker[id][PokerMoney][0], 1);
	TextDrawBoxColor(Poker[id][PokerMoney][0], 855585380);
	TextDrawTextSize(Poker[id][PokerMoney][0], 270.000000, -80.000000);

	Poker[id][PokerMoney][1] = TextDrawCreate(562.000000, 328.000000, "0EUR");
	TextDrawAlignment(Poker[id][PokerMoney][1], 2);
	TextDrawBackgroundColor(Poker[id][PokerMoney][1], 255);
	TextDrawFont(Poker[id][PokerMoney][1], 1);
	TextDrawLetterSize(Poker[id][PokerMoney][1], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerMoney][1], -1);
	TextDrawSetOutline(Poker[id][PokerMoney][1], 0);
	TextDrawSetProportional(Poker[id][PokerMoney][1], 1);
	TextDrawSetShadow(Poker[id][PokerMoney][1], 0);
	TextDrawUseBox(Poker[id][PokerMoney][1], 1);
	TextDrawBoxColor(Poker[id][PokerMoney][1], 855585380);
	TextDrawTextSize(Poker[id][PokerMoney][1], 270.000000, -80.000000);

	Poker[id][PokerMoney][2] = TextDrawCreate(375.000000, 376.000000, "0EUR");
	TextDrawAlignment(Poker[id][PokerMoney][2], 2);
	TextDrawBackgroundColor(Poker[id][PokerMoney][2], 255);
	TextDrawFont(Poker[id][PokerMoney][2], 1);
	TextDrawLetterSize(Poker[id][PokerMoney][2], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerMoney][2], -1);
	TextDrawSetOutline(Poker[id][PokerMoney][2], 0);
	TextDrawSetProportional(Poker[id][PokerMoney][2], 1);
	TextDrawSetShadow(Poker[id][PokerMoney][2], 0);
	TextDrawUseBox(Poker[id][PokerMoney][2], 1);
	TextDrawBoxColor(Poker[id][PokerMoney][2], 855585380);
	TextDrawTextSize(Poker[id][PokerMoney][2], 270.000000, -80.000000);

	Poker[id][PokerMoney][3] = TextDrawCreate(235.000000, 376.000000, "0EUR");
	TextDrawAlignment(Poker[id][PokerMoney][3], 2);
	TextDrawBackgroundColor(Poker[id][PokerMoney][3], 255);
	TextDrawFont(Poker[id][PokerMoney][3], 1);
	TextDrawLetterSize(Poker[id][PokerMoney][3], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerMoney][3], -1);
	TextDrawSetOutline(Poker[id][PokerMoney][3], 0);
	TextDrawSetProportional(Poker[id][PokerMoney][3], 1);
	TextDrawSetShadow(Poker[id][PokerMoney][3], 0);
	TextDrawUseBox(Poker[id][PokerMoney][3], 1);
	TextDrawBoxColor(Poker[id][PokerMoney][3], 855585380);
	TextDrawTextSize(Poker[id][PokerMoney][3], 270.000000, -80.000000);

	Poker[id][PokerMoney][4] = TextDrawCreate(101.000000, 326.000000, "0EUR");
	TextDrawAlignment(Poker[id][PokerMoney][4], 2);
	TextDrawBackgroundColor(Poker[id][PokerMoney][4], 255);
	TextDrawFont(Poker[id][PokerMoney][4], 1);
	TextDrawLetterSize(Poker[id][PokerMoney][4], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerMoney][4], -1);
	TextDrawSetOutline(Poker[id][PokerMoney][4], 0);
	TextDrawSetProportional(Poker[id][PokerMoney][4], 1);
	TextDrawSetShadow(Poker[id][PokerMoney][4], 0);
	TextDrawUseBox(Poker[id][PokerMoney][4], 1);
	TextDrawBoxColor(Poker[id][PokerMoney][4], 855585380);
	TextDrawTextSize(Poker[id][PokerMoney][4], 270.000000, -80.000000);

	Poker[id][PokerMoney][5] = TextDrawCreate(175.000000, 186.000000, "0EUR");
	TextDrawAlignment(Poker[id][PokerMoney][5], 2);
	TextDrawBackgroundColor(Poker[id][PokerMoney][5], 255);
	TextDrawFont(Poker[id][PokerMoney][5], 1);
	TextDrawLetterSize(Poker[id][PokerMoney][5], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerMoney][5], -1);
	TextDrawSetOutline(Poker[id][PokerMoney][5], 0);
	TextDrawSetProportional(Poker[id][PokerMoney][5], 1);
	TextDrawSetShadow(Poker[id][PokerMoney][5], 0);
	TextDrawUseBox(Poker[id][PokerMoney][5], 1);
	TextDrawBoxColor(Poker[id][PokerMoney][5], 855585380);
	TextDrawTextSize(Poker[id][PokerMoney][5], 270.000000, -80.000000);

	Poker[id][PokerAction][0] = TextDrawCreate(465.000000, 196.000000, "Action");
	TextDrawAlignment(Poker[id][PokerAction][0], 2);
	TextDrawBackgroundColor(Poker[id][PokerAction][0], 255);
	TextDrawFont(Poker[id][PokerAction][0], 1);
	TextDrawLetterSize(Poker[id][PokerAction][0], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerAction][0], -1);
	TextDrawSetOutline(Poker[id][PokerAction][0], 0);
	TextDrawSetProportional(Poker[id][PokerAction][0], 1);
	TextDrawSetShadow(Poker[id][PokerAction][0], 0);
	TextDrawUseBox(Poker[id][PokerAction][0], 1);
	TextDrawBoxColor(Poker[id][PokerAction][0], -13487516);
	TextDrawTextSize(Poker[id][PokerAction][0], 270.000000, -80.000000);

	Poker[id][PokerAction][1] = TextDrawCreate(562.000000, 338.000000, "Action");
	TextDrawAlignment(Poker[id][PokerAction][1], 2);
	TextDrawBackgroundColor(Poker[id][PokerAction][1], 255);
	TextDrawFont(Poker[id][PokerAction][1], 1);
	TextDrawLetterSize(Poker[id][PokerAction][1], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerAction][1], -1);
	TextDrawSetOutline(Poker[id][PokerAction][1], 0);
	TextDrawSetProportional(Poker[id][PokerAction][1], 1);
	TextDrawSetShadow(Poker[id][PokerAction][1], 0);
	TextDrawUseBox(Poker[id][PokerAction][1], 1);
	TextDrawBoxColor(Poker[id][PokerAction][1], -13487516);
	TextDrawTextSize(Poker[id][PokerAction][1], 270.000000, -80.000000);

	Poker[id][PokerAction][2] = TextDrawCreate(375.000000, 386.000000, "Action");
	TextDrawAlignment(Poker[id][PokerAction][2], 2);
	TextDrawBackgroundColor(Poker[id][PokerAction][2], 255);
	TextDrawFont(Poker[id][PokerAction][2], 1);
	TextDrawLetterSize(Poker[id][PokerAction][2], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerAction][2], -1);
	TextDrawSetOutline(Poker[id][PokerAction][2], 0);
	TextDrawSetProportional(Poker[id][PokerAction][2], 1);
	TextDrawSetShadow(Poker[id][PokerAction][2], 0);
	TextDrawUseBox(Poker[id][PokerAction][2], 1);
	TextDrawBoxColor(Poker[id][PokerAction][2], -13487516);
	TextDrawTextSize(Poker[id][PokerAction][2], 270.000000, -80.000000);

	Poker[id][PokerAction][3] = TextDrawCreate(235.000000, 386.000000, "Action");
	TextDrawAlignment(Poker[id][PokerAction][3], 2);
	TextDrawBackgroundColor(Poker[id][PokerAction][3], 255);
	TextDrawFont(Poker[id][PokerAction][3], 1);
	TextDrawLetterSize(Poker[id][PokerAction][3], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerAction][3], -1);
	TextDrawSetOutline(Poker[id][PokerAction][3], 0);
	TextDrawSetProportional(Poker[id][PokerAction][3], 1);
	TextDrawSetShadow(Poker[id][PokerAction][3], 0);
	TextDrawUseBox(Poker[id][PokerAction][3], 1);
	TextDrawBoxColor(Poker[id][PokerAction][3], -13487516);
	TextDrawTextSize(Poker[id][PokerAction][3], 270.000000, -80.000000);

	Poker[id][PokerAction][4] = TextDrawCreate(101.000000, 336.000000, "Action");
	TextDrawAlignment(Poker[id][PokerAction][4], 2);
	TextDrawBackgroundColor(Poker[id][PokerAction][4], 255);
	TextDrawFont(Poker[id][PokerAction][4], 1);
	TextDrawLetterSize(Poker[id][PokerAction][4], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerAction][4], -1);
	TextDrawSetOutline(Poker[id][PokerAction][4], 0);
	TextDrawSetProportional(Poker[id][PokerAction][4], 1);
	TextDrawSetShadow(Poker[id][PokerAction][4], 0);
	TextDrawUseBox(Poker[id][PokerAction][4], 1);
	TextDrawBoxColor(Poker[id][PokerAction][4], -13487516);
	TextDrawTextSize(Poker[id][PokerAction][4], 270.000000, -80.000000);

	Poker[id][PokerAction][5] = TextDrawCreate(175.000000, 196.000000, "Action");
	TextDrawAlignment(Poker[id][PokerAction][5], 2);
	TextDrawBackgroundColor(Poker[id][PokerAction][5], 255);
	TextDrawFont(Poker[id][PokerAction][5], 1);
	TextDrawLetterSize(Poker[id][PokerAction][5], 0.220000, 0.699999);
	TextDrawColor(Poker[id][PokerAction][5], -1);
	TextDrawSetOutline(Poker[id][PokerAction][5], 0);
	TextDrawSetProportional(Poker[id][PokerAction][5], 1);
	TextDrawSetShadow(Poker[id][PokerAction][5], 0);
	TextDrawUseBox(Poker[id][PokerAction][5], 1);
	TextDrawBoxColor(Poker[id][PokerAction][5], -13487516);
	TextDrawTextSize(Poker[id][PokerAction][5], 270.000000, -80.000000);

	Poker[id][TableKorta][0] = CreateCardTextDraw(226.000000, 241.000000);

	Poker[id][TableKorta][1] = CreateCardTextDraw(263.000000, 241.000000);

	Poker[id][TableKorta][2] = CreateCardTextDraw(301.000000, 241.000000);

	Poker[id][TableKorta][3] = CreateCardTextDraw(339.000000, 241.000000);

	Poker[id][TableKorta][4] = CreateCardTextDraw(377.000000, 241.000000);

	Poker[id][BankTD] = TextDrawCreate(321.000000, 221.000000, "1,000,000EUR");
	TextDrawAlignment(Poker[id][BankTD], 2);
	TextDrawBackgroundColor(Poker[id][BankTD], 255);
	TextDrawFont(Poker[id][BankTD], 1);
	TextDrawLetterSize(Poker[id][BankTD], 0.400000, 0.799999);
	TextDrawColor(Poker[id][BankTD], -1);
	TextDrawSetOutline(Poker[id][BankTD], 0);
	TextDrawSetProportional(Poker[id][BankTD], 1);
	TextDrawSetShadow(Poker[id][BankTD], 1);
	TextDrawUseBox(Poker[id][BankTD], 1);
	TextDrawBoxColor(Poker[id][BankTD], 255);
	TextDrawTextSize(Poker[id][BankTD], 325.000000, 90.000000);

	Poker[id][JusuEile] = TextDrawCreate(11.000000, 129.000000, "Jusu eile");
	TextDrawBackgroundColor(Poker[id][JusuEile], 255);
	TextDrawFont(Poker[id][JusuEile], 2);
	TextDrawLetterSize(Poker[id][JusuEile], 0.500000, 1.000000);
	TextDrawColor(Poker[id][JusuEile], -1);
	TextDrawSetOutline(Poker[id][JusuEile], 0);
	TextDrawSetProportional(Poker[id][JusuEile], 1);
	TextDrawSetShadow(Poker[id][JusuEile], 1);
	return 1;
}

#if defined _formatnumber_included
	#endinput
#else
	#define _formatnumber_included
#endif

#if !defined HEX_PREFIX
	#define HEX_PREFIX  "0x"
#endif

#if !defined BIT_PREFIX
	#define BIT_PREFIX  "0b"
#endif

#if !defined DEFAULT_DECIMAL_COUNT
	#define DEFAULT_DECIMAL_COUNT  8
#endif

#if !defined DEFAULT_THOUSAND_SEP
	#define DEFAULT_THOUSAND_SEP  '.'
#endif

#if !defined DEFAULT_DECIMAL_POINT
	#define DEFAULT_DECIMAL_POINT  ','
#endif

stock FormatNumber( { _, Float, Text3D, Menu, Text, DB, DBResult, bool, File, hex, bit, bit_byte, Bit }:xVariable, iDecimals = -1, iThousandSeparator = DEFAULT_THOUSAND_SEP, iDecimalPoint = DEFAULT_DECIMAL_POINT)
{

	static
		s_szReturn[ 32 ],
		s_szThousandSeparator[ 2 ] = { ' ', EOS },
		s_iDecimalPos,
		s_iChar,
		s_iSepPos
	;
	new neg = 0;

	if(xVariable < 0)
	{
		xVariable = xVariable*(-1);
		neg = 1;
	}

	
	format( s_szReturn, sizeof( s_szReturn ), "%d", xVariable );
	
	if ( iDecimals > 0 )
	{
		strcat( s_szReturn, "." );
		
		while ( iDecimals-- )
			strcat( s_szReturn, "0" );
	}
	
	s_iDecimalPos = strfind( s_szReturn, "." );
	
	if ( s_iDecimalPos == -1 )
		s_iDecimalPos = strlen( s_szReturn );
	else
		s_szReturn[ s_iDecimalPos ] = iDecimalPoint;
	
	if ( s_iDecimalPos >= 4 && iThousandSeparator )
	{
		s_szThousandSeparator[ 0 ] = iThousandSeparator;
		
		s_iChar = s_iDecimalPos;
		s_iSepPos = 0;
		
		while ( --s_iChar > 0 )
		{
			if ( ++s_iSepPos == 3 )
			{
				strins( s_szReturn, s_szThousandSeparator, s_iChar );
				
				s_iSepPos = 0;
			}
		}
	}
	if(neg == 1)
	{
		xVariable = xVariable*(-1);
		format( s_szReturn, sizeof( s_szReturn ), "-%s", s_szReturn );
	}
	return s_szReturn;
}

stock CreatePlayerTextDraws(playerid)
{
	Korta[playerid][0][0] = CreatePlayerCardTextDraw(playerid, 430.000000, 140.000000);

	Korta[playerid][0][1] = CreatePlayerCardTextDraw(playerid, 464.000000, 140.000000);

	Korta[playerid][1][0] = CreatePlayerCardTextDraw(playerid, 527.000000, 282.000000);

	Korta[playerid][1][1] = CreatePlayerCardTextDraw(playerid, 561.000000, 282.000000);

	Korta[playerid][2][0] = CreatePlayerCardTextDraw(playerid, 340.000000, 330.000000);

	Korta[playerid][2][1] = CreatePlayerCardTextDraw(playerid, 374.000000, 330.000000);

	Korta[playerid][3][0] = CreatePlayerCardTextDraw(playerid, 203.000000, 330.000000);

	Korta[playerid][3][1] = CreatePlayerCardTextDraw(playerid, 237.000000, 330.000000);

	Korta[playerid][4][0] = CreatePlayerCardTextDraw(playerid, 67.000000, 280.000000);

	Korta[playerid][4][1] = CreatePlayerCardTextDraw(playerid, 101.000000, 280.000000);

	Korta[playerid][5][0] = CreatePlayerCardTextDraw(playerid, 141.000000, 140.000000);

	Korta[playerid][5][1] = CreatePlayerCardTextDraw(playerid, 175.000000, 140.000000);
	Mygtukas[0][playerid] = CreatePlayerTextDraw(playerid,59.000000, 151.000000, "Check");
	PlayerTextDrawAlignment(playerid,Mygtukas[0][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Mygtukas[0][playerid], 255);
	PlayerTextDrawFont(playerid,Mygtukas[0][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Mygtukas[0][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Mygtukas[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Mygtukas[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Mygtukas[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Mygtukas[0][playerid], 1);
	PlayerTextDrawUseBox(playerid,Mygtukas[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Mygtukas[0][playerid], 255);
	PlayerTextDrawTextSize(playerid,Mygtukas[0][playerid], 20.000000, 80.000000);

	Mygtukas[1][playerid] = CreatePlayerTextDraw(playerid,59.000000, 171.000000, "Call");
	PlayerTextDrawAlignment(playerid,Mygtukas[1][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Mygtukas[1][playerid], 255);
	PlayerTextDrawFont(playerid,Mygtukas[1][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Mygtukas[1][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Mygtukas[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Mygtukas[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Mygtukas[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Mygtukas[1][playerid], 1);
	PlayerTextDrawUseBox(playerid,Mygtukas[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Mygtukas[1][playerid], 255);
	PlayerTextDrawTextSize(playerid,Mygtukas[1][playerid], 20.000000, 80.000000);

	Mygtukas[2][playerid] = CreatePlayerTextDraw(playerid,59.000000, 191.000000, "Raise");
	PlayerTextDrawAlignment(playerid,Mygtukas[2][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Mygtukas[2][playerid], 255);
	PlayerTextDrawFont(playerid,Mygtukas[2][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Mygtukas[2][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Mygtukas[2][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Mygtukas[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Mygtukas[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Mygtukas[2][playerid], 1);
	PlayerTextDrawUseBox(playerid,Mygtukas[2][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Mygtukas[2][playerid], 255);
	PlayerTextDrawTextSize(playerid,Mygtukas[2][playerid], 20.000000, 80.000000);

	Mygtukas[3][playerid] = CreatePlayerTextDraw(playerid,59.000000, 211.000000, "Fold");
	PlayerTextDrawAlignment(playerid,Mygtukas[3][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Mygtukas[3][playerid], 255);
	PlayerTextDrawFont(playerid,Mygtukas[3][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Mygtukas[3][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Mygtukas[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Mygtukas[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Mygtukas[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Mygtukas[3][playerid], 1);
	PlayerTextDrawUseBox(playerid,Mygtukas[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Mygtukas[3][playerid], 255);
	PlayerTextDrawTextSize(playerid,Mygtukas[3][playerid], 20.000000, 80.000000);

	Mygtukas[4][playerid] = CreatePlayerTextDraw(playerid,59.000000, 231.000000, "Leave");
	PlayerTextDrawAlignment(playerid,Mygtukas[4][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Mygtukas[4][playerid], 255);
	PlayerTextDrawFont(playerid,Mygtukas[4][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Mygtukas[4][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Mygtukas[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Mygtukas[4][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Mygtukas[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Mygtukas[4][playerid], 1);
	PlayerTextDrawUseBox(playerid,Mygtukas[4][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Mygtukas[4][playerid], 255);
	PlayerTextDrawTextSize(playerid,Mygtukas[4][playerid], 20.000000, 80.000000);

	// SA-MP allows 256 per-player textdraws. If the gamemode's HUD already uses most of
	// them, some of the 17 poker textdraws fail to create (INVALID_TEXT_DRAW) and that
	// card/button never appears. Detect it and say so instead of failing silently.
	new failed = 0;
	for(new y;y<6;y++) for(new x;x<2;x++)
		if(Korta[playerid][y][x] == PlayerText:INVALID_TEXT_DRAW) { failed++; printf("[POKER] WARNING: player %d: card textdraw seat %d card %d could not be created (per-player textdraw limit reached?)", playerid, y, x); }
	for(new x;x<5;x++)
		if(Mygtukas[x][playerid] == PlayerText:INVALID_TEXT_DRAW) { failed++; printf("[POKER] WARNING: player %d: button textdraw %d could not be created (per-player textdraw limit reached?)", playerid, x); }
	if(failed) SendClientMessage(playerid, TEXTCOL_WHITE, "[POKER] Ispejimas: nepavyko sukurti visu pokerio elementu (textdraw limitas). Praneskite administratoriui.");
}
stock SendMessageToPokerTable(id,color,const msg[])
{
	for(new i;i<6;i++)
	{
		if(Poker[id][players][i] != -1)
			SendClientMessage(Poker[id][players][i],color,msg);
	}
	if(Poker[id][watching] != -1)
		SendClientMessage(Poker[id][watching],color,msg);
	return 1;
}

// ============================================================
//      queue system (was at the bottom of LSG.pwn)
// ============================================================
stock AddToPokerWaitQue(playerid, table, suma)
{
	if(table < 0 || table >= MAX_POKER_GAMES)
		return 0;
	if(PlayingPoker[playerid])
		return 0;

	for(new i;i<MAX_POKER_WAITING;i++)
	{
		if(PokerWaitQueSuma[table][i] == 0)
		{
			PokerWaitQue[table][i] = playerid;
			PokerWaitQueSuma[table][i] = suma;
			TogglePlayerControllable(playerid, false);
			PlayerPokerWaitQue[playerid] = table;
			return i+1;
		}
	}
	return 0;
}
stock GetPlayerFromPokerWaitQue(table)
{
	if(table < 0 || table >= MAX_POKER_GAMES)
		return -1;

	if(PokerWaitQueSuma[table][0] == 0)
		return -1;

	new playerid = PokerWaitQue[table][0];

	if(!IsPlayerConnected(playerid) || PokerCash(playerid) < PokerWaitQueSuma[table][0] || !IsPlayerInRangeOfPointEx(10.0,playerid,PokerTables[table][0],PokerTables[table][1],PokerTables[table][2]))
	{
		new suma = PokerWaitQueSuma[table][0];
		RemovePlayerFromPokerWaitQue(playerid, table);
		if(PokerCash(playerid) < suma)
			SendInfoMessage(playerid, "Nebeturi pakankamai EURO pokeriui!");
		else
			SendInfoMessage(playerid, "Palikai pokerio eile!");

		return GetPlayerFromPokerWaitQue(table);
	}

	return playerid;
}
// seat a player at a running table and show them everything
stock SeatPlayerAtTable(playerid, table, found, suma)
{
	if(!PokerTake(playerid, suma))
	{
		SendInfoMessage(playerid, "Jus neturite tiek EURO!");
		PokerLog("seat refused: could not take %d EURO from player %d", suma, playerid);
		return 0;
	}
	PokerBuyIn[playerid] = suma;
	Poker[table][PFondas][found]=suma;
	Poker[table][players][found]=playerid;
	Streamer_ToggleItem(playerid, STREAMER_TYPE_3D_TEXT_LABEL, PokerBlindsTD[table], false); // paslepti stalo info atsisedusiam
	Poker[table][Playing][found]=0;
	PokerSetInterior(playerid, table);
	SetPlayerPos(playerid,SeatCoords[table][found][0],SeatCoords[table][found][1],SeatCoords[table][found][2]);
	SetPlayerFacingAngle(playerid,SeatCoords[table][found][3]);
	ApplyAnimation(playerid,"INT_OFFICE", "FF_Dam_Fwd",4.0,0,0,0,1,0,1);
	PlayingPoker[playerid]=1;
	PokerLog("seated player %d at table %d seat %d (joined running game)", playerid, table, found);
	SetTimerEx("PokerReseat", 700, false, "iii", playerid, table, found);
	if(Poker[table][TheStep]>=0)
		for(new x;x<3;x++)
		{
			TextDrawShowForPlayer(playerid,Poker[table][TableKorta][x]);
		}
	if(Poker[table][TheStep] >=1)
		TextDrawShowForPlayer(playerid,Poker[table][TableKorta][3]);
	if(Poker[table][TheStep] >=2)
		TextDrawShowForPlayer(playerid,Poker[table][TableKorta][4]);
	TextDrawShowForPlayer(playerid,Poker[table][BankTD]);
	CreatePlayerTextDraws(playerid);
	for(new y;y<6;y++)
	{
		if(Poker[table][players][y] != -1)
		{
			TextDrawShowForPlayer(playerid,Poker[table][PokerAction][y]);
			TextDrawShowForPlayer(playerid,Poker[table][PokerMoney][y]);
			TextDrawShowForPlayer(playerid,Poker[table][PokerName][y]);
			for(new x;x<2;x++)
			{
				PlayerTextDrawShow(playerid,Korta[playerid][y][x]);
			}
		}
	}
	for(new x;x<5;x++)
	{
		PlayerTextDrawHide(playerid,Mygtukas[x][playerid]);
	}
	SetPlayerCameraPos(playerid,PokerCameras[table][0],PokerCameras[table][1],PokerCameras[table][2]);
	SetPlayerCameraLookAt(playerid,PokerCameras[table][3],PokerCameras[table][4],PokerCameras[table][5], CAMERA_MOVE);
	SendClientMessage(playerid,-1,"Noredami iseiti spauskite ESC!");
	SelectTextDraw(playerid, 0xACCBF1FF);
	return 1;
}
public AddPokerQuePlayer(table)
{
	if(table < 0 || table >= MAX_POKER_GAMES)
		return 0;

	new playerid = GetPlayerFromPokerWaitQue(table);

	if(playerid == -1)
		return 0;

	new suma = PokerWaitQueSuma[table][0];

	RemovePlayerFromPokerWaitQue(playerid, table);

	if(Poker[table][GameUsed])
	{
		new found=-1;
		for(new x;x<6;x++)
		{
			if(Poker[table][players][x] == -1)
			{
				found = x;
				break;
			}
		}
		if(found == -1)
		{
			SendInfoMessage(playerid,"Ivyko klaida!");
			return 0;
		}
		SeatPlayerAtTable(playerid, table, found, suma);
	}
	else
	{
		AddToPokerQue(playerid,table,suma);
	}
	return 1;
}
public RemovePlayerFromPokerWaitQue(playerid, table)
{
	if(table < 0 || table >= MAX_POKER_GAMES)
		return 0;
	for(new i;i<MAX_POKER_WAITING;i++)
	{
		if(PokerWaitQue[table][i] == playerid)
		{
			PokerWaitQue[table][i] = 0;
			PokerWaitQueSuma[table][i] = 0;
			UpdatePokerWaitQue(table);
			PlayerPokerWaitQue[playerid] = -1;
			if(IsPlayerConnected(playerid))
			{
				TogglePlayerControllable(playerid, true);
			}
			return 1;
		}
	}
	return 0;
}
stock UpdatePokerWaitQue(table)
{
	if(table < 0 || table >= MAX_POKER_GAMES)
		return 0;
	new pos = -1;
	for(new i;i<MAX_POKER_WAITING;i++)
	{
		if(PokerWaitQueSuma[table][i] == 0)
		{
			pos = i;
			break;
		}
	}
	if(pos == -1)
		return 0;
	for(new x = pos + 1; x < MAX_POKER_WAITING; x++) // shift all records from pos left
	{
		if(PokerWaitQueSuma[table][x] == 0)
		{
			break;
		}
		new playerid = PokerWaitQue[table][x];
		new queId = x;
		PokerWaitQueSuma[table][x-1] = PokerWaitQueSuma[table][x];
		PokerWaitQue[table][x-1] = PokerWaitQue[table][x];

		PokerWaitQueSuma[table][x] = 0;
		PokerWaitQue[table][x] = 0;

		if(IsPlayerConnected(playerid) && PlayerPokerWaitQue[playerid] != -1)
		{
			new msg[256];
			format(msg,256,"Jusu vieta pokerio eileje: ~r~%i~n~~w~Noredami iseiti spauskite ["POKER_KEY_NAME"]",queId);
			SendInfoMessage(playerid, msg);
		}
	}
	return 1;
}
public AddToPokerQue(playerid,id,suma)
{
	if(PokerQueUsed[id][0] && playerid != PokerQue[id][0])
	{
		if(!IsPlayerConnected(PokerQue[id][0]))
		{
			PokerQueUsed[id][0]=0;
			AddToPokerQue(playerid,id,suma);
			return 1;
		}
		if(PokerCash(PokerQue[id][0]) < PokerQueSuma[id][0] || !PokerTake(PokerQue[id][0], PokerQueSuma[id][0]))
		{
			SendInfoMessage(PokerQue[id][0],"Jus nebeturite pinigu!");
			ClearAnimations(PokerQue[id][0]);
			SetCameraBehindPlayer(PokerQue[id][0]);
			PlayingPoker[PokerQue[id][0]]=0;
			PokerQueUsed[id][0]=0;
			AddToPokerQue(playerid,id,suma);
			return 1;
		}
		// the waiting player's EURO were taken just above; now the new player's
		if(!PokerTake(playerid, suma))
		{
			PokerPay(PokerQue[id][0], PokerQueSuma[id][0]); // give the waiting player's EURO back, he keeps waiting
			SendInfoMessage(playerid, "Jus neturite tiek EURO!");
			return 1;
		}
		SendInfoMessage(PokerQue[id][0],"Zaidimas prasideda!");
		PlayingPoker[playerid]=1;
		PokerBuyIn[playerid] = suma;
		Poker[id][PFondas][1]=suma;
		PokerBuyIn[PokerQue[id][0]] = PokerQueSuma[id][0];
		Poker[id][PFondas][0]=PokerQueSuma[id][0];
		SendClientMessage(playerid,-1,"Noredami iseiti spauskite ESC!");
		PokerSetInterior(playerid, id);
		SetPlayerPos(playerid,SeatCoords[id][1][0],SeatCoords[id][1][1],SeatCoords[id][1][2]);
		SetPlayerFacingAngle(playerid,SeatCoords[id][1][3]);
		ApplyAnimation(playerid,"INT_OFFICE", "FF_Dam_Fwd",4.0,0,0,0,1,0,1);
		PokerLog("second player %d seated at table %d seat 1, game starting with %d", playerid, id, PokerQue[id][0]);
		SetTimerEx("PokerReseat", 700, false, "iii", playerid, id, 1);
		InitPokerGame(id,PokerBlinds[id][0],PokerBlinds[id][1],PokerQue[id][0],playerid);
		SetPlayerCameraPos(playerid,PokerCameras[id][0],PokerCameras[id][1],PokerCameras[id][2]);
		SetPlayerCameraLookAt(playerid,PokerCameras[id][3],PokerCameras[id][4],PokerCameras[id][5], CAMERA_MOVE);
		SetPlayerCameraPos(PokerQue[id][0],PokerCameras[id][0],PokerCameras[id][1],PokerCameras[id][2]);
		SetPlayerCameraLookAt(PokerQue[id][0],PokerCameras[id][3],PokerCameras[id][4],PokerCameras[id][5], CAMERA_MOVE);
		SelectTextDraw(playerid, 0xACCBF1FF);
		SelectTextDraw(PokerQue[id][0], 0xACCBF1FF);
		for(new x;x<2;x++)
		{
			PokerQueSuma[id][x]=0;
			PokerQueUsed[id][x]=0;
			PokerQue[id][x]=0;
		}
	}
	else
	{
		new found=0;
		PokerSetInterior(playerid, id);
		SetPlayerPos(playerid,SeatCoords[id][found][0],SeatCoords[id][found][1],SeatCoords[id][found][2]);
		SetPlayerFacingAngle(playerid,SeatCoords[id][found][3]);
		ApplyAnimation(playerid,"INT_OFFICE", "FF_Dam_Fwd",4.0,0,0,0,1,0,1);
		PlayingPoker[playerid]=1;
		PokerLog("first player %d seated at table %d seat 0, waiting for an opponent", playerid, id);
		SetTimerEx("PokerReseat", 700, false, "iii", playerid, id, 0);
		SendInfoMessage(playerid,"Laukite kito zaidejo!");
		SendClientMessage(playerid,-1,"Noredami iseiti spauskite ESC!");
		PokerQue[id][0]=playerid;
		PokerQueUsed[id][0]=1;
		PokerQueSuma[id][0]=suma;
		SelectTextDraw(playerid, 0xACCBF1FF);
	}
	return 1;
}
// hide the table for a spectator (used by ESC and disconnect)
stock StopWatchingPoker(playerid, id)
{
	Poker[id][watching]=-1;
	PlayingPoker[playerid] = 0;
	for(new i;i<5;i++)
	{
		TextDrawHideForPlayer(playerid,Poker[id][TableKorta][i]);
	}
	TextDrawHideForPlayer(playerid,Poker[id][BankTD]);
	TextDrawHideForPlayer(playerid,Poker[id][JusuEile]);
	for(new y;y<6;y++)
	{
		TextDrawHideForPlayer(playerid,Poker[id][PokerAction][y]);
		TextDrawHideForPlayer(playerid,Poker[id][PokerMoney][y]);
		TextDrawHideForPlayer(playerid,Poker[id][PokerName][y]);
		for(new z;z<2;z++)
		{
			PlayerTextDrawHide(playerid,Korta[playerid][y][z]);
			PlayerTextDrawDestroy(playerid,Korta[playerid][y][z]);
		}
	}
	for(new z;z<5;z++)
	{
		PlayerTextDrawHide(playerid,Mygtukas[z][playerid]);
		PlayerTextDrawDestroy(playerid,Mygtukas[z][playerid]);
	}
	SetCameraBehindPlayer(playerid);
}

// ============================================================
//      one second timer (was inside the LSG second timer)
// ============================================================
forward PokerSecond();
public PokerSecond()
{
	new string[64];
	static owedTick;
	if(++owedTick >= 5)
	{
		owedTick = 0;
		for(new p; p < MAX_PLAYERS; p++) if(IsPlayerConnected(p) && PokerOwed[p] > 0) PokerTryPayOwed(p);
	}
	for(new id;id<MAX_POKER_GAMES;id++)
	{
		if(Poker[id][GameUsed])
		{
			if(Poker[id][Eile] != -1)
			{
				if(Poker[id][players][Poker[id][Eile]] != -1)
				{
					Poker[id][TimeLeft]--;
					format(string,sizeof(string),"Laukiama...%i",Poker[id][TimeLeft]);
					TextDrawSetString(Poker[id][PokerAction][Poker[id][Eile]],string);
					if(Poker[id][TimeLeft] == 0)
					{
						LeaveGame(Poker[id][players][Poker[id][Eile]],id,Poker[id][Eile]);
					}
				}
			}
		}
	}
	return 1;
}

// ============================================================
//                       callbacks
// ============================================================
public OnFilterScriptInit()
{
	print("\n--- Texas Hold'em poker (LSG) loaded ---\n");
	PokerDB_Open();
	for(new ia;ia < MAX_POKER_GAMES;ia++)
	{
		new tmpstr[100];
		format( tmpstr, 100, "Blinds %s/%sEUR\nBuy in %s-%sEUR\nSpauskite ["POKER_KEY_NAME"] arba /pokeris", FormatNumber(PokerBlinds[ia][0]),FormatNumber(PokerBlinds[ia][1]),FormatNumber(PokerBlinds[ia][2]),FormatNumber(PokerBlinds[ia][3]) );
		PokerBlindsTD[ia] = CreateDynamic3DTextLabel( tmpstr, COLOR_PILKA,PokerTables[ia][0],PokerTables[ia][1],PokerTables[ia][2],25,_,_,true );
		for(new ix;ix<6;ix++)
		{
			Poker[ia][players][ix]=-1;
		}
		Poker[ia][watching]=-1;
	}
	for(new i;i<MAX_PLAYERS;i++)
	{
		PlayerPokerWaitQue[i] = -1;
		if(IsPlayerConnected(i)) CreateInfoTextDraw(i);
	}
	CreateDynamicMapIcon(981.8362,-1161.8503,25.0859, 25, 0,_,_,_,_,MAPICON_LOCAL); // Caligula's (pokeris)
	CreateDynamicMapIcon(2019.4331,1007.7090,10.8203, 25, 0,_,_,_,_,MAPICON_LOCAL); // Four Dragons (pokeris)
	CreatePokerObjects();
	PokerTimer = SetTimer("PokerSecond", 1000, true);
	return 1;
}
public OnFilterScriptExit()
{
	KillTimer(PokerTimer);
	PokerDB_Close();
	for(new id;id<MAX_POKER_GAMES;id++)
	{
		if(Poker[id][GameUsed]) EndPokerGame(id);
		DestroyDynamic3DTextLabel(PokerBlindsTD[id]);
	}
	return 1;
}
public OnPlayerConnect(playerid)
{
	PlayingPoker[playerid] = 0;
	PlayerPokerWaitQue[playerid] = -1;
	PokerPromptTable[playerid] = -1;
	PokerChatBuyInUntil[playerid] = 0;
	PokerChatRaiseUntil[playerid] = 0;
	PokerOpenDialog[playerid] = -1;
	InfoTimer[playerid] = 0;
	ApplyAnimation(playerid, "INT_OFFICE", "null", 4.1, 0, 0, 0, 0, 0); // preload the sitting animation library
	PokerBuyIn[playerid] = 0;
	PokerDB_LoadOwed(playerid);
	for(new _lbt; _lbt < MAX_POKER_GAMES; _lbt++) Streamer_ToggleItem(playerid, STREAMER_TYPE_3D_TEXT_LABEL, PokerBlindsTD[_lbt], true); // visada rodyti stalu info naujai prisijungusiam
	CreateInfoTextDraw(playerid);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	if(PlayerPokerWaitQue[playerid] != -1)
	{
		RemovePlayerFromPokerWaitQue(playerid, PlayerPokerWaitQue[playerid]);
	}
	for(new x;x<MAX_POKER_GAMES;x++)
	{
		if(PokerQueUsed[x][0] && PokerQue[x][0] == playerid)
		{
			PokerQue[x][0]=0;
			PokerQueUsed[x][0]=0;
			PokerQueSuma[x][0]=0;
		}
	}
	if(PlayingPoker[playerid])
	{
		new id=-1,pid=-1;
		for(new x;x<MAX_POKER_GAMES;x++)
		{
			for(new i;i<6;i++)
			{
				if(Poker[x][players][i] == playerid)
				{
					id=x;
					pid=i;
					break;
				}
			}
			if(Poker[x][watching] == playerid)
			{
				StopWatchingPoker(playerid, x);
			}
		}
		if(id != -1 &&  pid != -1)
		{
			LeaveGame(playerid,id,pid);
		}
	}
	PlayingPoker[playerid] = 0;
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & POKER_KEY && !IsPlayerInAnyVehicle(playerid))
	{
		PokerLog("key pressed by %d, nearest table %d, money %d, playing %d", playerid, GetNearestPokerTable(playerid, 5.0), PokerCash(playerid), PlayingPoker[playerid]);
		PokerTryJoin(playerid);
	}
	return 1;
}
// The prompt is shown slightly AFTER the key press. Reason: the gamemode gets the
// same key event and may call ShowPlayerDialog itself (e.g. to close/decline
// something on N). SA-MP only accepts the answer to the most recently shown
// dialog, so if ours is shown first its answer is silently dropped. A short
// delay guarantees ours is the last one shown.
#define POKER_PROMPT_DELAY 350
forward PokerShowPrompt(playerid, i);
public PokerShowPrompt(playerid, i)
{
	if(!IsPlayerConnected(playerid) || PlayingPoker[playerid]) return 0;
	new txt[160];
	format(txt,sizeof(txt),"Irasykite savo pradini inasa (buy in).\nSis stalas: nuo %s iki %s EUR.\n\nJei langas neveikia - tiesiog parasykite suma i chata\narba rasykite /pokeris <suma>",FormatNumber(PokerBlinds[i][2]),FormatNumber(PokerBlinds[i][3]));
	PokerPromptTable[playerid] = i;
	PokerChatBuyInUntil[playerid] = GetTickCount() + POKER_CHAT_BUYIN_TIME;
	new hint[128];
	format(hint,sizeof(hint),"[POKER] Stalas %d: irasykite suma (%s-%s EUR) i langa, arba tiesiog i chata, arba /pokeris <suma>.",i+1,FormatNumber(PokerBlinds[i][2]),FormatNumber(PokerBlinds[i][3]));
	SendClientMessage(playerid,TEXTCOL_WHITE,hint);
	PokerLog("showing buy-in prompt to %d for table %d", playerid, i);
	PokerShowDialog(playerid,POKER_DIALOG_BUYIN,DIALOG_STYLE_INPUT,"Pokeris",txt,"Gerai","Atsaukti");
	return 1;
}
stock ShowBuyInPrompt(playerid, i, delay = POKER_PROMPT_DELAY)
{
	PokerPromptTable[playerid] = i;
	if(delay > 0) SetTimerEx("PokerShowPrompt", delay, false, "ii", playerid, i);
	else PokerShowPrompt(playerid, i);
	return 1;
}
// walk up to a table and press the key (or type /pokeris): leave the waiting
// queue if in one, otherwise open the buy-in prompt
// returns the nearest poker table within `range` metres of the player, or -1
stock GetNearestPokerTable(playerid, Float:range = 5.0)
{
	new Float:x, Float:y, Float:z, Float:best = range * range, nearest = -1;
	GetPlayerPos(playerid, x, y, z);
	for(new i;i<MAX_POKER_GAMES;i++)
	{
		new Float:dx = x - PokerTables[i][0], Float:dy = y - PokerTables[i][1], Float:dz = z - PokerTables[i][2];
		new Float:d = dx*dx + dy*dy + dz*dz;
		if(d <= best) { best = d; nearest = i; }
	}
	return nearest;
}
stock PokerTryJoin(playerid)
{
	if(PlayerPokerWaitQue[playerid] != -1)
	{
		RemovePlayerFromPokerWaitQue(playerid, PlayerPokerWaitQue[playerid]);
		SendInfoMessage(playerid, "Palikai pokerio eile!");
		return 1;
	}
	// The tables stand 6m apart and the join radius is 5m, so "first table in
	// range" (the original logic) could pick the neighbouring table. Use the nearest.
	new i = GetNearestPokerTable(playerid, 5.0);
	if(i == -1) return 0;
	if(PlayingPoker[playerid]) return SendInfoMessage(playerid,"~r~Jus jau zaidziate!");
	if(GetPlayerScore(playerid) < POKER_MIN_SCORE) return SendInfoMessage(playerid,"Pokeri zaisti gali tik nuo 100 xp!");
	if(!PokerApiOK())
	{
		print("[POKER] ERROR: the gamemode has no Poker_* EURO functions (Poker_ApiVersion). Recompile arizona.pwn with the poker block.");
		return SendClientMessage(playerid, TEXTCOL_WHITE, "[POKER] Pokeris laikinai neveikia (serverio klaida). Praneskite administracijai.");
	}
	if(PokerCash(playerid) < 0) return SendInfoMessage(playerid, "Pirmiausia prisijunkite prie savo paskyros!");
	if(PokerCash(playerid) >= PokerBlinds[i][2])
	{
		return ShowBuyInPrompt(playerid, i);
	}
	new txt[128];
	format(txt,sizeof(txt),"[POKER] Stalas %d: reikia bent %s EURO inventoriuje (turite %s EURO).",i+1,FormatNumber(PokerBlinds[i][2]),FormatNumber(PokerCash(playerid)));
	SendClientMessage(playerid,TEXTCOL_WHITE,txt);
	SendInfoMessage(playerid,"Jus neturite tiek pinigu!");
	return 1;
}
stock PokerParseAmount(const text[])
{
	if(IsNumeric(text)) return strval(text);
	return GetPokerNumber(text);
}
public OnPlayerText(playerid, text[])
{
	if(PokerChatRaiseUntil[playerid] && GetTickCount() < PokerChatRaiseUntil[playerid] && PlayingPoker[playerid])
	{
		new amount = PokerParseAmount(text);
		if(amount > 0)
		{
			PokerLog("chat raise '%s' by %d", text, playerid);
			PokerChatRaiseUntil[playerid] = 0;
			PokerHideDialog(playerid);
			if(!Raising(playerid, amount)) SendInfoMessage(playerid,"Zaidimas nerastas!");
			return 0;
		}
	}
	if(PokerChatBuyInUntil[playerid] && GetTickCount() < PokerChatBuyInUntil[playerid] && !PlayingPoker[playerid] && IsNumeric(text) && strlen(text) > 0)
	{
		new i = PokerPromptTable[playerid];
		if(i >= 0 && i < MAX_POKER_GAMES && IsPlayerInRangeOfPointEx(8.0,playerid,PokerTables[i][0],PokerTables[i][1],PokerTables[i][2]))
		{
			PokerLog("chat buy-in '%s' by %d for table %d", text, playerid, i);
			PokerChatBuyInUntil[playerid] = 0;
			PokerHideDialog(playerid); // close the prompt if it is still open
			new amount[16]; strmid(amount, text, 0, 15, sizeof(amount));
			PokerOpenDialog[playerid] = POKER_DIALOG_BUYIN; // feed the chat value in as the prompt's answer
			OnDialogResponse(playerid, POKER_DIALOG_BUYIN, 1, 0, amount);
			return 0; // do not broadcast the number as chat
		}
	}
	return 1;
}
// ---- gamemode side, needed only with POKER_DIALOGS_VIA_GAMEMODE 1 ----
// 1) anywhere in the gamemode:
//   forward PokerShowDialog(playerid, dialogid, style, const caption[], const info[], const button1[], const button2[]);
//   public PokerShowDialog(playerid, dialogid, style, const caption[], const info[], const button1[], const button2[])
//       return ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
// 2) first line inside the gamemode's OnDialogResponse:
//   if(dialogid == 7781 || dialogid == 7782) return CallRemoteFunction("PokerDialogResponse", "iiiis", playerid, dialogid, response, listitem, inputtext);
forward PokerDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
public PokerDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	PokerLog("dialog answer forwarded by gamemode: player %d dialog %d", playerid, dialogid);
	if(!strcmp(inputtext, " ")) inputtext[0] = EOS; // " " placeholder = empty input (see poker_gm.inc)
	return OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid != POKER_DIALOG_BUYIN && dialogid != POKER_DIALOG_RAISE) return 0; // not ours
	if(PokerOpenDialog[playerid] != dialogid) { PokerLog("answer to dialog %d from player %d ignored: not open (open: %d)", dialogid, playerid, PokerOpenDialog[playerid]); return 1; }
	PokerOpenDialog[playerid] = -1; // consumed
	PokerLog("OnDialogResponse player %d dialog %d response %d text '%s' (prompt table %d)", playerid, dialogid, response, inputtext, PokerPromptTable[playerid]);
	if(dialogid==POKER_DIALOG_BUYIN)
	{
		if(!response) { PokerPromptTable[playerid] = -1; PokerChatBuyInUntil[playerid] = 0; return 1; }
		{
			// use the table the prompt was opened for (the original re-scanned with a
			// 3m radius here vs 5m for the key, so standing at the table edge silently failed)
			new i = PokerPromptTable[playerid];
			PokerPromptTable[playerid] = -1;
			if(i < 0 || i >= MAX_POKER_GAMES) return SendInfoMessage(playerid,"~r~Klaida: stalas nerastas, bandykite dar karta.");
			if(!IsPlayerInRangeOfPointEx(8.0,playerid,PokerTables[i][0],PokerTables[i][1],PokerTables[i][2])) return SendInfoMessage(playerid,"~r~Per toli nuo stalo!");
			{
				{
					if(!PlayingPoker[playerid])
					{
						if(!IsNumeric(inputtext)) { SendInfoMessage(playerid,"Skaiciais!"); return ShowBuyInPrompt(playerid, i, 0); }
						new suma = strval(inputtext);
						if(suma < PokerBlinds[i][2] || suma > PokerBlinds[i][3]) { SendInfoMessage(playerid,"Netinkama suma!"); return ShowBuyInPrompt(playerid, i, 0); }
						if(PokerCash(playerid) < suma)
						{
							SendInfoMessage(playerid,"Jus neturite tiek EURO inventoriuje!");
							return ShowBuyInPrompt(playerid, i, 0);
						}
						PokerLog("buy-in accepted: player %d table %d amount %d, game running %d", playerid, i, suma, Poker[i][GameUsed]);
						PokerChatBuyInUntil[playerid] = 0;
						if(Poker[i][GameUsed])
						{
							new found=-1;
							for(new x;x<6;x++)
							{
								if(Poker[i][players][x] == -1)
								{
									found = x;
									break;
								}
							}
							if(found == -1)
							{
								new queId = AddToPokerWaitQue(playerid, i, suma);
								if(!queId)
								{
									return SendInfoMessage(playerid, "Pokerio eile pilna!");
								}
								new msg[256];
								format(msg,256,"Jusu vieta pokerio eileje: ~r~%i~n~~w~Noredami iseiti spauskite ["POKER_KEY_NAME"]",queId);
								SendInfoMessage(playerid, msg);
								return 1;
							}
							if(!SeatPlayerAtTable(playerid, i, found, suma)) return ShowBuyInPrompt(playerid, i, 0);
						}
						else
						{
							AddToPokerQue(playerid,i,suma);
						}
						return 1;
					}
					else SendInfoMessage(playerid,"~r~Jus jau zaidziate!");
				}
			}
		}
		return 1;
	}
	if(dialogid==POKER_DIALOG_RAISE)
	{
		if(response)
		{
			new kiekRaise = (strlen(inputtext) > 0) ? PokerParseAmount(inputtext) : 0;
			if(kiekRaise <= 0)
			{
				SendInfoMessage(playerid,"Skaiciais! (pvz. 2000 arba 2k)");
				PokerShowDialog(playerid,POKER_DIALOG_RAISE,DIALOG_STYLE_INPUT,"Raise","Irasykite suma, kuria norite raisinti.\nGalite naudoti trumpinius pvz.: 100k, 1.2m","Gerai","Atsaukti");
				return 1;
			}
			PokerChatRaiseUntil[playerid] = 0;
			if(!Raising(playerid,kiekRaise))
				return SendInfoMessage(playerid,"Dabar ne jusu eile arba jus nezaidziate!");
		}
		else PokerChatRaiseUntil[playerid] = 0;
		return 1;
	}
	return 0;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(OnPlayerClickPoker(playerid, playertextid)) return 1;
	return 0;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	// ESC pressed while at a poker table (SelectTextDraw cancelled)
	if(clickedid == Text:INVALID_TEXT_DRAW && PlayingPoker[playerid])
	{
		new id=-1,pid=-1;
		for(new i;i<MAX_POKER_GAMES;i++)
		{
			for(new x;x<6;x++)
			{
				if(Poker[i][players][x]==playerid)
				{
					id=i;
					pid=x;
					break;
				}
			}
			if(Poker[i][watching] == playerid)
			{
				id=i;
			}
		}
		if(id != -1)
		{
			if(pid != -1)
				LeaveGame(playerid,id,pid,1);
			else
				StopWatchingPoker(playerid, id);
		}
		else
		{
			for(new x;x<MAX_POKER_GAMES;x++)
			{
				if(PokerQueUsed[x][0] && PokerQue[x][0] == playerid)
				{
					ClearAnimations(playerid);
					SetCameraBehindPlayer(playerid);
					PokerQue[x][0]=0;
					PokerQueUsed[x][0]=0;
					PokerQueSuma[x][0]=0;
					PlayingPoker[playerid]=0;
				}
			}
		}
		return 1;
	}
	return 0;
}
// ---------------- commands ----------------
// /pokeris            at a table: open the buy-in prompt; elsewhere: teleport to the room
// /pokeris <amount>   at a table: buy in directly without the dialog (e.g. /pokeris 50000)
stock Cmd_Pokeris(playerid, const params[])
{
	if(!isnull(params) && IsNumeric(params))
	{
		new i = GetNearestPokerTable(playerid, 5.0);
		if(i == -1) return SendInfoMessage(playerid, "Prieik prie pokerio stalo!");
		PokerLog("/pokeris %s by %d at table %d", params, playerid, i);
		PokerPromptTable[playerid] = i;
		new amount[16]; strmid(amount, params, 0, 15, sizeof(amount));
		PokerOpenDialog[playerid] = POKER_DIALOG_BUYIN; // feed the command value in as the prompt's answer
		return OnDialogResponse(playerid, POKER_DIALOG_BUYIN, 1, 0, amount);
	}
	if(PokerTryJoin(playerid)) return 1; // standing at a table: same as pressing the key
	SetPlayerInterior(playerid, 0);                 // tables are in your own map (interior 0)
	SetPlayerPos(playerid, 2261.9, -798.5, 1407.6); // beside new table 1 - change if the spot is off
	SendInfoMessage(playerid, "Prieik prie stalo ir spausk ["POKER_KEY_NAME"] arba rasyk /pokeris <suma>");
	return 1;
}
// /raise <amount>  (same as the Raise button + dialog, without the dialog)
stock Cmd_Raise(playerid, const params[])
{
	if(!PlayingPoker[playerid]) return SendInfoMessage(playerid,"Jus nezaidziate pokerio!");
	new amount = isnull(params) ? 0 : PokerParseAmount(params);
	if(amount <= 0) return SendInfoMessage(playerid,"Naudojimas: /raise <suma>  (pvz. 2000 arba 2k)");
	if(!Raising(playerid, amount)) SendInfoMessage(playerid,"Dabar ne jusu eile!");
	return 1;
}
stock Cmd_Pokerstats(playerid)
{
	PokerDB_ShowStats(playerid, playerid);
	return 1;
}
stock Cmd_Pokerfloor(playerid, const params[])
{
	if(PokerAdminLevel(playerid) < 1) return SendInfoMessage(playerid,"Si komanda tik administratoriams.");
	if(isnull(params)) { new t[96]; format(t,sizeof(t),"[POKER] Grindu aukscio poslinkis dabar: %.2f. Naudojimas: /pokerfloor <poslinkis>, pvz. -0.5",PokerFloorOffset); return SendClientMessage(playerid,TEXTCOL_WHITE,t); }
	new Float:off = floatstr(params);
	if(off < -5.0 || off > 5.0) return SendInfoMessage(playerid,"Poslinkis nuo -5 iki 5.");
	CreatePokerFloor(off);
	new t[128]; format(t,sizeof(t),"[POKER] Grindys perkeltos, poslinkis %.2f. Irasyk si skaiciu i POKER_FLOOR_OFFSET, kad liktu po restarto.",off);
	return SendClientMessage(playerid,TEXTCOL_WHITE,t);
}
// admin: spectate a table (originally /pzutable, RCON admin only here)
stock Cmd_Pzutable(playerid)
{
	if(PokerAdminLevel(playerid) < 1) return SendInfoMessage(playerid,"Si komanda tik administratoriams.");
	if(PlayerPokerWaitQue[playerid] != -1) return SendInfoMessage(playerid, "Negali naudoti sios komandos laukdamas eileje");
	new i = GetNearestPokerTable(playerid, 5.0);
	if(i == -1) return SendInfoMessage(playerid,"Prieikite prie stalo");
	if(PlayingPoker[playerid]) return SendInfoMessage(playerid,"Jus zaidziate!");
	if(!Poker[i][GameUsed]) return SendInfoMessage(playerid,"Prie sio stalo niekas nezaidzia.");
	if(Poker[i][watching] != -1) return SendInfoMessage(playerid," * Si zaidima jau kazkas stebi!");
	PlayingPoker[playerid]=1;
	for(new x;x<3;x++) TextDrawShowForPlayer(playerid,Poker[i][TableKorta][x]);
	if(Poker[i][TheStep] >=1) TextDrawShowForPlayer(playerid,Poker[i][TableKorta][3]);
	if(Poker[i][TheStep] >=2) TextDrawShowForPlayer(playerid,Poker[i][TableKorta][4]);
	TextDrawShowForPlayer(playerid,Poker[i][BankTD]);
	CreatePlayerTextDraws(playerid);
	for(new y;y<6;y++)
	{
		if(Poker[i][players][y] != -1)
		{
			TextDrawShowForPlayer(playerid,Poker[i][PokerAction][y]);
			TextDrawShowForPlayer(playerid,Poker[i][PokerMoney][y]);
			TextDrawShowForPlayer(playerid,Poker[i][PokerName][y]);
			for(new x;x<2;x++) PlayerTextDrawShow(playerid,Korta[playerid][y][x]);
		}
	}
	for(new x;x<5;x++) PlayerTextDrawHide(playerid,Mygtukas[x][playerid]);
	SetPlayerCameraPos(playerid,PokerCameras[i][0],PokerCameras[i][1],PokerCameras[i][2]);
	SetPlayerCameraLookAt(playerid,PokerCameras[i][3],PokerCameras[i][4],PokerCameras[i][5], CAMERA_MOVE);
	Poker[i][watching] = playerid;
	SendClientMessage(playerid,-1,"Stebite zaidima. Noredami iseiti spauskite ESC!");
	SelectTextDraw(playerid, 0xACCBF1FF);
	return 1;
}
stock Cmd_Blinds(playerid, const params[])
{
	if(PokerAdminLevel(playerid) < 1) return SendInfoMessage(playerid, "Si komanda tik administratoriams.");
	new id = -1;
	for(new x; x < MAX_POKER_GAMES; x++)
		if(Poker[x][watching] == playerid) id = x;
	if(id == -1) return SendInfoMessage(playerid, "Turite stebeti zaidima su /pzutable");
	new part0[16], part1[16], p = 0, i;
	while(params[p] == ' ') p++;
	i = 0; while(params[p] != ' ' && params[p] != EOS && i < 15) part0[i++] = params[p++]; part0[i] = EOS;
	while(params[p] == ' ') p++;
	i = 0; while(params[p] != ' ' && params[p] != EOS && i < 15) part1[i++] = params[p++]; part1[i] = EOS;
	if(isnull(part0) || isnull(part1) || !IsNumeric(part0) || !IsNumeric(part1))
		return SendInfoMessage(playerid, "Naudojimas: /blinds [small blind] [big blind]");
	new sb = strval(part0), bb = strval(part1);
	if(sb < 1 || sb > 100000 || bb < 1 || bb > 100000 || sb > bb)
		return SendInfoMessage(playerid, "Blindai nuo 1 iki 100000 ir small blind turi buti mazesnis uz big.");
	PokerBlinds[id][0] = sb;
	PokerBlinds[id][1] = bb;
	new tmpstr[128], s0[16], s1[16], s2[16], s3[16];
	format(s0, sizeof(s0), "%s", FormatNumber(PokerBlinds[id][0]));
	format(s1, sizeof(s1), "%s", FormatNumber(PokerBlinds[id][1]));
	format(s2, sizeof(s2), "%s", FormatNumber(PokerBlinds[id][2]));
	format(s3, sizeof(s3), "%s", FormatNumber(PokerBlinds[id][3]));
	format(tmpstr, sizeof(tmpstr), "Blinds %s/%sEUR\nBuy in %s-%sEUR\nSpauskite ["POKER_KEY_NAME"] arba /pokeris", s0, s1, s2, s3);
	UpdateDynamic3DTextLabelText(PokerBlindsTD[id], COLOR_PILKA, tmpstr);
	SendClientMessage(playerid, -1, " * Blindai pakeisti! Nepamirskite sugrazinti ju i normalius.");
	return 1;
}

#if defined POKER_USE_PAWNCMD
cmd:pokeris(playerid, params[])    { return Cmd_Pokeris(playerid, params); }
cmd:raise(playerid, params[])      { return Cmd_Raise(playerid, params); }
cmd:pokerstats(playerid, params[]) { return Cmd_Pokerstats(playerid) + (params[0] - params[0]); }
cmd:pokerfloor(playerid, params[]) { return Cmd_Pokerfloor(playerid, params); }
cmd:pzutable(playerid, params[])   { return Cmd_Pzutable(playerid) + (params[0] - params[0]); }
cmd:pokeradmin(playerid, params[])  { return Cmd_Pzutable(playerid) + (params[0] - params[0]); }
cmd:blinds(playerid, params[])     { return Cmd_Blinds(playerid, params); }
#else
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[32], params[64], idx;
	// split "/name params"
	while(cmdtext[idx] != EOS && cmdtext[idx] != ' ' && idx < 31) { cmd[idx] = cmdtext[idx]; idx++; }
	cmd[idx] = EOS;
	while(cmdtext[idx] == ' ') idx++;
	strmid(params, cmdtext, idx, strlen(cmdtext), sizeof(params));
	if(!strcmp(cmd, "/pokeris", true))    return Cmd_Pokeris(playerid, params);
	if(!strcmp(cmd, "/raise", true))      return Cmd_Raise(playerid, params);
	if(!strcmp(cmd, "/pokerstats", true)) return Cmd_Pokerstats(playerid);
	if(!strcmp(cmd, "/pokerfloor", true)) return Cmd_Pokerfloor(playerid, params);
	if(!strcmp(cmd, "/pzutable", true))   return Cmd_Pzutable(playerid);
	if(!strcmp(cmd, "/pokeradmin", true)) return Cmd_Pzutable(playerid);
	if(!strcmp(cmd, "/blinds", true))     return Cmd_Blinds(playerid, params);
	return 0;
}
#endif

// ============================================================
//      poker table objects (objektai.inc "pokerio stalai")
//      Caligula's Casino, interior 1
// ============================================================
public CreatePokerFloor(Float:offset)
{
	for(new i;i<3;i++) if(PokerFloorObj[i] != INVALID_STREAMER_ID) { DestroyDynamicObject(PokerFloorObj[i]); PokerFloorObj[i] = INVALID_STREAMER_ID; }
	PokerFloorOffset = offset;
	// Caligula's tables 1-4 (chair feet at z 1007.99), two 25x25 slabs
	PokerFloorObj[0] = CreateDynamicObject(18981, 2236.0, 1638.0, 1007.45 + offset, 0.0, 90.0, 0.0, -1, -1, -1, 300.0);
	PokerFloorObj[1] = CreateDynamicObject(18981, 2236.0, 1652.0, 1007.45 + offset, 0.0, 90.0, 0.0, -1, -1, -1, 300.0);
	// Four Dragons table 5 (table at z 994.795)
	PokerFloorObj[2] = CreateDynamicObject(18981, 1993.0, 1018.0, 994.25 + offset, 0.0, 90.0, 0.0, -1, -1, -1, 300.0);
	for(new i;i<3;i++) SetDynamicObjectMaterial(PokerFloorObj[i], 0, 10412, "hotel1", "carpet_red_256", 0);
	return 1;
}
stock CreatePokerObjects()
{
	// grindys (tik 5-am Four Dragons stalui; 1-4 stalai tavo mape, interjeras 0)
	CreatePokerFloor(PokerFloorOffset);

	// ---- stalas 1 (2258.2017, -793.8016, 1406.6118) ----
	CreateDynamicObject(19474,2258.201660,-793.801574,1406.611800,0.000000,0.000000,0.000000);
	CreateDynamicObject(2636,2259.276611,-791.739562,1406.688765,0.000000,0.000000,54.000000);
	CreateDynamicObject(2636,2259.952637,-793.295593,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2259.328613,-795.721496,1406.688765,0.000000,0.000000,315.000000);
	CreateDynamicObject(2636,2259.949707,-794.597594,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2257.080566,-791.899596,1406.688765,0.000000,0.000000,135.000000);
	CreateDynamicObject(2636,2257.031494,-795.738586,1406.688765,0.000000,0.000000,235.000000);
	CreateDynamicObject(1923,2258.914551,-794.662536,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2258.821533,-794.667541,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.912598,-794.567565,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.816650,-794.571594,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.908691,-794.469543,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.808594,-794.468566,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.907715,-794.371520,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.813476,-794.373595,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2258.570556,-795.079528,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2258.525635,-795.007507,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.645508,-795.023498,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.598633,-794.949523,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.499512,-795.120544,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.456543,-795.053527,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.722656,-794.973571,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.669678,-794.897521,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2258.900635,-793.480529,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2258.796631,-793.480529,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.908691,-793.393493,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.804687,-793.394592,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.905517,-793.302551,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.803711,-793.305602,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.903564,-793.216491,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.810547,-793.218566,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.740478,-792.673522,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2258.689697,-792.737487,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.676514,-792.626525,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2258.627685,-792.689513,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.614502,-792.589538,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2258.565674,-792.656554,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2258.553711,-792.537536,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2258.509521,-792.612487,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2257.586670,-794.886535,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2257.640625,-794.827575,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2257.640625,-794.938537,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2257.694580,-794.885558,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2257.695556,-795.003600,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2257.751709,-794.942565,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2257.758545,-795.048522,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2257.810547,-794.984557,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2257.787598,-792.552551,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2257.838623,-792.628600,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2257.721680,-792.604552,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2257.771484,-792.672546,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2257.654541,-792.646545,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2257.703613,-792.717590,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2257.592529,-792.698547,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2257.642578,-792.758605,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2258.863525,-794.255553,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2258.861572,-793.118591,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2258.383056,-795.124694,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2257.562744,-794.773132,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2258.476562,-792.544494,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2257.560791,-792.810241,1407.215743,0.000000,0.000000,0.000000);

	// ---- stalas 2 (2260.2454, -801.5114, 1406.6118) ----
	CreateDynamicObject(19474,2260.245361,-801.511413,1406.611800,0.000000,0.000000,0.000000);
	CreateDynamicObject(2636,2261.320312,-799.449401,1406.688765,0.000000,0.000000,54.000000);
	CreateDynamicObject(2636,2261.996337,-801.005432,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2261.372314,-803.431335,1406.688765,0.000000,0.000000,315.000000);
	CreateDynamicObject(2636,2261.993408,-802.307433,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2259.124267,-799.609435,1406.688765,0.000000,0.000000,135.000000);
	CreateDynamicObject(2636,2259.075195,-803.448425,1406.688765,0.000000,0.000000,235.000000);
	CreateDynamicObject(1923,2260.958252,-802.372375,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2260.865234,-802.377380,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.956298,-802.277404,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.860351,-802.281433,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.952392,-802.179382,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.852294,-802.178405,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.951416,-802.081359,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.857177,-802.083434,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2260.614257,-802.789367,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2260.569336,-802.717346,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.689209,-802.733337,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.642334,-802.659362,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.543212,-802.830383,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.500244,-802.763366,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.766357,-802.683410,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.713379,-802.607360,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2260.944336,-801.190368,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2260.840332,-801.190368,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.952392,-801.103332,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.848388,-801.104431,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.949218,-801.012390,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.847412,-801.015441,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.947265,-800.926330,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.854248,-800.928405,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.784179,-800.383361,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2260.733398,-800.447326,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.720214,-800.336364,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2260.671386,-800.399352,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.658203,-800.299377,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2260.609375,-800.366393,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2260.597412,-800.247375,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2260.553222,-800.322326,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2259.630371,-802.596374,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2259.684326,-802.537414,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2259.684326,-802.648376,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2259.738281,-802.595397,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2259.739257,-802.713439,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2259.795410,-802.652404,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2259.802246,-802.758361,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2259.854248,-802.694396,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2259.831298,-800.262390,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2259.882324,-800.338439,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2259.765380,-800.314391,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2259.815185,-800.382385,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2259.698242,-800.356384,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2259.747314,-800.427429,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2259.636230,-800.408386,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2259.686279,-800.468444,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2260.907226,-801.965392,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2260.905273,-800.828430,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2260.426757,-802.834533,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2259.606445,-802.482971,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2260.520263,-800.254333,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2259.604492,-800.520080,1407.215743,0.000000,0.000000,0.000000);

	// ---- stalas 3 (2274.5798, -793.7927, 1406.6118) ----
	CreateDynamicObject(19474,2274.579833,-793.792724,1406.611800,0.000000,0.000000,0.000000);
	CreateDynamicObject(2636,2275.654784,-791.730712,1406.688765,0.000000,0.000000,54.000000);
	CreateDynamicObject(2636,2276.330809,-793.286743,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2275.706786,-795.712646,1406.688765,0.000000,0.000000,315.000000);
	CreateDynamicObject(2636,2276.327880,-794.588745,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2273.458739,-791.890746,1406.688765,0.000000,0.000000,135.000000);
	CreateDynamicObject(2636,2273.409667,-795.729736,1406.688765,0.000000,0.000000,235.000000);
	CreateDynamicObject(1923,2275.292724,-794.653686,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2275.199706,-794.658691,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2275.290770,-794.558715,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2275.194823,-794.562744,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2275.286864,-794.460693,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2275.186766,-794.459716,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2275.285888,-794.362670,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2275.191649,-794.364746,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2274.948729,-795.070678,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2274.903808,-794.998657,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2275.023681,-795.014648,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2274.976806,-794.940673,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2274.877684,-795.111694,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2274.834716,-795.044677,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2275.100829,-794.964721,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2275.047851,-794.888671,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2275.278808,-793.471679,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2275.174804,-793.471679,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2275.286864,-793.384643,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2275.182860,-793.385742,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2275.283690,-793.293701,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2275.181884,-793.296752,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2275.281737,-793.207641,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2275.188720,-793.209716,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2275.118651,-792.664672,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2275.067870,-792.728637,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2275.054686,-792.617675,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2275.005858,-792.680664,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2274.992675,-792.580688,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2274.943847,-792.647705,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2274.931884,-792.528686,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2274.887694,-792.603637,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2273.964843,-794.877685,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2274.018798,-794.818725,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2274.018798,-794.929687,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2274.072753,-794.876708,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2274.073729,-794.994750,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2274.129882,-794.933715,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2274.136718,-795.039672,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2274.188720,-794.975707,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2274.165770,-792.543701,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2274.216796,-792.619750,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2274.099852,-792.595703,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2274.149657,-792.663696,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2274.032714,-792.637695,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2274.081786,-792.708740,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2273.970702,-792.689697,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2274.020751,-792.749755,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2275.241698,-794.246703,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2275.239745,-793.109741,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2274.761229,-795.115844,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2273.940917,-794.764282,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2274.854735,-792.535644,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2273.938964,-792.801391,1407.215743,0.000000,0.000000,0.000000);

	// ---- stalas 4 (2272.5217, -801.5045, 1406.6118) ----
	CreateDynamicObject(19474,2272.521728,-801.504516,1406.611800,0.000000,0.000000,0.000000);
	CreateDynamicObject(2636,2273.596679,-799.442504,1406.688765,0.000000,0.000000,54.000000);
	CreateDynamicObject(2636,2274.272705,-800.998535,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2273.648681,-803.424438,1406.688765,0.000000,0.000000,315.000000);
	CreateDynamicObject(2636,2274.269775,-802.300537,1406.688765,0.000000,0.000000,359.989014);
	CreateDynamicObject(2636,2271.400634,-799.602539,1406.688765,0.000000,0.000000,135.000000);
	CreateDynamicObject(2636,2271.351562,-803.441528,1406.688765,0.000000,0.000000,235.000000);
	CreateDynamicObject(1923,2273.234619,-802.365478,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2273.141601,-802.370483,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2273.232666,-802.270507,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2273.136718,-802.274536,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2273.228759,-802.172485,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2273.128662,-802.171508,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2273.227783,-802.074462,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2273.133544,-802.076538,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2272.890624,-802.782470,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2272.845703,-802.710449,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2272.965576,-802.726440,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2272.918701,-802.652465,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2272.819580,-802.823486,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2272.776611,-802.756469,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2273.042724,-802.676513,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2272.989746,-802.600463,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2273.220703,-801.183471,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2273.116699,-801.183471,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2273.228759,-801.096435,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2273.124755,-801.097534,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2273.225585,-801.005493,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2273.123779,-801.008544,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2273.223632,-800.919433,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2273.130615,-800.921508,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2273.060546,-800.376464,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2273.009765,-800.440429,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2272.996582,-800.329467,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2272.947753,-800.392456,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2272.934570,-800.292480,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2272.885742,-800.359497,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2272.873779,-800.240478,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2272.829589,-800.315429,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2271.906738,-802.589477,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2271.960693,-802.530517,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2271.960693,-802.641479,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2272.014648,-802.588500,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2272.015624,-802.706542,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2272.071777,-802.645507,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2272.078613,-802.751464,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2272.130615,-802.687499,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2272.107666,-800.255493,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1923,2272.158691,-800.331542,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2272.041748,-800.307495,1407.119796,0.000000,0.000000,0.000000);
	CreateDynamicObject(1924,2272.091552,-800.375488,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2271.974609,-800.349487,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1926,2272.023681,-800.420532,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2271.912597,-800.401489,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1925,2271.962646,-800.461547,1407.127791,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2273.183593,-801.958496,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2273.181640,-800.821533,1407.215743,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2272.703124,-802.827636,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2271.882812,-802.476074,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2272.796630,-800.247436,1407.208785,0.000000,0.000000,0.000000);
	CreateDynamicObject(1667,2271.880859,-800.513183,1407.215743,0.000000,0.000000,0.000000);

	// ---- stalas 5 (Four Dragons, nepaliestas) ----
	CreateDynamicObject(19168,1797.847500,-1881.631100,15.089200,90.000000,0.000000,0.000000);
	CreateDynamicObject(19169,1799.345300,-1881.631100,15.089200,90.000000,0.000000,0.000000);
	CreateDynamicObject(19170,1797.847500,-1881.631100,13.589600,90.000000,0.000000,0.000000);
	CreateDynamicObject(19171,1799.347200,-1881.631100,13.589600,90.000000,0.000000,0.000000);
	return 1;
}
