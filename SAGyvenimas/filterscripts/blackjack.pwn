/*
    ============================================================
     BLACK JACK  -  atskiras SA:MP filterscript (SAGyvenimas)
    ------------------------------------------------------------
     * 4 stalai jusu Casino (4 Dragons, virtual world 3, interior 215).
       Prie kiekvieno stalo - dileris ir 3 vietos zaidejams.
     * Prie stalo: spausti [N] arba /bj (/bj <suma> - statyti iskart).
     * Statymas renkamas zetonais (paspaudus zetona suma didinama),
       VALYTI - isvalyti, STATYTI - dalinti kortas.
     * Taisykles: 6 kalades, dileris ima iki 17 (stoja ant soft 17),
       Black Jack moka 3:2, laimejimas 1:1, lygiosios - statymas grazinamas,
       "Dvigubinti" - tik su pirmomis 2 kortomis.
     * Pinigai - EURO daiktas inventoriuje (Poker_* public'ai arizona.pwn).
       Ko nepavyko ideti i inventoriu - saugoma scriptfiles/blackjack.db
       ir grazinama automatiskai.
     * ESC - palikti stala (jei ranka vyksta - ji baigiama automatiskai).
     * Jei casino mape stalo (2188) toje vietoje nera - filterscript ji
       sukuria pats (patikrinama praejus 5 s po paleidimo).

     server.cfg: filterscripts ... blackjack
     Gamemode (arizona.pwn) persiuncia BJ_DIALOG_BET (32711) atsakymus i
     BJDialogResponse (kaip pokerio dialogus).
    ============================================================
*/
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>
#include <Pawn.CMD>

// ---------------- nustatymai ----------------
#define BJ_TABLES            4
#define BJ_SEATS             3
#define BJ_DECKS             6
#define BJ_ACTION_TIME       30          // sek. sprendimui (po to - automatiskai "Stoti")
#define BJ_KEY               KEY_NO
#define BJ_KEY_NAME          "N"
#define BJ_DIALOG_BET        32711
#define BJ_API_VERSION       1
#define BJ_DB_FILE           "blackjack.db"

// Casino (4 Dragons) - kaip arizona.pwn: SetPlayerVirtualWorld(3), SetPlayerInterior(215)
#define BJ_WORLD             3
#define BJ_INTERIOR          215
#define BJ_TABLE_MODEL       2188        // GTA kazino Black Jack stalas

// stalai: x, y, z, pasukimas (z) - is jusu casino
new const Float:BJ_TablePos[BJ_TABLES][4] = {
	{2278.459960, -818.768981, 1407.150024, 14.899999},
	{2295.179931, -816.690979, 1407.140014, 14.899999},
	{2290.820068, -815.062988, 1407.069946, 21.700000},
	{2297.459960, -812.155029, 1407.099975, 17.000000}
};
// stalu statymu ribos (EUR)
new const BJ_Limits[BJ_TABLES][2] = {
	{100, 5000},
	{1000, 25000},
	{5000, 100000},
	{25000, 500000}
};
// GTA stalas 2188: pusapvalis, pivot - tiesiosios krastines viduryje.
// Zaidejai lenktoje (-Y) puseje, dileris uz tiesios (+Y) krastines (stalo koordinatemis).
new const Float:BJ_SeatOff[BJ_SEATS][2] = {
	{-1.30, -1.58}, {0.0, -2.05}, {1.30, -1.58}
};
#define BJ_DEALER_OFF_Y      0.65
#define BJ_PLAYER_Z_OFF      0.44        // zaidejo pozicija = stalo z + 0.44 (stalo pivot ~0.55 virs grindu)

new const BJ_CardSprite[52][] = {
	"LD_POKE:cd2c","LD_POKE:cd3c","LD_POKE:cd4c","LD_POKE:cd5c","LD_POKE:cd6c","LD_POKE:cd7c","LD_POKE:cd8c","LD_POKE:cd9c","LD_POKE:cd10c","LD_POKE:cd11c","LD_POKE:cd12c","LD_POKE:cd13c","LD_POKE:cd1c",
	"LD_POKE:cd2d","LD_POKE:cd3d","LD_POKE:cd4d","LD_POKE:cd5d","LD_POKE:cd6d","LD_POKE:cd7d","LD_POKE:cd8d","LD_POKE:cd9d","LD_POKE:cd10d","LD_POKE:cd11d","LD_POKE:cd12d","LD_POKE:cd13d","LD_POKE:cd1d",
	"LD_POKE:cd2h","LD_POKE:cd3h","LD_POKE:cd4h","LD_POKE:cd5h","LD_POKE:cd6h","LD_POKE:cd7h","LD_POKE:cd8h","LD_POKE:cd9h","LD_POKE:cd10h","LD_POKE:cd11h","LD_POKE:cd12h","LD_POKE:cd13h","LD_POKE:cd1h",
	"LD_POKE:cd2s","LD_POKE:cd3s","LD_POKE:cd4s","LD_POKE:cd5s","LD_POKE:cd6s","LD_POKE:cd7s","LD_POKE:cd8s","LD_POKE:cd9s","LD_POKE:cd10s","LD_POKE:cd11s","LD_POKE:cd12s","LD_POKE:cd13s","LD_POKE:cd1s"
};
#define BJ_CARD_BACK         "LD_POKE:cdback"
#define BJ_MAX_CARDS         7     // rodoma kortu eileje

// ---------------- busenos ----------------
#define BJS_FREE     0   // vieta laisva
#define BJS_BET      1   // laukiama statymo
#define BJS_DEAL     2   // dalinamos kortos
#define BJS_PLAYER   3   // zaidejo eile
#define BJS_DEALER   4   // dilerio eile
#define BJS_DONE     5   // rezultatas

#define BJ_SEAT_COUNT (BJ_TABLES * BJ_SEATS)

enum E_BJ_SEAT
{
	bsPlayer,
	bsState,
	bsBet,
	bsLastBet,
	bsSelBet,            // renkamas statymas (zetonai)
	bsPCards[12],
	bsPCount,
	bsDCards[12],
	bsDCount,
	bool:bsHole,         // dilerio antra korta atversta
	bsStep,
	bsNext,              // GetTickCount() kito zingsnio
	bsDeadline,          // GetTickCount() sprendimo pabaiga
	bool:bsDoubled,
	bool:bsPlayerDone,
	bsShoe[BJ_DECKS * 52],
	bsShoePos
};
new BJ[BJ_SEAT_COUNT][E_BJ_SEAT];

new BJ_PlayerSeat[MAX_PLAYERS] = {-1, ...};
new BJ_OpenDialog[MAX_PLAYERS] = {-1, ...};
new BJ_ChatBetUntil[MAX_PLAYERS];
new BJ_Owed[MAX_PLAYERS];
new bool:BJ_TDCreated[MAX_PLAYERS];
new bool:BJ_Enabled = true;

// ---------------- textdraw'ai ----------------
#define BJ_CHIPS      5
#define BJ_BTNS       3
new PlayerText:TD_Bg[MAX_PLAYERS], PlayerText:TD_LineT[MAX_PLAYERS], PlayerText:TD_LineB[MAX_PLAYERS],
	PlayerText:TD_FeltL[MAX_PLAYERS], PlayerText:TD_FeltR[MAX_PLAYERS],
	PlayerText:TD_Title[MAX_PLAYERS], PlayerText:TD_Table[MAX_PLAYERS], PlayerText:TD_DLabel[MAX_PLAYERS], PlayerText:TD_PLabel[MAX_PLAYERS],
	PlayerText:TD_DCard[MAX_PLAYERS][BJ_MAX_CARDS], PlayerText:TD_PCard[MAX_PLAYERS][BJ_MAX_CARDS],
	PlayerText:TD_Badge[MAX_PLAYERS][2][3], Float:BJ_BadgeX[MAX_PLAYERS][2],
	PlayerText:TD_Info[MAX_PLAYERS], PlayerText:TD_Money[MAX_PLAYERS], PlayerText:TD_BetInfo[MAX_PLAYERS],
	PlayerText:TD_Chip[MAX_PLAYERS][BJ_CHIPS][4], BJ_ChipVal[MAX_PLAYERS][BJ_CHIPS],
	PlayerText:TD_Btn[MAX_PLAYERS][BJ_BTNS];

new BJ_Timer, BJ_SpawnTimer, DB:BJ_DB, STREAMER_TAG_ACTOR:BJ_TableActor[BJ_TABLES],
	STREAMER_TAG_OBJECT:BJ_TableObj[BJ_TABLES] = {STREAMER_TAG_OBJECT:INVALID_STREAMER_ID, ...},
	STREAMER_TAG_3D_TEXT_LABEL:BJ_TableLabel[BJ_TABLES];

