/*
    ============================================================
     AMERIKIETISKA RULETE  -  atskiras SA:MP filterscript (SAGyvenimas)
    ------------------------------------------------------------
     * Ruletes stalai jusu Casino (VW 3, interior 215). Stalas (1978) ir
       ratas (1979) surandami casino mape automatiskai (iki 4 m nuo
       RL_TablePos); jei ju nera - sukuriami. Kiti (ne sio skripto)
       krupje botai prie ruletes stalu pasalinami.
     * Prie stalo: [N] arba /rulete (/rl). Iki 5 zaideju, visi stato i ta
       pati sukima.
     * Kaip GTA SA vieno zaidejo rulete: kamera is stalo galo i lenta,
       ant stalo langelio - geltonas zymeklis su zetonu.
         W/A/S/D (rodykles)  - rinktis langeli ant stalo,
         SPACE - statyti (didinti), C - mazinti statyma langelyje,
         ALT - keisti zetona, LMB - kartoti praeitus statymus,
         N - atsaukti visus statymus, Y - sukti (kai visi pasiruose),
         ENTER/F - palikti stala.
       Padeti zetonai matomi ant stalo visiems.
     * Pirmas statymas paleidzia 20 s laikmati (visi paspaude Y - sukama
       is karto). Tada kamera rodo rata: ratas sukasi, kamuoliukas
       iskrenta, ridenasi ir sustoja kiseneje.
     * 38 langeliai (0, 00, 1-36). Ismokos: skaicius 35:1, stulpelis ir
       tuzinas 2:1, 1-18/19-36/lyginis/nelyginis/raudona/juoda 1:1;
       0 ir 00 - isoriniai statymai pralaimi.
     * Lentos matmenys paimti is GTA SA stalo (1978) kolizijos ir
       originalaus zaidimo vaizdo. Admin (6+): /rlboard - lentos derinimas
       klavisais, /rlcfg - kamuoliuko derinimas, /rltest - sukimas be
       statymu. Nustatymai issaugomi roulette.db.
     * Admin (8): /casinogames (gamemode) - ijungti / isjungti rulete.
     * Pinigai - EURO daiktas inventoriuje (Poker_* public'ai arizona.pwn).

     server.cfg: filterscripts ... roulette
    ============================================================
*/
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>
#include <Pawn.CMD>

// ---------------- nustatymai ----------------
#define RL_TABLES            2
#define RL_SEATS             5
#define RL_BET_TIME          20          // sek. statymams po pirmo statymo
#define RL_SPIN_TIME         8000        // ms nuo sukimo pradzios iki rezultato
#define RL_BALL_TIME         7200        // ms kamuoliuko ridenimas
#define RL_RESULT_TIME       5000        // ms rezultato rodymas
#define RL_KEY               KEY_NO
#define RL_KEY_NAME          "N"
#define RL_API_VERSION       1
#define RL_DB_FILE           "roulette.db"

#define RL_WORLD             3
#define RL_INTERIOR          215
#define RL_TABLE_MODEL       1978
#define RL_WHEEL_MODEL       1979
#define RL_BALL_MODEL        3003        // baltas kamuoliukas (d = 7.6 cm)
#define RL_CHIP_MODEL        1925        // zetonu stulpelis
#define RL_MARK_MODEL        19475       // plokstuma geltonam zymekliui

// stalai (apytiksliai - tikra padetis surandama casino mape): x, y, z, pasukimas
new Float:RL_TablePos[RL_TABLES][4] = {
	{2290.500977, -829.954590, 1407.137085, 74.999870},
	{2295.228516, -832.025391, 1407.137085, 104.999802}
};
new Float:RL_WheelPos[RL_TABLES][3];
// min. zetonas ir max. bendras statymas vienam zaidejui per sukima (EUR)
new const RL_Limits[RL_TABLES][2] = {
	{100, 50000},
	{1000, 500000}
};
// stalo koordinatemis (1978): ratas +Y gale, lenta -Y link; tuzinai ir 1:1 - -X puseje.
// Stalo pagrindas: x -1.02..0.74, y -1.80..0.96, gelmenys (felt) z = -0.10
new const Float:RL_SeatOff[RL_SEATS][2] = {
	{-1.42, 0.05}, {-1.42, -0.85}, {1.12, -0.45}, {1.12, -1.30}, {-0.14, -2.22}
};
#define RL_WHEEL_X           -0.195
#define RL_WHEEL_Y           1.353
#define RL_DEALER_X          1.15        // ten, kur stovi originalus GTA krupje
#define RL_DEALER_Y          0.30
#define RL_PLAYER_Z_OFF      0.0

// lentos geometrija stalo koordinatemis (derinama /rlboard, saugoma DB):
// eilute r (0 - 3,6,9..; 1 - 2,5,8..; 2 - 1,4,7..; 3 - tuzinai; 4 - 1:1) -> x = BX0 + r * BDX
// stulpelis c (0 - 1/2/3 ... 11 - 34/35/36)                             -> y = BY0 - c * BDY
// Langelis 0.261 x 0.166 m (GTA SA tekstura), "3" centras - (0.298, 0.647).
new Float:RL_BX0 = 0.298, Float:RL_BDX = -0.261, Float:RL_BY0 = 0.647, Float:RL_BDY = 0.166, Float:RL_FeltZ = -0.10;
// kamuoliukas: takelio spindulys, kiseniu spindulys, aukstis virs rato centro
new Float:RL_BallROut = 0.36, Float:RL_BallRIn = 0.23, Float:RL_BallZ = 0.12;

// ---------------- langeliai ----------------
#define RL_CELLS             50
#define RL_C_00              37
#define RL_C_COL             38
#define RL_C_DOZ             41
#define RL_C_LOW             44
#define RL_C_EVEN            45
#define RL_C_RED             46
#define RL_C_BLACK           47
#define RL_C_ODD             48
#define RL_C_HIGH            49

// amerikietiskas ratas (37 = 00)
new const RL_WheelOrder[38] = {0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1, 37, 27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2};

// ---------------- busenos ----------------
#define RLS_WAIT     0
#define RLS_BETTING  1
#define RLS_SPIN     2
#define RLS_RESULT   3

enum E_RL_TABLE
{
	rtState,
	rtEnd,
	rtResult,
	rtHistory[10],
	rtHistCount,
	rtSpinStart,
	Float:rtA0,
	Float:rtTotal,
	Float:rtWheelTotal,
	rtWheelFlip,
	STREAMER_TAG_OBJECT:rtBall
};
new RLT[RL_TABLES][E_RL_TABLE];

enum E_RL_SEAT
{
	rsPlayer,
	rsBets[RL_CELLS],
	rsLast[RL_CELLS],
	rsTotal,
	bool:rsReady,
	rsName[MAX_PLAYER_NAME],
	STREAMER_TAG_OBJECT:rsChips[RL_CELLS]
};
new RLS[RL_TABLES * RL_SEATS][E_RL_SEAT];

new RL_PlayerSeat[MAX_PLAYERS] = {-1, ...};
new RL_Chip[MAX_PLAYERS];
new bool:RL_TDCreated[MAX_PLAYERS];
new RL_Owed[MAX_PLAYERS];
new RL_CurRow[MAX_PLAYERS], RL_CurCol[MAX_PLAYERS], RL_MoveTick[MAX_PLAYERS], RL_HeldDir[MAX_PLAYERS];
new STREAMER_TAG_OBJECT:RL_CurDisc[MAX_PLAYERS] = {STREAMER_TAG_OBJECT:INVALID_STREAMER_ID, ...};
new STREAMER_TAG_OBJECT:RL_CurChip[MAX_PLAYERS] = {STREAMER_TAG_OBJECT:INVALID_STREAMER_ID, ...};
new PlayerText3D:RL_Preview[MAX_PLAYERS][RL_CELLS];
new bool:RL_PreviewOn[MAX_PLAYERS];
new RL_EditMode[MAX_PLAYERS];          // /rlboard: 0 - ne, 1 - stumti, 2 - dydis, 3 - aukstis
new bool:RL_Enabled = true;

#define RL_CHIPS     5
new const RL_ChipMult[RL_CHIPS]  = {1, 5, 10, 25, 100};
new RL_ChipVal[MAX_PLAYERS][RL_CHIPS];

// ---------------- textdraw'ai (kaip GTA SA: pagalba virsuje kaireje, statymai kaireje) ----------------
#define RL_ROWS_TD   5
new PlayerText:RT_HelpBg[MAX_PLAYERS], PlayerText:RT_Help[MAX_PLAYERS],
	PlayerText:RT_Bg[MAX_PLAYERS], PlayerText:RT_LineT[MAX_PLAYERS], PlayerText:RT_Title[MAX_PLAYERS],
	PlayerText:RT_Info[MAX_PLAYERS], PlayerText:RT_Lbl[MAX_PLAYERS][RL_ROWS_TD], PlayerText:RT_Val[MAX_PLAYERS][RL_ROWS_TD],
	PlayerText:RT_Money[MAX_PLAYERS], PlayerText:RT_Hist[MAX_PLAYERS], PlayerText:RT_Ball[MAX_PLAYERS][3];

new RL_Timer, RL_BallTimer, RL_SpawnTimer, DB:RL_DB,
	STREAMER_TAG_ACTOR:RL_Actor[RL_TABLES] = {STREAMER_TAG_ACTOR:INVALID_STREAMER_ID, ...},
	STREAMER_TAG_3D_TEXT_LABEL:RL_Label[RL_TABLES] = {STREAMER_TAG_3D_TEXT_LABEL:INVALID_STREAMER_ID, ...},
	STREAMER_TAG_OBJECT:RL_Objs[RL_TABLES][2], bool:RL_Ready,
	STREAMER_TAG_OBJECT:RL_WheelObj[RL_TABLES] = {STREAMER_TAG_OBJECT:INVALID_STREAMER_ID, ...},
	Float:RL_WheelRot[RL_TABLES][3];

// ============================================================
//      pinigai (EURO per gamemode Poker_* API)
// ============================================================
stock bool:RL_ApiOK() return CallRemoteFunction("Poker_ApiVersion", "i", 0) == RL_API_VERSION;

stock RL_Cash(playerid)
{
	if(!RL_ApiOK()) return -1;
	return CallRemoteFunction("Poker_GetEuro", "i", playerid);
}

stock RL_Take(playerid, amount)
{
	if(amount <= 0 || !RL_ApiOK()) return 0;
	return CallRemoteFunction("Poker_TakeEuro", "ii", playerid, amount);
}

stock RL_Escape(const src[], dest[], len)
{
	new j = 0;
	for(new i = 0; src[i] && j < len - 2; i++)
	{
		if(src[i] == '\'') dest[j++] = '\'';
		dest[j++] = src[i];
	}
	dest[j] = EOS;
}

// skola pagal varda (veikia ir atsijungusiam zaidejui)
stock RL_AddOwed(const name[], amount)
{
	if(amount <= 0) return 0;
	new q[220], esc[MAX_PLAYER_NAME * 2];
	RL_Escape(name, esc, sizeof esc);
	format(q, sizeof q, "INSERT OR IGNORE INTO rl_owed (name, amount) VALUES ('%s', 0)", esc);
	db_free_result(db_query(RL_DB, q));
	format(q, sizeof q, "UPDATE rl_owed SET amount = amount + %d WHERE name = '%s'", amount, esc);
	db_free_result(db_query(RL_DB, q));
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		new n[MAX_PLAYER_NAME];
		GetPlayerName(i, n, sizeof n);
		if(!strcmp(n, name, false)) { RL_Owed[i] += amount; break; }
	}
	return 1;
}

