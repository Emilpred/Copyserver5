// ============================================================================
//  ALGOS (atlyginimai darbuotojams) - perkelta is LSGyvenimas logikos
//  * Kiekviena budejimo minute (ne AFK) valstybines organizacijos nariui
//    skaiciuojama "pradirbta minute" ir sukaupiama alga pagal ranga.
//  * Algas moka organizacijos LYDERIS: treciadieniais ir sestadieniais
//    nuo 17:00 iki 19:00 (Lietuvos laiku), komanda /algos.
//  * Ismokama tik tiems, kas pradirbo bent AL_MIN_MINUTES minuciu.
//  * Pervedimo mokestis AL_FEE_PERCENT % (kaip LSG).
//  * Darbuotojas savo minutes mato su /pradirbta.
//  Duomenys saugomi `accounts` lenteleje, stulpeliuose:
//    AlgosMin (pradirbtos minutes), AlgosSum (informacinis), AlgosOrg (organizacija)
//  ALGA = pradirbtos minutes x tarifas pagal dabartini ranga (AL_Rate).
//  Stulpeliai pridedami automatiskai arba per algos.sql (phpMyAdmin).
// ============================================================================

#define AL_DIALOG_LIST      31520
#define AL_DIALOG_CONFIRM   31521
#define AL_MIN_MINUTES      100     // min. pradirbtu minuciu algai gauti
#define AL_DALIKLIS         200     // alga uz minute = rango PayDay alga / AL_DALIKLIS
#define AL_FEE_PERCENT      1       // pervedimo mokestis %
#define AL_HOUR_FROM        17      // mokejimo pradzia (val.)
#define AL_HOUR_TO          19      // mokejimo pabaiga (val., neimtinai)
#define AL_ADMIN_BYPASS     5       // admin lygis, kuriam laiko apribojimas negalioja
#define AL_MAX_ROWS         60
#define AL_DIALOG_ORGS      31522
#define AL_TEST_ADMIN       8       // /atlyginimai, /duotiminutes - admin lygis
#define AL_X2_HOUR          19      // Tr/S nuo 19:00 iki 20:00 - x2 minutes
#define AL_DIALOG_COWORK    31523

new AL_ListAcc[MAX_PLAYERS][AL_MAX_ROWS],
	AL_ListMin[MAX_PLAYERS][AL_MAX_ROWS],
	AL_ListAmt[MAX_PLAYERS][AL_MAX_ROWS],
	AL_ListName[MAX_PLAYERS][AL_MAX_ROWS][MAX_PLAYER_NAME],
	AL_ListCount[MAX_PLAYERS],
	AL_ListOrg[MAX_PLAYERS],
	AL_Sel[MAX_PLAYERS],
	bool:AL_AdminMode[MAX_PLAYERS],
	AL_OrgMap[MAX_PLAYERS][MAX_ORGS];

stock Algos_Init()
{
	mysql_tquery(mysql, "ALTER TABLE `accounts` ADD COLUMN IF NOT EXISTS `AlgosMin` INT(11) NOT NULL DEFAULT 0, ADD COLUMN IF NOT EXISTS `AlgosSum` INT(11) NOT NULL DEFAULT 0, ADD COLUMN IF NOT EXISTS `AlgosOrg` INT(11) NOT NULL DEFAULT 0");
	print("[ALGOS] Atlyginimu sistema ikelta (Tr/S 17:00-19:00, /algos). Stulpeliai: accounts.AlgosMin/AlgosSum/AlgosOrg");
	return 1;
}

stock AL_IsWorkerOrg(team)
{
	if(team <= 0 || team >= MAX_ORGS) return 0;
	switch(team)
	{
		case TEAM_GROOVE, TEAM_VAGOS, TEAM_BALLAS, TEAM_CORONOS, TEAM_RIFA, TEAM_WOLFS,
			TEAM_RM, TEAM_YAKUZA, TEAM_LCN, TEAM_BIKERS: return 0;
	}
	return 1;
}