// ============================================================
//      pinigai (EURO per gamemode Poker_* API)
// ============================================================
stock bool:BJ_ApiOK() return CallRemoteFunction("Poker_ApiVersion", "i", 0) == BJ_API_VERSION;

stock BJ_Cash(playerid)
{
	if(!BJ_ApiOK()) return -1;
	return CallRemoteFunction("Poker_GetEuro", "i", playerid);
}

stock BJ_Take(playerid, amount)
{
	if(amount <= 0 || !BJ_ApiOK()) return 0;
	return CallRemoteFunction("Poker_TakeEuro", "ii", playerid, amount);
}

stock BJ_Pay(playerid, amount)
{
	if(amount <= 0) return 1;
	new paid = 0;
	if(IsPlayerConnected(playerid) && BJ_ApiOK()) paid = CallRemoteFunction("Poker_GiveEuro", "ii", playerid, amount);
	if(paid < 0) paid = 0;
	if(paid > amount) paid = amount;
	if(paid < amount)
	{
		BJ_Owed[playerid] += amount - paid;
		BJ_SaveOwed(playerid);
		if(IsPlayerConnected(playerid))
		{
			new m[144];
			format(m, sizeof m, "[Black Jack] {FFFFFF}%s EUR netilpo i inventoriu - issaugota, bus grazinta automatiskai.", BJ_Fmt(amount - paid));
			SendClientMessage(playerid, 0xE3B924FF, m);
		}
	}
	return 1;
}

stock BJ_Name(playerid)
{
	new n[MAX_PLAYER_NAME];
	GetPlayerName(playerid, n, sizeof n);
	return n;
}

stock BJ_SaveOwed(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new q[200], name[MAX_PLAYER_NAME * 2], n[MAX_PLAYER_NAME];
	n = BJ_Name(playerid);
	BJ_Escape(n, name, sizeof name);
	format(q, sizeof q, "INSERT OR REPLACE INTO bj_owed (name, amount) VALUES ('%s', %d)", name, BJ_Owed[playerid]);
	db_free_result(db_query(BJ_DB, q));
	return 1;
}

stock BJ_LoadOwed(playerid)
{
	BJ_Owed[playerid] = 0;
	new q[160], name[MAX_PLAYER_NAME * 2], n[MAX_PLAYER_NAME];
	n = BJ_Name(playerid);
	BJ_Escape(n, name, sizeof name);
	format(q, sizeof q, "SELECT amount FROM bj_owed WHERE name = '%s'", name);
	new DBResult:r = db_query(BJ_DB, q);
	if(r)
	{
		if(db_num_rows(r)) BJ_Owed[playerid] = db_get_field_int(r, 0);
		db_free_result(r);
	}
	return 1;
}

stock BJ_TryPayOwed(playerid)
{
	if(BJ_Owed[playerid] <= 0 || BJ_Cash(playerid) == -1) return 0;
	new amount = BJ_Owed[playerid];
	BJ_Owed[playerid] = 0;
	new paid = CallRemoteFunction("Poker_GiveEuro", "ii", playerid, amount);
	if(paid < 0) paid = 0;
	if(paid > amount) paid = amount;
	BJ_Owed[playerid] = amount - paid;
	BJ_SaveOwed(playerid);
	if(paid > 0)
	{
		new m[144];
		format(m, sizeof m, "[Black Jack] {FFFFFF}Grazinta %s EUR (anksciau netilpo i inventoriu).", BJ_Fmt(paid));
		SendClientMessage(playerid, 0xE3B924FF, m);
	}
	return 1;
}

stock BJ_Escape(const src[], dest[], len)
{
	new j = 0;
	for(new i = 0; src[i] && j < len - 2; i++)
	{
		if(src[i] == '\'') dest[j++] = '\'';
		dest[j++] = src[i];
	}
	dest[j] = EOS;
}

stock BJ_Fmt(number)
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

// ============================================================
//      dialogai (Nex-AC registracija kaip pokeryje)
// ============================================================
stock BJ_ShowDialog(playerid, dialogid, style, caption[], info[], b1[], b2[])
{
	BJ_OpenDialog[playerid] = dialogid;
	CallRemoteFunction("ac_ShowPlayerDialog", "idi", playerid, dialogid, 0);
	return ShowPlayerDialog(playerid, dialogid, style, caption, info, b1, b2);
}

// ============================================================
//      kortos
// ============================================================
stock BJ_Shuffle(s)
{
	for(new i = 0; i < BJ_DECKS * 52; i++) BJ[s][bsShoe][i] = i % 52;
	for(new i = BJ_DECKS * 52 - 1; i > 0; i--)
	{
		new j = random(i + 1), t = BJ[s][bsShoe][i];
		BJ[s][bsShoe][i] = BJ[s][bsShoe][j];
		BJ[s][bsShoe][j] = t;
	}
	BJ[s][bsShoePos] = 0;
}

stock BJ_Draw(s)
{
	if(BJ[s][bsShoePos] >= BJ_DECKS * 52) BJ_Shuffle(s);
	return BJ[s][bsShoe][BJ[s][bsShoePos]++];
}

stock BJ_CardValue(card)
{
	new r = card % 13;          // 0 = 2 ... 8 = 10, 9 J, 10 Q, 11 K, 12 A
	if(r <= 8) return r + 2;
	if(r <= 11) return 10;
	return 11;
}

// &soft - ar suma "minksta" (su tuzu = 11)
stock BJ_HandValue(const cards[], count, &soft = 0)
{
	new sum = 0, aces = 0;
	for(new i = 0; i < count; i++)
	{
		new v = BJ_CardValue(cards[i]);
		if(v == 11) aces++;
		sum += v;
	}
	while(sum > 21 && aces > 0) sum -= 10, aces--;
	soft = aces > 0;
	return sum;
}

stock BJ_PValue(s) return BJ_HandValue(BJ[s][bsPCards], BJ[s][bsPCount]);
stock BJ_DValue(s)
{
	if(!BJ[s][bsHole]) return BJ_CardValue(BJ[s][bsDCards][0]);
	return BJ_HandValue(BJ[s][bsDCards], BJ[s][bsDCount]);
}

// ============================================================
//      textdraw'ai (apatinis skydelis)
//      kaireje - dilerio kortos, desineje - jusu; tasku "zetonas"
//      visada iskart uz paskutines kortos; apacioje - zetonai ir mygtukai
// ============================================================
#define BJC_GOLD      0xE3B924FF
#define BJC_GREEN     0x1E8C46FF
#define BJC_RED       0xA82828FF
#define BJC_GOLDBTN   0xB08A1CFF
#define BJC_GREY      0x4A4A4AFF
#define BJC_FELT      0x0E5A2EFF
#define BJC_SPRITE    "LD_SPAC:white"
#define BJC_CIRCLE    "LD_BEAT:chit"

new const BJ_ChipColor[BJ_CHIPS] = {0xECECECFF, 0xC0392BFF, 0x2F6FD6FF, 0x23A455FF, 0x1E1E1EFF};
new const BJ_ChipText[BJ_CHIPS]  = {0x202020FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xE3B924FF};
new const BJ_ChipMult[BJ_CHIPS]  = {1, 2, 5, 10, 25};

stock PlayerText:BJ_MakeText(playerid, Float:x, Float:y, text[], Float:lx, Float:ly, align, color, font = 1)
{
	new PlayerText:t = CreatePlayerTextDraw(playerid, x, y, text);
	PlayerTextDrawFont(playerid, t, font);
	PlayerTextDrawLetterSize(playerid, t, lx, ly);
	PlayerTextDrawAlignment(playerid, t, align);
	PlayerTextDrawColor(playerid, t, color);
	PlayerTextDrawSetOutline(playerid, t, 0);
	PlayerTextDrawSetShadow(playerid, t, 0);
	PlayerTextDrawBackgroundColor(playerid, t, 255);
	PlayerTextDrawSetProportional(playerid, t, 1);
	return t;
}

stock PlayerText:BJ_MakeSprite(playerid, Float:x, Float:y, Float:w, Float:h, sprite[], color)
{
	new PlayerText:t = CreatePlayerTextDraw(playerid, x, y, sprite);
	PlayerTextDrawFont(playerid, t, 4);
	PlayerTextDrawColor(playerid, t, color);
	PlayerTextDrawTextSize(playerid, t, w, h);
	return t;
}