stock RL_LoadOwed(playerid)
{
	RL_Owed[playerid] = 0;
	new q[160], n[MAX_PLAYER_NAME], esc[MAX_PLAYER_NAME * 2];
	GetPlayerName(playerid, n, sizeof n);
	RL_Escape(n, esc, sizeof esc);
	format(q, sizeof q, "SELECT amount FROM rl_owed WHERE name = '%s'", esc);
	new DBResult:r = db_query(RL_DB, q);
	if(r)
	{
		if(db_num_rows(r)) RL_Owed[playerid] = db_get_field_int(r, 0);
		db_free_result(r);
	}
	return 1;
}

stock RL_SetOwed(playerid, amount)
{
	new q[200], n[MAX_PLAYER_NAME], esc[MAX_PLAYER_NAME * 2];
	GetPlayerName(playerid, n, sizeof n);
	RL_Escape(n, esc, sizeof esc);
	RL_Owed[playerid] = amount;
	format(q, sizeof q, "INSERT OR REPLACE INTO rl_owed (name, amount) VALUES ('%s', %d)", esc, amount);
	db_free_result(db_query(RL_DB, q));
}

// ismoka; ko netilpo - i skola (grazinama veliau)
stock RL_Pay(playerid, const name[], amount)
{
	if(amount <= 0) return 1;
	new paid = 0;
	if(playerid != INVALID_PLAYER_ID && IsPlayerConnected(playerid) && RL_ApiOK()) paid = CallRemoteFunction("Poker_GiveEuro", "ii", playerid, amount);
	if(paid < 0) paid = 0;
	if(paid > amount) paid = amount;
	if(paid < amount)
	{
		RL_AddOwed(name, amount - paid);
		if(playerid != INVALID_PLAYER_ID && IsPlayerConnected(playerid))
		{
			new m[144];
			format(m, sizeof m, "[Rulete] {FFFFFF}%s EUR netilpo i inventoriu - issaugota, bus grazinta automatiskai.", RL_Fmt(amount - paid));
			SendClientMessage(playerid, 0xE3B924FF, m);
		}
	}
	return 1;
}

stock RL_TryPayOwed(playerid)
{
	if(RL_Owed[playerid] <= 0 || RL_Cash(playerid) == -1) return 0;
	new amount = RL_Owed[playerid];
	new paid = CallRemoteFunction("Poker_GiveEuro", "ii", playerid, amount);
	if(paid < 0) paid = 0;
	if(paid > amount) paid = amount;
	RL_SetOwed(playerid, amount - paid);
	if(paid > 0)
	{
		new m[144];
		format(m, sizeof m, "[Rulete] {FFFFFF}Grazinta %s EUR (anksciau netilpo i inventoriu).", RL_Fmt(paid));
		SendClientMessage(playerid, 0xE3B924FF, m);
	}
	return 1;
}

stock RL_Fmt(number)
{
	new s[24], out[32], len, neg = number < 0;
	format(s, sizeof s, "%d", neg ? -number : number);
	len = strlen(s);
	new j = 0;
	if(neg) out[j++] = '-';
	for(new i = 0; i < len; i++)
	{
		out[j++] = s[i];
		if((len - i - 1) % 3 == 0 && i != len - 1) out[j++] = ' ';
	}
	out[j] = EOS;
	return out;
}

stock RL_Short(number)
{
	new s[12];
	if(number >= 1000000)
	{
		if(number % 1000000) format(s, sizeof s, "%d.%dM", number / 1000000, (number % 1000000) / 100000);
		else format(s, sizeof s, "%dM", number / 1000000);
	}
	else if(number >= 1000)
	{
		if(number % 1000) format(s, sizeof s, "%d.%dK", number / 1000, (number % 1000) / 100);
		else format(s, sizeof s, "%dK", number / 1000);
	}
	else format(s, sizeof s, "%d", number);
	return s;
}

// ============================================================
//      ruletes logika
// ============================================================
stock bool:RL_IsRed(n)
{
	switch(n)
	{
		case 1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36: return true;
	}
	return false;
}

// kiek grazinama (su statymu) uz 1 EUR statyma langelyje cell, kai iskrito res (0..37)
stock RL_Multiplier(cell, res)
{
	if(cell <= 37) return (cell == res) ? 36 : 0;
	if(res == 0 || res == 37) return 0;              // 0 / 00 - isoriniai pralaimi
	switch(cell)
	{
		case RL_C_COL, RL_C_COL + 1, RL_C_COL + 2: return ((res - 1) % 3 == cell - RL_C_COL) ? 3 : 0;
		case RL_C_DOZ, RL_C_DOZ + 1, RL_C_DOZ + 2: return ((res - 1) / 12 == cell - RL_C_DOZ) ? 3 : 0;
		case RL_C_LOW:   return (res <= 18) ? 2 : 0;
		case RL_C_HIGH:  return (res >= 19) ? 2 : 0;
		case RL_C_EVEN:  return (res % 2 == 0) ? 2 : 0;
		case RL_C_ODD:   return (res % 2 == 1) ? 2 : 0;
		case RL_C_RED:   return RL_IsRed(res) ? 2 : 0;
		case RL_C_BLACK: return RL_IsRed(res) ? 0 : 2;
	}
	return 0;
}

stock RL_NumText(res)
{
	new s[8];
	if(res == 37) s = "00";
	else format(s, sizeof s, "%d", res);
	return s;
}

// ~r~ / ~w~ / ~g~ spalva skaiciui
stock RL_NumColorCode(res)
{
	new s[4];
	if(res == 0 || res == 37) s = "~g~";
	else if(RL_IsRed(res)) s = "~r~";
	else s = "~w~";
	return s;
}

stock RL_NumBoxColor(res)
{
	if(res == 0 || res == 37) return 0x1E8C3CFF;
	return RL_IsRed(res) ? 0xB3201FFF : 0x161616FF;
}

// ============================================================
//      nustatymai DB (lentos / kamuoliuko derinimas, ijungta)
// ============================================================
// raktai "g2_" - nauja geometrija (GTA SA stalo matmenys); senieji nebenaudojami
stock RL_CfgSave(const key[], Float:val)
{
	new q[160];
	format(q, sizeof q, "INSERT OR REPLACE INTO rl_cfg (k, v) VALUES ('%s', %f)", key, val);
	db_free_result(db_query(RL_DB, q));
}

stock RL_CfgLoad(const key[], &Float:val)
{
	new q[120];
	format(q, sizeof q, "SELECT v FROM rl_cfg WHERE k = '%s'", key);
	new DBResult:r = db_query(RL_DB, q);
	if(r)
	{
		if(db_num_rows(r)) val = db_get_field_float(r, 0);
		db_free_result(r);
	}
}

stock RL_SaveBoard()
{
	RL_CfgSave("g2_bx0", RL_BX0); RL_CfgSave("g2_bdx", RL_BDX); RL_CfgSave("g2_by0", RL_BY0);
	RL_CfgSave("g2_bdy", RL_BDY); RL_CfgSave("g2_feltz", RL_FeltZ);
}

stock RL_SaveBall()
{
	RL_CfgSave("g2_brout", RL_BallROut); RL_CfgSave("g2_brin", RL_BallRIn); RL_CfgSave("g2_bz", RL_BallZ);
}

stock RL_LoadAllCfg()
{
	RL_CfgLoad("g2_bx0", RL_BX0);   RL_CfgLoad("g2_bdx", RL_BDX);
	RL_CfgLoad("g2_by0", RL_BY0);   RL_CfgLoad("g2_bdy", RL_BDY);
	RL_CfgLoad("g2_feltz", RL_FeltZ);
	RL_CfgLoad("g2_brout", RL_BallROut); RL_CfgLoad("g2_brin", RL_BallRIn); RL_CfgLoad("g2_bz", RL_BallZ);
	new Float:en = 1.0;
	RL_CfgLoad("enabled", en);
	RL_Enabled = en > 0.5;
}

// ============================================================
//      geometrija
// ============================================================
stock RL_Local(t, Float:ox, Float:oy, &Float:wx, &Float:wy)
{
	new Float:a = RL_TablePos[t][3];
	wx = RL_TablePos[t][0] + ox * floatcos(a, degrees) - oy * floatsin(a, degrees);
	wy = RL_TablePos[t][1] + ox * floatsin(a, degrees) + oy * floatcos(a, degrees);
}

// lentos koordinates (eilute r, stulpelis c - gali buti trupmenos) -> stalo koordinates
stock RL_Board(Float:r, Float:c, &Float:lx, &Float:ly)
{
	lx = RL_BX0 + r * RL_BDX;
	ly = RL_BY0 - c * RL_BDY;
}

// langelio centras stalo koordinatemis (kaip GTA SA lentoje: 1-2-3 prie rato,
// "3 to 1" - tolimame gale, tuzinai ir 1:1 - salia skaiciu)
stock RL_CellLocal(cell, &Float:lx, &Float:ly)
{
	if(cell >= 1 && cell <= 36) RL_Board(float(2 - (cell - 1) % 3), float((cell - 1) / 3), lx, ly);
	else if(cell == 0)        RL_Board(1.75, -0.9, lx, ly);      // 0 ir 00 - siauroje juostoje virs 1-2-3
	else if(cell == RL_C_00)  RL_Board(0.25, -0.9, lx, ly);
	else if(cell < RL_C_DOZ)  RL_Board(float(2 - (cell - RL_C_COL)), 12.0, lx, ly);
	else if(cell < RL_C_LOW)  RL_Board(3.0, float(cell - RL_C_DOZ) * 4.0 + 1.5, lx, ly);
	else                      RL_Board(4.0, float(cell - RL_C_LOW) * 2.0 + 0.5, lx, ly);
}

stock RL_CellWorld(t, cell, &Float:x, &Float:y, &Float:z)
{
	new Float:lx, Float:ly;
	RL_CellLocal(cell, lx, ly);
	RL_Local(t, lx, ly, x, y);
	z = RL_TablePos[t][2] + RL_FeltZ;
}

stock RL_CellName(cell)
{
	static const evn[6][] = {"1-18", "LYGINIS", "RAUDONA", "JUODA", "NELYGINIS", "19-36"};
	new s[24];
	if(cell <= 36) format(s, sizeof s, "%d", cell);
	else if(cell == RL_C_00) s = "00";
	else if(cell < RL_C_DOZ) format(s, sizeof s, "2:1 (%d stulp.)", cell - RL_C_COL + 1);
	else if(cell < RL_C_LOW) format(s, sizeof s, "%d-%d", (cell - RL_C_DOZ) * 12 + 1, (cell - RL_C_DOZ) * 12 + 12);
	else format(s, sizeof s, "%s", evn[cell - RL_C_LOW]);
	return s;
}

// textdraw'ui: spalvotas langelio pavadinimas
stock RL_CellTd(cell)
{
	new s[32];
	if(cell == 0 || cell == RL_C_00) format(s, sizeof s, "~g~%s", RL_CellName(cell));
	else if((cell >= 1 && cell <= 36 && RL_IsRed(cell)) || cell == RL_C_RED) format(s, sizeof s, "~r~%s", RL_CellName(cell));
	else format(s, sizeof s, "~w~%s", RL_CellName(cell));
	return s;
}