stock AL_Rate(team, rank)
{
	new idx = rank - 1;
	if(idx < 0) idx = 0;
	if(idx > 13) idx = 13;
	new r = OldOrgSalary[team][idx] / AL_DALIKLIS;
	return (r < 1) ? 1 : r;
}

stock AL_WeekDay()
{
	new y, mo, d, h, mi, se;
	LT_Local(y, mo, d, h, mi, se);
	return (LT_DaysFromCivil(y, mo, d) + 4) % 7; // 0 = sekmadienis
}

stock AL_IsPayTime()
{
	new y, mo, d, h, mi, se;
	LT_Local(y, mo, d, h, mi, se);
	new wd = (LT_DaysFromCivil(y, mo, d) + 4) % 7;
	return ((wd == 3 || wd == 6) && h >= AL_HOUR_FROM && h < AL_HOUR_TO);
}

// kvieciama kas minute (MinuteTimer)
stock Algos_Minute()
{
	new y, mo, d, h, mi, se;
	LT_Local(y, mo, d, h, mi, se);
	new wd = (LT_DaysFromCivil(y, mo, d) + 4) % 7;
	if((wd == 3 || wd == 6) && mi == 0)
	{
		if(h == AL_HOUR_FROM)
			SendClientMessageToAll(0x73B461FF, "[Algos] {FFFFFF}Prasidejo algu mokejimas (iki 19:00). Organizaciju lyderiai: {73B461}/algos");
		else if(h == AL_HOUR_TO - 1)
			SendClientMessageToAll(0x73B461FF, "[Algos] {FFFFFF}Liko 1 valanda algoms ismoketi. Lyderiai: {73B461}/algos");
		else if(h == AL_X2_HOUR)
			SendClientMessageToAll(0x73B461FF, "[Algos] {FFFFFF}Prasidejo {FFFF00}x2 darbo minuciu{FFFFFF} valanda (19:00-20:00)! Budejimo minutes skaiciuojamos dvigubai.");
		else if(h == AL_X2_HOUR + 1)
			SendClientMessageToAll(0x73B461FF, "[Algos] {FFFFFF}x2 darbo minuciu valanda baigesi.");
	}
	new mult = ((wd == 3 || wd == 6) && h == AL_X2_HOUR) ? 2 : 1;

	foreach(new i : Player)
	{
		if(!IsPlayerLogged{i}) continue;
		new team = GetTeamID(i);
		if(!AL_IsWorkerOrg(team)) continue;
		if(!TeamDuty{i}) continue;
		if(PlayerAFKTime[i] >= 60) continue;
		new rate = AL_Rate(team, PI[i][pRank]) * mult;
		SQL("UPDATE `accounts` SET `AlgosMin` = IF(`AlgosOrg` = %d, `AlgosMin` + %d, %d), `AlgosSum` = IF(`AlgosOrg` = %d, `AlgosSum` + %d, %d), `AlgosOrg` = %d WHERE `ID` = %d", team, mult, mult, team, rate, rate, team, PI[i][pID]);
	}
	return 1;
}