// trumpas skaicius zetonui: 500, 2.5K, 25K, 1M
stock BJ_Short(number)
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

// tasku zenklelis: auksinis ratas + tamsus vidus + skaicius. which: 0 dileris, 1 zaidejas
stock BJ_MakeBadge(playerid, which, Float:cx)
{
	TD_Badge[playerid][which][0] = BJ_MakeSprite(playerid, cx - 13.0, 323.0, 26.0, 26.0, BJC_CIRCLE, BJC_GOLD);
	TD_Badge[playerid][which][1] = BJ_MakeSprite(playerid, cx - 11.0, 325.0, 22.0, 22.0, BJC_CIRCLE, 0x141414FF);
	TD_Badge[playerid][which][2] = BJ_MakeText(playerid, cx, 331.0, "_", 0.20, 0.95, 2, -1, 2);
	BJ_BadgeX[playerid][which] = cx;
}

stock BJ_DestroyBadge(playerid, which)
{
	for(new k = 0; k < 3; k++) PlayerTextDrawDestroy(playerid, TD_Badge[playerid][which][k]);
}

stock BJ_PlaceBadge(playerid, which, count, text[])
{
	if(count <= 0)
	{
		for(new k = 0; k < 3; k++) PlayerTextDrawHide(playerid, TD_Badge[playerid][which][k]);
		return 1;
	}
	if(count > BJ_MAX_CARDS) count = BJ_MAX_CARDS;
	new Float:cx = (which ? 330.0 : 114.0) + (count - 1) * 25.0 + 33.0 + 16.0;
	if(BJ_BadgeX[playerid][which] != cx)
	{
		BJ_DestroyBadge(playerid, which);
		BJ_MakeBadge(playerid, which, cx);
	}
	PlayerTextDrawLetterSize(playerid, TD_Badge[playerid][which][2], strlen(text) > 5 ? 0.15 : 0.20, strlen(text) > 5 ? 0.8 : 0.95);
	PlayerTextDrawSetString(playerid, TD_Badge[playerid][which][2], text);
	for(new k = 0; k < 3; k++) PlayerTextDrawShow(playerid, TD_Badge[playerid][which][k]);
	return 1;
}

stock BJ_CreateTD(playerid, t)
{
	if(BJ_TDCreated[playerid]) return 0;
	BJ_TDCreated[playerid] = true;

	TD_Bg[playerid]    = BJ_MakeSprite(playerid, 100.0, 282.0, 440.0, 156.0, BJC_SPRITE, 0x0A0E0BEB);
	TD_LineT[playerid] = BJ_MakeSprite(playerid, 100.0, 282.0, 440.0, 2.0, BJC_SPRITE, BJC_GOLD);
	TD_LineB[playerid] = BJ_MakeSprite(playerid, 100.0, 436.0, 440.0, 2.0, BJC_SPRITE, BJC_GOLD);
	TD_FeltL[playerid] = BJ_MakeSprite(playerid, 106.0, 301.0, 211.0, 63.0, BJC_SPRITE, BJC_FELT);
	TD_FeltR[playerid] = BJ_MakeSprite(playerid, 323.0, 301.0, 211.0, 63.0, BJC_SPRITE, BJC_FELT);

	TD_Title[playerid] = BJ_MakeText(playerid, 108.0, 282.5, "Black Jack", 0.48, 1.55, 1, BJC_GOLD, 0);
	TD_Table[playerid] = BJ_MakeText(playerid, 533.0, 288.0, " ", 0.17, 0.85, 3, 0xBEBEBEFF, 1);

	TD_DLabel[playerid] = BJ_MakeText(playerid, 110.0, 302.5, "DILERIS", 0.16, 0.75, 1, 0xE3B924C8, 2);
	TD_PLabel[playerid] = BJ_MakeText(playerid, 327.0, 302.5, "JUSU RANKA", 0.16, 0.75, 1, 0xE3B924C8, 2);

	for(new i = 0; i < BJ_MAX_CARDS; i++)
	{
		TD_DCard[playerid][i] = BJ_MakeSprite(playerid, 114.0 + i * 25.0, 312.0, 33.0, 47.0, BJ_CARD_BACK, -1);
		TD_PCard[playerid][i] = BJ_MakeSprite(playerid, 330.0 + i * 25.0, 312.0, 33.0, 47.0, BJ_CARD_BACK, -1);
	}
	// zenkleliai kuriami po kortu, kad butu virs ju
	BJ_MakeBadge(playerid, 0, 163.0);
	BJ_MakeBadge(playerid, 1, 379.0);

	TD_Info[playerid]    = BJ_MakeText(playerid, 320.0, 367.0, " ", 0.25, 1.15, 2, -1, 2);
	TD_Money[playerid]   = BJ_MakeText(playerid, 107.0, 383.0, " ", 0.19, 0.9, 1, 0xC8C8C8FF, 1);
	TD_BetInfo[playerid] = BJ_MakeText(playerid, 533.0, 383.0, " ", 0.19, 0.9, 3, 0xC8C8C8FF, 1);

	// zetonai
	for(new c = 0; c < BJ_CHIPS; c++)
	{
		new Float:x = 107.0 + c * 35.0, Float:y = 397.0;
		new v = BJ_Limits[t][0] * BJ_ChipMult[c];
		if(v > BJ_Limits[t][1]) v = BJ_Limits[t][1];
		BJ_ChipVal[playerid][c] = v;
		TD_Chip[playerid][c][0] = BJ_MakeSprite(playerid, x, y, 32.0, 32.0, BJC_CIRCLE, BJ_ChipColor[c]);
		PlayerTextDrawSetSelectable(playerid, TD_Chip[playerid][c][0], 1);
		TD_Chip[playerid][c][1] = BJ_MakeSprite(playerid, x + 4.0, y + 4.0, 24.0, 24.0, BJC_CIRCLE, 0xFFFFFFE6);
		TD_Chip[playerid][c][2] = BJ_MakeSprite(playerid, x + 6.0, y + 6.0, 20.0, 20.0, BJC_CIRCLE, BJ_ChipColor[c]);
		TD_Chip[playerid][c][3] = BJ_MakeText(playerid, x + 16.0, y + 11.5, BJ_Short(v), 0.14, 0.7, 2, BJ_ChipText[c], 2);
	}

	for(new b = 0; b < BJ_BTNS; b++)
	{
		TD_Btn[playerid][b] = BJ_MakeText(playerid, 331.0 + b * 82.0, 402.0, "_", 0.22, 1.3, 2, -1, 2);
		PlayerTextDrawUseBox(playerid, TD_Btn[playerid][b], 1);
		PlayerTextDrawBoxColor(playerid, TD_Btn[playerid][b], BJC_GREEN);
		PlayerTextDrawTextSize(playerid, TD_Btn[playerid][b], 16.0, 76.0);
		PlayerTextDrawSetSelectable(playerid, TD_Btn[playerid][b], 1);
	}
	return 1;
}

stock BJ_DestroyTD(playerid)
{
	if(!BJ_TDCreated[playerid]) return 0;
	BJ_TDCreated[playerid] = false;
	PlayerTextDrawDestroy(playerid, TD_Bg[playerid]);
	PlayerTextDrawDestroy(playerid, TD_LineT[playerid]);
	PlayerTextDrawDestroy(playerid, TD_LineB[playerid]);
	PlayerTextDrawDestroy(playerid, TD_FeltL[playerid]);
	PlayerTextDrawDestroy(playerid, TD_FeltR[playerid]);
	PlayerTextDrawDestroy(playerid, TD_Title[playerid]);
	PlayerTextDrawDestroy(playerid, TD_Table[playerid]);
	PlayerTextDrawDestroy(playerid, TD_DLabel[playerid]);
	PlayerTextDrawDestroy(playerid, TD_PLabel[playerid]);
	PlayerTextDrawDestroy(playerid, TD_Info[playerid]);
	PlayerTextDrawDestroy(playerid, TD_Money[playerid]);
	PlayerTextDrawDestroy(playerid, TD_BetInfo[playerid]);
	for(new i = 0; i < BJ_MAX_CARDS; i++)
	{
		PlayerTextDrawDestroy(playerid, TD_DCard[playerid][i]);
		PlayerTextDrawDestroy(playerid, TD_PCard[playerid][i]);
	}
	BJ_DestroyBadge(playerid, 0);
	BJ_DestroyBadge(playerid, 1);
	for(new c = 0; c < BJ_CHIPS; c++) for(new k = 0; k < 4; k++) PlayerTextDrawDestroy(playerid, TD_Chip[playerid][c][k]);
	for(new b = 0; b < BJ_BTNS; b++) PlayerTextDrawDestroy(playerid, TD_Btn[playerid][b]);
	return 1;
}