stock RL_CellColorHex(cell)
{
	new s[10];
	if(cell == 0 || cell == RL_C_00) s = "{3CC864}";
	else if((cell >= 1 && cell <= 36 && RL_IsRed(cell)) || cell == RL_C_RED) s = "{FF4040}";
	else if(cell <= 36 || cell == RL_C_BLACK) s = "{C8C8C8}";
	else s = "{F5DEB3}";
	return s;
}

// ============================================================
//      zymeklis ant stalo (geltonas apskritimas + zetonas, kaip GTA SA)
// ============================================================
stock RL_CellAt(row, col)
{
	if(row <= 2)
	{
		if(col < 0) return row == 0 ? RL_C_00 : 0;
		if(col > 11) return RL_C_COL + (2 - row);
		return 3 * col + 3 - row;
	}
	if(row == 3) return RL_C_DOZ + (col < 0 ? 0 : (col > 11 ? 2 : col / 4));
	return RL_C_LOW + (col < 0 ? 0 : (col > 11 ? 5 : col / 2));
}

stock RL_CursorCell(playerid) return RL_CellAt(RL_CurRow[playerid], RL_CurCol[playerid]);

stock RL_HideCursor(playerid)
{
	if(RL_CurDisc[playerid] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID) DestroyDynamicObject(RL_CurDisc[playerid]);
	if(RL_CurChip[playerid] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID) DestroyDynamicObject(RL_CurChip[playerid]);
	RL_CurDisc[playerid] = RL_CurChip[playerid] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
	return 1;
}