// ---------------------------------------------------------------- /pradirbta
CMD:pradirbta(playerid)
{
	if(!IsPlayerLogged{playerid}) return 0;
	if(!AL_IsWorkerOrg(GetTeamID(playerid))) return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Algos mokamos tik valstybiniu organizaciju darbuotojams.");
	new q[160];
	f(q, sizeof q, "SELECT `AlgosMin`,`AlgosSum`,`AlgosOrg` FROM `accounts` WHERE `ID` = %d", PI[playerid][pID]);
	mysql_tquery(mysql, q, "AL_OnMine", "d", playerid);
	return 1;
}
forward AL_OnMine(playerid);
public AL_OnMine(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new mins = 0, amt = 0;
	if(cache_get_row_count(mysql) && cache_get_row_int(0, 2, mysql) == GetTeamID(playerid))
	{
		mins = cache_get_row_int(0, 0, mysql);
		amt = mins * AL_Rate(GetTeamID(playerid), PI[playerid][pRank]);
	}
	static str[512];
	f(str, sizeof str, "{FFFFFF}Pradirbta laiko (budejime): {73B461}%d min.\n{FFFFFF}Sukaupta alga: {73B461}%d$\n{FFFFFF}Dabartinis tarifas: {73B461}%d$/min.\n\n%s\n\n{AFAFAF}Algas moka organizacijos lyderis treciadieniais ir sestadieniais 17:00-19:00.\nTr ir S 19:00-20:00 minutes skaiciuojamos x2.\nMinutes skaiciuojamos tik budejime ir ne AFK. Bendradarbiai: /bendradarbiai",
		mins, amt, AL_Rate(GetTeamID(playerid), PI[playerid][pRank]),
		(mins >= AL_MIN_MINUTES) ? ("{9ACD32}Jus jau galite gauti alga!") : ("{FF6347}Algai gauti reikia pradirbti bent 100 min."));
	SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Algos | Pradirbtas laikas", str, !"Uzdaryti", !"");
	return 1;
}

// ---------------------------------------------------------------- /algos (lyderiams)
CMD:algos(playerid)
{
	if(!IsPlayerLogged{playerid}) return 0;
	new org = PI[playerid][pLeader];
	if(org <= 0) return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Algas gali moketi tik organizacijos lyderis!");
	if(!AL_IsWorkerOrg(org)) return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Jusu organizacijai algos nemokamos.");
	if(!AL_IsPayTime() && PI[playerid][pAdmin] < AL_ADMIN_BYPASS)
		return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Algas galima moketi tik treciadieniais ir sestadieniais nuo 17:00 iki 19:00!");
	AL_AdminMode[playerid] = false;
	return AL_ShowList(playerid, org);
}

stock AL_ShowList(playerid, org)
{
	new q[300];
	f(q, sizeof q, "SELECT `ID`, `NickName`, `AlgosMin`, `Rank` FROM `accounts` WHERE `AlgosOrg` = %d AND `Member` = %d AND `AlgosMin` >= %d ORDER BY `AlgosMin` DESC LIMIT %d",
		org, org, AL_MIN_MINUTES, AL_MAX_ROWS);
	mysql_tquery(mysql, q, "AL_OnList", "dd", playerid, org);
	return 1;
}

forward AL_OnList(playerid, org);
public AL_OnList(playerid, org)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new rows = cache_get_row_count(mysql);
	if(rows > AL_MAX_ROWS) rows = AL_MAX_ROWS;
	AL_ListCount[playerid] = rows;
	AL_ListOrg[playerid] = org;
	if(!rows && AL_AdminMode[playerid])
		return SPD(playerid, AL_DIALOG_CONFIRM + 100, DIALOG_STYLE_MSGBOX, !"Algos", !"{FFFFFF}Sioje organizacijoje nera darbuotoju, pradirbusiu bent {73B461}100 min.", !"Atgal", !"");
	if(!rows)
		return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Algos", !"{FFFFFF}Siuo metu nera darbuotoju, pradirbusiu bent {73B461}100 min.{FFFFFF}\nJiems ismoketi nieko nereikia.", !"Uzdaryti", !"");

	static str[4096];
	new total = 0;
	for(new r; r < rows; r++)
	{
		AL_ListAcc[playerid][r] = cache_get_row_int(r, 0, mysql);
		cache_get_row(r, 1, AL_ListName[playerid][r], mysql, MAX_PLAYER_NAME);
		AL_ListMin[playerid][r] = cache_get_row_int(r, 2, mysql);
		AL_ListAmt[playerid][r] = AL_ListMin[playerid][r] * AL_Rate(org, cache_get_row_int(r, 3, mysql));
		total += AL_ListAmt[playerid][r];
	}
	f(str, sizeof str, "Darbuotojas\tPradirbta\tAlga\n{9ACD32}>> Ismoketi visiems (%d)\t\t{73B461}%d$", rows, total);
	for(new r; r < rows; r++)
		f(str, sizeof str, "%s\n{FFFFFF}%s\t%d min.\t{73B461}%d$", str, AL_ListName[playerid][r], AL_ListMin[playerid][r], AL_ListAmt[playerid][r]);
	SPD(playerid, AL_DIALOG_LIST, DIALOG_STYLE_TABLIST_HEADERS, !"Algos | Darbuotojai", str, !"Ismoketi", !"Uzdaryti");
	return 1;
}