stock BJ_SetButton(playerid, b, text[], bool:show, color = BJC_GREEN)
{
	if(!show) return PlayerTextDrawHide(playerid, TD_Btn[playerid][b]);
	PlayerTextDrawSetString(playerid, TD_Btn[playerid][b], text);
	PlayerTextDrawBoxColor(playerid, TD_Btn[playerid][b], color);
	return PlayerTextDrawShow(playerid, TD_Btn[playerid][b]);
}

stock BJ_ShowChips(playerid, bool:show)
{
	for(new c = 0; c < BJ_CHIPS; c++)
	{
		// vienodi zetonai (kai max mazas) nerodomi du kartus
		new bool:dup = (c > 0 && BJ_ChipVal[playerid][c] == BJ_ChipVal[playerid][c - 1]);
		for(new k = 0; k < 4; k++)
		{
			if(show && !dup) PlayerTextDrawShow(playerid, TD_Chip[playerid][c][k]);
			else PlayerTextDrawHide(playerid, TD_Chip[playerid][c][k]);
		}
	}
}

// perpiesia visa stala zaidejui
stock BJ_Render(s)
{
	new playerid = BJ[s][bsPlayer];
	if(playerid == INVALID_PLAYER_ID || !BJ_TDCreated[playerid]) return 0;
	new str[160], t = s / BJ_SEATS;

	PlayerTextDrawShow(playerid, TD_Bg[playerid]);
	PlayerTextDrawShow(playerid, TD_LineT[playerid]);
	PlayerTextDrawShow(playerid, TD_LineB[playerid]);
	PlayerTextDrawShow(playerid, TD_FeltL[playerid]);
	PlayerTextDrawShow(playerid, TD_FeltR[playerid]);
	PlayerTextDrawShow(playerid, TD_Title[playerid]);
	PlayerTextDrawShow(playerid, TD_DLabel[playerid]);
	PlayerTextDrawShow(playerid, TD_PLabel[playerid]);

	format(str, sizeof str, "STALAS #%d   ~y~%s - %s EUR   ~w~BLACK JACK 3:2", t + 1, BJ_Fmt(BJ_Limits[t][0]), BJ_Fmt(BJ_Limits[t][1]));
	PlayerTextDrawSetString(playerid, TD_Table[playerid], str);
	PlayerTextDrawShow(playerid, TD_Table[playerid]);

	for(new i = 0; i < BJ_MAX_CARDS; i++)
	{
		if(i < BJ[s][bsDCount])
		{
			PlayerTextDrawSetString(playerid, TD_DCard[playerid][i], (i == 1 && !BJ[s][bsHole]) ? (BJ_CARD_BACK) : (BJ_CardSprite[BJ[s][bsDCards][i]]));
			PlayerTextDrawShow(playerid, TD_DCard[playerid][i]);
		}
		else PlayerTextDrawHide(playerid, TD_DCard[playerid][i]);

		if(i < BJ[s][bsPCount])
		{
			PlayerTextDrawSetString(playerid, TD_PCard[playerid][i], BJ_CardSprite[BJ[s][bsPCards][i]]);
			PlayerTextDrawShow(playerid, TD_PCard[playerid][i]);
		}
		else PlayerTextDrawHide(playerid, TD_PCard[playerid][i]);
	}

	// tasku zenkleliai iskart uz paskutines kortos
	if(BJ[s][bsDCount] > 0)
	{
		new v = BJ[s][bsHole] ? BJ_HandValue(BJ[s][bsDCards], BJ[s][bsDCount]) : BJ_CardValue(BJ[s][bsDCards][0]);
		format(str, sizeof str, "%s%d", v > 21 ? ("~r~") : (v == 21 ? ("~y~") : ("~w~")), v);
	}
	else str = "_";
	BJ_PlaceBadge(playerid, 0, BJ[s][bsDCount], str);

	if(BJ[s][bsPCount] > 0)
	{
		new soft, v = BJ_HandValue(BJ[s][bsPCards], BJ[s][bsPCount], soft);
		if(soft && v < 21) format(str, sizeof str, "~w~%d/%d", v - 10, v);
		else format(str, sizeof str, "%s%d", v > 21 ? ("~r~") : (v == 21 ? ("~y~") : ("~w~")), v);
	}
	else str = "_";
	BJ_PlaceBadge(playerid, 1, BJ[s][bsPCount], str);

	// balansas / statymas
	new cash = BJ_Cash(playerid);
	format(str, sizeof str, "EURO: ~w~%s", BJ_Fmt(cash < 0 ? 0 : cash));
	PlayerTextDrawSetString(playerid, TD_Money[playerid], str);
	PlayerTextDrawShow(playerid, TD_Money[playerid]);

	switch(BJ[s][bsState])
	{
		case BJS_PLAYER:
		{
			new canDouble = (BJ[s][bsPCount] == 2 && !BJ[s][bsDoubled] && cash >= BJ[s][bsBet]);
			BJ_ShowChips(playerid, false);
			BJ_SetButton(playerid, 0, "IMTI", true, BJC_GREEN);
			BJ_SetButton(playerid, 1, "STOTI", true, BJC_RED);
			BJ_SetButton(playerid, 2, "DVIGUBINTI", canDouble ? true : false, BJC_GOLDBTN);
		}
		case BJS_DONE, BJS_BET:
		{
			BJ_ShowChips(playerid, true);
			BJ_SetButton(playerid, 0, "STATYTI", BJ[s][bsSelBet] > 0 ? true : false, BJC_GREEN);
			BJ_SetButton(playerid, 1, "VALYTI", BJ[s][bsSelBet] > 0 ? true : false, BJC_GREY);
			BJ_SetButton(playerid, 2, "ISEITI", true, BJC_RED);
		}
		default:
		{
			BJ_ShowChips(playerid, false);
			for(new b = 0; b < BJ_BTNS; b++) BJ_SetButton(playerid, b, "_", false);
		}
	}
	BJ_RenderBetInfo(s, -1);
	return 1;
}

// desinysis apatinis tekstas: statymas (+ laikas, kai zaidejo eile)
stock BJ_RenderBetInfo(s, left)
{
	new playerid = BJ[s][bsPlayer], str[96];
	if(playerid == INVALID_PLAYER_ID || !BJ_TDCreated[playerid]) return 0;
	if(BJ[s][bsState] == BJS_BET || BJ[s][bsState] == BJS_DONE)
	{
		if(BJ[s][bsSelBet] > 0) format(str, sizeof str, "Statymas: ~y~%s EUR", BJ_Fmt(BJ[s][bsSelBet]));
		else str = "Statymas: ~y~-";
	}
	else if(left >= 0)
		format(str, sizeof str, "Statymas: ~y~%s EUR   ~w~Laikas: %s%d s", BJ_Fmt(BJ[s][bsBet]), left <= 10 ? ("~r~") : ("~g~"), left);
	else
		format(str, sizeof str, "Statymas: ~y~%s EUR", BJ_Fmt(BJ[s][bsBet]));
	PlayerTextDrawSetString(playerid, TD_BetInfo[playerid], str);
	return PlayerTextDrawShow(playerid, TD_BetInfo[playerid]);
}

stock BJ_SetInfo(s, text[])
{
	new playerid = BJ[s][bsPlayer];
	if(playerid == INVALID_PLAYER_ID || !BJ_TDCreated[playerid]) return 0;
	PlayerTextDrawSetString(playerid, TD_Info[playerid], text);
	return PlayerTextDrawShow(playerid, TD_Info[playerid]);
}

stock BJ_SetTimer(s, left) return BJ_RenderBetInfo(s, left);

stock BJ_AddChip(s, c)
{
	new playerid = BJ[s][bsPlayer], t = s / BJ_SEATS;
	new nb = BJ[s][bsSelBet] + BJ_ChipVal[playerid][c];
	if(nb > BJ_Limits[t][1]) nb = BJ_Limits[t][1];
	new cash = BJ_Cash(playerid);
	if(cash >= 0 && nb > cash)
	{
		new m[144];
		format(m, sizeof m, "[Black Jack] {FFFFFF}Jums truksta EURO. Turite: %s EUR.", BJ_Fmt(cash));
		SendClientMessage(playerid, 0xFF6347FF, m);
		return 0;
	}
	BJ[s][bsSelBet] = nb;
	PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
	return BJ_Render(s);
}