stock RL_UpdateCursor(playerid)
{
	new s = RL_PlayerSeat[playerid];
	if(s == -1) return RL_HideCursor(playerid), 0;
	new t = s / RL_SEATS;
	if((RLT[t][rtState] != RLS_WAIT && RLT[t][rtState] != RLS_BETTING) || RL_EditMode[playerid]) return RL_HideCursor(playerid), 0;
	new cell = RL_CursorCell(playerid), Float:x, Float:y, Float:z;
	RL_CellWorld(t, cell, x, y, z);
	if(RL_CurDisc[playerid] == STREAMER_TAG_OBJECT:INVALID_STREAMER_ID)
	{
		// plokstuma paguldyta (ry = 90) - geltonas permatomas apskritimas
		RL_CurDisc[playerid] = CreateDynamicObject(RL_MARK_MODEL, x, y, z + 0.004, 0.0, 90.0, 0.0, RL_WORLD, RL_INTERIOR, playerid, 30.0, 30.0);
		SetDynamicObjectMaterialText(RL_CurDisc[playerid], 0, "l", OBJECT_MATERIAL_SIZE_256x256, "Wingdings", 150, 0, 0xA0FFD200, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
		RL_CurChip[playerid] = CreateDynamicObject(RL_CHIP_MODEL, x, y, z + 0.006, 0.0, 0.0, 0.0, RL_WORLD, RL_INTERIOR, playerid, 30.0, 30.0);
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	}
	else
	{
		SetDynamicObjectPos(RL_CurDisc[playerid], x, y, z + 0.004);
		SetDynamicObjectPos(RL_CurChip[playerid], x, y, z + 0.006);
	}
	RL_RenderSel(s);
	return 1;
}

stock RL_MoveCursor(playerid, drow, dcol)
{
	new old = RL_CursorCell(playerid);
	if(drow)
	{
		RL_CurRow[playerid] += drow;
		if(RL_CurRow[playerid] < 0) RL_CurRow[playerid] = 0;
		if(RL_CurRow[playerid] > 4) RL_CurRow[playerid] = 4;
		// 0 / 00 - tik skaiciu eilutese
		if(RL_CurRow[playerid] > 2 && RL_CurCol[playerid] < 0) RL_CurCol[playerid] = 0;
		if(RL_CurRow[playerid] > 2 && RL_CurCol[playerid] > 11) RL_CurCol[playerid] = 11;
	}
	if(dcol)
	{
		switch(RL_CurRow[playerid])
		{
			case 3:
			{
				new d = RL_CursorCell(playerid) - RL_C_DOZ + dcol;
				if(d < 0) d = 0;
				if(d > 2) d = 2;
				RL_CurCol[playerid] = d * 4 + 1;
			}
			case 4:
			{
				new k = RL_CursorCell(playerid) - RL_C_LOW + dcol;
				if(k < 0) k = 0;
				if(k > 5) k = 5;
				RL_CurCol[playerid] = k * 2;
			}
			default:
			{
				RL_CurCol[playerid] += dcol;
				if(RL_CurCol[playerid] < -1) RL_CurCol[playerid] = -1;
				if(RL_CurCol[playerid] > 12) RL_CurCol[playerid] = 12;
			}
		}
	}
	if(RL_CursorCell(playerid) != old)
	{
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		RL_UpdateCursor(playerid);
	}
	return 1;
}

// admin: visu langeliu pavadinimai ant stalo (lentos derinimui)
stock RL_ShowPreview(playerid, t, bool:on)
{
	for(new c = 0; c < RL_CELLS; c++)
	{
		if(RL_PreviewOn[playerid]) DeletePlayer3DTextLabel(playerid, RL_Preview[playerid][c]);
		if(on)
		{
			new Float:x, Float:y, Float:z, str[40];
			RL_CellWorld(t, c, x, y, z);
			format(str, sizeof str, "%s%s", RL_CellColorHex(c), RL_CellName(c));
			RL_Preview[playerid][c] = CreatePlayer3DTextLabel(playerid, str, -1, x, y, z + 0.01, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
		}
	}
	RL_PreviewOn[playerid] = on;
}

// ============================================================
//      textdraw'ai (GTA SA stilius: pagalba ir statymu skydelis kaireje)
// ============================================================
#define RLC_GOLD      0xE3B924FF
#define RLC_LABEL     0x8CB4E6FF
#define RLC_SPRITE    "LD_SPAC:white"
#define RLC_CIRCLE    "LD_BEAT:chit"

stock PlayerText:RL_MakeText(playerid, Float:x, Float:y, text[], Float:lx, Float:ly, align, color, font = 1, outline = 0)
{
	new PlayerText:t = CreatePlayerTextDraw(playerid, x, y, text);
	PlayerTextDrawFont(playerid, t, font);
	PlayerTextDrawLetterSize(playerid, t, lx, ly);
	PlayerTextDrawAlignment(playerid, t, align);
	PlayerTextDrawColor(playerid, t, color);
	PlayerTextDrawSetOutline(playerid, t, outline);
	PlayerTextDrawSetShadow(playerid, t, 0);
	PlayerTextDrawBackgroundColor(playerid, t, 255);
	PlayerTextDrawSetProportional(playerid, t, 1);
	return t;
}

stock PlayerText:RL_MakeSprite(playerid, Float:x, Float:y, Float:w, Float:h, sprite[], color)
{
	new PlayerText:t = CreatePlayerTextDraw(playerid, x, y, sprite);
	PlayerTextDrawFont(playerid, t, 4);
	PlayerTextDrawColor(playerid, t, color);
	PlayerTextDrawTextSize(playerid, t, w, h);
	return t;
}

stock RL_CreateTD(playerid)
{
	if(RL_TDCreated[playerid]) return 0;
	RL_TDCreated[playerid] = true;
	static lbl[RL_ROWS_TD][] = {"Langelis", "Zetonas", "Sitame langelyje", "Bendras statymas", "Maks. statymas"};

	RT_HelpBg[playerid] = RL_MakeSprite(playerid, 14.0, 18.0, 206.0, 64.0, RLC_SPRITE, 0x000000B4);
	RT_Help[playerid] = RL_MakeText(playerid, 20.0, 21.0,
		"~y~W A S D ~w~- rinktis langeli~n~~y~SPACE ~w~- statyti   ~y~C ~w~- mazinti~n~~y~ALT ~w~- zetonas   ~y~LMB ~w~- kartoti~n~~y~N ~w~- atsaukti   ~y~Y ~w~- sukti~n~~y~ENTER ~w~- palikti stala",
		0.22, 1.05, 1, -1, 1);

	RT_Bg[playerid]    = RL_MakeSprite(playerid, 14.0, 150.0, 156.0, 214.0, RLC_SPRITE, 0x000000B4);
	RT_LineT[playerid] = RL_MakeSprite(playerid, 14.0, 150.0, 156.0, 2.0, RLC_SPRITE, RLC_GOLD);
	RT_Title[playerid] = RL_MakeText(playerid, 20.0, 150.0, "Rulete", 0.62, 2.2, 1, -1, 0);
	RT_Info[playerid]  = RL_MakeText(playerid, 20.0, 172.0, "_", 0.2, 0.95, 1, RLC_GOLD, 1);
	PlayerTextDrawTextSize(playerid, RT_Info[playerid], 166.0, 0.0);
	for(new i = 0; i < RL_ROWS_TD; i++)
	{
		RT_Lbl[playerid][i] = RL_MakeText(playerid, 20.0, 196.0 + float(i) * 29.0, lbl[i], 0.25, 1.15, 1, RLC_LABEL, 1, 1);
		RT_Val[playerid][i] = RL_MakeText(playerid, 20.0, 205.5 + float(i) * 29.0, "_", 0.36, 1.55, 1, -1, 1, 1);
	}
	RT_Money[playerid] = RL_MakeText(playerid, 20.0, 343.0, "_", 0.2, 0.95, 1, 0xC8C8C8FF, 1);

	RT_Ball[playerid][0] = RL_MakeSprite(playerid, 16.0, 368.0, 34.0, 34.0, RLC_CIRCLE, RLC_GOLD);
	RT_Ball[playerid][1] = RL_MakeSprite(playerid, 19.0, 371.0, 28.0, 28.0, RLC_CIRCLE, 0x161616FF);
	RT_Ball[playerid][2] = RL_MakeText(playerid, 33.0, 377.5, "_", 0.28, 1.3, 2, -1, 2);
	RT_Hist[playerid]  = RL_MakeText(playerid, 56.0, 380.0, "_", 0.2, 0.95, 1, 0xBEBEBEFF, 2);
	return 1;
}

stock RL_DestroyTD(playerid)
{
	if(!RL_TDCreated[playerid]) return 0;
	RL_TDCreated[playerid] = false;
	PlayerTextDrawDestroy(playerid, RT_HelpBg[playerid]);
	PlayerTextDrawDestroy(playerid, RT_Help[playerid]);
	PlayerTextDrawDestroy(playerid, RT_Bg[playerid]);
	PlayerTextDrawDestroy(playerid, RT_LineT[playerid]);
	PlayerTextDrawDestroy(playerid, RT_Title[playerid]);
	PlayerTextDrawDestroy(playerid, RT_Info[playerid]);
	for(new i = 0; i < RL_ROWS_TD; i++) PlayerTextDrawDestroy(playerid, RT_Lbl[playerid][i]), PlayerTextDrawDestroy(playerid, RT_Val[playerid][i]);
	PlayerTextDrawDestroy(playerid, RT_Money[playerid]);
	PlayerTextDrawDestroy(playerid, RT_Hist[playerid]);
	for(new k = 0; k < 3; k++) PlayerTextDrawDestroy(playerid, RT_Ball[playerid][k]);
	return 1;
}

stock RL_ShowBall(playerid, res)
{
	if(!RL_TDCreated[playerid]) return 0;
	if(res < 0)
	{
		for(new k = 0; k < 3; k++) PlayerTextDrawHide(playerid, RT_Ball[playerid][k]);
		return 1;
	}
	PlayerTextDrawColor(playerid, RT_Ball[playerid][1], RL_NumBoxColor(res));
	PlayerTextDrawSetString(playerid, RT_Ball[playerid][2], RL_NumText(res));
	for(new k = 0; k < 3; k++) PlayerTextDrawShow(playerid, RT_Ball[playerid][k]);
	return 1;
}

stock RL_SetVal(playerid, row, text[])
{
	PlayerTextDrawSetString(playerid, RT_Val[playerid][row], text);
	PlayerTextDrawShow(playerid, RT_Val[playerid][row]);
}

// langelis / zetonas / statymas langelyje / bendras statymas
stock RL_RenderSel(s)
{
	new playerid = RLS[s][rsPlayer];
	if(playerid == INVALID_PLAYER_ID || !RL_TDCreated[playerid]) return 0;
	new t = s / RL_SEATS, str[48], cell = RL_CursorCell(playerid);
	RL_SetVal(playerid, 0, RL_CellTd(cell));
	format(str, sizeof str, "%s EUR", RL_Fmt(RL_ChipVal[playerid][RL_Chip[playerid]]));
	RL_SetVal(playerid, 1, str);
	format(str, sizeof str, "%s%s EUR", RLS[s][rsBets][cell] > 0 ? ("~y~") : ("~w~"), RL_Fmt(RLS[s][rsBets][cell]));
	RL_SetVal(playerid, 2, str);
	format(str, sizeof str, "%s EUR", RL_Fmt(RLS[s][rsTotal]));
	RL_SetVal(playerid, 3, str);
	format(str, sizeof str, "%s EUR", RL_Fmt(RL_Limits[t][1]));
	RL_SetVal(playerid, 4, str);
	return 1;
}

stock RL_Render(s)
{
	new playerid = RLS[s][rsPlayer];
	if(playerid == INVALID_PLAYER_ID || !RL_TDCreated[playerid]) return 0;
	new t = s / RL_SEATS, str[160];
	PlayerTextDrawShow(playerid, RT_HelpBg[playerid]);
	PlayerTextDrawShow(playerid, RT_Help[playerid]);
	PlayerTextDrawShow(playerid, RT_Bg[playerid]);
	PlayerTextDrawShow(playerid, RT_LineT[playerid]);
	PlayerTextDrawShow(playerid, RT_Title[playerid]);
	for(new i = 0; i < RL_ROWS_TD; i++) PlayerTextDrawShow(playerid, RT_Lbl[playerid][i]);

	str = "";
	for(new i = 0; i < RLT[t][rtHistCount] && i < 8; i++)
		format(str, sizeof str, "%s%s%s ", str, RL_NumColorCode(RLT[t][rtHistory][i]), RL_NumText(RLT[t][rtHistory][i]));
	if(!str[0]) str = "_";
	PlayerTextDrawSetString(playerid, RT_Hist[playerid], str);
	PlayerTextDrawShow(playerid, RT_Hist[playerid]);

	new cash = RL_Cash(playerid);
	format(str, sizeof str, "EURO: ~w~%s", RL_Fmt(cash < 0 ? 0 : cash));
	PlayerTextDrawSetString(playerid, RT_Money[playerid], str);
	PlayerTextDrawShow(playerid, RT_Money[playerid]);

	RL_RenderSel(s);
	RL_RenderInfo(s);
	if(RLT[t][rtState] == RLS_RESULT) RL_ShowBall(playerid, RLT[t][rtResult]);
	else RL_ShowBall(playerid, -1);
	return 1;
}

stock RL_RenderInfo(s)
{
	new playerid = RLS[s][rsPlayer];
	if(playerid == INVALID_PLAYER_ID || !RL_TDCreated[playerid]) return 0;
	new t = s / RL_SEATS, str[128];
	if(RL_EditMode[playerid])
	{
		static const md[3][] = {"stumti lenta", "langeliu dydis", "aukstis"};
		format(str, sizeof str, "~r~LENTOS DERINIMAS~w~~n~ALT - %s, ENTER - issaugoti", md[RL_EditMode[playerid] - 1]);
	}
	else switch(RLT[t][rtState])
	{
		case RLS_WAIT: str = "Pasirinkite langeli ir spauskite ~y~SPACE";
		case RLS_BETTING:
		{
			new left = (RLT[t][rtEnd] - GetTickCount()) / 1000;
			if(left < 0) left = 0;
			format(str, sizeof str, "Statymai priimami: %s%d s~w~~n~%s", left <= 5 ? ("~r~") : ("~g~"), left, RLS[s][rsReady] ? ("~g~Pasiruose - laukiama kitu") : ("~y~Y~w~ - sukti"));
		}
		case RLS_SPIN: str = "~y~Statymai nebepriimami~w~~n~Kamuoliukas rieda...";
		case RLS_RESULT: return 1;
	}
	PlayerTextDrawSetString(playerid, RT_Info[playerid], str);
	return PlayerTextDrawShow(playerid, RT_Info[playerid]);
}

stock RL_SetInfo(playerid, text[])
{
	if(!RL_TDCreated[playerid]) return 0;
	PlayerTextDrawSetString(playerid, RT_Info[playerid], text);
	return PlayerTextDrawShow(playerid, RT_Info[playerid]);
}

stock RL_RenderTable(t)
{
	for(new i = 0; i < RL_SEATS; i++)
	{
		new s = t * RL_SEATS + i;
		if(RLS[s][rsPlayer] != INVALID_PLAYER_ID) RL_Render(s), RL_UpdateCursor(RLS[s][rsPlayer]);
	}
}

// ============================================================
//      zetonai ant stalo (matomi visiems casino)
// ============================================================
stock RL_PutChipObject(s, cell)
{
	if(RLS[s][rsChips][cell] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID) return 1;
	new t = s / RL_SEATS, seat = s % RL_SEATS, Float:x, Float:y, Float:z, Float:lx, Float:ly;
	RL_CellLocal(cell, lx, ly);
	// kiekvieno zaidejo zetonai siek tiek pasislinke - nesutampa
	lx += float(seat - 2) * 0.03, ly += float(seat % 2) * 0.03 - 0.015;
	RL_Local(t, lx, ly, x, y);
	z = RL_TablePos[t][2] + RL_FeltZ;
	RLS[s][rsChips][cell] = CreateDynamicObject(RL_CHIP_MODEL, x, y, z, 0.0, 0.0, float(random(360)), RL_WORLD, RL_INTERIOR, -1, 40.0, 40.0);
	return 1;
}

stock RL_RemoveChipObject(s, cell)
{
	if(RLS[s][rsChips][cell] == STREAMER_TAG_OBJECT:INVALID_STREAMER_ID) return 0;
	DestroyDynamicObject(RLS[s][rsChips][cell]);
	RLS[s][rsChips][cell] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
	return 1;
}

stock RL_ClearChipObjects(s)
{
	for(new c = 0; c < RL_CELLS; c++) RL_RemoveChipObject(s, c);
}

// ============================================================
//      statymai
// ============================================================
stock RL_PlaceBet(s, cell, amount)
{
	new playerid = RLS[s][rsPlayer], t = s / RL_SEATS;
	if(RLT[t][rtState] != RLS_WAIT && RLT[t][rtState] != RLS_BETTING)
		return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Statymai nebepriimami - palaukite kito sukimo."), 0;
	if(RLS[s][rsTotal] + amount > RL_Limits[t][1])
	{
		new m[144];
		format(m, sizeof m, "[Rulete] {FFFFFF}Max bendras statymas siame stale: %s EUR.", RL_Fmt(RL_Limits[t][1]));
		return SendClientMessage(playerid, 0xFF6347FF, m), 0;
	}
	new cash = RL_Cash(playerid);
	if(cash < amount)
	{
		new m[144];
		format(m, sizeof m, "[Rulete] {FFFFFF}Jums truksta EURO. Turite: %s EUR.", RL_Fmt(cash < 0 ? 0 : cash));
		return SendClientMessage(playerid, 0xFF6347FF, m), 0;
	}
	if(!RL_Take(playerid, amount)) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Nepavyko paimti statymo."), 0;
	RLS[s][rsBets][cell] += amount;
	RLS[s][rsTotal] += amount;
	RL_PutChipObject(s, cell);
	PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
	if(RLT[t][rtState] == RLS_WAIT)
	{
		RLT[t][rtState] = RLS_BETTING;
		RLT[t][rtEnd] = GetTickCount() + RL_BET_TIME * 1000;
	}
	RL_Render(s);
	for(new i = 0; i < RL_SEATS; i++) if(t * RL_SEATS + i != s && RLS[t * RL_SEATS + i][rsPlayer] != INVALID_PLAYER_ID) RL_RenderInfo(t * RL_SEATS + i);
	return 1;
}

// C - sumazinti statyma pasirinktame langelyje vienu zetonu
stock RL_DecBet(s, cell)
{
	new playerid = RLS[s][rsPlayer], t = s / RL_SEATS;
	if(RLT[t][rtState] != RLS_WAIT && RLT[t][rtState] != RLS_BETTING) return 0;
	if(RLS[s][rsBets][cell] <= 0) return PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0), 0;
	new amount = RL_ChipVal[playerid][RL_Chip[playerid]];
	if(amount > RLS[s][rsBets][cell]) amount = RLS[s][rsBets][cell];
	RLS[s][rsBets][cell] -= amount;
	RLS[s][rsTotal] -= amount;
	RL_Pay(playerid, RLS[s][rsName], amount);
	if(RLS[s][rsBets][cell] <= 0) RL_RemoveChipObject(s, cell);
	if(RLS[s][rsTotal] <= 0) RLS[s][rsReady] = false;
	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
	RL_Render(s);
	return 1;
}

// Y - pasiruoses; kai visi prie stalo pasiruose - sukama is karto
stock RL_SetReady(s)
{
	new playerid = RLS[s][rsPlayer], t = s / RL_SEATS;
	if(RLT[t][rtState] != RLS_BETTING) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Pirmiausia pastatykite statyma (SPACE)."), 0;
	if(RLS[s][rsTotal] <= 0) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Jus dar nieko nepastatete."), 0;
	RLS[s][rsReady] = true;
	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	new all = 1;
	for(new i = 0; i < RL_SEATS; i++)
	{
		new o = t * RL_SEATS + i;
		if(RLS[o][rsPlayer] != INVALID_PLAYER_ID && !RLS[o][rsReady]) all = 0;
	}
	if(all) RL_StartSpin(t);
	else
	{
		for(new i = 0; i < RL_SEATS; i++) if(RLS[t * RL_SEATS + i][rsPlayer] != INVALID_PLAYER_ID) RL_RenderInfo(t * RL_SEATS + i);
	}
	return 1;
}

stock RL_RefundBets(s)
{
	if(RLS[s][rsTotal] > 0) RL_Pay(RLS[s][rsPlayer], RLS[s][rsName], RLS[s][rsTotal]);
	for(new c = 0; c < RL_CELLS; c++) RLS[s][rsBets][c] = 0;
	RLS[s][rsTotal] = 0;
	RLS[s][rsReady] = false;
	RL_ClearChipObjects(s);
}

stock RL_RepeatBets(s)
{
	new playerid = RLS[s][rsPlayer], need = 0;
	for(new c = 0; c < RL_CELLS; c++) need += RLS[s][rsLast][c];
	if(!need) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Nera praeito sukimo statymu."), 0;
	for(new c = 0; c < RL_CELLS; c++)
		if(RLS[s][rsLast][c] > 0 && !RL_PlaceBet(s, c, RLS[s][rsLast][c])) break;
	return 1;
}

// ============================================================
//      ratas, kamuoliukas ir kameros
// ============================================================
stock Float:RL_SpinP(t, tick)
{
	new Float:p = float(tick - RLT[t][rtSpinStart]) / float(RL_BALL_TIME);
	if(p < 0.0) p = 0.0;
	if(p > 1.0) p = 1.0;
	return p;
}

stock RL_BallPos(t, tick, &Float:x, &Float:y, &Float:z)
{
	new Float:cx = RL_WheelPos[t][0], Float:cy = RL_WheelPos[t][1], Float:cz = RL_WheelPos[t][2];
	new Float:p = RL_SpinP(t, tick), Float:q = 1.0 - p;
	new Float:ease = 1.0 - q * q * q;
	new Float:a = RLT[t][rtA0] + RLT[t][rtTotal] * ease;
	new Float:r = RL_BallROut;
	if(p > 0.6) r = (p >= 0.82) ? RL_BallRIn : RL_BallROut - (RL_BallROut - RL_BallRIn) * ((p - 0.6) / 0.22);
	z = cz + RL_BallZ - (RL_BallROut - r) * 0.45;              // takelis -> kisenes (zemiau)
	if(p < 0.06) z += 0.10 * (1.0 - p / 0.06);                 // iskrenta i rata
	if(p > 0.6 && p < 0.94)                                     // atsimusa nuo skiriamuju
		z += 0.03 * floatabs(floatsin((p - 0.6) * 2400.0, degrees)) * ((0.94 - p) / 0.34);
	x = cx + r * floatcos(a, degrees);
	y = cy + r * floatsin(a, degrees);
}

// rato pasukimas (pries kamuoliuko krypti, leteja)
stock Float:RL_WheelAngle(t, tick)
{
	new Float:p = RL_SpinP(t, tick), Float:q = 1.0 - p;
	return RL_WheelRot[t][2] - RLT[t][rtWheelTotal] * (1.0 - q * q);
}

forward RL_BallTick();
public RL_BallTick()
{
	new now = GetTickCount();
	for(new t = 0; t < RL_TABLES; t++)
	{
		if(RLT[t][rtState] != RLS_SPIN) continue;
		if(RLT[t][rtBall] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID)
		{
			new Float:bx, Float:by, Float:bz, Float:ox, Float:oy, Float:oz;
			RL_BallPos(t, now + 50, bx, by, bz);
			GetDynamicObjectPos(RLT[t][rtBall], ox, oy, oz);
			new Float:dist = VectorSize(bx - ox, by - oy, bz - oz);
			if(dist >= 0.001) MoveDynamicObject(RLT[t][rtBall], bx, by, bz, dist / 0.05);
		}
		if(RL_WheelObj[t] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID && now >= RLT[t][rtSpinStart] && now <= RLT[t][rtSpinStart] + RL_BALL_TIME + 100)
		{
			// sukimas: maza pozicijos zingsni (1 mm) + pasukimas - klientas sklandziai pasuka per 50 ms
			RLT[t][rtWheelFlip] = !RLT[t][rtWheelFlip];
			MoveDynamicObject(RL_WheelObj[t], RL_WheelPos[t][0], RL_WheelPos[t][1], RL_WheelPos[t][2] + (RLT[t][rtWheelFlip] ? 0.001 : 0.0), 0.02,
				RL_WheelRot[t][0], RL_WheelRot[t][1], RL_WheelAngle(t, now + 50));
		}
	}
	return 1;
}

stock RL_StopWheel(t)
{
	if(RL_WheelObj[t] == STREAMER_TAG_OBJECT:INVALID_STREAMER_ID) return 0;
	new Float:rz = RL_WheelAngle(t, RLT[t][rtSpinStart] + RL_BALL_TIME);
	while(rz < 0.0) rz += 360.0;
	while(rz >= 360.0) rz -= 360.0;
	StopDynamicObject(RL_WheelObj[t]);
	SetDynamicObjectPos(RL_WheelObj[t], RL_WheelPos[t][0], RL_WheelPos[t][1], RL_WheelPos[t][2]);
	SetDynamicObjectRot(RL_WheelObj[t], RL_WheelRot[t][0], RL_WheelRot[t][1], rz);
	RL_WheelRot[t][2] = rz;
	return 1;
}

stock RL_DestroyTableBall(t)
{
	if(RLT[t][rtBall] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID)
	{
		DestroyDynamicObject(RLT[t][rtBall]);
		RLT[t][rtBall] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
	}
}

// kamera kaip GTA SA: is tolimo stalo galo, aukstai, i lenta link rato
// (apskaiciuota is originalaus zaidimo vaizdo; lentos vienetais, todel seka /rlboard)
stock RL_CamTablePos(t, &Float:cx, &Float:cy, &Float:cz, &Float:lx, &Float:ly, &Float:lz)
{
	new Float:ox, Float:oy, Float:w = floatabs(RL_BDX);
	RL_Board(3.93, 14.82, ox, oy);           // kameros taskas virs stalo
	RL_Local(t, ox, oy, cx, cy);
	RL_Board(2.52, 6.3, ox, oy);             // i kur ziuri
	RL_Local(t, ox, oy, lx, ly);
	cz = RL_TablePos[t][2] + RL_FeltZ + 8.23 * w;
	lz = RL_TablePos[t][2] + RL_FeltZ;
}

stock RL_CamWheelPos(t, &Float:cx, &Float:cy, &Float:cz, &Float:lx, &Float:ly, &Float:lz)
{
	// is lentos puses i rata, istrizai is virsaus
	new Float:dx = RL_TablePos[t][0] - RL_WheelPos[t][0], Float:dy = RL_TablePos[t][1] - RL_WheelPos[t][1];
	new Float:len = floatsqroot(dx * dx + dy * dy);
	if(len < 0.01) dx = 0.0, dy = -1.0, len = 1.0;
	cx = RL_WheelPos[t][0] + dx / len * 0.62, cy = RL_WheelPos[t][1] + dy / len * 0.62;
	cz = RL_WheelPos[t][2] + RL_BallZ + 0.95;
	lx = RL_WheelPos[t][0] - dx / len * 0.03, ly = RL_WheelPos[t][1] - dy / len * 0.03, lz = RL_WheelPos[t][2] + RL_BallZ - 0.04;
}

stock RL_CamToTable(playerid, t, bool:smooth)
{
	new Float:cx, Float:cy, Float:cz, Float:lx, Float:ly, Float:lz;
	RL_CamTablePos(t, cx, cy, cz, lx, ly, lz);
	if(smooth)
	{
		new Float:wx, Float:wy, Float:wz, Float:wlx, Float:wly, Float:wlz;
		RL_CamWheelPos(t, wx, wy, wz, wlx, wly, wlz);
		InterpolateCameraPos(playerid, wx, wy, wz, cx, cy, cz, 1200, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, wlx, wly, wlz, lx, ly, lz, 1200, CAMERA_MOVE);
	}
	else
	{
		SetPlayerCameraPos(playerid, cx, cy, cz);
		SetPlayerCameraLookAt(playerid, lx, ly, lz);
	}
}

stock RL_CamToWheel(playerid, t)
{
	new Float:cx, Float:cy, Float:cz, Float:lx, Float:ly, Float:lz, Float:wx, Float:wy, Float:wz, Float:wlx, Float:wly, Float:wlz;
	RL_CamTablePos(t, cx, cy, cz, lx, ly, lz);
	RL_CamWheelPos(t, wx, wy, wz, wlx, wly, wlz);
	InterpolateCameraPos(playerid, cx, cy, cz, wx, wy, wz, 1200, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, lx, ly, lz, wlx, wly, wlz, 1200, CAMERA_MOVE);
}

// ============================================================
//      stalo eiga
// ============================================================
stock RL_StartSpin(t)
{
	if(RLT[t][rtState] != RLS_BETTING && RLT[t][rtState] != RLS_WAIT) return 0;
	RLT[t][rtState] = RLS_SPIN;
	RLT[t][rtEnd] = GetTickCount() + RL_SPIN_TIME;
	RLT[t][rtResult] = random(38);
	RLT[t][rtSpinStart] = GetTickCount() + 900;          // kol kamera nuvaziuoja iki rato
	new pocket = 0;
	for(new k = 0; k < 38; k++) if(RL_WheelOrder[k] == RLT[t][rtResult]) { pocket = k; break; }
	new Float:afinal = RL_TablePos[t][3] + 90.0 + float(pocket) * (360.0 / 38.0);
	RLT[t][rtTotal] = 360.0 * 3.0 + float(random(180));
	RLT[t][rtA0] = afinal - RLT[t][rtTotal];
	RLT[t][rtWheelTotal] = 360.0 + float(random(180));

	RL_DestroyTableBall(t);
	new Float:bx, Float:by, Float:bz;
	RL_BallPos(t, RLT[t][rtSpinStart], bx, by, bz);
	RLT[t][rtBall] = CreateDynamicObject(RL_BALL_MODEL, bx, by, bz, 0.0, 0.0, 0.0, RL_WORLD, RL_INTERIOR, -1, 60.0, 60.0);
	ApplyDynamicActorAnimation(RL_Actor[t], "CASINO", "dealone", 4.1, 0, 0, 0, 0, 0);

	for(new i = 0; i < RL_SEATS; i++)
	{
		new s = t * RL_SEATS + i, playerid = RLS[s][rsPlayer];
		RLS[s][rsReady] = false;
		if(playerid == INVALID_PLAYER_ID) continue;
		RL_HideCursor(playerid);
		ApplyAnimation(playerid, "CASINO", "Roulette_loop", 4.1, 1, 0, 0, 1, 0, 1);
		PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
		RL_Render(s);
		RL_CamToWheel(playerid, t);
	}
	return 1;
}

stock RL_Finish(t)
{
	new res = RLT[t][rtResult], str[160];
	for(new i = 9; i > 0; i--) RLT[t][rtHistory][i] = RLT[t][rtHistory][i - 1];
	RLT[t][rtHistory][0] = res;
	if(RLT[t][rtHistCount] < 10) RLT[t][rtHistCount]++;
	RLT[t][rtState] = RLS_RESULT;
	RLT[t][rtEnd] = GetTickCount() + RL_RESULT_TIME;
	RL_StopWheel(t);

	new colorname[16];
	if(res == 0 || res == 37) colorname = "~g~ZALIA";
	else if(RL_IsRed(res)) colorname = "~r~RAUDONA";
	else colorname = "~w~JUODA";

	for(new i = 0; i < RL_SEATS; i++)
	{
		new s = t * RL_SEATS + i, playerid = RLS[s][rsPlayer];
		if(RLS[s][rsTotal] <= 0)
		{
			if(playerid != INVALID_PLAYER_ID)
			{
				format(str, sizeof str, "Iskrito: %s%s ~w~(%s~w~)", RL_NumColorCode(res), RL_NumText(res), colorname);
				RL_Render(s);
				RL_SetInfo(playerid, str);
			}
			continue;
		}
		new win = 0, total = RLS[s][rsTotal];
		for(new c = 0; c < RL_CELLS; c++)
			if(RLS[s][rsBets][c] > 0) win += RLS[s][rsBets][c] * RL_Multiplier(c, res);
		if(win > 0) RL_Pay(playerid, RLS[s][rsName], win);
		for(new c = 0; c < RL_CELLS; c++) RLS[s][rsLast][c] = RLS[s][rsBets][c], RLS[s][rsBets][c] = 0;
		RLS[s][rsTotal] = 0;

		if(playerid == INVALID_PLAYER_ID || !IsPlayerConnected(playerid))
		{
			RL_ClearChipObjects(s);
			RLS[s][rsPlayer] = INVALID_PLAYER_ID;
			continue;
		}
		if(win > total)
		{
			format(str, sizeof str, "%s%s ~w~(%s~w~)~n~Laimejote ~g~+%s EUR", RL_NumColorCode(res), RL_NumText(res), colorname, RL_Fmt(win - total));
			ApplyAnimation(playerid, "CASINO", "Roulette_win", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(playerid, 5448, 0.0, 0.0, 0.0);
		}
		else if(win > 0)
		{
			format(str, sizeof str, "%s%s ~w~(%s~w~)~n~Grazinta ~y~%s ~w~is %s EUR", RL_NumColorCode(res), RL_NumText(res), colorname, RL_Fmt(win), RL_Fmt(total));
			ApplyAnimation(playerid, "CASINO", "Roulette_lose", 4.1, 0, 0, 0, 1, 0, 1);
		}
		else
		{
			format(str, sizeof str, "%s%s ~w~(%s~w~)~n~Pralaimejote ~r~%s EUR", RL_NumColorCode(res), RL_NumText(res), colorname, RL_Fmt(total));
			ApplyAnimation(playerid, "CASINO", "Roulette_lose", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		RL_Render(s);
		RL_SetInfo(playerid, str);
	}
}

forward RL_Tick();
public RL_Tick()
{
	new now = GetTickCount();
	for(new t = 0; t < RL_TABLES; t++)
	{
		switch(RLT[t][rtState])
		{
			case RLS_BETTING:
			{
				if(now >= RLT[t][rtEnd])
				{
					new any = 0;
					for(new i = 0; i < RL_SEATS; i++) if(RLS[t * RL_SEATS + i][rsTotal] > 0) any = 1;
					if(any) RL_StartSpin(t);
					else { RLT[t][rtState] = RLS_WAIT; RL_RenderTable(t); }
				}
				else
				{
					static lastsec[RL_TABLES];
					new sec = (RLT[t][rtEnd] - now) / 1000;
					if(sec != lastsec[t])
					{
						lastsec[t] = sec;
						for(new i = 0; i < RL_SEATS; i++) if(RLS[t * RL_SEATS + i][rsPlayer] != INVALID_PLAYER_ID) RL_RenderInfo(t * RL_SEATS + i);
					}
				}
			}
			case RLS_SPIN:
			{
				if(now >= RLT[t][rtEnd]) RL_Finish(t);
			}
			case RLS_RESULT:
			{
				if(now >= RLT[t][rtEnd])
				{
					RLT[t][rtState] = RLS_WAIT;
					RL_DestroyTableBall(t);
					for(new i = 0; i < RL_SEATS; i++)
					{
						new s = t * RL_SEATS + i;
						RL_ClearChipObjects(s);
						if(RLS[s][rsPlayer] != INVALID_PLAYER_ID) RL_CamToTable(RLS[s][rsPlayer], t, true);
					}
					if(!RL_Enabled) RL_KickAll(t);
					else RL_RenderTable(t);
				}
			}
		}
	}
	static tick;
	if(++tick >= 50)
	{
		tick = 0;
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && RL_Owed[i] > 0) RL_TryPayOwed(i);
	}
	return 1;
}

// ============================================================
//      stalai ir sedimas
// ============================================================
stock RL_SetPos(playerid, Float:x, Float:y, Float:z)
{
	if(!CallRemoteFunction("ac_SetPlayerPos", "ifff", playerid, x, y, z)) SetPlayerPos(playerid, x, y, z);
	return 1;
}

stock RL_NearTable(playerid)
{
	if(!RL_Ready) return -1;
	if(GetPlayerVirtualWorld(playerid) != RL_WORLD || GetPlayerInterior(playerid) != RL_INTERIOR) return -1;
	new best = -1, Float:bestd = 3.0;
	for(new t = 0; t < RL_TABLES; t++)
	{
		new Float:x, Float:y;
		RL_Local(t, -0.14, -0.4, x, y);
		new Float:d = GetPlayerDistanceFromPoint(playerid, x, y, RL_TablePos[t][2]);
		if(d < bestd) bestd = d, best = t;
	}
	return best;
}

stock RL_SitDown(playerid, t)
{
	if(RL_PlayerSeat[playerid] != -1 || GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 0;
	if(!RL_Enabled) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Rulete siuo metu isjungta."), 0;
	if(RL_Cash(playerid) == -1) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Pirmiausia prisijunkite prie paskyros."), 0;
	new seat = -1, Float:bestd = 999.0;
	for(new i = 0; i < RL_SEATS; i++)
	{
		if(RLS[t * RL_SEATS + i][rsPlayer] != INVALID_PLAYER_ID || RLS[t * RL_SEATS + i][rsTotal] > 0) continue;
		new Float:x, Float:y;
		RL_Local(t, RL_SeatOff[i][0], RL_SeatOff[i][1], x, y);
		new Float:d = GetPlayerDistanceFromPoint(playerid, x, y, RL_TablePos[t][2] + RL_PLAYER_Z_OFF);
		if(d < bestd) bestd = d, seat = i;
	}
	if(seat == -1) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Prie sio stalo visos vietos uzimtos."), 0;

	new s = t * RL_SEATS + seat;
	RLS[s][rsPlayer] = playerid;
	RLS[s][rsTotal] = 0;
	RLS[s][rsReady] = false;
	for(new c = 0; c < RL_CELLS; c++) RLS[s][rsBets][c] = RLS[s][rsLast][c] = 0;
	GetPlayerName(playerid, RLS[s][rsName], MAX_PLAYER_NAME);
	RL_PlayerSeat[playerid] = s;
	RL_Chip[playerid] = 0;
	RL_EditMode[playerid] = 0;
	for(new c = 0; c < RL_CHIPS; c++)
	{
		new v = RL_Limits[t][0] * RL_ChipMult[c];
		if(v > RL_Limits[t][1]) v = RL_Limits[t][1];
		RL_ChipVal[playerid][c] = v;
	}

	new Float:sx, Float:sy, Float:fx, Float:fy, Float:z = RL_TablePos[t][2];
	RL_Local(t, RL_SeatOff[seat][0], RL_SeatOff[seat][1], sx, sy);
	if(seat < 4) RL_Local(t, -0.14, RL_SeatOff[seat][1], fx, fy);
	else RL_Local(t, -0.14, 0.0, fx, fy);
	RL_SetPos(playerid, sx, sy, z + RL_PLAYER_Z_OFF);
	SetPlayerFacingAngle(playerid, 360.0 - atan2(fx - sx, fy - sy));
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "CASINO", "Roulette_in", 4.1, 0, 0, 0, 1, 0, 1);
	RL_CurRow[playerid] = 1, RL_CurCol[playerid] = 0;       // pradzia - ant "2"
	RL_HeldDir[playerid] = 0;
	if(RLT[t][rtState] == RLS_SPIN || RLT[t][rtState] == RLS_RESULT)
	{
		new Float:cx, Float:cy, Float:cz, Float:lx, Float:ly, Float:lz;
		RL_CamWheelPos(t, cx, cy, cz, lx, ly, lz);
		SetPlayerCameraPos(playerid, cx, cy, cz);
		SetPlayerCameraLookAt(playerid, lx, ly, lz);
	}
	else RL_CamToTable(playerid, t, false);

	RL_CreateTD(playerid);
	RL_Render(s);
	RL_UpdateCursor(playerid);
	SendClientMessage(playerid, 0xE3B924FF, "[Rulete] {FFFFFF}W/A/S/D - langelis, SPACE - statyti, C - mazinti, ALT - zetonas, Y - sukti, N - atsaukti, ENTER - iseiti.");
	return 1;
}

stock RL_StandUp(playerid, bool:disconnect = false)
{
	new s = RL_PlayerSeat[playerid];
	if(s == -1) return 0;
	new t = s / RL_SEATS;
	if(RL_EditMode[playerid]) RL_EditMode[playerid] = 0, RL_SaveBoard();
	RL_PlayerSeat[playerid] = -1;
	if(RLT[t][rtState] == RLS_SPIN && RLS[s][rsTotal] > 0) RLS[s][rsPlayer] = INVALID_PLAYER_ID; // ismoka RL_Finish pagal varda
	else
	{
		RL_RefundBets(s);
		RLS[s][rsPlayer] = INVALID_PLAYER_ID;
	}
	RL_HideCursor(playerid);
	if(!disconnect)
	{
		if(RL_PreviewOn[playerid]) RL_ShowPreview(playerid, t, false);
		RL_DestroyTD(playerid);
		TogglePlayerControllable(playerid, 1);
		SetCameraBehindPlayer(playerid);
		ClearAnimations(playerid);
	}
	RL_PreviewOn[playerid] = false;
	// kiti prie stalo gal jau visi pasiruose
	if(RL_Enabled && RLT[t][rtState] == RLS_BETTING)
	{
		new all = 1, any = 0;
		for(new i = 0; i < RL_SEATS; i++)
		{
			new o = t * RL_SEATS + i;
			if(RLS[o][rsPlayer] == INVALID_PLAYER_ID) continue;
			any = 1;
			if(!RLS[o][rsReady]) all = 0;
		}
		if(any && all) RL_StartSpin(t);
	}
	return 1;
}

stock RL_KickAll(t)
{
	for(new i = 0; i < RL_SEATS; i++)
	{
		new playerid = RLS[t * RL_SEATS + i][rsPlayer];
		if(playerid == INVALID_PLAYER_ID) continue;
		RL_StandUp(playerid);
		SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Administracija isjunge rulete. Statymai grazinti.");
	}
}

stock RL_UpdateLabels()
{
	for(new t = 0; t < RL_TABLES; t++)
	{
		if(RL_Label[t] == STREAMER_TAG_3D_TEXT_LABEL:INVALID_STREAMER_ID) continue;
		new str[220];
		if(RL_Enabled) format(str, sizeof str, "{E3B924}AMERIKIETISKA RULETE  #%d\n{FFFFFF}Zetonas nuo {9ACD32}%s{FFFFFF}, max {9ACD32}%s EUR\n{AFAFAF}Spauskite {FFFFFF}["RL_KEY_NAME"]{AFAFAF} arba {FFFFFF}/rulete", t + 1, RL_Fmt(RL_Limits[t][0]), RL_Fmt(RL_Limits[t][1]));
		else format(str, sizeof str, "{E3B924}AMERIKIETISKA RULETE  #%d\n{FF6347}Siuo metu uzdaryta", t + 1);
		UpdateDynamic3DTextLabelText(RL_Label[t], -1, str);
	}
}

// surandamas artimiausias objektas (model) casino mape
stock STREAMER_TAG_OBJECT:RL_FindObject(model, Float:x, Float:y, Float:z, Float:maxd)
{
	new top = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT), STREAMER_TAG_OBJECT:best = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID, Float:bestd = maxd;
	for(new id = 1; id <= top; id++)
	{
		if(!IsValidDynamicObject(STREAMER_TAG_OBJECT:id)) continue;
		if(Streamer_GetIntData(STREAMER_TYPE_OBJECT, STREAMER_TAG_OBJECT:id, E_STREAMER_MODEL_ID) != model) continue;
		new Float:ox, Float:oy, Float:oz;
		GetDynamicObjectPos(STREAMER_TAG_OBJECT:id, ox, oy, oz);
		new Float:d = VectorSize(ox - x, oy - y, oz - z);
		if(d < bestd) bestd = d, best = STREAMER_TAG_OBJECT:id;
	}
	return best;
}

// pasalinami kitu skriptu botai (krupje), stovintys prie musu krupje
stock RL_RemoveForeignActors(t)
{
	new Float:dx, Float:dy, Float:dz = RL_TablePos[t][2], removed = 0;
	RL_Local(t, RL_DEALER_X, RL_DEALER_Y, dx, dy);
	new top = Streamer_GetUpperBound(STREAMER_TYPE_ACTOR);
	for(new id = 1; id <= top; id++)
	{
		if(!IsValidDynamicActor(STREAMER_TAG_ACTOR:id)) continue;
		new mine = 0;
		for(new k = 0; k < RL_TABLES; k++) if(STREAMER_TAG_ACTOR:id == RL_Actor[k]) mine = 1;
		if(mine) continue;
		if(!Streamer_IsInArrayData(STREAMER_TYPE_ACTOR, STREAMER_TAG_ACTOR:id, E_STREAMER_WORLD_ID, RL_WORLD)) continue;
		new Float:ax, Float:ay, Float:az;
		GetDynamicActorPos(STREAMER_TAG_ACTOR:id, ax, ay, az);
		if(floatabs(az - dz) > 2.0 || VectorSize(ax - dx, ay - dy, 0.0) > 1.8) continue;
		DestroyDynamicActor(STREAMER_TAG_ACTOR:id);
		removed++;
	}
	for(new a = 0, n = GetActorPoolSize(); a <= n; a++)
	{
		if(!IsValidActor(a) || GetActorVirtualWorld(a) != RL_WORLD) continue;
		new Float:ax, Float:ay, Float:az;
		GetActorPos(a, ax, ay, az);
		if(floatabs(az - dz) > 2.0 || VectorSize(ax - dx, ay - dy, 0.0) > 1.8) continue;
		DestroyActor(a);
		removed++;
	}
	return removed;
}

forward RL_SpawnTables();
public RL_SpawnTables()
{
	new made = 0, removed = 0;
	for(new t = 0; t < RL_TABLES; t++)
	{
		RL_Objs[t][0] = RL_Objs[t][1] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
		new STREAMER_TAG_OBJECT:tab = RL_FindObject(RL_TABLE_MODEL, RL_TablePos[t][0], RL_TablePos[t][1], RL_TablePos[t][2], 4.0);
		if(tab != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID)
		{
			new Float:rx, Float:ry, Float:rz;
			GetDynamicObjectPos(tab, RL_TablePos[t][0], RL_TablePos[t][1], RL_TablePos[t][2]);
			GetDynamicObjectRot(tab, rx, ry, rz);
			RL_TablePos[t][3] = rz;
		}
		else
		{
			RL_Objs[t][0] = CreateDynamicObject(RL_TABLE_MODEL, RL_TablePos[t][0], RL_TablePos[t][1], RL_TablePos[t][2], 0.0, 0.0, RL_TablePos[t][3], RL_WORLD, RL_INTERIOR, -1, 150.0, 150.0);
			made++;
		}
		// ratas: tikra padetis is mapo, jei yra
		new Float:wx, Float:wy;
		RL_Local(t, RL_WHEEL_X, RL_WHEEL_Y, wx, wy);
		new STREAMER_TAG_OBJECT:wh = RL_FindObject(RL_WHEEL_MODEL, wx, wy, RL_TablePos[t][2] - 0.05, 2.5);
		if(wh == STREAMER_TAG_OBJECT:INVALID_STREAMER_ID)
		{
			wh = RL_Objs[t][1] = CreateDynamicObject(RL_WHEEL_MODEL, wx, wy, RL_TablePos[t][2] - 0.05, 0.0, 0.0, RL_TablePos[t][3], RL_WORLD, RL_INTERIOR, -1, 150.0, 150.0);
		}
		RL_WheelObj[t] = wh;
		GetDynamicObjectPos(wh, RL_WheelPos[t][0], RL_WheelPos[t][1], RL_WheelPos[t][2]);
		GetDynamicObjectRot(wh, RL_WheelRot[t][0], RL_WheelRot[t][1], RL_WheelRot[t][2]);

		// krupje (originalaus GTA krupje vietoje) ir uzrasas
		new Float:dx, Float:dy, Float:lx, Float:ly;
		RL_Local(t, RL_DEALER_X, RL_DEALER_Y, dx, dy);
		RL_Actor[t] = CreateDynamicActor(t ? 172 : 171, dx, dy, RL_TablePos[t][2], RL_TablePos[t][3] + 90.0, true, 100.0, RL_WORLD, RL_INTERIOR, -1, 60.0);
		ApplyDynamicActorAnimation(RL_Actor[t], "CASINO", "dealone", 4.1, 1, 0, 0, 0, 0);
		RL_Local(t, -0.14, -0.6, lx, ly);
		RL_Label[t] = CreateDynamic3DTextLabel(" ", -1, lx, ly, RL_TablePos[t][2] + 1.2, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, RL_WORLD, RL_INTERIOR);
	}
	for(new t = 0; t < RL_TABLES; t++) removed += RL_RemoveForeignActors(t);
	RL_Ready = true;
	RL_UpdateLabels();
	printf("[Rulete] stalai: %d sukurta, %d rasta casino mape; pasalinta svetimu botu: %d", made, RL_TABLES - made, removed);
	return 1;
}

// ============================================================
//      ijungimas / isjungimas (gamemode /casinogames, admin 8)
// ============================================================
forward RL_SetEnabled(on);
public RL_SetEnabled(on)
{
	RL_Enabled = on ? true : false;
	RL_CfgSave("enabled", on ? 1.0 : 0.0);
	if(!RL_Enabled)
		for(new t = 0; t < RL_TABLES; t++)
			if(RLT[t][rtState] != RLS_SPIN && RLT[t][rtState] != RLS_RESULT) RL_KickAll(t), RLT[t][rtState] = RLS_WAIT;
	RL_UpdateLabels();
	return 1;
}

// 2 - ijungta, 1 - isjungta (0 - filterscript neikeltas)
forward RL_IsEnabled();
public RL_IsEnabled() return RL_Enabled ? 2 : 1;

// ============================================================
//      callback'ai
// ============================================================
public OnFilterScriptInit()
{
	RL_DB = db_open(RL_DB_FILE);
	db_free_result(db_query(RL_DB, "CREATE TABLE IF NOT EXISTS rl_owed (name TEXT PRIMARY KEY, amount INTEGER NOT NULL DEFAULT 0)"));
	db_free_result(db_query(RL_DB, "CREATE TABLE IF NOT EXISTS rl_cfg (k TEXT PRIMARY KEY, v REAL NOT NULL DEFAULT 0)"));
	RL_LoadAllCfg();
	for(new s = 0; s < RL_TABLES * RL_SEATS; s++)
	{
		RLS[s][rsPlayer] = INVALID_PLAYER_ID;
		for(new c = 0; c < RL_CELLS; c++) RLS[s][rsChips][c] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
	}
	for(new t = 0; t < RL_TABLES; t++) RLT[t][rtState] = RLS_WAIT, RLT[t][rtHistCount] = 0, RLT[t][rtBall] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) RL_LoadOwed(i);
	RL_SpawnTimer = SetTimer("RL_SpawnTables", 5000, false);   // casino mapas sukuriamas gamemode - palaukiama
	RL_Timer = SetTimer("RL_Tick", 100, true);
	RL_BallTimer = SetTimer("RL_BallTick", 50, true);
	print("\n--- Amerikietiska rulete (SAGyvenimas) loaded ---\n");
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(RL_Timer);
	KillTimer(RL_BallTimer);
	KillTimer(RL_SpawnTimer);
	for(new i = 0; i < MAX_PLAYERS; i++)
		if(IsPlayerConnected(i) && RL_PlayerSeat[i] != -1) RL_StandUp(i);
	for(new s = 0; s < RL_TABLES * RL_SEATS; s++) { if(RLS[s][rsTotal] > 0) RL_RefundBets(s); RL_ClearChipObjects(s); }
	for(new t = 0; t < RL_TABLES; t++)
	{
		if(RLT[t][rtState] == RLS_SPIN) RL_StopWheel(t);
		RL_DestroyTableBall(t);
		if(RL_Actor[t] != STREAMER_TAG_ACTOR:INVALID_STREAMER_ID) DestroyDynamicActor(RL_Actor[t]);
		if(RL_Label[t] != STREAMER_TAG_3D_TEXT_LABEL:INVALID_STREAMER_ID) DestroyDynamic3DTextLabel(RL_Label[t]);
		for(new k = 0; k < 2; k++) if(RL_Objs[t][k] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID) DestroyDynamicObject(RL_Objs[t][k]);
	}
	db_close(RL_DB);
	return 1;
}

public OnPlayerConnect(playerid)
{
	RL_PlayerSeat[playerid] = -1;
	RL_TDCreated[playerid] = false;
	RL_Chip[playerid] = 0;
	RL_EditMode[playerid] = 0;
	RL_CurDisc[playerid] = RL_CurChip[playerid] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
	RL_PreviewOn[playerid] = false;
	RL_LoadOwed(playerid);
	ApplyAnimation(playerid, "CASINO", "null", 4.1, 0, 0, 0, 0, 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(RL_PlayerSeat[playerid] != -1) RL_StandUp(playerid, true);
	RL_HideCursor(playerid);
	RL_TDCreated[playerid] = false;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(RL_PlayerSeat[playerid] != -1) RL_StandUp(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(RL_PlayerSeat[playerid] != -1) RL_StandUp(playerid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(RL_PlayerSeat[playerid] != -1) return RL_HandleKeys(playerid, newkeys, oldkeys);
	if((newkeys & RL_KEY) && !(oldkeys & RL_KEY))
	{
		new t = RL_NearTable(playerid);
		if(t != -1) { RL_SitDown(playerid, t); return 1; }
	}
	return 0;
}

stock RL_HandleKeys(playerid, newkeys, oldkeys)
{
	new s = RL_PlayerSeat[playerid];
	if(s == -1) return 0;
	new t = s / RL_SEATS;
	#define RL_PRESSED(%0) ((newkeys & (%0)) && !(oldkeys & (%0)))
	if(RL_EditMode[playerid])
	{
		if(RL_PRESSED(KEY_WALK))
		{
			RL_EditMode[playerid] = RL_EditMode[playerid] % 3 + 1;
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			RL_RenderInfo(s);
		}
		else if(RL_PRESSED(KEY_SECONDARY_ATTACK))
		{
			RL_EditMode[playerid] = 0;
			RL_SaveBoard();
			RL_ShowPreview(playerid, t, false);
			RL_RenderTable(t);
			new str[144];
			format(str, sizeof str, "[Rulete] {FFFFFF}Lenta issaugota: /rlboard %.3f %.3f %.3f %.3f %.3f", RL_BX0, RL_BDX, RL_BY0, RL_BDY, RL_FeltZ);
			SendClientMessage(playerid, 0xE3B924FF, str);
		}
		return 1;
	}
	if(RL_PRESSED(KEY_SPRINT))
	{
		RL_PlaceBet(s, RL_CursorCell(playerid), RL_ChipVal[playerid][RL_Chip[playerid]]);
		return 1;
	}
	if(RL_PRESSED(KEY_CROUCH))
	{
		RL_DecBet(s, RL_CursorCell(playerid));
		return 1;
	}
	if(RL_PRESSED(KEY_WALK))
	{
		new c = RL_Chip[playerid];
		for(new k = 0; k < RL_CHIPS; k++)
		{
			c = (c + 1) % RL_CHIPS;
			if(c == 0 || RL_ChipVal[playerid][c] != RL_ChipVal[playerid][c - 1]) break;
		}
		RL_Chip[playerid] = c;
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		RL_RenderSel(s);
		return 1;
	}
	if(RL_PRESSED(KEY_NO))
	{
		if(RLT[t][rtState] != RLS_WAIT && RLT[t][rtState] != RLS_BETTING) return 1;
		if(RLS[s][rsTotal] > 0) RL_RefundBets(s), SendClientMessage(playerid, 0xE3B924FF, "[Rulete] {FFFFFF}Visi statymai atsaukti ir grazinti.");
		RL_Render(s);
		return 1;
	}
	if(RL_PRESSED(KEY_YES))
	{
		RL_SetReady(s);
		return 1;
	}
	if(RL_PRESSED(KEY_FIRE))
	{
		RL_RepeatBets(s);
		return 1;
	}
	if(RL_PRESSED(KEY_SECONDARY_ATTACK))
	{
		if(RLT[t][rtState] == RLS_SPIN && RLS[s][rsTotal] > 0)
			return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Palaukite, kol sustos kamuoliukas."), 1;
		RL_StandUp(playerid);
		SendClientMessage(playerid, 0xE3B924FF, "[Rulete] {FFFFFF}Palikote stala.");
		return 1;
	}
	#undef RL_PRESSED
	return 1;
}

// /rlboard derinimo zingsnis
stock RL_EditStep(playerid, dir)
{
	new s = RL_PlayerSeat[playerid], t = s / RL_SEATS;
	new Float:sgn = RL_BDX < 0.0 ? -1.0 : 1.0;
	switch(RL_EditMode[playerid])
	{
		case 1:   // stumti: W - link rato, D - i desine
		{
			switch(dir)
			{
				case 1: RL_BY0 += 0.01;
				case 2: RL_BY0 -= 0.01;
				case 3: RL_BX0 -= 0.01;
				case 4: RL_BX0 += 0.01;
			}
		}
		case 2:   // dydis: W/S - langelio ilgis, A/D - plotis
		{
			switch(dir)
			{
				case 1: RL_BDY += 0.002;
				case 2: RL_BDY -= 0.002;
				case 3: RL_BDX -= 0.002 * sgn;
				case 4: RL_BDX += 0.002 * sgn;
			}
			if(RL_BDY < 0.05) RL_BDY = 0.05;
			if(floatabs(RL_BDX) < 0.05) RL_BDX = 0.05 * sgn;
		}
		case 3:   // aukstis: W - aukstyn
		{
			if(dir == 1) RL_FeltZ += 0.005;
			else if(dir == 2) RL_FeltZ -= 0.005;
		}
	}
	RL_ShowPreview(playerid, t, true);
	RL_CamToTable(playerid, t, false);
	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	return 1;
}

// W/S - per skaicius (link rato / nuo rato), A/D - per eiles; laikant - kartojasi
public OnPlayerUpdate(playerid)
{
	new s = RL_PlayerSeat[playerid];
	if(s == -1) return 1;
	new t = s / RL_SEATS;
	if(!RL_EditMode[playerid] && RLT[t][rtState] != RLS_WAIT && RLT[t][rtState] != RLS_BETTING) return 1;
	new keys, ud, lr;
	GetPlayerKeys(playerid, keys, ud, lr);
	new dir = 0;
	if(ud < 0) dir = 1;
	else if(ud > 0) dir = 2;
	else if(lr < 0) dir = 3;
	else if(lr > 0) dir = 4;
	if(!dir) { RL_HeldDir[playerid] = 0; return 1; }
	new now = GetTickCount();
	if(dir == RL_HeldDir[playerid] && now < RL_MoveTick[playerid]) return 1;
	RL_MoveTick[playerid] = now + (dir == RL_HeldDir[playerid] ? 120 : 260);
	RL_HeldDir[playerid] = dir;
	if(RL_EditMode[playerid]) return RL_EditStep(playerid, dir), 1;
	// ekrane: virsus - ratas (+Y), desine - +X
	new rstep = RL_BDX < 0.0 ? -1 : 1;
	switch(dir)
	{
		case 1: RL_MoveCursor(playerid, 0, -1);        // W - link rato (0 / 00)
		case 2: RL_MoveCursor(playerid, 0, 1);         // S - nuo rato
		case 3: RL_MoveCursor(playerid, -rstep, 0);    // A - kairen (tuzinai, 1:1)
		case 4: RL_MoveCursor(playerid, rstep, 0);     // D - desinen
	}
	return 1;
}

// ============================================================
//      komandos
// ============================================================
CMD:rulete(playerid, params[])
{
	if(RL_PlayerSeat[playerid] != -1) return SendClientMessage(playerid, 0xE3B924FF, "[Rulete] {FFFFFF}Jus jau prie stalo. ENTER - palikti stala."), 1;
	new t = RL_NearTable(playerid);
	if(t == -1) return SendClientMessage(playerid, 0xE3B924FF, "[Rulete] {FFFFFF}Ruletes stalai yra Casino. Prieikite prie stalo ir spauskite ["RL_KEY_NAME"] arba /rulete."), 1;
	RL_SitDown(playerid, t);
	return 1;
}
CMD:rl(playerid, params[]) return callcmd::rulete(playerid, params);

// skaiciai be sscanf; grazina kiek perskaityta
stock RL_ParseFloats(const params[], Float:out[], max)
{
	new tmp[16], idx = 0, pos = 0, len = strlen(params);
	for(new i = 0; i <= len && idx < max; i++)
	{
		if(params[i] == ' ' || params[i] == EOS)
		{
			if(pos > 0) { tmp[pos] = EOS; out[idx++] = floatstr(tmp); pos = 0; }
		}
		else if(pos < 15) tmp[pos++] = params[i];
	}
	return idx;
}

// /rlboard                        - derinimas klavisais (W/A/S/D, ALT - rezimas, ENTER - issaugoti)
// /rlboard x0 dx y0 dy [aukstis]  - tiksliai skaiciais
// /rlboard reset                  - grazinti GTA SA numatytuosius
CMD:rlboard(playerid, params[])
{
	if(CallRemoteFunction("Poker_GetAdmin", "i", playerid) < 6) return 0;
	new s = RL_PlayerSeat[playerid];
	if(s == -1) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Atsisekite prie ruletes stalo (N)."), 1;
	new t = s / RL_SEATS, Float:v[5], n = RL_ParseFloats(params, v, 5), str[160];
	if(!strcmp(params, "reset", true) && params[0])
	{
		RL_BX0 = 0.298, RL_BDX = -0.261, RL_BY0 = 0.647, RL_BDY = 0.166, RL_FeltZ = -0.10;
		RL_SaveBoard();
		RL_ShowPreview(playerid, t, true);
		RL_CamToTable(playerid, t, false);
		RL_UpdateCursor(playerid);
	}
	else if(n >= 4)
	{
		RL_BX0 = v[0], RL_BDX = v[1], RL_BY0 = v[2], RL_BDY = v[3];
		if(n >= 5) RL_FeltZ = v[4];
		RL_SaveBoard();
		RL_ShowPreview(playerid, t, true);
		RL_CamToTable(playerid, t, false);
		RL_UpdateCursor(playerid);
	}
	else
	{
		if(RLT[t][rtState] != RLS_WAIT && RLT[t][rtState] != RLS_BETTING) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Palaukite, kol baigsis sukimas."), 1;
		RL_EditMode[playerid] = 1;
		RL_HideCursor(playerid);
		RL_ShowPreview(playerid, t, true);
		RL_CamToTable(playerid, t, false);
		RL_RenderInfo(s);
		SendClientMessage(playerid, 0xE3B924FF, "[Rulete] {FFFFFF}Lentos derinimas: W/A/S/D - keisti, ALT - rezimas (stumti / dydis / aukstis), ENTER - issaugoti.");
		SendClientMessage(playerid, 0xAFAFAFFF, "Sutapatinkite uzrasus su skaiciais ant stalo pieso. /rlboard reset - GTA SA numatytieji.");
	}
	format(str, sizeof str, "[Rulete] {FFFFFF}Lenta: /rlboard %.3f %.3f %.3f %.3f %.3f  (x0, eiles zingsnis, y0, stulpelio zingsnis, aukstis)", RL_BX0, RL_BDX, RL_BY0, RL_BDY, RL_FeltZ);
	SendClientMessage(playerid, 0xE3B924FF, str);
	return 1;
}

// /rlcfg <takelio spindulys> <kiseniu spindulys> <aukstis> - kamuoliukas (admin 6+)
CMD:rlcfg(playerid, params[])
{
	if(CallRemoteFunction("Poker_GetAdmin", "i", playerid) < 6) return 0;
	new Float:v[3], str[160];
	if(RL_ParseFloats(params, v, 3) == 3)
	{
		RL_BallROut = v[0], RL_BallRIn = v[1], RL_BallZ = v[2];
		RL_SaveBall();
	}
	format(str, sizeof str, "[Rulete] {FFFFFF}Kamuoliukas: /rlcfg %.3f %.3f %.3f  (takelio spindulys, kiseniu spindulys, aukstis virs rato). Issaugoma.", RL_BallROut, RL_BallRIn, RL_BallZ);
	return SendClientMessage(playerid, 0xE3B924FF, str), 1;
}

// /rltest - admin: rato ir kamuoliuko animacija be statymu (patikrinimui)
CMD:rltest(playerid, params[])
{
	if(CallRemoteFunction("Poker_GetAdmin", "i", playerid) < 6) return 0;
	new s = RL_PlayerSeat[playerid];
	if(s == -1) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Atsisekite prie ruletes stalo (N)."), 1;
	new t = s / RL_SEATS;
	if(RLT[t][rtState] != RLS_WAIT) return SendClientMessage(playerid, 0xFF6347FF, "[Rulete] {FFFFFF}Stalas uzimtas (vyksta sukimas arba statymai)."), 1;
	RL_StartSpin(t);
	return 1;
}