stock AL_FindOnline(accid)
{
	foreach(new i : Player) if(IsPlayerLogged{i} && PI[i][pID] == accid) return i;
	return INVALID_PLAYER_ID;
}

stock AL_PayOne(playerid, r)
{
	new acc = AL_ListAcc[playerid][r];
	if(acc <= 0) return 0;
	new amt = AL_ListAmt[playerid][r], mins = AL_ListMin[playerid][r];
	new fee = amt * AL_FEE_PERCENT / 100, net = amt - fee;
	new t = AL_FindOnline(acc);
	if(t != INVALID_PLAYER_ID)
	{
		PI[t][pMyBank] += net; // iprasta ($) banko saskaita, ne BTC
		if(PI[t][pMyBank] > 2000000000 || PI[t][pMyBank] < 0) PI[t][pMyBank] = 2000000000;
		UpdatePlayerDataInt(t, "pMyBank", PI[t][pMyBank]);
		SCMF(t, 0x73B461FF, "[Algos] {FFFFFF}%s %s jums pervede alga: {73B461}%d$ {FFFFFF}(pradirbta %d min., mokestis %d$). Pinigai banke.", AL_AdminMode[playerid] ? ("Administratorius") : ("Lyderis"), PN(playerid), net, mins, fee);
	}
	else SQL("UPDATE `accounts` SET `pMyBank` = LEAST(`pMyBank` + %d, 2000000000) WHERE `ID` = %d", net, acc);
	SQL("UPDATE `accounts` SET `AlgosMin` = GREATEST(`AlgosMin` - %d, 0), `AlgosSum` = GREATEST(`AlgosSum` - %d, 0) WHERE `ID` = %d", mins, amt, acc);
	SCMF(playerid, 0x73B461FF, "[Algos] {FFFFFF}Pervedete %s alga {73B461}%d$ {FFFFFF}(%d min., mokestis %d$).", AL_ListName[playerid][r], net, mins, fee);
	AL_ListAcc[playerid][r] = 0;
	return net;
}

stock AL_CanPay(playerid)
{
	if(AL_AdminMode[playerid]) return (PI[playerid][pAdmin] >= AL_TEST_ADMIN);
	return (PI[playerid][pLeader] > 0 && PI[playerid][pLeader] == AL_ListOrg[playerid]);
}

// ---------------------------------------------------------------- /atlyginimai (admin 8 lvl, testavimui)
CMD:atlyginimai(playerid)
{
	if(!IsPlayerLogged{playerid} || PI[playerid][pAdmin] < AL_TEST_ADMIN) return 0;
	AL_AdminMode[playerid] = true;
	new q[220];
	f(q, sizeof q, "SELECT `AlgosOrg`, `Rank`, `AlgosMin` FROM `accounts` WHERE `AlgosMin` >= %d AND `AlgosOrg` > 0 AND `Member` = `AlgosOrg`", AL_MIN_MINUTES);
	mysql_tquery(mysql, q, "AL_OnOrgs", "d", playerid);
	return 1;
}
forward AL_OnOrgs(playerid);
public AL_OnOrgs(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new cnt[MAX_ORGS], sum[MAX_ORGS], rows = cache_get_row_count(mysql);
	for(new r; r < rows; r++)
	{
		new o = cache_get_row_int(r, 0, mysql);
		if(o <= 0 || o >= MAX_ORGS) continue;
		if(!AL_IsWorkerOrg(o)) continue;
		cnt[o]++;
		sum[o] += cache_get_row_int(r, 2, mysql) * AL_Rate(o, cache_get_row_int(r, 1, mysql));
	}
	static str[3072];
	new n = 0;
	str = "Organizacija\tDarbuotoju (100+ min.)\tSuma";
	for(new o = 1; o < MAX_ORGS; o++)
	{
		if(!AL_IsWorkerOrg(o)) continue;
		f(str, sizeof str, "%s\n{FFFFFF}[%d] %s\t%s%d\t{73B461}%d$", str, o, OrgInfo[o][oName], cnt[o] ? ("{9ACD32}") : ("{AFAFAF}"), cnt[o], sum[o]);
		AL_OrgMap[playerid][n++] = o;
	}
	SPD(playerid, AL_DIALOG_ORGS, DIALOG_STYLE_TABLIST_HEADERS, !"Atlyginimai | Organizacijos (ADMIN)", str, !"Pasirinkti", !"Uzdaryti");
	return 1;
}