// ============================================================
//      zaidimo eiga
// ============================================================
stock BJ_StartRound(s, bet)
{
	new playerid = BJ[s][bsPlayer], table = s / BJ_SEATS;
	if(BJ[s][bsState] != BJS_BET && BJ[s][bsState] != BJS_DONE) return 0;
	if(bet < BJ_Limits[table][0] || bet > BJ_Limits[table][1])
	{
		new m[144];
		format(m, sizeof m, "[Black Jack] {FFFFFF}Siame stale statymas nuo %s iki %s EUR.", BJ_Fmt(BJ_Limits[table][0]), BJ_Fmt(BJ_Limits[table][1]));
		return SendClientMessage(playerid, 0xFF6347FF, m), 0;
	}
	new cash = BJ_Cash(playerid);
	if(cash == -1) return SendClientMessage(playerid, 0xFF6347FF, "[Black Jack] {FFFFFF}Pirmiausia prisijunkite prie paskyros."), 0;
	if(cash < bet)
	{
		new m[144];
		format(m, sizeof m, "[Black Jack] {FFFFFF}Jums truksta EURO. Turite: %s EUR.", BJ_Fmt(cash));
		return SendClientMessage(playerid, 0xFF6347FF, m), 0;
	}
	if(!BJ_Take(playerid, bet)) return SendClientMessage(playerid, 0xFF6347FF, "[Black Jack] {FFFFFF}Nepavyko paimti statymo."), 0;

	if(BJ[s][bsShoePos] > BJ_DECKS * 52 - 30) BJ_Shuffle(s);
	BJ[s][bsBet] = bet;
	BJ[s][bsLastBet] = bet;
	BJ[s][bsSelBet] = bet;
	BJ[s][bsPCount] = BJ[s][bsDCount] = 0;
	BJ[s][bsHole] = false;
	BJ[s][bsDoubled] = false;
	BJ[s][bsPlayerDone] = false;
	BJ[s][bsStep] = 0;
	BJ[s][bsState] = BJS_DEAL;
	BJ[s][bsNext] = GetTickCount() + 300;

	BJ_SetInfo(s, "~w~Dalinamos kortos...");
	ApplyAnimation(playerid, "CASINO", "cards_in", 4.1, 0, 0, 0, 1, 0, 1);
	PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
	BJ_Render(s);
	return 1;
}

stock BJ_Hit(s)
{
	if(BJ[s][bsState] != BJS_PLAYER) return 0;
	new playerid = BJ[s][bsPlayer];
	BJ[s][bsPCards][BJ[s][bsPCount]++] = BJ_Draw(s);
	PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
	ApplyAnimation(playerid, "CASINO", "cards_pick_01", 4.1, 0, 0, 0, 1, 0, 1);
	new v = BJ_PValue(s);
	if(v >= 21 || BJ[s][bsPCount] >= 11) BJ_ToDealer(s);
	else BJ[s][bsDeadline] = GetTickCount() + BJ_ACTION_TIME * 1000;
	BJ_Render(s);
	return 1;
}

stock BJ_Double(s)
{
	if(BJ[s][bsState] != BJS_PLAYER || BJ[s][bsPCount] != 2 || BJ[s][bsDoubled]) return 0;
	new playerid = BJ[s][bsPlayer];
	if(BJ_Cash(playerid) < BJ[s][bsBet] || !BJ_Take(playerid, BJ[s][bsBet]))
		return SendClientMessage(playerid, 0xFF6347FF, "[Black Jack] {FFFFFF}Nepakanka EURO dvigubinimui."), 0;
	BJ[s][bsBet] *= 2;
	BJ[s][bsDoubled] = true;
	BJ[s][bsPCards][BJ[s][bsPCount]++] = BJ_Draw(s);
	PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
	BJ_SetInfo(s, "~y~Statymas padvigubintas ~w~- dileris zaidzia...");
	BJ_ToDealer(s);
	BJ_Render(s);
	return 1;
}

stock BJ_ToDealer(s)
{
	if(BJ_PValue(s) <= 21) BJ_SetInfo(s, "~w~Dileris zaidzia...");
	BJ[s][bsPlayerDone] = true;
	BJ[s][bsState] = BJS_DEALER;
	BJ[s][bsStep] = 0;
	BJ[s][bsNext] = GetTickCount() + 600;
	return 1;
}

// zingsnis (kvieciamas is laikmacio)
stock BJ_Process(s)
{
	new playerid = BJ[s][bsPlayer], now = GetTickCount();
	switch(BJ[s][bsState])
	{
		case BJS_DEAL:
		{
			if(now < BJ[s][bsNext]) return 0;
			switch(BJ[s][bsStep])
			{
				case 0, 2: BJ[s][bsPCards][BJ[s][bsPCount]++] = BJ_Draw(s);
				case 1, 3: BJ[s][bsDCards][BJ[s][bsDCount]++] = BJ_Draw(s);
			}
			PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
			BJ[s][bsStep]++;
			BJ[s][bsNext] = now + 550;
			if(BJ[s][bsStep] >= 4)
			{
				new p = BJ_PValue(s), up = BJ_CardValue(BJ[s][bsDCards][0]);
				new d = BJ_HandValue(BJ[s][bsDCards], 2);
				// Black Jack patikra (dileris "pazviegia", jei atversta korta 10 ar tuzas)
				if(p == 21 || ((up == 10 || up == 11) && d == 21))
				{
					BJ[s][bsHole] = true;
					BJ_Resolve(s);
					return 1;
				}
				BJ[s][bsState] = BJS_PLAYER;
				BJ[s][bsDeadline] = now + BJ_ACTION_TIME * 1000;
				BJ_SetInfo(s, "Jusu eile: ~g~IMTI ~w~korta, ~r~STOTI ~w~arba ~y~DVIGUBINTI");
				ApplyAnimation(playerid, "CASINO", "cards_loop", 4.1, 1, 0, 0, 1, 0, 1);
			}
			BJ_Render(s);
		}
		case BJS_PLAYER:
		{
			if(now >= BJ[s][bsDeadline])
			{
				SendClientMessage(playerid, 0xE3B924FF, "[Black Jack] {FFFFFF}Laikas baigesi - automatiskai pasirinkta \"Stoti\".");
				BJ_ToDealer(s);
				BJ_Render(s);
			}
			else
			{
				BJ_SetTimer(s, (BJ[s][bsDeadline] - now) / 1000);
			}
		}
		case BJS_DEALER:
		{
			if(now < BJ[s][bsNext]) return 0;
			if(!BJ[s][bsHole])
			{
				BJ[s][bsHole] = true;
				PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
				BJ[s][bsNext] = now + 700;
				BJ_Render(s);
				return 1;
			}
			new p = BJ_PValue(s);
			new soft, d = BJ_HandValue(BJ[s][bsDCards], BJ[s][bsDCount], soft);
			#pragma unused soft
			if(p <= 21 && d < 17 && BJ[s][bsDCount] < 11)
			{
				BJ[s][bsDCards][BJ[s][bsDCount]++] = BJ_Draw(s);
				PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
				BJ[s][bsNext] = now + 700;
				BJ_Render(s);
				return 1;
			}
			BJ_Resolve(s);
		}
	}
	return 1;
}

// baigia ranka iskart (zaidejas palieka stala / atsijungia)
stock BJ_FinishInstant(s)
{
	if(BJ[s][bsState] == BJS_DEAL)
	{
		while(BJ[s][bsStep] < 4)
		{
			if(BJ[s][bsStep] == 0 || BJ[s][bsStep] == 2) BJ[s][bsPCards][BJ[s][bsPCount]++] = BJ_Draw(s);
			else BJ[s][bsDCards][BJ[s][bsDCount]++] = BJ_Draw(s);
			BJ[s][bsStep]++;
		}
		BJ[s][bsState] = BJS_DEALER;
	}
	if(BJ[s][bsState] == BJS_PLAYER) BJ[s][bsState] = BJS_DEALER;
	if(BJ[s][bsState] == BJS_DEALER)
	{
		BJ[s][bsHole] = true;
		new p = BJ_PValue(s);
		if(!(BJ[s][bsPCount] == 2 && p == 21))
			while(p <= 21 && BJ_HandValue(BJ[s][bsDCards], BJ[s][bsDCount]) < 17 && BJ[s][bsDCount] < 11)
				BJ[s][bsDCards][BJ[s][bsDCount]++] = BJ_Draw(s);
		BJ_Resolve(s);
	}
	return 1;
}

stock BJ_Resolve(s)
{
	new playerid = BJ[s][bsPlayer], bet = BJ[s][bsBet];
	new p = BJ_PValue(s), d = BJ_HandValue(BJ[s][bsDCards], BJ[s][bsDCount]);
	new bool:pBJ = (BJ[s][bsPCount] == 2 && p == 21 && !BJ[s][bsDoubled]);
	new bool:dBJ = (BJ[s][bsDCount] == 2 && d == 21);
	new payout = 0, str[128], result;   // result: 0 pralaimejo, 1 laimejo, 2 lygiosios, 3 black jack

	if(p > 21) result = 0;
	else if(pBJ && !dBJ) result = 3, payout = bet + (bet * 3) / 2;
	else if(pBJ && dBJ) result = 2, payout = bet;
	else if(dBJ) result = 0;
	else if(d > 21 || p > d) result = 1, payout = bet * 2;
	else if(p == d) result = 2, payout = bet;
	else result = 0;

	BJ[s][bsState] = BJS_DONE;
	BJ[s][bsHole] = true;
	BJ[s][bsSelBet] = BJ[s][bsLastBet];   // STATYTI - ta pati suma
	BJ[s][bsBet] = 0;
	if(payout > 0) BJ_Pay(playerid, payout);

	switch(result)
	{
		case 3: format(str, sizeof str, "~y~BLACK JACK! ~w~Laimejote ~g~%s EUR", BJ_Fmt(payout - bet));
		case 1: format(str, sizeof str, "%s~w~Laimejote ~g~%s EUR", d > 21 ? ("~r~Dileris virsijo 21! ") : (""), BJ_Fmt(payout - bet));
		case 2: format(str, sizeof str, "~w~Lygiosios - statymas ~y~%s EUR ~w~grazintas", BJ_Fmt(payout));
		default: format(str, sizeof str, "%s~w~Pralaimejote ~r~%s EUR", p > 21 ? ("~r~Virsijote 21! ") : (""), BJ_Fmt(bet));
	}
	if(IsPlayerConnected(playerid))
	{
		BJ_SetInfo(s, str);
		BJ_Render(s);
		if(result == 1 || result == 3)
		{
			ApplyAnimation(playerid, "CASINO", "cards_win", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(playerid, 5448, 0.0, 0.0, 0.0);
		}
		else if(result == 0)
		{
			ApplyAnimation(playerid, "CASINO", "cards_lose", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
	}
	return result;
}

// ============================================================
//      stalai casino ir sedimas prie stalo
// ============================================================
stock BJ_SetPos(playerid, Float:x, Float:y, Float:z)
{
	if(!CallRemoteFunction("ac_SetPlayerPos", "ifff", playerid, x, y, z)) SetPlayerPos(playerid, x, y, z);
	return 1;
}

// stalo koordinates (ox - i sona, oy - nuo dilerio (+) link zaideju (-)) -> pasaulio
stock BJ_Local(t, Float:ox, Float:oy, &Float:wx, &Float:wy)
{
	new Float:a = BJ_TablePos[t][3];
	wx = BJ_TablePos[t][0] + ox * floatcos(a, degrees) - oy * floatsin(a, degrees);
	wy = BJ_TablePos[t][1] + ox * floatsin(a, degrees) + oy * floatcos(a, degrees);
}

stock BJ_InCasino(playerid) return (GetPlayerVirtualWorld(playerid) == BJ_WORLD && GetPlayerInterior(playerid) == BJ_INTERIOR);

stock BJ_NearTable(playerid)
{
	if(!BJ_InCasino(playerid)) return -1;
	new best = -1, Float:bestd = 3.2;
	for(new t = 0; t < BJ_TABLES; t++)
	{
		new Float:x, Float:y;
		BJ_Local(t, 0.0, -1.5, x, y);
		new Float:d = GetPlayerDistanceFromPoint(playerid, x, y, BJ_TablePos[t][2] + BJ_PLAYER_Z_OFF);
		if(d < bestd) bestd = d, best = t;
	}
	return best;
}

stock BJ_SitDown(playerid, t)
{
	if(BJ_PlayerSeat[playerid] != -1) return 0;
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 0;
	if(!BJ_Enabled) return SendClientMessage(playerid, 0xFF6347FF, "[Black Jack] {FFFFFF}Black Jack siuo metu isjungtas."), 0;
	if(BJ_Cash(playerid) == -1) return SendClientMessage(playerid, 0xFF6347FF, "[Black Jack] {FFFFFF}Pirmiausia prisijunkite prie paskyros."), 0;
	// laisva vieta, artimiausia zaidejui
	new seat = -1, Float:bestd = 999.0;
	for(new i = 0; i < BJ_SEATS; i++)
	{
		if(BJ[t * BJ_SEATS + i][bsState] != BJS_FREE) continue;
		new Float:x, Float:y;
		BJ_Local(t, BJ_SeatOff[i][0], BJ_SeatOff[i][1], x, y);
		new Float:d = GetPlayerDistanceFromPoint(playerid, x, y, BJ_TablePos[t][2] + BJ_PLAYER_Z_OFF);
		if(d < bestd) bestd = d, seat = i;
	}
	if(seat == -1) return SendClientMessage(playerid, 0xFF6347FF, "[Black Jack] {FFFFFF}Prie sio stalo visos vietos uzimtos."), 0;

	new s = t * BJ_SEATS + seat;
	BJ[s][bsPlayer] = playerid;
	BJ[s][bsState] = BJS_BET;
	BJ[s][bsPCount] = BJ[s][bsDCount] = 0;
	BJ[s][bsBet] = 0;
	BJ[s][bsLastBet] = 0;
	BJ[s][bsSelBet] = 0;
	BJ_Shuffle(s);
	BJ_PlayerSeat[playerid] = s;

	new Float:sx, Float:sy, Float:cx, Float:cy, Float:camx, Float:camy, Float:z = BJ_TablePos[t][2];
	BJ_Local(t, BJ_SeatOff[seat][0], BJ_SeatOff[seat][1], sx, sy);
	BJ_Local(t, 0.0, -0.45, cx, cy);
	BJ_Local(t, BJ_SeatOff[seat][0] * 1.75, BJ_SeatOff[seat][1] * 1.75, camx, camy);

	BJ_SetPos(playerid, sx, sy, z + BJ_PLAYER_Z_OFF);
	SetPlayerFacingAngle(playerid, 360.0 - atan2(cx - sx, cy - sy));
	TogglePlayerControllable(playerid, 0);
	SetPlayerCameraPos(playerid, camx, camy, z + 1.85);
	SetPlayerCameraLookAt(playerid, cx, cy, z - 0.15);
	ApplyAnimation(playerid, "CASINO", "cards_loop", 4.1, 1, 0, 0, 1, 0, 1);
	SetTimerEx("BJ_Reseat", 700, false, "ii", playerid, s);

	BJ_CreateTD(playerid, t);
	BJ_SetInfo(s, "Spauskite ~y~zetonus~w~, tada ~g~STATYTI");
	BJ_Render(s);
	SelectTextDraw(playerid, 0xFFD700FF);
	SendClientMessage(playerid, 0xE3B924FF, "[Black Jack] {FFFFFF}Statyma rinkites zetonais, STATYTI - dalinti kortas. Savo suma - /bj <suma>. ESC - palikti stala.");
	return 1;
}

// pakartotinai pastato i vieta (jei gamemode ka tik perkele zaideja)
forward BJ_Reseat(playerid, s);
public BJ_Reseat(playerid, s)
{
	if(!IsPlayerConnected(playerid) || BJ_PlayerSeat[playerid] != s) return 0;
	new t = s / BJ_SEATS, seat = s % BJ_SEATS, Float:sx, Float:sy, Float:px, Float:py, Float:pz;
	BJ_Local(t, BJ_SeatOff[seat][0], BJ_SeatOff[seat][1], sx, sy);
	GetPlayerPos(playerid, px, py, pz);
	if(floatabs(px - sx) > 0.5 || floatabs(py - sy) > 0.5)
	{
		new Float:cx, Float:cy;
		BJ_Local(t, 0.0, -0.45, cx, cy);
		BJ_SetPos(playerid, sx, sy, BJ_TablePos[t][2] + BJ_PLAYER_Z_OFF);
		SetPlayerFacingAngle(playerid, 360.0 - atan2(cx - sx, cy - sy));
	}
	return 1;
}

stock BJ_AskBet(playerid)
{
	new s = BJ_PlayerSeat[playerid];
	if(s == -1) return 0;
	new t = s / BJ_SEATS, txt[300], cash = BJ_Cash(playerid);
	format(txt, sizeof txt, "{FFFFFF}Iveskite statyma.\nSis stalas: nuo {E3B924}%s{FFFFFF} iki {E3B924}%s{FFFFFF} EUR.\nJusu EURO: {9ACD32}%s\n\n{AFAFAF}Jei langas neveikia - parasykite suma i chata.",
		BJ_Fmt(BJ_Limits[t][0]), BJ_Fmt(BJ_Limits[t][1]), BJ_Fmt(cash < 0 ? 0 : cash));
	BJ_ChatBetUntil[playerid] = GetTickCount() + 60000;
	return BJ_ShowDialog(playerid, BJ_DIALOG_BET, DIALOG_STYLE_INPUT, "{E3B924}Black Jack - statymas", txt, "Statyti", "Atsaukti");
}

stock BJ_StandUp(playerid, bool:disconnect = false)
{
	new s = BJ_PlayerSeat[playerid];
	if(s == -1) return 0;
	if(BJ[s][bsState] == BJS_DEAL || BJ[s][bsState] == BJS_PLAYER || BJ[s][bsState] == BJS_DEALER)
		BJ_FinishInstant(s);

	BJ[s][bsState] = BJS_FREE;
	BJ[s][bsPlayer] = INVALID_PLAYER_ID;
	BJ_PlayerSeat[playerid] = -1;
	BJ_ChatBetUntil[playerid] = 0;
	if(!disconnect)
	{
		BJ_DestroyTD(playerid);
		CancelSelectTextDraw(playerid);
		TogglePlayerControllable(playerid, 1);
		SetCameraBehindPlayer(playerid);
		ClearAnimations(playerid);
		if(BJ_OpenDialog[playerid] == BJ_DIALOG_BET)
		{
			BJ_OpenDialog[playerid] = -1;
			ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, " ", " ", " ", " ");
		}
	}
	return 1;
}

// dileriai, uzrasai; stalai - tik jei ju nera casino mape
stock BJ_CreateTables()
{
	for(new t = 0; t < BJ_TABLES; t++)
	{
		new Float:dx, Float:dy, Float:lx, Float:ly, str[200];
		BJ_Local(t, 0.0, BJ_DEALER_OFF_Y, dx, dy);
		BJ_TableActor[t] = CreateDynamicActor(t % 2 ? 172 : 171, dx, dy, BJ_TablePos[t][2] + BJ_PLAYER_Z_OFF, BJ_TablePos[t][3] + 180.0, true, 100.0, BJ_WORLD, BJ_INTERIOR, -1, 60.0);
		ApplyDynamicActorAnimation(BJ_TableActor[t], "CASINO", "dealone", 4.1, 1, 0, 0, 0, 0);

		BJ_Local(t, 0.0, 0.2, lx, ly);
		#pragma unused str
		BJ_TableLabel[t] = CreateDynamic3DTextLabel(" ", -1, lx, ly, BJ_TablePos[t][2] + 1.75, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, BJ_WORLD, BJ_INTERIOR);
	}
	BJ_UpdateLabels();
	BJ_SpawnTimer = SetTimer("BJ_SpawnTableObjects", 5000, false);
	return 1;
}

stock BJ_UpdateLabels()
{
	for(new t = 0; t < BJ_TABLES; t++)
	{
		new str[200];
		if(BJ_Enabled) format(str, sizeof str, "{E3B924}BLACK JACK  #%d\n{FFFFFF}Statymas: {9ACD32}%s - %s EUR\n{AFAFAF}Spauskite {FFFFFF}["BJ_KEY_NAME"]{AFAFAF} arba {FFFFFF}/bj", t + 1, BJ_Fmt(BJ_Limits[t][0]), BJ_Fmt(BJ_Limits[t][1]));
		else format(str, sizeof str, "{E3B924}BLACK JACK  #%d\n{FF6347}Siuo metu uzdaryta", t + 1);
		UpdateDynamic3DTextLabelText(BJ_TableLabel[t], -1, str);
	}
}

// ============================================================
//      ijungimas / isjungimas (gamemode /casinogames, admin 8)
// ============================================================
forward BJ_SetEnabled(on);
public BJ_SetEnabled(on)
{
	BJ_Enabled = on ? true : false;
	new q[96];
	format(q, sizeof q, "INSERT OR REPLACE INTO bj_cfg (k, v) VALUES ('enabled', %d)", on ? 1 : 0);
	db_free_result(db_query(BJ_DB, q));
	if(!BJ_Enabled)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(!IsPlayerConnected(i) || BJ_PlayerSeat[i] == -1) continue;
			BJ_StandUp(i);
			SendClientMessage(i, 0xFF6347FF, "[Black Jack] {FFFFFF}Administracija isjunge Black Jack. Zaidimas uzbaigtas, pinigai ismoketi.");
		}
	}
	BJ_UpdateLabels();
	return 1;
}