stock Algos_OnDialog(playerid, dialogid, response, listitem)
{
	if(dialogid == AL_DIALOG_ORGS)
	{
		if(!response || PI[playerid][pAdmin] < AL_TEST_ADMIN) return 1;
		if(listitem < 0 || listitem >= MAX_ORGS) return 1;
		AL_AdminMode[playerid] = true;
		return AL_ShowList(playerid, AL_OrgMap[playerid][listitem]);
	}
	if(dialogid == AL_DIALOG_CONFIRM + 100) // tuscia organizacija -> atgal i sarasa
	{
		if(AL_AdminMode[playerid] && PI[playerid][pAdmin] >= AL_TEST_ADMIN) return callcmd::atlyginimai(playerid);
		return 1;
	}
	if(dialogid == AL_DIALOG_LIST)
	{
		if(!response) return (AL_AdminMode[playerid] && PI[playerid][pAdmin] >= AL_TEST_ADMIN) ? callcmd::atlyginimai(playerid) : 1;
		if(!AL_CanPay(playerid)) return 1;
		if(!AL_AdminMode[playerid] && !AL_IsPayTime() && PI[playerid][pAdmin] < AL_ADMIN_BYPASS)
			return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Algu mokejimo laikas baigesi!");
		AL_Sel[playerid] = listitem - 1; // -1 = visiems
		static str[300];
		if(listitem == 0)
		{
			new total = 0;
			for(new r; r < AL_ListCount[playerid]; r++) if(AL_ListAcc[playerid][r]) total += AL_ListAmt[playerid][r];
			f(str, sizeof str, "{FFFFFF}Ismoketi algas {73B461}visiems %d{FFFFFF} darbuotojams?\nBendra suma: {73B461}%d$\n{AFAFAF}Pervedimo mokestis %d%% nuskaiciuojamas is algos.", AL_ListCount[playerid], total, AL_FEE_PERCENT);
		}
		else
		{
			new r = listitem - 1;
			if(r >= AL_ListCount[playerid] || !AL_ListAcc[playerid][r]) return AL_ShowList(playerid, AL_ListOrg[playerid]);
			f(str, sizeof str, "{FFFFFF}Darbuotojas: {73B461}%s\n{FFFFFF}Pradirbta: {73B461}%d min.\n{FFFFFF}Alga: {73B461}%d$ {AFAFAF}(mokestis %d$)\n\n{FFFFFF}Ismoketi?",
				AL_ListName[playerid][r], AL_ListMin[playerid][r], AL_ListAmt[playerid][r], AL_ListAmt[playerid][r] * AL_FEE_PERCENT / 100);
		}
		SPD(playerid, AL_DIALOG_CONFIRM, DIALOG_STYLE_MSGBOX, !"Algos | Patvirtinimas", str, !"Ismoketi", !"Atgal");
		return 1;
	}
	if(dialogid == AL_DIALOG_CONFIRM)
	{
		if(!AL_CanPay(playerid)) return 1;
		if(!response) return AL_ShowList(playerid, AL_ListOrg[playerid]);
		if(!AL_AdminMode[playerid] && !AL_IsPayTime() && PI[playerid][pAdmin] < AL_ADMIN_BYPASS)
			return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Algu mokejimo laikas baigesi!");
		new sel = AL_Sel[playerid];
		if(sel == -1)
		{
			new cnt = 0, sum = 0;
			for(new r; r < AL_ListCount[playerid]; r++)
			{
				if(!AL_ListAcc[playerid][r]) continue;
				sum += AL_PayOne(playerid, r);
				cnt++;
			}
			SCMF(playerid, 0x73B461FF, "[Algos] {FFFFFF}Ismoketa %d darbuotojams, is viso {73B461}%d$.", cnt, sum);
		}
		else if(sel >= 0 && sel < AL_ListCount[playerid]) AL_PayOne(playerid, sel);
		AL_ListCount[playerid] = 0;
		if(AL_AdminMode[playerid]) SetTimerEx("AL_BackToOrgs", 700, false, "d", playerid);
		return 1;
	}
	return 0;
}