// 2 - ijungta, 1 - isjungta (0 - filterscript neikeltas)
forward BJ_IsEnabled();
public BJ_IsEnabled() return BJ_Enabled ? 2 : 1;

// ar casino mape (gamemode) jau yra Black Jack stalas siose koordinatese
stock BJ_MapHasTable(t)
{
	new top = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT);
	for(new id = 1; id <= top; id++)
	{
		if(!IsValidDynamicObject(STREAMER_TAG_OBJECT:id)) continue;
		if(Streamer_GetIntData(STREAMER_TYPE_OBJECT, STREAMER_TAG_OBJECT:id, E_STREAMER_MODEL_ID) != BJ_TABLE_MODEL) continue;
		if(STREAMER_TAG_OBJECT:id == BJ_TableObj[t]) continue;
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(STREAMER_TAG_OBJECT:id, x, y, z);
		if(floatabs(x - BJ_TablePos[t][0]) < 0.6 && floatabs(y - BJ_TablePos[t][1]) < 0.6 && floatabs(z - BJ_TablePos[t][2]) < 0.6) return 1;
	}
	return 0;
}

// pasalinami kitu skriptu botai (dileriai), stovintys prie musu dileriu
stock BJ_RemoveForeignActors(t)
{
	new Float:dx, Float:dy, Float:dz = BJ_TablePos[t][2], removed = 0;
	BJ_Local(t, 0.0, BJ_DEALER_OFF_Y, dx, dy);
	new top = Streamer_GetUpperBound(STREAMER_TYPE_ACTOR);
	for(new id = 1; id <= top; id++)
	{
		if(!IsValidDynamicActor(STREAMER_TAG_ACTOR:id)) continue;
		new mine = 0;
		for(new k = 0; k < BJ_TABLES; k++) if(STREAMER_TAG_ACTOR:id == BJ_TableActor[k]) mine = 1;
		if(mine) continue;
		if(!Streamer_IsInArrayData(STREAMER_TYPE_ACTOR, STREAMER_TAG_ACTOR:id, E_STREAMER_WORLD_ID, BJ_WORLD)) continue;
		new Float:ax, Float:ay, Float:az;
		GetDynamicActorPos(STREAMER_TAG_ACTOR:id, ax, ay, az);
		if(floatabs(az - dz) > 2.0 || VectorSize(ax - dx, ay - dy, 0.0) > 1.6) continue;
		DestroyDynamicActor(STREAMER_TAG_ACTOR:id);
		removed++;
	}
	for(new a = 0, n = GetActorPoolSize(); a <= n; a++)
	{
		if(!IsValidActor(a) || GetActorVirtualWorld(a) != BJ_WORLD) continue;
		new Float:ax, Float:ay, Float:az;
		GetActorPos(a, ax, ay, az);
		if(floatabs(az - dz) > 2.0 || VectorSize(ax - dx, ay - dy, 0.0) > 1.6) continue;
		DestroyActor(a);
		removed++;
	}
	return removed;
}

forward BJ_SpawnTableObjects();
public BJ_SpawnTableObjects()
{
	new made = 0, removed = 0;
	for(new t = 0; t < BJ_TABLES; t++) removed += BJ_RemoveForeignActors(t);
	for(new t = 0; t < BJ_TABLES; t++)
	{
		if(BJ_MapHasTable(t)) continue;
		BJ_TableObj[t] = CreateDynamicObject(BJ_TABLE_MODEL, BJ_TablePos[t][0], BJ_TablePos[t][1], BJ_TablePos[t][2], 0.0, 0.0, BJ_TablePos[t][3], BJ_WORLD, BJ_INTERIOR, -1, 150.0, 150.0);
		made++;
	}
	printf("[Black Jack] stalai: %d sukurta, %d jau buvo casino mape; pasalinta svetimu botu: %d", made, BJ_TABLES - made, removed);
	return 1;
}

// ============================================================
//      callback'ai
// ============================================================
public OnFilterScriptInit()
{
	BJ_DB = db_open(BJ_DB_FILE);
	db_free_result(db_query(BJ_DB, "CREATE TABLE IF NOT EXISTS bj_owed (name TEXT PRIMARY KEY, amount INTEGER NOT NULL DEFAULT 0)"));
	db_free_result(db_query(BJ_DB, "CREATE TABLE IF NOT EXISTS bj_cfg (k TEXT PRIMARY KEY, v INTEGER NOT NULL DEFAULT 0)"));
	{
		new DBResult:r = db_query(BJ_DB, "SELECT v FROM bj_cfg WHERE k = 'enabled'");
		if(r)
		{
			if(db_num_rows(r)) BJ_Enabled = db_get_field_int(r, 0) != 0;
			db_free_result(r);
		}
	}
	for(new s = 0; s < BJ_SEAT_COUNT; s++) BJ[s][bsPlayer] = INVALID_PLAYER_ID, BJ[s][bsState] = BJS_FREE;
	BJ_CreateTables();
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) BJ_LoadOwed(i);
	BJ_Timer = SetTimer("BJ_Tick", 250, true);
	print("\n--- Black Jack (SAGyvenimas) loaded ---\n");
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(BJ_Timer);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		if(BJ_PlayerSeat[i] != -1) BJ_StandUp(i);
	}
	KillTimer(BJ_SpawnTimer);
	for(new t = 0; t < BJ_TABLES; t++)
	{
		DestroyDynamicActor(BJ_TableActor[t]);
		DestroyDynamic3DTextLabel(BJ_TableLabel[t]);
		if(BJ_TableObj[t] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID) DestroyDynamicObject(BJ_TableObj[t]);
	}
	db_close(BJ_DB);
	return 1;
}

public OnPlayerConnect(playerid)
{
	BJ_PlayerSeat[playerid] = -1;
	BJ_OpenDialog[playerid] = -1;
	BJ_ChatBetUntil[playerid] = 0;
	BJ_TDCreated[playerid] = false;
	BJ_LoadOwed(playerid);
	ApplyAnimation(playerid, "CASINO", "null", 4.1, 0, 0, 0, 0, 0); // ikelti animaciju biblioteka
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(BJ_PlayerSeat[playerid] != -1) BJ_StandUp(playerid, true);
	BJ_TDCreated[playerid] = false;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(BJ_PlayerSeat[playerid] != -1) BJ_StandUp(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(BJ_PlayerSeat[playerid] != -1) BJ_StandUp(playerid);
	return 1;
}

forward BJ_Tick();
public BJ_Tick()
{
	for(new s = 0; s < BJ_SEAT_COUNT; s++)
	{
		if(BJ[s][bsState] == BJS_FREE) continue;
		if(!IsPlayerConnected(BJ[s][bsPlayer])) { BJ[s][bsState] = BJS_FREE; BJ[s][bsPlayer] = INVALID_PLAYER_ID; continue; }
		BJ_Process(s);
	}
	static tick;
	if(++tick >= 20) // kas 5 s - grazinti skolas
	{
		tick = 0;
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && BJ_Owed[i] > 0) BJ_TryPayOwed(i);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & BJ_KEY) && !(oldkeys & BJ_KEY) && BJ_PlayerSeat[playerid] == -1)
	{
		new t = BJ_NearTable(playerid);
		if(t != -1) { BJ_SitDown(playerid, t); return 1; }
	}
	return 0;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	new s = BJ_PlayerSeat[playerid];
	if(s == -1 || !BJ_TDCreated[playerid]) return 0;
	if(BJ[s][bsState] == BJS_BET || BJ[s][bsState] == BJS_DONE)
	{
		for(new c = 0; c < BJ_CHIPS; c++)
			if(playertextid == TD_Chip[playerid][c][0]) return BJ_AddChip(s, c), 1;
	}
	for(new b = 0; b < BJ_BTNS; b++)
	{
		if(playertextid != TD_Btn[playerid][b]) continue;
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		switch(BJ[s][bsState])
		{
			case BJS_PLAYER:
			{
				switch(b)
				{
					case 0: BJ_Hit(s);
					case 1: BJ_ToDealer(s), BJ_Render(s);
					case 2: BJ_Double(s);
				}
			}
			case BJS_BET, BJS_DONE:
			{
				switch(b)
				{
					case 0: if(BJ[s][bsSelBet] > 0) BJ_StartRound(s, BJ[s][bsSelBet]);
					case 1: BJ[s][bsSelBet] = 0, BJ_Render(s);
					case 2: BJ_StandUp(playerid);
				}
			}
		}
		return 1;
	}
	return 0;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	// ESC - palikti stala
	if(clickedid == Text:INVALID_TEXT_DRAW && BJ_PlayerSeat[playerid] != -1)
	{
		if(BJ_OpenDialog[playerid] == BJ_DIALOG_BET) return 1; // atidarytas statymo langas
		BJ_StandUp(playerid);
		SendClientMessage(playerid, 0xE3B924FF, "[Black Jack] {FFFFFF}Palikote stala.");
		return 1;
	}
	return 0;
}

stock BJ_ParseAmount(const text[])
{
	new len = strlen(text);
	if(!len || len > 10) return 0;
	for(new i = 0; i < len; i++) if(text[i] < '0' || text[i] > '9') return 0;
	return strval(text);
}

// gamemode persiuncia (arizona.pwn OnDialogResponse)
forward BJDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
public BJDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(!strcmp(inputtext, " ")) inputtext[0] = EOS;
	return BJ_HandleDialog(playerid, dialogid, response, inputtext);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid != BJ_DIALOG_BET) return 0;
	return BJ_HandleDialog(playerid, dialogid, response, inputtext);
}

stock BJ_HandleDialog(playerid, dialogid, response, const inputtext[])
{
	if(dialogid != BJ_DIALOG_BET) return 0;
	if(BJ_OpenDialog[playerid] != dialogid) return 1;
	BJ_OpenDialog[playerid] = -1;
	BJ_ChatBetUntil[playerid] = 0;
	new s = BJ_PlayerSeat[playerid];
	if(s == -1) return 1;
	if(response)
	{
		new amount = BJ_ParseAmount(inputtext);
		if(amount <= 0) { SendClientMessage(playerid, 0xFF6347FF, "[Black Jack] {FFFFFF}Iveskite skaiciu."); return BJ_AskBet(playerid), 1; }
		if(!BJ_StartRound(s, amount)) return BJ_AskBet(playerid), 1;
	}
	SelectTextDraw(playerid, 0xFFD700FF);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new s = BJ_PlayerSeat[playerid];
	if(s != -1 && BJ_ChatBetUntil[playerid] && GetTickCount() < BJ_ChatBetUntil[playerid])
	{
		new amount = BJ_ParseAmount(text);
		if(amount > 0 && (BJ[s][bsState] == BJS_BET || BJ[s][bsState] == BJS_DONE))
		{
			BJ_ChatBetUntil[playerid] = 0;
			if(BJ_OpenDialog[playerid] == BJ_DIALOG_BET)
			{
				BJ_OpenDialog[playerid] = -1;
				ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, " ", " ", " ", " ");
			}
			BJ_StartRound(s, amount);
			SelectTextDraw(playerid, 0xFFD700FF);
			return 0;
		}
	}
	return 1;
}

// ============================================================
//      komandos
// ============================================================
CMD:blackjack(playerid, params[])
{
	if(BJ_PlayerSeat[playerid] != -1)
	{
		new s = BJ_PlayerSeat[playerid], amount = BJ_ParseAmount(params);
		if(amount > 0) BJ_StartRound(s, amount);
		else if(BJ[s][bsState] == BJS_BET || BJ[s][bsState] == BJS_DONE) BJ_AskBet(playerid);
		return 1;
	}
	new t = BJ_NearTable(playerid);
	if(t == -1) return SendClientMessage(playerid, 0xE3B924FF, "[Black Jack] {FFFFFF}Black Jack stalai yra Casino. Prieikite prie stalo ir spauskite ["BJ_KEY_NAME"] arba /bj."), 1;
	if(BJ_SitDown(playerid, t))
	{
		new amount = BJ_ParseAmount(params);
		if(amount > 0) BJ_StartRound(BJ_PlayerSeat[playerid], amount);
	}
	return 1;
}
CMD:bj(playerid, params[]) return callcmd::blackjack(playerid, params);