forward AL_BackToOrgs(playerid);
public AL_BackToOrgs(playerid)
{
	if(IsPlayerConnected(playerid) && AL_AdminMode[playerid] && PI[playerid][pAdmin] >= AL_TEST_ADMIN) callcmd::atlyginimai(playerid);
	return 1;
}

// ---------------------------------------------------------------- /bendradarbiai (kaip LSG, tik savo organizacija)
#define AL_CW_MAX 60
new AL_CwAcc[AL_CW_MAX], AL_CwMin[AL_CW_MAX], AL_CwLead[AL_CW_MAX], AL_CwOn[AL_CW_MAX], AL_CwName[AL_CW_MAX][MAX_PLAYER_NAME];

CMD:bendradarbiai(playerid)
{
	if(!IsPlayerLogged{playerid}) return 0;
	new team = GetTeamID(playerid);
	if(team <= 0) return SCM(playerid, COLOR_GREY, !" * Bedarbiai neturi bendradarbiu ;)");
	if(!AL_IsWorkerOrg(team)) return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Minutes skaiciuojamos tik valstybiniu organizaciju darbuotojams.");
	new q[300];
	// tik TAVO organizacijos nariai, kurie pradirbo minuciu butent sioje organizacijoje
	f(q, sizeof q, "SELECT `ID`, `NickName`, `AlgosMin`, `Leader` FROM `accounts` WHERE `Member` = %d AND `AlgosOrg` = %d AND `AlgosMin` > 0 ORDER BY `AlgosMin` DESC LIMIT %d", team, team, AL_CW_MAX);
	mysql_tquery(mysql, q, "AL_OnCowork", "dd", playerid, team);
	return 1;
}
forward AL_OnCowork(playerid, team);
public AL_OnCowork(playerid, team)
{
	if(!IsPlayerConnected(playerid) || GetTeamID(playerid) != team) return 0;
	new rows = cache_get_row_count(mysql), n = 0;
	for(new r; r < rows && n < AL_CW_MAX; r++)
	{
		new acc = cache_get_row_int(r, 0, mysql), on = AL_FindOnline(acc);
		if(on != INVALID_PLAYER_ID && GetTeamID(on) != team) continue; // jau ne sios organizacijos
		AL_CwAcc[n] = acc;
		cache_get_row(r, 1, AL_CwName[n], mysql, MAX_PLAYER_NAME);
		AL_CwMin[n] = cache_get_row_int(r, 2, mysql);
		AL_CwLead[n] = (cache_get_row_int(r, 3, mysql) == team);
		AL_CwOn[n] = on;
		n++;
	}
	// prisijunge sios organizacijos nariai, dar nepradirbe nei minutes
	foreach(new i : Player)
	{
		if(n >= AL_CW_MAX) break;
		if(!IsPlayerLogged{i} || GetTeamID(i) != team) continue;
		new found = 0;
		for(new k; k < n; k++) if(AL_CwAcc[k] == PI[i][pID]) { found = 1; break; }
		if(found) continue;
		AL_CwAcc[n] = PI[i][pID]; AL_CwMin[n] = 0; AL_CwLead[n] = (PI[i][pLeader] == team); AL_CwOn[n] = i;
		GetPlayerName(i, AL_CwName[n], MAX_PLAYER_NAME);
		n++;
	}
	if(!n) return SCM(playerid, COLOR_GREY, !"[Algos] {FFFFFF}Bendradarbiu nerasta.");

	static str[4096];
	new myPos = -1;
	str = "#\tDarbuotojas\tPradirbta\tBusena";
	for(new r; r < n; r++)
	{
		new on = AL_CwOn[r], bool:me = (AL_CwAcc[r] == PI[playerid][pID]);
		if(me) myPos = r;
		f(str, sizeof str, "%s\n%s%d.\t%s%s%s\t%d min.%s\t%s", str, me ? ("{FF6347}") : ("{FFFFFF}"), r + 1,
			me ? ("{FF6347}") : ("{FFFFFF}"), AL_CwLead[r] ? ("Dir. ") : (""), AL_CwName[r], AL_CwMin[r], (AL_CwMin[r] >= AL_MIN_MINUTES) ? (" {9ACD32}(alga)") : (""),
			(on == INVALID_PLAYER_ID) ? ("{AFAFAF}Offline") : ((PlayerAFKTime[on] >= 60) ? ("{FFFF00}[AFK]") : (TeamDuty{on} ? ("{9ACD32}Budi") : ("{FFFFFF}Online"))));
	}
	new title[96];
	if(myPos == 0) title = "Bendradarbiai | Jus pirmaujate!";
	else if(myPos > 0)
	{
		new need = AL_CwMin[myPos - 1] - AL_CwMin[myPos] + 1;
		f(title, sizeof title, "Bendradarbiai | Iki aplenkimo: %d min.", need);
		SCMF(playerid, 0x73B461FF, "[Algos] {FFFFFF}Esate %d vietoje (%d min.). Kad aplenktumete %s, reikia dar {73B461}%d min.", myPos + 1, AL_CwMin[myPos], AL_CwName[myPos - 1], need);
	}
	else title = "Bendradarbiai";
	SPD(playerid, AL_DIALOG_COWORK, DIALOG_STYLE_TABLIST_HEADERS, title, str, !"Uzdaryti", !"");
	return 1;
}

// ---------------------------------------------------------------- /duotiminutes (admin 8 lvl)
CMD:duotiminutes(playerid, params[])
{
	if(!IsPlayerLogged{playerid} || PI[playerid][pAdmin] < AL_TEST_ADMIN) return 0;
	new id, mins;
	if(sscanf(params, "ud", id, mins)) return SCM(playerid, COLOR_GREY, !"Naudokite: /duotiminutes [id] [minutes] (minusas - atimti)");
	if(id == INVALID_PLAYER_ID || !IsPlayerLogged{id}) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Zaidejas neprisijunges!");
	new team = GetTeamID(id);
	if(!AL_IsWorkerOrg(team)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Zaidejas nera valstybines organizacijos darbuotojas!");
	if(mins == 0 || mins > 100000 || mins < -100000) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Minutes: nuo -100000 iki 100000 (ne 0).");
	SQL("UPDATE `accounts` SET `AlgosMin` = GREATEST(IF(`AlgosOrg` = %d, `AlgosMin`, 0) + %d, 0), `AlgosOrg` = %d WHERE `ID` = %d", team, mins, team, PI[id][pID]);
	SCMF(playerid, 0x73B461FF, "[Algos] {FFFFFF}%s zaidejui %s(%d) %d darbo minuciu.", mins > 0 ? ("Pridejote") : ("Atemete"), PN(id), id, mins > 0 ? mins : -mins);
	SCMF(id, 0x73B461FF, "[Algos] {FFFFFF}Administratorius %s jums %s {73B461}%d{FFFFFF} darbo minuciu. Perziureti: /pradirbta", PN(playerid), mins > 0 ? ("pridejo") : ("atemo"), mins > 0 ? mins : -mins);
	return 1;
}
