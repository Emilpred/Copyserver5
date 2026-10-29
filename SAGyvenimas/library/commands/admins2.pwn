static const NO_ACCES_TEXT[] =	!"[Klaida] {cccccc}Jus neturite prieigos prie sios komandos.";
static const NO_DUTY_TEXT[] = !"[A] Jus nesate autorizuoti. Naudokite {33CCFF}/apanel";

cmd:adminss(playerid)
{
 	SCMF(playerid, -1, "{33CC00}Administracija Online: (prisijunge: %i, is ju AFK: 0)", Iter_Count(Admin));
	foreach(Admin, i)
	{
		if !PI[i][pAdmin] *then
			continue;
		if SERIU[i][sID] != INVALID_PLAYER_ID *then
			f(global_str, 128, "{fefe22}%s[%i] - [%i lvl] {FFFFFF} - {DC2020}/re %i- [AFK: %i]{FFFFFF} - Reputacija: %i", PN(i), i, PI[i][pAdmin], SERIU[i][sID], PlayerAFKTime[i], PI[i][pAdmRep]);

		else
			f(global_str, 128, "{fefe22}%s[%i] - [%i lvl] -{FFFFFF} [AFK: %i]{FFFFFF} - Reputacija: %i", PN(i), i, PI[i][pAdmin], PlayerAFKTime[i], PI[i][pAdmRep]);
		SCM(playerid, 0xFEFE22FF, global_str);
	}

}
cmd:checkpromo(playerid, params[])
{
	if !CheckAdm(playerid, 5) *then
		return false;
	if sscanf(params, "s[24]", params[0]) *then
		return SCM(playerid, COLOR_OLDRED, "Naudokite: /checkpromo [Promocode]");
	f(global_str, 128, "SELECT * FROM promo WHERE code = '%s'", params[0]);
	mysql_tquery(mysql, global_str, "CMDCheckPromo", "d", playerid);
	return 1;
}
cmd:checkoff(playerid, params[])
{
	if sscanf(params, "s[24]", params[0]) *then
		return SCM(playerid, COLOR_OLDRED, "Naudokite: /checkoff [Nick]");
	return CheckStatsOff(playerid, params[0]);
}
cmd:redactbonuscar(playerid)
{
	if !IsAOwner(playerid) *then return false;
	return SPD(playerid, 8440, DIALOG_STYLE_LIST, "{ffffff}VIP automobiliai", "\
		{ffffff}Klase {73B461}Luxe\n\
		{ffffff}Klase {73B461}VIP\n\
		{ffffff}Klase {73B461}Diamond\n\
		{ffffff}Klase {73B461}Gold", "Isrinkti", "Uzdaryti");
}
cmd:giveaz(playerid, data[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract data -> new player:targetId, count; else
		 return SCM(playerid, COLOR_OLDRED, "Naudokite: /giveaz [playerid] [count]");
	if !IsPlayerOnline(targetId) *then
		return false;
	GiveDonate(targetId, count);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave %d SAG-Coins zaidejui <a href=../pages/user?name=%s>%s</a>", 5, PN(playerid), PN(targetId), PN(playerid), PlayerName[playerid], count, PN(targetId), PlayerName[targetId]);
}
CMD:acceptadmin(playerid, params[])
{
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /acceptadmin [id]");
    if(!PI[params[0]][pAdmin]) return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Sis zaidejas nera administratorius!");
    if(IsAOwner(playerid) && params[0] == playerid) return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Negalima sau suteikti patvirtinimo!");
    if(IsASuccesIP(PlayerRegIP[params[0]], PlayerIp[params[0]])) return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Siam administratoriui nereikia patvirtinimo.");
    if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return 1;
    if(!GetString(PN(playerid),"Milancholi") && !GetString(PN(playerid),"Developer") && params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin]) return 1;
    PlayerRegIP[params[0]] = PlayerIp[params[0]];
    f(global_str, 100, "UPDATE `accounts` SET `RegIP` = '%s' WHERE `ID` = '%i'",PlayerRegIP[params[0]], PI[params[0]][pID]);
    mysql_pquery(mysql, global_str);
    SCM(playerid, COLOR_VALIK, !"Jus patvirtinote administratoriaus teises.");
    SCM(params[0], COLOR_VALIK, !"Jums patvirtino administratoriaus teises.");
    return SendAdminsMessage(COLOR_VALIK, (str_f("[A] %s[%d] isdave patvirtinima %s[%d]", PN(playerid), playerid, PN(params[0]), params[0])) );
}
cmd:setauction(playerid,data[]) {

	if !CheckAdm(playerid, 5) *then
		return false;
	extract data -> new orgid, time; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setauction [frakcijos ID] [aukciono laikas (min)]");
    if !(1 <= orgid <= MAX_ORGS-1) *then
		return SCM(playerid,COLOR_GREY, !"Neteisingas frakcijos ID");
	new success = -1;
	for new i = 0; i < TOTALFRACTIONS; i++ do {
		if PrivateInfo[i][privateID] == orgid *then {
            success = i; break;
		}
	}
	if success == -1 *then
	    return SCM(playerid,COLOR_GREY, !"Si organizacija nera privati.");
    PrivateInfo[success][privateFamily] =
    PrivateInfo[success][privateAuctionFamily] =
    PrivateInfo[success][privateAuctionLast] = 0;
    PrivateInfo[success][privateAuctionTime] = time*60;
	SetString(PrivateInfo[success][privateAuctionDate],UNIX_TO_DATE(PrivateInfo[success][privateAuctionTime]+Global_Time));
	f(global_str, 145, "[A]{FFFFFF} Kurejas SAG: %s isstate privacia frakcija %s i aukciona (laikas: %s).", PN(playerid),OrgInfo[PrivateInfo[success][privateID]][oName],Convert(PrivateInfo[success][privateAuctionTime]));
	SendAdminsMessage(COLOR_YELLOW, global_str);
	SavePrivateFraction(success);
	return SCMF(playerid,COLOR_VALIK, "[Informacija] {FFFFFF}Sekmingai isstatete privacia frakcija '%s' aukcionui(%s).",OrgInfo[PrivateInfo[success][privateID]][oName],Convert(PrivateInfo[success][privateAuctionTime]));
}
cmd:checkjail(playerid, params[])
{
    extract params -> new id; else
		return SCM(playerid, COLOR_OLDRED, !"/checkjail [id]");
	return SCMF(playerid, -1, "Zaidejas %s sedi demorgane jau: %d laiko", PN(id), PI[id][pDemorgan]);
}
cmd:astats(playerid)
{
	if !CheckAdm(playerid, 6) *then
		return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
	return SPD(playerid, 2375, DIALOG_STYLE_INPUT, !"Perziureti administratoriaus statistika", "{FFFFFF}Noredami perziureti kokio nors administratoriaus statistika, irasykite jo slapyvardi zemiau esanciame laukelyje:\n\n{cccccc}pastaba: Nick turi buti teisingas", !"Priimti", !"Atgal");
}
cmd:fakeban(playerid, data[])
{
	if !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    new id, days, reason[30];
    if sscanf(data, "uds[30]", id, days, reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /fakeban [id] [days 1-30] [Priezastis]");
	if id == INVALID_PLAYER_ID *then
		return 0;
	if strlen(reason) > 30 *then
		return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
 	if IsAIP(reason) *then
	 	return 1;
	if !(1 <= days <= 30) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /fakeban [id] [days 1-30] [Priezastis]");
    f(global_str, 145, "À: %s[%d] uzblokavo zaideja %s[%d] %d dienu. Priezastis: %s", PN(playerid), playerid, PN(id), id, days, reason);
    ASCMALL(COLOR_RED, global_str);
	ANL(PN(id), global_str);
	SPD(id, 0, DIALOG_STYLE_MSGBOX, !"", !"Jusu paskyra buvo uzblokuota, jei nesutinkate su administratoriaus sprendimu, parasykite skunda forume, pridedami sia ekrano nuotrauka.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
	f(global_str, 256, "Administratorius <a href=../pages/user?name=%s>%s</a> FAKE uzblokavo zaideja <a href=../pages/user?name=%s>%s</a> %d dienu. Priezastis: %s", PN(playerid), PN(playerid), PN(id), PN(id), days, reason);
	aml(global_str, 5, "","");
	return 1;
}
cmd:antiteleport(playerid, params[])
{
	if !IsAOwner(playerid) && !CheckAdm(playerid, 8) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    extract params -> new zapros; else
		return SCM(playerid, -1, !"/antiteleport [Issaugoti po persijungimo (0 - ne / 1 - taip]");
	if PI[playerid][pBlockTP] *then
	{
		PI[playerid][pBlockTP] = 0;
		SCM(playerid, COLOR_VALIK, "[Informacija] {ffffff}Dabar pas jus vel gali teleportuotis");
		if zapros *then SQL("UPDATE `accounts` SET `BlockTP` = '0' WHERE `ID` = '%d'", PI[playerid][pID]);
		return SAMF(COLOR_YELLOW, "[A] À: %s[%d] vel ijunge teleportus pas save.", PN(playerid), playerid);
	}
	PI[playerid][pBlockTP] = 1;
	SAMF(COLOR_YELLOW, "[A] À: %s[%d] isjunge teleportus pas save.", PN(playerid), playerid);
	SCM(playerid, COLOR_VALIK, "[Èíôîðìàöèÿ] {ffffff}Dabar pas jus negalima teleportuotis");
	SCM(playerid, COLOR_VALIK, "[Informacija] {ffffff}Iveskite sia komanda vel, kad ijungtumete teleportus pas save.");
	if zapros *then
		SQL("UPDATE `accounts` SET `BlockTP` = '1' WHERE `ID` = '%d'", PI[playerid][pID]);
	return 1;
}
CMD:sethousecost(playerid, params[])
{
 	if !CheckFD(playerid, 1) *then
		return false;
    extract params -> new houseid, type, cost; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethousecost [id] [type] [cost]");
	if(type > 2 || type < 0) return 1;
	if(houseid > OWNABLEHOUSES) return 1;
	HouseInfo[houseid][hType] = type;
    HouseInfo[houseid][hCost] = cost;
    return UpdateHouse(houseid);
}
CMD:setklass(playerid, params[])
{
 	if !CheckFD(playerid, 1) *then
		return false;
	extract params -> new houseid, klass; else
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setklass [id] [klass]");
	if(houseid > OWNABLEHOUSES || klass > 6)
	    return 1;
	UpdateHouse(houseid);
	HouseInfo[houseid][hKlass] = klass;
	SCM(playerid, -1, !"ATLIKTA");
	UpdateHouse(houseid);
	return 1;
}
CMD:changehouse(playerid, params[])
{
 	if !CheckFD(playerid, 1) *then
	    return false;
    extract params -> new houseid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /changehouse [id]");
    if(houseid > OWNABLEHOUSES)
		return 1;
	GetPlayerPos(playerid, HouseInfo[houseid][hEnter_X], HouseInfo[houseid][hEnter_Y], HouseInfo[houseid][hEnter_Z]);
	DestroyDynamic3DTextLabel(House3DText[houseid]);
   	House3DText[houseid] = CreateDynamic3DTextLabel(" Namas ", 0xE1AE3CFF, HouseInfo[houseid][hEnter_X], HouseInfo[houseid][hEnter_Y], HouseInfo[houseid][hEnter_Z], 10.0);
	UpdateHouse(houseid);
    return SCM(playerid, COLOR_OLDRED, !"house suc transportation to you mark point");
}
CMD:setbizcost(playerid, params[])
{
	if !CheckFD(playerid, 1) *then
  		return false;
	extract params -> new bizid, cost, type; else
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setbizcost [id] [cost] [cost type]");
	if type > 3 || type < 0 *then return 1;
    BizData[bizid][bCost] = cost;
    BizData[bizid][bCostType] = type;
    UpdateBusinessText(bizid, 1);
    return SCM(playerid, COLOR_RED, !"atlikta");
}
CMD:map(playerid)
{
	if(GetString(PN(playerid),"Milancholi"))
	{
		if !CheckAdm(playerid, 7) *then
			return false;
		return SPD(playerid, 7797, DIALOG_STYLE_LIST, !"Admin Mapping", "\
		- sukurti objekta\n\
		- grupes\n\
		- pasirinkti objekta zymekliu\n\
		- mano objektu sarasas\n\
		- visu objektu sarasas\n\
		- pasalinimas\n\
		{F4D048}Help: /map, /mapg, /mapobj", !"Isrinkti", !"Uzdaryti");
	}
	return 1;
}
CMD:removetune(playerid, params[])
{
	if !CheckAdm(playerid, 3) *then return false;
	extract params -> new vehicle; else
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Naudokite: /removetune [transporto ID]");
	if !IsAOwnableCar(vehicle) *then return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Tuninga galima pasalinti tik is zaidejo asmeninio transporto.");
	new car = GetVehicleID(vehicle);
	for new i; i < 10; i++ do
		InstallTun(vehicle, i, 1), CarInfo[car][TuningComp][i] = CarInfo[car][InvCar][i] = 0;
	SCMF(playerid, COLOR_GREEN, "Jus sekmingai isvalete visa tuninga transporto ID: %d (savininkas %s)!", vehicle, CarInfo[car][cOwner]);
	f(global_str, 145, "[%s] pasalino visa tuninga is transporto ID: %d (savininkas %s)", PN(playerid), vehicle, CarInfo[car][cOwner]);
	SendAdminsMessage(COLOR_GREY, global_str);
	SaveInvCar(vehicle);
	f(global_str, 256, "Administratorius <a href=../pages/user?name=%s>%s</a> pasalino tuninga automobilio <a href=../pages/carlog.php?id=%d>¹%d</a>",
	PN(playerid), PN(playerid), CarInfo[car][cID], CarInfo[car][cID]);
	aml(global_str, 5, PN(playerid),"");
	return false;
}
CMD:anticheat(playerid, params[])
{
	if !CheckAdm(playerid, 7) *then
		return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    pAntiCheatSettingsPage{playerid} = 1;
    return ShowPlayer_AntiCheatSettings(playerid);
}
CMD:ahelp(playerid)
{
	global_str = "";
	for new i = 1; i < 9; i++ do
		strcat(global_str, (str_f("\n{633169}[%d]{%s} %d lygis", i, PI[playerid][pAdmin] >= i ? "FFFFFF":"AFAFAF", i)));
	return SPD(playerid, 25021, DIALOG_STYLE_LIST, !"{FFFFFF}Administratoriaus komandos", global_str, !"Isrinkti", !"Atsaukti");
}
CMD:sethousegarage(playerid, params[])
{
    if !CheckAdm(playerid, 7) *then return false;
	extract params -> new house_id, house_garage_status; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethousegarage [house id] [0/1]");
	if(!(0 <= house_garage_status <= 1))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethousegarage [house id] [0/1]");
	if(house_garage_status == HouseInfo[house_id][hGarage])
		return SCM(playerid, COLOR_RED, (HouseInfo[house_id][hGarage]) ? ("[Klaida] {FFFFFF}Namas jau su garazu") : ("[Klaida] {FFFFFF}Namas ir taip su garazu"));
	if(house_id > OWNABLEHOUSES)
	    return 1;
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	HouseInfo[house_id][hGarage] = house_garage_status;
	if(house_garage_status)
	{
		HouseInfo[house_id][hGarage_X] = X;
		HouseInfo[house_id][hGarage_Y] = Y;
		HouseInfo[house_id][hGarage_Z] = Z;
	}
	UpdateHouse(house_id);
	UpdateHouseGarage(house_id);
	SCM(playerid, COLOR_RED, (HouseInfo[house_id][hGarage]) ? ("Pridejote garaza prie nurodyto namo") : ("Pasalinote garaza nuo nurodyto namo"));
	return 1;
}
CMD:addhouse(playerid, params[])
{
 	if !CheckFD(playerid, 2) && !CheckAdm(playerid, 8) *then
	    return false;
    if(sscanf(params, "ddd", params[0], params[1], params[2]))
    {
        SCM(playerid, COLOR_OLDRED, !"Naudokite: /addhouse [klass] [cost type] [cost]"), SCM(playerid, -1, !"Cost type: 0 - Pinigai; 1 - SAG-Coins; 3 - Kaledines monetos");
        return 1;
    }
	if(!(1 <= params[0] <= 6)) return SCM(playerid, COLOR_OLDRED, !"ID êëàññà îò 1 äî 6");
	if(!(0 <= params[1] <= 3)) return SCM(playerid, COLOR_OLDRED, !"Òèï öåíû îò 0 äî 3");
	if(!(1 <= params[2] <= 2100000000)) return SCM(playerid, COLOR_OLDRED, !"Kainos nuo 1 iki 2100000000");
	new ID = OWNABLEHOUSES;
    if(ID+1 > MAX_HOUSES) return SCM(playerid, COLOR_OLDRED, !"House dont suc add, because house int the bigest");
	GetPlayerPos(playerid, HouseInfo[ID][hEnter_X], HouseInfo[ID][hEnter_Y], HouseInfo[ID][hEnter_Z]);
    HouseInfo[ID][hID] = ID;
    HouseInfo[ID][hKlass] = params[0];
    HouseInfo[ID][hType] = params[1];
    HouseInfo[ID][hCost] = params[2];
    SetString(HouseInfo[ID][hOwner], "The State");
    HouseInfo[ID][hExit_X] = 267.1;
    HouseInfo[ID][hExit_Y] = 305;
    HouseInfo[ID][hExit_Z] = 999.148;
    HouseInfo[ID][hInt] = 2;
	HouseInfo[ID][hLevel] = 1;
	for(new i; i < 5; i++) HRoomOwner[ID][i] = "The State";
	f(global_str, 350, "\
    INSERT INTO `houses`(`ID`, `Enter_X`, `Enter_Y`, `Enter_Z`, `Exit_X`, `Exit_Y`, `Exit_Z`, `Owner`, `Cost` , `Klass`, `Interior`, `Level`, `Type`) \
    VALUES (%d, '%.2f', '%.2f', '%.2f', '%.2f', '%.2f', '%.2f', 'The State', '%d', '%d', '%d', '%d', '%d')", ID \
	,HouseInfo[ID][hEnter_X], HouseInfo[ID][hEnter_Y], HouseInfo[ID][hEnter_Z], HouseInfo[ID][hExit_X], HouseInfo[ID][hExit_Y], HouseInfo[ID][hExit_Z], HouseInfo[ID][hCost], HouseInfo[ID][hKlass], HouseInfo[ID][hInt], HouseInfo[ID][hLevel], HouseInfo[ID][hType]);
    mysql_tquery(mysql, global_str);
   	HouseIcon[ID] = CreateDynamicMapIcon(HouseInfo[ID][hEnter_X], HouseInfo[ID][hEnter_Y], HouseInfo[ID][hEnter_Z], 31, 0);
    House3DText[ID] = CreateDynamic3DTextLabel(" Äîì ", 0xE1AE3CFF, HouseInfo[ID][hEnter_X], HouseInfo[ID][hEnter_Y], HouseInfo[ID][hEnter_Z], 10.0);
    UpdateHouse(ID);
    OWNABLEHOUSES++;
	return SCMF(playerid, -1, "Sekmingai sukurete nama numeriu {E7E7E7}%d {ffffff}Pirkimo kaina: {E7E7E7}%d", ID, params[1]);
}
CMD:clearhouseitem(playerid, params[])
{
 	if !CheckFD(playerid, 1) *then
		return false;
	new id;
	if sscanf(params, "d", id) *then return false; //hItem
	if id > OWNABLEHOUSES *then return false;
	for new i; i < 90; i++ do
		HouseInfo[id][hItem][i] = 0,
		HouseInfo[id][hItemCount][i] = 0;
	SCMF(playerid, COLOR_VALIK, "[Informacija] {FFFFFF}Sekmingai isvalete namo ¹%d spinta", id);
	SaveItemHouse(id);
	return false;
}
CMD:tp(playerid, params[])
{
	if !CheckAdm(playerid, 1) *then return 0;
	new meber;
    if(sscanf(params, "d", meber))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /tp [frakcijos ID]");
    if(meber > 27 || meber < 1)
    	return SCM(playerid, COLOR_GREY, !"OT 1 DO 28");
    SetPlayerVirtualWorld(playerid, SpawnIntWorld[meber][1]), SetPlayerInterior(playerid, SpawnIntWorld[meber][0]);
	return UpdatePlayerPos(playerid, SpawnInfo[meber][0], SpawnInfo[meber][1], SpawnInfo[meber][2], SpawnInfo[meber][3]);
}
cmd:plpos(playerid, params[])
{
	if !CheckAdm(playerid, 1) *then return false;
	extract params -> new player:target, Float:coords[3]; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /plpos [id] [x] [y] [z]");
	if(PI[playerid][pAdmin] < PI[target][pAdmin]) return 1;
	if(target != playerid && PI[playerid][pAdmin] == PI[target][pAdmin]) return 1;
    SCMF(target, COLOR_LIGHTBLUE, " Administratorius %s[%d] teleportavo jus i koordinates %.3f, %.3f, %.3f.", PN(playerid), playerid, coords[0], coords[1], coords[2]);
   	SAMF(COLOR_GREY, "[A] %s[%d] teleportavo zaideja %s[%d] i koordinates %.3f, %.3f, %.3f.", PN(playerid), playerid, PN(target), target, coords[0], coords[1], coords[2]);
    return UpdatePlayerPos(target, coords[0], coords[1], coords[2]);
}
CMD:tpcor(playerid, data[])
{
	new Float:coords[3];
    if !CheckAdm(playerid, 1) *then
		return false;
    if sscanf(data, "p<,>fff", coords[0], coords[1], coords[2]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /tpcor [x] [y] [z]");
    return UpdatePlayerPos(playerid, coords[0], coords[1], coords[2]);
}
CMD:amember(playerid, data[])
{
	if !CheckAdm(playerid, 4) *then return false;
	extract data -> new orgid, rang; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /amember [id] [rang]");
    if !(1 <= orgid <= 30) *then
		return SCM(playerid,COLOR_GREY, !"OT 1 DO 30");
	else if !(1 <= rang <= OrgInfo[orgid][Max_Rang]-1) *then
		return false;
	PI[playerid][pMember] = orgid;
	PI[playerid][pRank] = rang;
	TeamDuty{playerid} = true;
	SetPlayerColor(playerid, TeamColors[orgid]);
	SetPlayerSkinEx(playerid, GetSkinOfPlayer(playerid));
	f(global_str, 125, "Administrarorius %s(%d) prisijunge prie organizacijos %s i %d ranga", PN(playerid), playerid, OrgInfo[orgid][oName], rang);
	return SendAdminsMessage(COLOR_GREY, global_str);
}
CMD:asellbiz(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
		return false;
    extract params -> new bizid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /asellbiz [bizid]");
	if(bizid > OWNABLEBIZES)
	    return false;
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pardave versla %d %s [savininkas: %s]", 5, PN(playerid), "", PN(playerid), PN(playerid), bizid, BizData[bizid][bName], BizData[bizid][bOwner]);
	f(global_str, 128, "A: %s pardave versla %d %s [savininkas: %s]", PN(playerid), bizid, BizData[bizid][bName], BizData[bizid][bOwner]);
    SendAdminsMessage(COLOR_GREY, global_str);
    SetString(BizData[bizid][bOwner], "The State");
	BizData[bizid][bMoney] = 0;
	BizData[bizid][bLevel] = 0;
	UpdateBusinessText(bizid, 1);
	SCM(playerid, COLOR_LIGHTBLUE, !"Jus pardavete versla");
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
CMD:deletefamily(playerid, params[])
{
    if sscanf(params, "s[30]", params[0]) *then
        return SCM(playerid, COLOR_OLDRED, !"Naudokite: /deletefamily [name]");
	if strlen(params[0]) > 30 *then return false;
    f(global_str, 80, "SELECT id FROM family WHERE name = '%s' LIMIT 1", params[0]);
    mysql_tquery(mysql, global_str, "DeleteFamily", "d", playerid);
    return 1;
}
CMD:asellhouse(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
		return false;
    extract params -> new houseid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /asellhouse [houseid]");
	if(houseid > OWNABLEHOUSES)
	    return 0;
    foreach(new i: Player)
	{
	    if(PI[i][pHouseKey] == houseid) {
			PI[i][pHouseKey] = -1;
			PI[i][pDCTime] = 0;
		}
	}
	f(global_str, 256, "UPDATE `accounts` SET `HouseKey` = '-1', `DropCarTime` = '0' WHERE `NickName` = '%s';", HouseInfo[houseid][hOwner]);
	mysql_tquery(mysql, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pardave nama %d [ %s ]", 5, PN(playerid),"", PN(playerid), PN(playerid), houseid, HouseInfo[houseid][hOwner]);
	SCM(playerid, COLOR_LIGHTBLUE, !"Âû ïðîäàëè äîì");
    f(global_str, 128, "A: %s pardave nama %d [savininkas: %s]", PN(playerid), houseid, HouseInfo[houseid][hOwner]);
    SendAdminsMessage(COLOR_GREY, global_str);
    SetString(HouseInfo[houseid][hOwner], "The State");
	HouseInfo[houseid][hMoney] = 0;
	HouseInfo[houseid][hNalog] = 0;
	UpdateHouse(houseid);
	ResetHouse(houseid);
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
CMD:deletecar(playerid, params[])
{
	extract params -> new carid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /deletecar [carid]");
	if IsAOwnableCar(carid) *then
	{
		amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pardave automobili <a href=../pages/carlog.php?id=%d>%d</a>. Buves savininkas: %s", 5, PN(playerid),"", PN(playerid), PN(playerid), CarInfo[GetVehicleID(carid)][cID], CarInfo[GetVehicleID(carid)][cID], CarInfo[GetVehicleID(carid)][cOwner]);
		f(global_str, 128, "A: %s pardave automobili %d!", PN(playerid), carid);
    	SendAdminsMessage(COLOR_GREY, global_str);
		SellCar(carid, true);
	}
	else DestroyVehicleEx(carid);
	SCM(playerid, COLOR_LIGHTBLUE, !"Sekmingai istrinta transporto priemone!");
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
CMD:veh(playerid,params[])
{
	if CountVehicles() == 1999 *then return SendErrorMessage(playerid);
    new Float:pX,Float:pY,Float:pZ;
 	if sscanf(params, "ddd", params[0], params[1], params[2]) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /veh [automobilio ID] [spalva 1] [spalva 2]");
	else if !ValidVehicleModel(params[0]) *then
		return SCM(playerid, COLOR_VALIK, !"Neteisingas transporto priemones numeris!");
	else if params[0] == 538 || params[0] == 449 || params[0] == 570 *then
		return SCM(playerid, COLOR_OLDRED, !"Bybi tau..");
	if VehID[playerid] > 0 *then
        DestroyVehicleIter(VehID[playerid]),
        	SCM(playerid, -1, !"[Informacija] Ankstesne masina buvo pasalinta, nes sukurete nauja!"),
        		VehID[playerid] = 0;
    if params[1] > 126 || params[1] < 0 || params[2] > 126 || params[2] < 0 *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Spalvos ID nuo 0 iki 126!");
	GetPlayerPos(playerid, pX,pY, pZ);
    VehID[playerid] = J_AddStaticVehicleEx(params[0],pX+2,pY,pZ,0.0,1,1);
	SCMF(playerid, COLOR_RED, "[Informacija] {FFFFFF}Jus sukurete automobili ¹%d | CarID: %d.", params[0], VehID[playerid]);
	if(!IsAOwner(playerid))
	{
		f(global_str, 128,"À: %s sukure transporta. ID: %d | [%d]",PN(playerid),params[0], VehID[playerid]);
		SendAdminsMessage(COLOR_GREY, global_str);
	}
	return ChangeVehicleColor(VehID[playerid], params[1], params[2]);
}
CMD:delveh(playerid)
{
	if VehID[playerid] > 0 *then
    	DestroyVehicleIter(VehID[playerid]),
    		SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Automobilis pasalintas!"),
        		VehID[playerid] = 0;
    else SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Jus ne sukurete automobilio!");
    return true;
}
CMD:delvehall(playerid)
{
	new count;
	foreach(Player, i)
	{
	    if !VehID[i] *then continue;
	   	DestroyVehicleEx(VehID[i]), VehID[i] = 0, count ++;
	}
	f(global_str,100,"[A] %s pasalino visus admin sukurtus automobilius %d", PN(playerid), count);
    return SendAdminsMessage(COLOR_GREEN, global_str);
}
CMD:enableworkshop(playerid)
{
	EnableWorkShop = !EnableWorkShop;
	SCMF(playerid, -1, "Jus %s dirbtuviu drabuziu sistema", !EnableWorkShop ? "isjungete" : "ijungete");
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> %s dirbtuviu drabuziu sistema", 5, PN(playerid),"", PN(playerid), PN(playerid), !EnableWorkShop ? "isjunge" : "ijunge");
}
CMD:plveh(playerid, params[])
{
    new
		id = playerid,
		veh = 462,
		TT;
    sscanf(params, "udd", id, veh, TT);
    if !ValidVehicleModel(veh) *then return SCM(playerid, COLOR_VALIK, !"Neteisingas transporto numeris!");
   	if (veh == 538 || veh == 449 || veh == 570) return false;
	if(id == INVALID_PLAYER_ID)
	    return 0;
    if GetPlayerState(id) != 1 *then
        return SCM(playerid, COLOR_GREY, !"Zaidejas uz vairo!");
	else if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	if(CountVehicles() == 1999) return SendErrorMessage(playerid);
	SCM(playerid, -1, !"/plveh [id] [idcar] [TT 0/1]");
    new
		Float:X, Float:Y, Float:Z, Float:A;
	GetPlayerPos(id, X, Y, Z);
	GetPlayerFacingAngle(id, A);
	PLVEH_destroy(id);
	if AnimPlayed{id} *then return false;
    PI[id][plveh] = J_AddStaticVehicleEx(veh, X, Y, Z, A, random(127), random(127));
 	PutPlayerInVehicle(id, PI[id][plveh], 0);
 	if TT *then
 		OtherInstallTun(PI[id][plveh], 578),
 		VehicleInfo[PI[id][plveh]][vStyle] = true;
	f(global_str, 128, "[A] À: %s[%d] isdave laikina automobili zaidejui %s[%d] [%d]", PN(playerid), playerid, PN(id), id, PI[id][plveh]);
	SendAdminsMessage(COLOR_GREY, global_str);
    if !IsAVelik(PI[id][plveh]) || !IsASkate(PI[id][plveh]) *then SetEngineStatus(PI[id][plveh], false, id);
	return 1;
}
CMD:weather(playerid, params[])
{
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /weather [id]");
    new string[18 - 2 + MAX_PLAYER_NAME];
    f(string, 128, "%s Pakeite ora.", PN(playerid));
	SendAdminsMessage(COLOR_GREY, string);
    Weather = params[0];
    SetWeather(Weather);
	return 1;
}
CMD:makeleader(playerid, params[])
{
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /makeleader [id]");
	global_str = "";
	for(new i = 1; i < MAX_ORGS; i++) f(global_str, 500, "%s%s\n", global_str, OrgInfo[i][oName]);
	SPD(playerid, 26, DIALOG_STYLE_LIST, PN(params[0]), global_str, !"Isrinkti", !"Atsaukti");
	return MLPlayer[playerid] = params[0];
}
CMD:setgangzone(playerid, params[])
{
	new gang;
	if(sscanf(params,"d",gang)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setgangzone [11 - 15 arba 25]");
	if((11 > gang || gang > 15) && gang != 21) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setgangzone [11 - 15]");
	new zone = GetPlayerGangZone(playerid);
	if(CaptureZone == zone) return SCM(playerid, COLOR_GREY, !"Sia zona jau uzima");
	new lastgang = GZInfo[zone][gzFracID];
	GangZoneHideForAll(GangZone[zone]);
    GangZoneShowForAll(GangZone[zone],TeamColors[gang]);
    GZInfo[zone][gzFracID] = gang;
    f(global_str, 50,"%d òåððèòîðèÿ",zone);
    SCM(playerid,COLOR_WHITE,global_str);
    SendTeamMessage(gang,COLOR_VALIK, !"[Informacija] {FFFFFF}Jusu gauja uzeme nauja teritorija");
   	f(global_str, 400, "UPDATE `zonesinfo` SET `GangID` = '%i', `Min_X` = '%.4f', `Min_Y` = '%.4f', `Max_X` = '%.4f', `Max_Y` = '%.4f' WHERE `ID` = '%i'",
	GZInfo[gang][gzFracID],
	GZInfo[zone][gzMin_X],
	GZInfo[zone][gzMin_Y],
	GZInfo[zone][gzMax_X],
	GZInfo[zone][gzMax_Y],zone + 1);
    UpdateDorm(gang);
    UpdateDorm(lastgang);
    SaveGangZone(zone);
	f(global_str, 150, "Administratorius <a href=../pages/user?name=%s>%s</a> pakeite spalva GangZone ¹%d", PN(playerid), PN(playerid), gang);
	aml(global_str, 5, PN(playerid), "");
	return 1;
}
CMD:slap(playerid, params[])
{
	new id;
	if(sscanf(params,"ud",id,params[1])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /slap [id] [1 - aukstyn/2 - zemyn]");
	if(params[1] < 1 || params[1] > 2) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /slap [id] [1 - aukstyn/2 - zemyn]");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_RED, !"Zaidejas dar neprisijunge!");
	else if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(id,X,Y,Z);
	if(params[1] == 2) SetPlayerPos(id,X,Y,Z-5);
	else if(params[1] == 1) SetPlayerPos(id,X,Y,Z+5);
	f(global_str,128,"[A] À: %s[%d] dave per uzpakali %s[%d]", PN(playerid),playerid,PN(id),id);
	SendAdminsMessage(COLOR_GREY, global_str);
	return true;
}
CMD:weap(playerid, params[])
{
	extract params -> new player:target; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /weap [id]");
	if !IsPlayerOnline(target) *then
	    return false;
   	_ResetGun(target);
	return SCMF(playerid, COLOR_LIGHTBLUE, "Jus atemete ginklus is zaidejo %s[%d]", PN(target), target);
}
CMD:settime(playerid, params[])
{
	if(sscanf(params,"d", params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /settime [hour]");
    return SetWorldTime(params[0]);
}
CMD:unban(playerid, params[])
{
	new
		name[MAX_PLAYER_NAME],
		reason[64];
    if(sscanf(params, "s[24]s[64]", name, reason))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unban [name] [reason]");
	SetPVarString(playerid, "ReasonBanString", reason);
    if !IsBannedName(name) *then
		return SCM(playerid, -1, !"Sis zaidejas nera uzblokuotas");
    mysql_real_escape_string(name, UnbanName[playerid]);
    new
		seconds,
		admin[MAX_PLAYER_NAME];
    f(global_str, 200, "SELECT * FROM `bannames` WHERE BINARY `Name` = '%s' LIMIT 1", UnbanName[playerid]);
	new Cache:result = mysql_query(mysql, global_str);
	if(cache_get_row_count(mysql) > 0)
	{
		cache_get_row(0, 2, admin, mysql);
		cache_get_row(0, 3, reason, mysql);
		seconds = cache_get_row_int(0, 4, mysql);
		new
			times = Global_Time,
			tima[20],
			dima;
		if(floatround((seconds-times)/60/60/24) > 1)
		{
			tima = "dienu";
			dima = floatround((seconds-times)/60/60/24,floatround_ceil);
		}
		else
	 	{
 			tima = "valanda(u)";
 			dima = floatround((seconds-times)/60/60,floatround_ceil);
		}
	    f(global_str, 200, "\
		{FFFFFF}Blokuotojas: \t{FF0000}%s\n\
		{FFFFFF}Priezastis: \t{FF0000}%s\n\
		{FFFFFF}Iki atblokavimo: \t\t{FF0000}%d %s",
		admin, reason, dima, tima);
	}
	SPD(playerid, 91, DIALOG_STYLE_MSGBOX, !"Informacija apie uzblokuota asmeni", global_str, !"Atblokuoti", !"Atsaukti");
	cache_delete(result, mysql);
	return 1;
}
CMD:agiveskin(playerid, data[])
{
	extract data -> new player:target, number; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /agiveskin [zaidejo ID] [skino ID]");
	if !(0 <= number <= 311) *then return false;
	AddItem(target, number, 1);
	SCMF(playerid, -1, "Jus isdavete %s skina(id: %d) i inventoriu", PN(target), number);
	SCMF(target, COLOR_OLDRED, "À: %s isdave jums amzina skina i inventoriu. (skinid: %d).", PN(playerid), number);
	f(global_str, 128, "[A] %s[%d] isdave i inventoriu skina [ID: %d] zaidejui %s[%d]", PN(playerid), playerid, number, PN(target), target);
    SendAdminsMessage(COLOR_GREY, global_str);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave amzina skina i inventoriu <a href=../pages/user?name=%s>%s</a> ¹%d", 5, PN(playerid),PN(target), PN(playerid), PN(playerid), PN(target), PN(target), number);
}
CMD:unjail(playerid, params[])
{
	if sscanf(params, "us[48]", params[0],params[1]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unjail [id] [priezastis]");
	if params[0] == INVALID_PLAYER_ID *then
		return false;
	if IsAIP(params[1]) *then return 0;
	if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return 1;
	if(params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin]) return 1;
	f(global_str, 128, " À: %s isleido zaideja %s, priezastis: %s", PN(playerid), PN(params[0]), params[1]);
	ASCMALL(COLOR_RED, global_str);
	ANL(PN(params[0]), global_str);
	PI[params[0]][pDemorgan] = 0;
	PlayerSpawn(params[0]);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isleido zaideja <a href=../pages/user?name=%s>%s</a> is demorgano. Priezastis: %s", 5, PN(playerid), PN(params[0]), PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), params[1]);
}
CMD:apunish(playerid, params[])
{
    new time;
    if(sscanf(params,"uds[100]",params[0],time,params[1])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /apunish [id] [time] [reason]");
	if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
    f(global_str, 128, "[A] À: %s[%d] pasodino zaideja %s[%d] i GRK %d minuciu. Priezastis: %s",PN(playerid), playerid,PN(params[0]), params[0],time,params[1]);
	SendAdminsMessage(COLOR_GREY,  global_str);
	JailTSR[params[0]] = 1;
	PI[params[0]][pJailTime] = time*60;
	PlayerSpawn(params[0]);
	SaveAccount(params[0]);
	return 0;
}
CMD:unpunish(playerid, params[])
{
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unpunish [id]");
    if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return 1;
    if(params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin]) return 1;
    f(global_str, 128, "[A] À: %s[%d] isleido zaideja %s[%d] is GRK. ",PN(playerid), playerid,PN(params[0]), params[0]);
	SendAdminsMessage(COLOR_GREY, global_str);
	JailTSR[params[0]] = -1;
	PI[params[0]][pJailTime] = 0;
	PlayerSpawn(params[0]);
 	SaveAccount(params[0]);
	return 0;
}
CMD:jail(playerid, params[])
{
    new time;
    if(sscanf(params,"uds[100]",params[0],time,params[1])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /jail [id] [time] [reason]");
	if !IsPlayerOnline(params[0]) *then return false;
    if(IsAIP(params[1]))return 1;
    if(strlen(params[1])>30) return SCM(playerid,COLOR_RED,!"Ne daugiau nei 30 simboliu!");
    if(PI[params[0]][pJailTime]>0)return SCM(playerid,COLOR_RED,!"Sis zaidejas jau yra arestineje!");
    if(PI[params[0]][pDemorgan]>0)return SCM(playerid,COLOR_RED,!"Sis zaidejas jau yra DEMORGANE!");
    if(time == 0) return SCM(playerid, COLOR_RED, !"Negalima pasodinti 0 minutems");
    if(time> 3000) return SCM(playerid, COLOR_RED, !"Negalima pasodinti daugiau kaip 3000 minuciu");
    if(PI[params[0]][pDemorgan]>0 && PI[playerid][pAdmin] < 4) return SCM(playerid, COLOR_RED, !"Jusu lygis nesuteikia galimybes keisti sio zaidejo kalinimo laika.");
    if(JailTSR[params[0]] != -1) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jis randasi GRK!");
	if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	SetSpawnInfo(params[0], 255, 8, -799.1370,2831.1130,1501.9896, 90.0, 6, 6, 6, 6, 6, 6);
	f(global_str, 145, " À: %s[%d] pasodino zaideja %s[%d] i demorgana %d minuciu. Priezastis: %s",PN(playerid), playerid,PN(params[0]), params[0],time, params[1]);
	ASCMALL(COLOR_RED, global_str);
	ANL(PN(params[0]), global_str);
	f(global_str, 256, "Administratorius <a href=../pages/user?name=%s>%s</a> pasodino zaideja <a href=../pages/user?name=%s>%s</a> i demorgana %d minuciu. Priezastis: %s",
	PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), time, params[1]);
	aml(global_str, 5, PN(playerid), PN(params[0]));
	PlayerPlaySound(params[0], 1058, 0.0, 0.0, 0.0);
	_ResetGun(params[0]);
	PI[params[0]][pDemorgan] = time*60 / (PI[params[0]][pVIP] == 10 ? 2:1);
	PI[params[0]][pWanted] = 0;
	PI[params[0]][pPcix] ++;
	UpdatePlayerHealth(params[0],100);
	PlayerSpawn(params[0]);
	if(QuestProgress[playerid][17] >= 25) NextStapQI(playerid, 17);
	if(AcceptQuest[playerid][17]!=0) QuestProgress[playerid][17]++;
	return 1;
}
CMD:unwarn(playerid, params[])
{
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unwarn [id/name]");
	if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return 1;
	if(params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin]) return 1;
	if(params[0] == playerid) return 1;
	if(!PI[params[0]][pWarns])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jis neturi WARN!");
	f(global_str, 106, " À: %s panaikino 1 warn %s", PN(playerid), PN(params[0]));
	SendAdminsMessage(COLOR_YELLOW, global_str);
	SCM(params[0], COLOR_GREEN, !"[Informacija] {FFFFFF}Administratorius panaikino jums 1 Warn!");
	PI[params[0]][pWarns] -= 1;
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> panaikino warn zaidejui <a href=../pages/user?name=%s>%s</a> %d/3.", 5, PN(playerid), PN(params[0]), PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), PI[params[0]][pAWarns]);
}
CMD:unfreeze(playerid, params[])
{
	new
	    targetid;
	if(sscanf(params, "u", targetid))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unfreeze [id/name]");
	f(global_str, 125, " À: %s uzsalde zaideja %s", PN(playerid), PN(targetid));
	SendAdminsMessage(COLOR_YELLOW, global_str);
	TogglePlayerControllable(targetid, true);
	return 1;
}
CMD:setskin(playerid, params[])
{
    new id, skin, oll;
    if sscanf(params, "udd", id, skin, oll) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setskin [id] [0 - 744] [0/1]");
    if oll < 0 || oll > 1 *then return false;
    if oll == 1 && PI[playerid][pAdmin] < 5 *then return SCM(playerid, COLOR_RED, !"Negalite suteikti amzino skino!");
    if(PI[playerid][pAdmin] < PI[id][pAdmin]) return 1;
    if(id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin]) return 1;
   	if !(0 <= skin <= 732) *then return false;
    if !IsPlayerConnected(id) *then return false;
	if oll == 1 *then
	{
	    if(PI[id][pSkin] != 18) AddItem(id, GetSkinInfo(PI[id][pSkin], 3));
	    PI[id][pSkin] = skin;
	    SetPlayerSkinEx(id, skin);
	    f(global_str, 128, "À: %s suteike jums amzina skina.", PN(playerid));
	    SCM(id, COLOR_RED, global_str);
        f(global_str, 128, "[A] %s[%d] nustate amzina skina [ID: %d] zaidejui %s[%d]", PN(playerid), playerid, skin, PN(id), id);
	    SendAdminsMessage(COLOR_GREY, global_str);
	}
	else
	{
	    if(PI[id][pSkin] != 18) AddItem(id, GetSkinInfo(PI[id][pSkin], 3));
        SetPlayerSkinEx(id, skin);
	    f(global_str, 128, "À: %s suteike jums laikina skina.", PN(playerid));
	    SCM(id, COLOR_RED, global_str);
        f(global_str, 128, "[A] %s[%d] nustate laikina skina [ID: %d] zaidejui %s[%d]", PN(playerid), playerid, skin, PN(id), id);
	    SendAdminsMessage(COLOR_GREY, global_str);
	}
	f(global_str, 128, "Jus suteikete %s skina %d", PN(id), skin);
	SCM(playerid, -1, global_str);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> nustate %s skina %d zaidejui <a href=../pages/user?name=%s>%s</a>.", 5, PN(playerid), PN(id), PN(playerid), PN(playerid), oll ? "amzina":"laikinas", skin, PN(id), PN(id));
}
CMD:givemoney(playerid, params[])
{
	new
		id,
		money;
    if sscanf(params, "ud", id, money) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /givemoney [id/name] [money]");
    if id == INVALID_PLAYER_ID *then
		return false;
	GiveMoney(id, money);
	return SCMF(playerid, -1, "Jus isdavete zaidejui %s $%d", PN(id), money);
}
alias:menu("mm", "mn");
CMD:menu(playerid)
{
    if Clother[playerid] != -1 || BuyInt[playerid] != -1 || BuyGuns[playerid] != -1 || Buyitem[playerid] != -1 *then return 0;
	if CuffedTime[playerid] *then return SCM(playerid, COLOR_RED, !"Jus esate nejudrus ir negalite judeti");
	if Cuffed[playerid] *then return SCM(playerid, COLOR_RED, !"Jus esate sukaustytas ir negalite judeti");
    new npromo[24];
    if(GetString(PI[playerid][pUsePromo],"None")) npromo = "Dar nenaudotas";
    else strmid(npromo, PI[playerid][pUsePromo], 0, 24);
	f(global_str, 1024, "\
	{633169}[1]{FFFFFF} Personazo veiksmas\n\
	{633169}[2]{FFFFFF} Personazo igudziai\n\
	{633169}[3]{FFFFFF} Rysys su administracija\n\
	{633169}[4]{FFFFFF} Pagalba serveryje\n\
	{633169}[5]{FFFFFF} Personazo nustatymai\n\
	{633169}[6]{FFFFFF} Donate\n\
	{633169}[7]{FFFFFF} Telefonas\n\
	{633169}[8]{FFFFFF} Atidaryti rulete\n\
	{633169}[9]{FFFFFF} Nicku istorija\n\
	{633169}[10]{FFFFFF} Bausmiu istorija\n\
	{633169}[11]{FFFFFF} PREMIUM zaidejai Online\n\
	{633169}[12]{FFFFFF} Promocode: {ffff00}%s\n\
	{633169}[13]{FFFFFF} Rusiskas standartas [Pakviesk drauga]", npromo);
	return SPD(playerid, 722, DIALOG_STYLE_LIST, !"Zaidimo meniu", global_str, !"Isrinkti", !"Atsaukti");
}
CMD:farmhelp(playerid) return SPD(playerid, 15188, DIALOG_STYLE_LIST, !"Ukine veikla", !"Bendra informacija\nKaip dirbti ukyje?\nKaip valdyti uki?\nAugalu sarasas ir augimo laikas", !"Isrinkti", !"Uzdaryti");
CMD:jobhelp(playerid) return ShowJobInfo(playerid, PlayerJob[playerid]);
CMD:quitjob(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 100.0, 2093.2317,797.1243,1027.1211))
		return SCM(playerid, COLOR_GREY, !"Palikti darba galima tik darbo centre!");
	else if(PlayerJob[playerid] == JOB_NONE)
		return SCM(playerid, COLOR_GREY, !"Jus ir taip jau esate bedarbis.");
    else if(InJob[playerid] != 0)
		return SCM(playerid, COLOR_GREY, !"Siuo metu jus dirbate. Baikite darba ir iveskite /quitjob");
    PlayerJob[playerid] = JOB_NONE;
    SCM(playerid, COLOR_GREEN, !"[Informacija] {FFFFFF}Jus sekmingai palikote darba.");
    _ResetGun(playerid);
    UpdatePlayerArmour(playerid, 0);
    ResetDynamicCPs(playerid);
	return 1;
}
CMD:unmute(playerid, params[])
{
	if(sscanf(params, "us[150]", params[0], params[1])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unmute [id] [reason]");
	if(params[0] == INVALID_PLAYER_ID) return 0;
	if(PI[params[0]][pMuteTime]==0) return SCM(playerid, COLOR_RED, !"Zaidejas neturi MUTE!");
	if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return 1;
	if(params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin]) return 1;
	f(global_str, 144, " À: %s panaikino MUTE zaidejui %s, priezastis: %s", PN(playerid), PN(params[0]), params[1]);
	ASCMALL(COLOR_RED, global_str);
	ANL(PN(params[0]), global_str);
	PI[params[0]][pMuteTime] = 0;
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> panaikino MUTE zaidejui <a href=../pages/user?name=%s>%s</a>. Priezastis: %s", 5, PN(playerid), PN(params[0]), PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), params[1]);
}
CMD:getherecar(playerid, params[])
{
	extract params -> new car; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /getherecar [id]");
	new
	    Float:X,
	    Float:Y,
	    Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    LinkVehicleToInterior(car, GetPlayerInterior(playerid));
    SetVehicleVirtualWorld(car, GetPlayerVirtualWorld(playerid));
    SetVehiclePos(car, X - 4, Y, Z + 1);
    SCMF(playerid, COLOR_LIGHTBLUE, "Jus teleportavote automobili pas save, index: %d", car);
    f(global_str, 128, "[%s] Teleportavo automobili pas save, index: %d", PN(playerid), car);
	SendAdminsMessage(COLOR_GREY, global_str);
	return 1;
}
CMD:gethere(playerid, params[])
{
	new
		Float:X,
		Float:Z,
		Float:Y,
		Float:A;
    extract params -> new player:id; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gethere [id]");
	if PI[id][pBlockTP] && !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {ffffff}Sis asmuo isjunge teleportavima pas save.");
	else if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	if(id == INVALID_PLAYER_ID) return 0;
    GetPlayerPos(playerid,X,Y,Z);
    GetPlayerFacingAngle(playerid, A);
    ShiftCords(0, X, Y, A, 3.0);
	if GetPlayerInterior(playerid) == 104 && 101 <= GetPlayerVirtualWorld(playerid) <= 110 *then
	    SkladEntered[id] = GetPlayerVirtualWorld(playerid)-100;
	else
	    SkladEntered[id] = 0;
	SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid)), SetPlayerInterior(id,GetPlayerInterior(playerid));
    if(GetPlayerState(id) != 2) UpdatePlayerPos(id, X, Y, Z);
    else SetVehiclePos(GetPlayerVehicleID(id), X, Y, Z);
    BizEntered[id] = BizEntered[playerid];
    HouseEntered[id] = HouseEntered[playerid];
    ParkingEntered[id] = ParkingEntered[playerid];
	SCMF(id, COLOR_LIGHTBLUE, "Jus teleportavo administratorius %s",PN(playerid));
    SCMF(playerid, COLOR_LIGHTBLUE, "Jus teleportavote pas save zaideja %s",PN(id));
	if(!IsAOwner(playerid))
	{
		f(global_str, 128,"[%s] Teleportavo pas save zaideja %s[%d]",PN(playerid),PN(id),id);
		SendAdminsMessage(COLOR_GREY, global_str);
	}
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> teleportavo pas save zaideja <a href=../pages/user?name=%s>%s</a>.", 5, PN(playerid), PN(id), PN(playerid), PN(playerid), PN(id), PN(id));
}
CMD:getwarn(playerid, params[])
{
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /getwarn [id]");
    f(global_str,300,"Zaidejas: %s\n___________________\n\n\nArestine: %d\nDemorganas: %d\nMUTE: %d\nWARN: %d\n\n___________________",PN(params[0]),PI[params[0]][pJailTime],PI[params[0]][pDemorgan],PI[params[0]][pMuteTime],PI[params[0]][pWarns]);
    SPD(playerid,0,0,!"",global_str, !"Uzdaryti","");
	return 1;
}
CMD:spcar(playerid, params[])
{
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /spcar [id]");
	f(global_str, 90,"[A] %s[%d] uzspawnino automobili ID: %d",PN(playerid),playerid,params[0]);
	SendAdminsMessage(COLOR_GREY, global_str);
	SetVehicleToRespawn(params[0]);
	return 1;
}
CMD:iwep(playerid, params[])
{
	extract params -> new player:target; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /iwep [id]");
	global_str = "Siuo metu zaidejas turi si ginkla, kuri jis gavo be jokiu sukciavimu:\n\n";
    for(new i = 0; i < 13; i++)
	{
	    if(PI[target][pGuns][i] > 0 && PI[target][pAmmos][i] > 0)
	    		f(global_str, 300,"%s\nID ginklo/soviniai - %d[%d]", global_str, PI[target][pGuns][i], PI[target][pAmmos][i]);
	}
	SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", global_str, !"Priimti", !"");
	return 1;
}
CMD:checkbiz(playerid, params[])
{
	extract params -> new bizid; else
    	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checkbiz [id]");
 	if bizid > OWNABLEBIZES *then
 		return 0;
    GetMysqlData("businesses", "opisanie", BizData[bizid][bID]);
	return SCMF(playerid, -1, "[CheckBiz ID %d] Name: %s | Savininkas: %s Pavaduotojas: %s Pinigai: %d$", bizid, mysql_string, BizData[bizid][bOwner], BizData[bizid][bZam], BizData[bizid][bMoney]);
}
CMD:houseinv(playerid, params[])
{
	if sscanf(params, "d", params[0]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /houseinv [houseid]");
	if params[0] < 0 || params[0] > OWNABLEHOUSES *then
		return false;
	new item, count;
	global_str = "Pavadinimas\tKiekis\n";
	for new i; i < 90; i++ do
	{
		item = HouseInfo[params[0]][hItem][i],
		count = HouseInfo[params[0]][hItemCount][i];
		if !count || !item *then
			continue;
		f(global_str,  sizeof global_str, "%s[%d] %s\t%d\n", global_str, i+1, ItemsInfo[item][ItemName2], count);
	}
	static head[50];
 	f(head, 50, "Spinta namo ¹%d", params[0]);
	return SPD(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, head, global_str, !"Uzdaryti", !"");
}
CMD:checkhouse(playerid, params[])
{
    extract params -> new houseid; else
    	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checkhouse [id]");
 	if houseid > OWNABLEHOUSES *then
 		return 0;
    GetMysqlData("houses", "Name", HouseInfo[houseid][hID]);
	if !GetString(mysql_string, "The State") *then return SCMF(playerid, -1, "[CheckHouse ID %d] Name: %s | Savininkas: %s Pinigai: %d$", houseid, mysql_string, HouseInfo[houseid][hOwner], HouseInfo[houseid][hMoney]);
	else return SCMF(playerid, -1, "[CheckHouse ID %d] Name: Nera | Savininkas: %s Pinigai: %d$", houseid, HouseInfo[houseid][hOwner], HouseInfo[houseid][hMoney]);
}
CMD:gotocar(playerid, params[])
{
    if sscanf(params, "d", params[0]) *then
    	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gotocar [id]");
	new
		Float:x,
		Float:y,
		Float:z;
	GetVehiclePos(params[0], x, y, z);
	UpdatePlayerPos(playerid, x, y, z);
	SetPlayerInterior(params[0], 0);
	SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(params[0]));
	return 1;
}
CMD:gototrailer(playerid, params[])
{
	extract params -> new trailer; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gototrailer [id]");
	if trailer > OWNABLETRAILERS *then
		return false;
	SetPlayerVirtualWorld(playerid, 0), SetPlayerInterior(playerid, 0);
	UpdatePlayerPos(playerid, TrailerInfo[trailer][tPos_X], TrailerInfo[trailer][tPos_Y], TrailerInfo[trailer][tPos_Z]);
	return SCMF(playerid, -1, "Jus teleportavotes prie priekabos ID:%d", trailer);
}
CMD:gotobiz(playerid, params[])
{
	extract params -> new bizid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gotobiz [id]");
	if bizid > OWNABLEBIZES *then
	    return 0;
	SetPlayerVirtualWorld(playerid, 0), SetPlayerInterior(playerid, 0);
	UpdatePlayerPos(playerid, BizData[bizid][bEnter_X], BizData[bizid][bEnter_Y], BizData[bizid][bEnter_Z]);
	return SCMF(playerid, -1, "Jus teleportavotes prie verslo ID:%d", bizid);
}
CMD:gotohouse(playerid, params[])
{
	extract params -> new houseid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gotohouse [id]");
	if houseid > OWNABLEHOUSES *then
	    return 0;
	SetPlayerVirtualWorld(playerid, 0), SetPlayerInterior(playerid, 0);
	UpdatePlayerPos(playerid, HouseInfo[houseid][hEnter_X], HouseInfo[houseid][hEnter_Y], HouseInfo[houseid][hEnter_Z]);
	return SCMF(playerid, -1, "Jus teleportavotes prie namo ID:%d", houseid);
}
CMD:gotoint(playerid, params[])
{
	extract params -> new int; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gotoint [id]");
	return WarpToInterior(playerid, int);
}
CMD:az(playerid, params[])
{
	if !sscanf(params, "u", params[0]) *then
		WarpToInterior(params[0], GLS[65]),
		SCMF(params[0], COLOR_LIGHTBLUE, "À: %s[%d] teleportavo jus i pokalbi.", PN(playerid), playerid);
	return WarpToInterior(playerid, GLS[65]);
}
CMD:changeadminint(playerid, params[])
{
	if(sscanf(params, "d", params[0]))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /changeadminint [id (0-145)]");
    if !(0 <= params[0] <= 145) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /changeadminint [id (0-145)]");
	GLS[65] = params[0];
	global_str = "";
	SaveInformation();
	f(global_str, 128, "[ADMIN]{FFFFFF} %s pakeite admin-zona!", PN(playerid));
	return SendAdminsMessage(COLOR_RED, global_str);
}
CMD:goto(playerid, params[])
{
	extract params -> new player:target; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /goto [id]");
	if(target == INVALID_PLAYER_ID)
	    return 1;
	if PI[target][pBlockTP] && !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {ffffff}Sis asmuo isjunge teleportavima pas save.");
	if(IsAOwner(target)) return 0;
    if(SERIU[target][sID] != INVALID_PLAYER_ID && !IsPlayerNPC(target))
		return SCM(playerid, COLOR_RED, !"Administratorius kazka stebi!");
	if GetPlayerInterior(target) == 104 *then return false;
	new
		Float:X,
		Float:Z,
		Float:Y;
    GetPlayerPos(target, X, Y, Z);
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(target)), SetPlayerInterior(playerid, GetPlayerInterior(target));
  	if GetPlayerInterior(target) == 104 && 101 <= GetPlayerVirtualWorld(target) <= 110 *then
	    SkladEntered[playerid] = GetPlayerVirtualWorld(target)-100;
	else
	    SkladEntered[playerid] = 0;
    if(GetPlayerState(playerid) != 2) UpdatePlayerPos(playerid, X+2, Y+2, Z);
    else SetVehiclePos(GetPlayerVehicleID(playerid), X+2, Y+2, Z);
    BizEntered[playerid] = BizEntered[target];
    HouseEntered[playerid] = HouseEntered[target];
    SCMF(playerid, -1, "Jus teleportavotes prie zaidejo %s", PN(target));
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> tp prie zaidejo <a href=../pages/user?name=%s>%s</a>", 5, PN(playerid), PN(target), PN(playerid), PN(playerid), PN(target), PN(target));
	return 1;
}
alias:goto("g");
CMD:kick(playerid, params[])
{
    new id, reason[30];
    if(sscanf(params,"us[30]",id,reason)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /kick [id] [Priezastis]");
    if(strlen(reason) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
    if(IsAIP(reason))return 1;
    if(PI[playerid][pAdmin]<PI[id][pAdmin]) PI[playerid][pAdmin]=0;
    if(PI[playerid][pAdmin]==PI[id][pAdmin]) PI[playerid][pAdmin]=0;
	if(id == playerid) return SCM(playerid, COLOR_RED, !"Negalima ismesti paties saves");
	f(global_str, 145," À: %s[%d] ismete zaideja %s[%d]. Priezastis: %s",PN(playerid),playerid,PN(id),id,reason);
    ASCMALL(COLOR_RED,global_str);
	ANL(PN(id), global_str);
    J_Kick(id);
	Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
	f(global_str, 256, "Administratorius <a href=../pages/user?name=%s>%s</a> ismete zaideja <a href=../pages/user?name=%s>%s</a> Priezastis: %s",
	PN(playerid), PN(playerid), PN(id), PN(id), reason);
	aml(global_str, 5, PN(playerid),PN(id));
	return 1;
}
CMD:smute(playerid, params[])
{
	if(sscanf(params, "uds[30]", params[0], params[1], params[2])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /smute [id] [laikas] [priezastis]");
	if(strlen(params[2]) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
	if(params[0] == INVALID_PLAYER_ID) return 0;
	if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
    if(IsAIP(params[2])) return 1;
 	if(params[1] < 1) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /mute [id] [laikas > 1] [priezastis]");
 	if(strlen(params[2]) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
 	if(params[1] > 300) return SCM(playerid, COLOR_RED, !"Negalima duoti MUTE ilgiau kaip 300 minuciu!");
 	if(PI[params[0]][pMuteTime] > 0) return SCM(playerid, COLOR_RED, !"Sis zaidejas jau turi MUTE!");
	f(global_str, 144, " À: %s[%d] tyliai isdave MUTE zaidejui %s[%d] %d minuciu. Priezastis: %s", PN(playerid), playerid, PN(params[0]), params[0], params[1], params[2]);
	SendAdminsMessage(COLOR_RED, global_str);
	SPD(params[0], 0, DIALOG_STYLE_MSGBOX, !"", !"Jus gavote MUTE. Jei nesutinkate su Administratoriaus sprendimu, parasykite skunda forume, pridedami sia ekrano nuotrauka.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
	PI[params[0]][pMuteTime] = params[1] * 60;
	return 1;
}
CMD:mute(playerid, params[])
{
	if(sscanf(params, "uds[30]", params[0], params[1], params[2])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /mute [id] [laikas] [priezastis]");
	if(strlen(params[2]) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
	if(params[0] == INVALID_PLAYER_ID) return 0;
	if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
    if(IsAIP(params[2])) return 1;
 	if(params[1] < 1) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /mute [id] [laikas > 1] [priezastis]");
 	if(strlen(params[2]) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
 	if(params[1] > 300) return SCM(playerid, COLOR_RED, !"Negalima duoti MUTE ilgiau kaip 300 minuciu!");
 	if(PI[params[0]][pMuteTime] > 0) return SCM(playerid, COLOR_RED, !"Sis zaidejas jau turi MUTE!");
	f(global_str, 144, " À: %s[%d] isdave MUTE zaidejui %s[%d] %d minuciu. Priezastis: %s", PN(playerid), playerid, PN(params[0]), params[0], params[1], params[2]);
	ASCMALL(COLOR_RED, global_str);
	ANL(PN(params[0]), global_str);
	f(global_str, 256, "Administratorius <a href=../pages/user?name=%s>%s</a> isdave MUTE zaidejui <a href=../pages/user?name=%s>%s</a> %d minuciu. Priezastis: %s",
	PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), params[1], params[2]);
	aml(global_str, 5, PN(playerid), PN(params[0]));
	SPD(params[0], 0, DIALOG_STYLE_MSGBOX, !"", !"Jus gavote MUTE. Jei nesutinkate su Administratoriaus sprendimu, parasykite skunda forume, pridedami sia ekrano nuotrauka.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
	PI[params[0]][pMuteTime] = params[1]*60/(PI[params[0]][pVIP] == 10 ? 2:1);
	if(QuestProgress[playerid][16] >= 25) NextStapQI(playerid, 16);
	if(AcceptQuest[playerid][16]!=0) QuestProgress[playerid][16]++;
	return 1;
}
CMD:rmute(playerid, params[])
{
	if sscanf(params, "uds[30]", params[0], params[1], params[2]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /rmute [id] [laikas] [priezastis]");
	else if strlen(params[2]) > 30 *then
		 return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
	else if params[0] == INVALID_PLAYER_ID *then
		return false;
	else if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
 	else if !(1 <= params[1] <= 300) *then
	  	return SCM(playerid, COLOR_RED, !"Negalima duoti reporto MUTE ilgiau kaip 300 minuciu ir trumpiau kaip minute!");
 	else if PI[params[0]][pRMuteTime] > 0 *then
	 	return SCM(playerid, COLOR_RED, !"Sis zaidejas jau turi reporto MUTE!");
	f(global_str, 144, " À: %s[%d] uzblokavo reporta zaidejui %s[%d] %d minuciu. Priezastis: %s", PN(playerid), playerid, PN(params[0]), params[0], params[1], params[2]);
	ASCMALL(COLOR_RED, global_str);
	ANL(PN(params[0]), global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> uzblokavo reporta zaidejui <a href=../pages/user?name=%s>%s</a> %d minuciu. Priezastis: %s", 5, PN(playerid), PN(params[0]), PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), params[1], params[2]);
	SPD(params[0], 0, DIALOG_STYLE_MSGBOX, !"", !"Jums buvo uzblokuota prieiga prie reporto. Jei nesutinkate su Administratoriaus sprendimu, parasykite skunda forume, pridedami sia ekrano nuotrauka.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
	return UpdatePlayerDataInt(params[0], "rMuteTime", PI[params[0]][pRMuteTime] = params[1] * 60);
}
CMD:unrmute(playerid, params[])
{
	if sscanf(params, "us[150]", params[0], params[1]) *then
		 return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unrmute [id] [reason]");
	else if params[0] == INVALID_PLAYER_ID *then
		return false;
	if !PI[params[0]][pRMuteTime] *then
		return SCM(playerid, COLOR_RED, !"Zaidejas neturi reporto MUTE!");
	f(global_str, 144, " À: %s panaikino reporto MUTE nuo zaidejo %s, priezastis: %s", PN(playerid), PN(params[0]), params[1]);
	ASCMALL(COLOR_RED, global_str);
	ANL(PN(params[0]), global_str);
	PI[params[0]][pRMuteTime] = 0;
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> panaikino reporto MUTE nuo zaidejo <a href=../pages/user?name=%s>%s</a>. Priezastis: %s", 5, PN(playerid), PN(params[0]), PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), params[1]);
}
CMD:sban(playerid, params[])
{
	new id, days, reason[30];
    if(sscanf(params, "uds[30]", id, days, reason)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sban [id] [days 1-30] [Priezastis]");
	if(id == INVALID_PLAYER_ID) return 0;
	if(strlen(reason) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
 	if(IsAIP(reason)) return 1;
	if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	if id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	if(!(1 <= days <= 30)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sban [id] [days 1-30] [Priezastis]");
    f(global_str, 145, "A: %s[%d] tyliai uzblokavo zaideja %s[%d] %d dienu. Priezastis: %s", PN(playerid), playerid, PN(id), id, days, reason);
    SendAdminsMessage(COLOR_RED, global_str);
	SPD(id, 0, DIALOG_STYLE_MSGBOX, !"", !"Jusu paskyra buvo uzblokuota, jei nesutinkate su Administratoriaus sprendimu, parasykite skunda, pridedami sia ekrano nuotrauka.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
    PI[id][pWarns] = 0;
    J_Kick(id);
    BanName(PN(id), PN(playerid), days, reason);
	Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
	return 1;
}
CMD:fakesms(playerid, data[])
{
	if(sscanf(data, "us[144]", data[0], data[1]))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /fakesms [id/name] [text]");
	if(data[0] == INVALID_PLAYER_ID)
		return 0;
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> parase pranesima zaidejui <a href=../pages/user?name=%s>%s</a> | %s", 5, PN(playerid),PN(data[0]), PN(playerid), PN(playerid), PN(data[0]), PN(data[0]), data[1]);
	SCMF(playerid, COLOR_RED, "[FAKESMS] Veiksmas %s atliktas.", data[1]);
	return SCM(data[0], COLOR_RED, data[1]);
}
CMD:ban(playerid, data[])
{
    new id, days, reason[30];
    if sscanf(data, "uds[30]", id, days, reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /ban [id] [days 1-30] [Priezastisp]");
  	else if IsAOwner(id) && !IsAOwner(playerid) *then
		return CheckAntiSliv(playerid);
	else if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	if id == INVALID_PLAYER_ID *then
		return 0;
	if strlen(reason) > 30 *then
		return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
 	if IsAIP(reason) *then
	 	return 1;
	if !(1 <= days <= 30) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /ban [id] [days 1-30] [Priezastis]");
	if(QuestProgress[playerid][19] >= 25) NextStapQI(playerid, 19);
	if(AcceptQuest[playerid][19]!=0) QuestProgress[playerid][19]++;
    f(global_str, 145, "A: %s[%d] uzblokavo zaideja %s[%d] %d dienu. Priezastis: %s", PN(playerid), playerid, PN(id), id, days, reason);
    ASCMALL(COLOR_RED, global_str);
	ANL(PN(id), global_str);
	SPD(id, 0, DIALOG_STYLE_MSGBOX, !"", !"Jusu paskyra buvo uzblokuota, jei nesutinkate su Administratoriaus sprendimu, parasykite skunda, pridedami sia ekrano nuotrauka.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
    PI[id][pWarns] = 0;
    BanName(PN(id), PN(playerid), days, reason);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> uzblokavo zaideja <a href=../pages/user?name=%s>%s</a> %d dienu. Priezastis: %s", 5, PN(playerid), PN(id), PN(playerid), PN(playerid), PN(id), PN(id), days, reason);
    J_Kick(id);
	Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
	return 1;
}
CMD:banip(playerid, params[])
{
    new id, reason[30];
    if(sscanf(params, "us[30]", id, reason)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /banip [id] [Priezastis]");
	if(id == INVALID_PLAYER_ID) return 0;
 	if(IsAIP(reason)) return 1;
  	if IsAOwner(id) && !IsAOwner(playerid) *then
		return CheckAntiSliv(playerid);
	else if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
    f(global_str, 150, " A: %s[%d] uzblokavo zaideja %s[%d]. Priezastis: %s", PN(playerid), playerid, PN(id), id, reason);
    ASCMALL(COLOR_RED, global_str);
	ANL(PN(id), global_str);
    f(global_str, 145, "Uzblokuotas: %s. IP: %s. REGIP: %s", PN(id), PlayerIP(id), PlayerRegIP[id]);
    SCM(playerid, 0xEFEFF7AA, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> uzblokavo zaideja <a href=../pages/user?name=%s>%s</a> pagal IP. Priezastis: %s", 5, PN(playerid),PN(id), PN(playerid), PN(playerid), PN(id), PN(id), reason);
	PI[id][pWarns] = 0;
    BanIP(PlayerIP(id));
    BanName(PN(id), PN(playerid), 2000, reason);
    J_Kick(id);
	Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
	return 1;
}
CMD:banipoff(playerid, params[])
{
    static ip[16];
    if(sscanf(params,"s[16]s[30]",ip,params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /banipoff [IP] [Priezastis]");
    if(strlen(params[0]) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
    if(IsAIP(params[0]))return 1;
    f(global_str,145," A: %s uzblokavo IP %s. Priezastis: %s",PN(playerid),ip, params[0]);
    SendAdminsMessage(COLOR_RED,global_str);
    BanIP(ip);
	return 1;
}
CMD:sbanoff(playerid, params[])
{
    new day; static name[24], reason[30];
    if(sscanf(params,"s[24]ds[30]",name,day, reason)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sbanoff [name] [dienu] [Priezastis]");
    if(strlen(reason) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
	if(day <1 && 30<day) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sbanoff [name] [dienu] [Priezastis]");
    if(IsAIP(reason))return 1;
 	new player = GetPlayerID(name);
    if(player != INVALID_PLAYER_ID) return SCM(playerid,COLOR_RED,!"JIS PRISIJUNGES!");
    f(global_str, 145," A: %s tyliai uzblokavo offline zaideja %s. Priezastis: %s",PN(playerid),name,reason);
    SendAdminsMessage(COLOR_RED,global_str);
	return BanName(name, PN(playerid), day, reason);
}
CMD:unbanip(playerid, data[])
{
	extract data -> new string:ip[16]; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unbanip [ip]");
	SQL("DELETE FROM `banip` WHERE `IP` = '%s'", ip);
    f(global_str, 70, "[A] %s[%d] atblokavo IP: %s", PN(playerid), playerid, ip);
	return SendAdminsMessage(COLOR_RED, global_str);
}
CMD:swarn(playerid, params[])
{
    new
		reason[30];
    if(sscanf(params, "us[30]", params[0], reason)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /swarn [id] [Priezastis]");
    if(params[0] == INVALID_PLAYER_ID) return 0;
    if(IsAIP(reason)) return 1;
    if(strlen(reason) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
	if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	UnInvite(params[0]);
	PlayerUnleader(params[0], PN(params[0]));
    PI[params[0]][pTimeToLastWarn] = Global_Time;
	PI[params[0]][pWarns] ++;
    f(global_str, 145, "A: %s[%d] tyliai isdave WARN zaidejui %s[%d] [%d/3] Priezastis: %s", PN(playerid), playerid, PN(params[0]), params[0], PI[params[0]][pWarns], reason);
    ASCMALL(COLOR_RED, global_str);
	SPD(params[0], 0, DIALOG_STYLE_MSGBOX, !"", !"Jus gavote WARN, jei nesutinkate su Administratoriaus sprendimu, parasykite skunda forume, pridedami sia ekrano nuotrauka.\nWARN galima pasalinti naudojant /donate.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
	if PI[params[0]][pWarns] > 2 *then
	{
	    PI[params[0]][pWarns] = 0;
		BanName(PN(params[0]), PN(playerid), 10, reason);
	}
	J_Kick(params[0]);
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
CMD:warn(playerid, params[])
{
    new reason[30];
	if(sscanf(params, "us[30]", params[0], reason)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /warn [id] [reason]");
    if params[0] == INVALID_PLAYER_ID *then return 0;
  	else if IsAOwner(params[0]) && !IsAOwner(playerid) *then
		return CheckAntiSliv(playerid);
    if(IsAIP(reason)) return 1;
    if(strlen(reason) > 30) return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
	if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	UnInvite(params[0]);
	PlayerUnleader(params[0], PN(params[0]));
    PI[params[0]][pTimeToLastWarn] = Global_Time;
	PI[params[0]][pWarns] ++;
    f(global_str, 150, "A: %s[%d] isdave WARN zaidejui %s[%d] [%d/3] Priezastis: %s", PN(playerid), playerid, PN(params[0]), params[0], PI[params[0]][pWarns], reason);
    ASCMALL(COLOR_RED, global_str);
	ANL(PN(params[0]), global_str);
	f(global_str, 256, "Administratorius <a href=../pages/user?name=%s>%s</a> isdave WARN zaidejui <a href=../pages/user?name=%s>%s</a> [%d/3] Priezastis: %s",
	PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), PI[params[0]][pWarns], reason);
	aml(global_str, 5, "","");
	SPD(params[0], 0, DIALOG_STYLE_MSGBOX, !"", !"Jus gavote WARN, jei nesutinkate su Administratoriaus sprendimu, parasykite skunda forume, pridedami sia ekrano nuotrauka.\nWARN galima pasalinti naudojant /donate.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
	if(QuestProgress[playerid][18] >= 25) NextStapQI(playerid, 18);
	if(AcceptQuest[playerid][18]!=0) QuestProgress[playerid][18]++;
	if PI[params[0]][pWarns] > 2 *then
	{
	    PI[params[0]][pWarns] = 0;
		BanName(PN(params[0]), PN(playerid), 10, reason);
	}
    J_Kick(params[0]);
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
CMD:awarnoff(playerid, params[])
{
	if sscanf(params, "s[24]s[30]", mysql_string, params[1]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /awarnoff [name] [reason]");
	f(global_str, 150, "SELECT `Admin`, `AWarns` FROM `accounts` WHERE `NickName` = BINARY('%s')", mysql_string);
	new Cache:result = mysql_query(mysql, global_str);
	if !cache_get_row_count() *then return
		cache_delete(result, mysql);
	new
		admin = cache_get_row_int(0, 0, mysql),
		awarns = cache_get_row_int(0, 1, mysql);
	cache_delete(result, mysql);
	if !admin *then return SCM(playerid, COLOR_GREY, "Sis zaidejas nera administratorius");
	if admin > PI[playerid][pAdmin] *then
	    return false;
	mysql_format(mysql, global_str, 256, "UPDATE `accounts` SET `AWarns` = `AWarns` + 1 WHERE `NickName` = BINARY('%s') LIMIT 1", mysql_string);
	mysql_tquery(mysql, global_str);
	awarns++;
	f(global_str, 145, "A: %s isdave ispejima offline administratoriui %s. Priezastis: %s. [%d/3]", PN(playerid), mysql_string, params[1], awarns);
	SendAdminsMessage(COLOR_RED, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave ispejima administratoriui <a href=../pages/user?name=%s>%s</a> [%d/3]. Priezastis: %s", 5, PN(playerid),mysql_string, PN(playerid), PN(playerid), mysql_string, mysql_string, awarns, params[1]);
	if awarns >= 3 *then
	{
		mysql_format(mysql, global_str, 150, "DELETE FROM admin WHERE name = '%s'", mysql_string);
		mysql_tquery(mysql, global_str);
		mysql_format(mysql, global_str, 150, "UPDATE `accounts` SET `Admin` = '0', `AWarns` = '0' WHERE `NickName` = BINARY('%s')", mysql_string);
		mysql_tquery(mysql, global_str);
	}
	return false;
}
CMD:awarn(playerid, params[])
{
    new reason[30];
    if sscanf(params, "us[30]", params[0], reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /awarn [id] [Priezastis]");
	else if !IsPlayerOnline(params[0]) *then
		return false;
  	else if IsAOwner(params[0]) && !IsAOwner(playerid) *then
		return CheckAntiSliv(playerid);
  	else if !PI[params[0]][pAdmin] *then
  		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas nera administratorius!");
    else if strlen(reason) > 30 *then
		return SCM(playerid, COLOR_RED, !"Ne daugiau nei 30 simboliu!");
	else if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	PI[params[0]][pAWarns] ++;
    f(global_str, 145, "A: %s[%d] isdave ispejima administratoriui %s[%d] [%d/3] Priezastis: %s", PN(playerid), playerid, PN(params[0]), params[0], PI[params[0]][pAWarns], reason);
    SendAdminsMessage(COLOR_RED, global_str);
	f(global_str, 350, "Administratorius <a href=../pages/user?name=%s>%s</a> isdave ispejima administratoriui <a href=../pages/user?name=%s>%s</a> [%d/3]. Priezastis: %s",
	PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), PI[params[0]][pAWarns], reason);
	aml(global_str, 5, "","");
	SPDF(params[0], 0, DIALOG_STYLE_MSGBOX, !"Awarn`S", "{FF0033}[AWarn] %s[%d] jums isdave administracini ispejima! Priezastis: %s", !"Uzdaryti", !"", PN(playerid),playerid, reason);
	if PI[params[0]][pAWarns] > 2 *then
	{
		PI[params[0]][pAWarns]=
		PI[params[0]][pAdmin] = 0;
		SCM(params[0], COLOR_RED, !"[Informacija]{FFFFFF} Jus buvote nusalintas nuo administratoriaus pareigu!");
		mysql_format(mysql, global_str, 150, "DELETE FROM admin WHERE name = '%s'", PN(params[0]));
		mysql_tquery(mysql, global_str, "", "");
		J_Kick(params[0]);
	}
	return true;
}
CMD:unawarn(playerid, params[])
{
	if sscanf(params, "u", params[0]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unawarn [id/name]");
	else if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	if !PI[params[0]][pAWarns] *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jis neturi ispejimu!");
	if playerid == params[0] *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {ffffff}Negalima pasalinti ispejimo sau paciam.");
	f(global_str, 106, "A: %s pasalino 1 ispejima nuo administratoriaus %s", PN(playerid), PN(params[0]));
	SendAdminsMessage(COLOR_YELLOW, global_str);
	SCM(params[0], COLOR_GREEN, !"[Informacija] {FFFFFF}Administratorius pasalino jums 1 ispejima!");
	PI[params[0]][pAWarns] -- ;
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pasalino administracini ispejima <a href=../pages/user?name=%s>%s</a> %d/3.", 5, PN(playerid), PN(params[0]), PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), PI[params[0]][pAWarns]);
}
CMD:givelicense(playerid, params[])
{
	if(PI[playerid][pAdmin] < 4 && GetTeamID(playerid) != TEAM_LICENSERS) return SCM(playerid, COLOR_GREY, !"Prieiga uzdrausta!");
	new id;
    if(sscanf(params, "u", id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /givelicense [id]");
    if(!ProxDetectorS(10, playerid, id)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo.");
    if(!IsPlayerConnected(id) || !IsPlayerLogged{id}) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Zaidejas neprisijunges!");
    if(!TeamDuty{playerid}) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate budejime!");
    if(id == playerid && PI[playerid][pAdmin] == 0) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus negalite isduoti licenciju sau paciam!");
    if(PI[playerid][pAdmin] == 0 && !IsPlayerInRangeOfPoint(playerid, 70, -2584.6873,-1381.9734,1500.7570)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Licencijas galima parduoti tik vairavimo mokykloje!");
	PanelPlayerID[playerid] = id;
	PanelPlayerID[id] = playerid;
	new rank = PI[playerid][pRank];
	if(rank >= 3)
	{
        SPD(playerid, 6, DIALOG_STYLE_TABLIST_HEADERS, !"Pasirinkite licencija", !"Licencija\tKaina\t\n\
			Automobilio vairavimo\t{52A32A}1000${FFFFFF}\n\
			Motociklo vairavimo\t{52A32A}2000${FFFFFF}\n\
			Skraidymo\t{52A32A}\n\
			{FFFFFF}Zvejybai\t{52A32A}1000${FFFFFF}\n\
			Vandens transporto vairavimo\t{52A32A}5000${FFFFFF}\n\
			Ginklams\t{52A32A}10000${FFFFFF}", !"Isduoti", !"Atsaukti");
	}
	else
	{
	    if(GetTeamID(playerid) == TEAM_LICENSERS) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jusu rangas per mazas");
	    SPD(playerid, 6, DIALOG_STYLE_TABLIST_HEADERS, !"Pasirinkite licencija", !"Licencija\tKaina\t\n\
			Automobilio vairavimo\t{52A32A}1000${FFFFFF}\n\
			Motociklo vairavimo\t{52A32A}2000${FFFFFF}", !"Isduoti", !"Atsaukti");
	}
	return 1;
}
alias:recon("re", "spec");
CMD:recon(id, params[])
{
	if IsPlayerInAnyVehicle(id) *then
		return SCM(id, COLOR_WHITE, !"Is transporto stebeti negalima!");
	else if sscanf(params, "u", params[0]) *then
		return SCM(id, COLOR_OLDRED, !"Iveskite: /re [zaidejo ID]");
 	if params[0] == INVALID_PLAYER_ID *then
		return SCM(id, COLOR_OLDRED, !"[Klaida] {FFFFFF}Zaidejas nerastas!");
  	if IsAOwner(params[0]) *then
		return SPD(id, 0, DIALOG_STYLE_MSGBOX, !"", !"{ff0000}Sis zaidejas yra {FFFFFF}Kurejas\n{FFFFFF}Jus negalite stebeti sio zaidejo!\n\nJei tesite bandyma stebeti si zaideja,{FFFFFF} sistema jus pasalins!", !"Uzdaryti", !"");
 	AdminInfo[id][admMember] = PI[id][pMember];
	AdminInfo[id][admMemberRank] = PI[id][pRank];
	AdminInfo[id][admWorld] = GetPlayerVirtualWorld(id);
	AdminInfo[id][admInterior] = GetPlayerInterior(id);
	GetPlayerPos(id, AdminInfo[id][admPos][0], AdminInfo[id][admPos][1], AdminInfo[id][admPos][2]);
	Vnedren[id] = PI[params[0]][pMember];
	SpecPlayer(id, params[0]);
	CheckLauncher(id, params[0]);
    return ShowRecon(id);
}
CMD:skick(playerid, params[])
{
	new targetid;
    if(sscanf(params, "u", targetid))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /skick [id]");
    if(targetid == INVALID_PLAYER_ID)
		return 1;
	if(targetid == playerid)
		return SCM(playerid, COLOR_RED, !"Negalima ismesti paties saves");
	if PI[playerid][pAdmin] < PI[targetid][pAdmin] *then
		return CheckAntiSliv(playerid);
	if targetid != playerid && PI[playerid][pAdmin] == PI[targetid][pAdmin] *then
		return CheckAntiSliv(playerid);
    f(global_str, 128, "[A] %s[%d] tyliai ismete zaideja %s [ID:%d]", PN(playerid), playerid, PN(targetid), targetid);
	SendAdminsMessage(COLOR_YELLOW, global_str);
    J_Kick(targetid);
	Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
	return 1;
}
CMD:getip(playerid, params[])
{
	new targetid;
    if sscanf(params, "u", targetid) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Iveskite: /getip [id]");
    if targetid == INVALID_PLAYER_ID *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas nerastas!");
	return SCMF(playerid, 0x6ab1ffaa, "Nick [%s]  R-IP [%s]  IP | A-IP [{6AFF99}%s | %s {6ab1ff}]", PN(targetid), PlayerRegIP[targetid], PlayerIp[targetid], PlayerIp[targetid]);
}
CMD:setstat(playerid, data[])
{
	new name_params[110];
    if !IsAOwner(playerid) *then
		return false;
    if sscanf(data, "udd", data[0], data[1], data[2]) *then
	{
		SCM(playerid, -1, !"Naudokite: /setstat [id] [kodas] [reiksme]");
		SCM(playerid, -1, !"[0] Lygis | [1] EXP | [2] Lytis | [3] VIP | [4] Telefono numeris | [5] Darbas");
		SCM(playerid, -1, !"[6] Banko saskaita (BTC) | [7] SAG-Coins saskaita | [8] Ukio taskai | [9] Spawnas[0/3] | [10] SAG-Eur");
		SCM(playerid, -1, !"[11] VIP papildymas | [12] Grynieji | [13] Bilietai | [14] Asmenine banko saskaita ($) | [15] Member Bonus");
		return 1;
	}
	switch data[1] do
	{
	    case 0: J_SetPlayerScore(data[0], data[2]), SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) lygi i %d", PN(data[0]), data[0], data[2]);
	    case 1:
	    {
	        PI[data[0]][pExp] = data[2];
			SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) EXP i %d", PN(data[0]), data[0], data[2]);
   			CheckNextLevel(data[0]);
			name_params = "EXP";
	    }
	    case 2: PI[data[0]][pSex] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) lyti i %d", PN(data[0]), data[0], data[2]);
	    case 3:
	    {
	        PI[data[0]][pVIP] = data[2];
	        PI[data[0]][pVipTime] = Global_Time+(30*24*60*60);
			SCMF(playerid, -1, "Jus pakeitete zaidejo %s(%d) VIP statusa i %d", PN(data[0]), data[0], data[2]);
			name_params = "VIP";
	    }
	    case 4: PI[data[0]][pTelNum] = data[2], SCMF(playerid,-1, "Jus pakeitete telefono numeri %s(%d) i %d", PN(data[0]), data[0], data[2]);
	    case 5:
	    {
			SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) darba i %d", PN(data[0]), data[0], data[2]);
			PlayerJob[data[0]] = data[2];
			name_params = "Darba";
	    }
	    case 6: PI[data[0]][pBank] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) banko saskaita %d BTC", PN(data[0]), data[0], data[2]), name_params = "Banko saskaita";
	    case 7: PI[data[0]][pVirMoney] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) SAG-Coins i %d", PN(data[0]), data[0], data[2]), name_params = "SAG-Coins";
	    case 8: PI[data[0]][pContractTime] = data[2], SCMF(playerid, -1, "Jus pakeitete zaidejo %s(%d) ukininko taskus i %d", PN(data[0]), data[0], data[2]), name_params = "Ukininko taskai";
	    case 9:
	    {
	        if data[2] > 2 || data[2] < 0 *then
				return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Data turi buti diapazone data[2] > 2 || data[2] < 0");
			SCMF(playerid,-1, "Jus nustatete nauja zaidejo %s(%d) spawna i %d", PN(data[0]), data[0], data[2]);
			PI[data[0]][pDCTime] = data[2];
			name_params = "Spawnas";
	    }
	    case 10:
			PI[data[0]][pRoubles] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) SAG-Eur saskaita i %d", PN(data[0]), data[0], data[2]), name_params = "SAG-Eur";
		case 11:
		{
		    if data[2] > 1 || data[2] < 0 *then
				return SCM(playerid, COLOR_OLDRED, !"[Klaida] {ffffff}Data turi buti diapazone data[2] > 1 || data[2] < 0");
			PI[data[0]][pAddVipInfninity] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) VIP-Papildyma i %d", PN(data[0]), data[0], data[2]);
			name_params = "ADD-VIP";
		}
		case 12:
		{
		    if data[2] > 2000000000 || data[2] < 0 *then
				return SCM(playerid, COLOR_OLDRED, !"[Klaida] {ffffff}Negalima nustatyti grynuju pinigu maziau nei 0$ ir daugiau nei 2.000.000.000$");
			PI[data[0]][pMoney] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) grynuosius pinigus i %d$", PN(data[0]), data[0], data[2]);
			SetPlayerMoney(data[0], data[2]);
			name_params = "Pinigai";
		}
		case 13:
		{
		    if data[2] > 1000000 || data[2] < 0 *then
				return SCM(playerid, COLOR_OLDRED, !"[Klaida] {ffffff}Negalima nustatyti zaidimo bilietu maziau nei 0 ir daugiau nei 1.000.000");
			PI[data[0]][pBilets] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) zaidimo bilietus i %d", PN(data[0]), data[0], data[2]);
			name_params = "Áèëåò";
		}
		case 14: PI[data[0]][pMyBank] = data[2], SCMF(playerid,-1, "Jus pakeitete zaidejo %s(%d) asm. banko saskaita i %d $", PN(data[0]), data[0], data[2]), name_params = "Asmenine banko saskaita";
		case 15: PI[data[0]][pMemberPlayHours] = data[2], SCMF(playerid,-1, "Jus pakeitete Member Hours %s(%d) i %d $", PN(data[0]), data[0], data[2]), name_params = "Member Hours";
	}
	return SaveAccount(data[0]);
}
CMD:spawn(playerid)
{
    if !(SERIU[playerid][sID] == INVALID_PLAYER_ID) *then return SCM(playerid,COLOR_GREY, !"Neprieinama! [/reoff]");
	return PlayerSpawn(playerid);
}
CMD:cc(playerid)
{
	if !CheckAdm(playerid, 4) *then
		return false;
    for(new i; i < 20; i++)
		SCMALL(-1, !" ");
	new
	    string[14 - 2 + MAX_PLAYER_NAME];
    f(string, sizeof(string), "%s Isvale chata", PN(playerid));
    SendAdminsMessage(COLOR_LIGHTBLUE, string);
	return 1;
}
CMD:jp(playerid) return SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
CMD:apanel(playerid)
{
	if(PI[playerid][pAdmin] > 9) return SCM(playerid, -1, "Virsytas administratoriaus lygio limitas!");
	if(PI[playerid][pAdmin] < 1) return SCM(playerid, -1, "Jus nesate administratorius!");
    if(GetString(PI[playerid][pAPass], "default"))
    {
        SetPVarInt(playerid, !"alogin", 1);
        return SPD(playerid, 211, DIALOG_STYLE_PASSWORD, !"Autorizacija", !"{FFFFFF}Sugalvokite ir iveskite admin slaptazodi\n\nPastaba:\n\t{FF6347}- Slaptazodis turi buti sudarytas is lotynisku raidziu ir skaiciu\n\t- Slaptazodzio ilgis gali buti nuo 6 iki 16 simboliu", !"Ivesti", !"Atsaukti");
    }
	if !ADuty{playerid} *then return
		SPD(playerid, 211, DIALOG_STYLE_PASSWORD, !"Autorizacija", !"{FFFFFF}Iveskite admin slaptazodi", !"OK", !"Atsaukti");
	f(global_str, 1700, "\
		[1] Admins\n\
		[2] Isvalyti chata\n\
		[4] Pripildyti automobilius\n\
		{ADFF2F}[2] Sutaisyti automobili\n\
		{ffffff}[3] Transporto spawnas\n\
		{D21A10}[3] BANLIST{FFFFFF}\n\
		[4] Lyderiai/pasalinti lyderi\n\
		[8] Nustatymai\n\
		[3] Namu stebejimas\n\
		[5] Baneriu stebejimas\n\
		{FAC658}[3]{FFFFFF} Teroro aktai: [%s]\n\
		{E98E52}[3]{FFFFFF} Papildyti ukio, krautuvu ir gamyklos sandeli\n\
		{E98E52}[3]{FFFFFF} Papildyti organizacijos sandeli.\n\
		{E98E52}[5]{FFFFFF} Privalomi atsakymai HELP. [%s]\n\
		{E98E52}[5]{FFFFFF} Valdymas ZZ\n\
		{E98E52}[4]{FFFFFF} Patvirtinimas E-mail [{209724}0 prasymu{FFFFFF}]\n\
		{E98E52}[6]{FFFFFF} Pakeisti serverio pavadinima\n\
		{E98E52}[5]{FFFFFF} Papildyti valstybiniu verslu produktus.\n\
		{E98E52}[1]{FFFFFF} Pinigu statistika.\n\
		{E98E52}[6]{FFFFFF} Loterijos: [%s]\n\
		{E98E52}[6]{FFFFFF} Papildyti bakomatus\n\
		{E98E52}[6]{FFFFFF} Anti-Cheat minigun: [%s]\n\
		{E98E52}[5] Auto respawn transporto: [%s]\n\
		{ffffff}[5] Reporto sistema: [%s]\n\
		{FAC658}[1]{FFFFFF} KillList [%s]\n\
		{FAC658}[1]{FFFFFF} Organizaciju Online\n\
		{FAC658}[1]{FFFFFF} IP adresai zinutese [%s]\n\
		{FAC658}[1]{FFFFFF} Kasdienes administratoriaus uzduotys\n\
		{FAC658}[4]{FFFFFF} Muzikos duomenu bazes valdymas {cccccc}(radijas, boombox)\n\
		{FAC658}[3] Sena sistema CAPTCHA: [%s]\n\
		{ffffff}[1] Statistika svarbiu vietu apsilankymo\n\
		[5] Isvalyti visas rekonstrukcijas\n\
		{9711f6}[1] Admin-parduotuve\n\
		{ff0000}VISKA ISSAUGOTI!",
		ACTIVEpanel[0] ? ("{9ACD32}Ijungti{FFFFFF}") : ("{FC5C5C}Isjungti{FFFFFF}"),
		ACTIVEpanel[2] ? ("{9ACD32}Ijungti{FFFFFF}") : ("{FC5C5C}Isjungti{FFFFFF}"),
		ACTIVEpanel[3] ? ("{9ACD32}Ijungti{FFFFFF}") : ("{FC5C5C}Isjungti{FFFFFF}"),
		ACTIVEpanel[4] ? ("{9ACD32}Ijungti{FFFFFF}") : ("{FC5C5C}Isjungti{FFFFFF}"),
		ACTIVEpanel[5] ? ("{9ACD32}Ijungti{FFFFFF}") : ("{FC5C5C}Isjungti{FFFFFF}"),
		ACTIVEpanel[6] ? ("{9ACD32}Nauja{FFFFFF}") : ("{FC5C5C}Sena{FFFFFF}"),
		ACTIVEpanel[8] ? ("{FC5C5C}IJUNGTI{FFFFFF}") : ("{9ACD32}ISJUNGTI{FFFFFF}"),
		AdminInfo[playerid][admIP] ? ("{9ACD32}ISJUNGTA{FFFFFF}") : ("{FC5C5C}IJUNGTA{FFFFFF}"),
		ACTIVEpanel[7] ? ("{9ACD32}Ijungti{FFFFFF}") : ("{FC5C5C}Isjungti{FFFFFF}"));
	SPD(playerid, 265, DIALOG_STYLE_LIST, !"", global_str, !"Isrinkti", !"Atsaukti");
    return 1;
}
CMD:sethp(playerid, params[])
{
	extract params -> new player:target, Float:hp; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethp [id] [ammount]");
	if hp < 0.0 || hp > 100.0 *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethp [id] 100 > hp > 0");
    if(target == INVALID_PLAYER_ID)
		return 0;
	else if PI[playerid][pAdmin] < PI[target][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if target != playerid && PI[playerid][pAdmin] == PI[target][pAdmin] *then
		return CheckAntiSliv(playerid);
	UpdatePlayerHealth(target, hp);
	f(global_str, 128, "[%s] nustate zaidejui %s[%d] %.0f HP", PN(playerid), PN(target), target, hp);
	SendAdminsMessage(COLOR_GREY, global_str);
	return 1;
}
CMD:a(playerid, params[])
{
    if(GetPVarInt(playerid, #AFvr) > gettime() && !IsAOwner(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODinkite!");
    if sscanf(params, "s[100]", params[0]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /a [tekstas]");
    SetPVarInt(playerid, #AFvr, gettime()+15);
    if(GetString(PN(playerid),"Developer")) return SAMF(COLOR_ACHAT, "[A] {%s}%s{99CC00} %s[%d]: {%s}%s", PI[playerid][pAdmTagColor],PI[playerid][pAdmTag], PN(playerid), playerid, PI[playerid][pAdmTagColor], params[0]);
	SAMF(COLOR_ACHAT, "[A] {%s}%s {99CC00}%s[%d]: %s", PI[playerid][pAdmTagColor], PI[playerid][pAdmTag], PN(playerid), playerid, params[0]);
	return 1;
}
CMD:setint(playerid, data[])
{
    extract data -> new player:targetid, interiorid; else
    	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setint [zaidejo ID] [interjero ID]"), SCMF(playerid, -1, "Jusu interjerius: %d", GetPlayerInterior(playerid));
	if(PI[playerid][pAdmin] < PI[targetid][pAdmin]) return 1;
	if(targetid != playerid && PI[playerid][pAdmin] == PI[targetid][pAdmin]) return 1;
    return SetPlayerInterior(targetid, interiorid);
}
CMD:setvw(playerid, data[])
{
   	extract data -> new player:targetid, virtualworld; else
    	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setvw [zaidejo ID] [virtualaus pasaulio ID]"), SCMF(playerid, -1, "Jusu virtualus pasaulis: %d", GetPlayerVirtualWorld(playerid));
	if(PI[playerid][pAdmin] < PI[targetid][pAdmin]) return 1;
	if(targetid != playerid && PI[playerid][pAdmin] == PI[targetid][pAdmin]) return 1;
    return SetPlayerVirtualWorld(targetid, virtualworld);
}
CMD:bizfin(playerid, data[])
{
	extract data -> new id; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /bizfin [verslo ID]");
	if id < 0 or id > OWNABLEBIZES *then return false;
	return ShowWeekBiz(playerid, id);
}
CMD:spcars(playerid, params[])
{
	new Float:radius;
    if sscanf(params, "f", radius) *then
        return SCM(playerid, COLOR_OLDRED, !"Naudokite: /spcars [spindulys]");
    if !(1.0 <= radius <= 100.0) *then
        return SCM(playerid, COLOR_OLDRED, !"Naudokite: /spcars [spindulys > 0 arba < 100]");
    new
        Float:x,
        Float:y,
        Float:z;
    foreach(Vehicle, i)
    {
        GetPlayerPos(playerid, x, y, z);
        if(IsVehicleInRangeOfPoint(i, radius, x, y, z))
        {
            if(IsBazarVehicle(i))
                continue;
            SetVehicleToRespawn(i);
        }
    }
    f(global_str, 145, "%s[%d] Uzspawnino transporta spindulyje %.01f", PN(playerid), playerid, radius);
    SendAdminsMessage(COLOR_ORANGE, global_str);
    return 1;
}
CMD:skinall(playerid, params[])
{
	extract params -> new Float:radius, skinid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /skinall [spindulys] [skinID]");
    if(!(1.0 <= radius <= 100.0))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /skinall [spindulys > 0 arba < 100]");
    if(!(1 <= skinid <= 381))
		return 0;
	new
		Float:x,
		Float:y,
		Float:z,
		num = 0;
	foreach(new i: Player)
    {
        GetPlayerPos(playerid, x, y, z);
        if(IsPlayerInRangeOfPoint(i, radius, x, y, z))
		{
			SetPlayerSkinEx(i, skinid);
			num ++;
			TogglePlayerControllable(i, true);
		}
    }
    f(global_str, 128, "[Informacija] {FFFFFF}Jus sekmingai isdavete %d zaidejams skina savo spindulyje.", num);
    SCM(playerid, COLOR_GREEN, global_str);
	f(global_str, 128, "[A] %s %d zaidejams suteike laikina skina!", PN(playerid), num);
    SendAdminsMessage(COLOR_GREEN, global_str);
	return 1;
}
CMD:gunall(playerid, params[])
{
	new num;
    new Float:x,Float:y,Float:z;
    new Float:id,mid,did;
    if(sscanf(params,"fii",id,mid,did)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gunall [spindulys] [gunid] [ammo]");
    if(id<1 || id > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /gunall [spindulys > 0 arba < 100]");
	switch(mid)
	{
		case 35..40,1,2,4,9,16..19,20..22,26..28,44,45:
		{
			if !IsAOwner(playerid) *then
				return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Draudziama isduoti toki ginkla");
		}
	}
    foreach(new i: Player)
    {
        if(IsPlayerLogged{i})
        {
	        GetPlayerPos(playerid,x,y,z);
	        if(IsPlayerInRangeOfPoint(i,id,x,y,z)) _GiveGun(i,mid,did),num++;
		}
    }
    f(global_str,128,"[A] %s isdave ginklus %s %d zaidejams!",PN(playerid),GunPN(mid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave ginklus %d zaidejams. Gun: %s[%d]", 4, PN(playerid), "", PN(playerid), PN(playerid), num, GunPN(mid), did);
    return 1;
}
CMD:spplayers(playerid, params[])
{
	new Float:radius,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",radius)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /spplayers [spindulys]");
    if(radius<1 || radius > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /spplayers [spindulys > 0 arba < 100]");
    new num;
    foreach(new i: Player)
    {
    	if PI[i][pAdmin] *then continue;

        GetPlayerPos(playerid,x,y,z);
        if(IsPlayerInRangeOfPoint(i,radius,x,y,z))
		{
			SCMF(i, COLOR_OLDRED, "A: %s[%d] jus uzspawnino", PN(playerid), playerid);
            PlayerSpawn(i);
			num++;
		}
    }
    f(global_str, 128,"[Informacija] {FFFFFF}Jus sekmingai uzspawninote %d zaideju savo spindulyje.",num);
    SCM(playerid,COLOR_GREEN,global_str);
	f(global_str, 100,"[A] %s uzspawnino %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:azakon(playerid, params[])
{
    new Float:radius,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",radius)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /azakon [spindulys]");
    if(radius<1 || radius > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /azakon [spindulys > 0 arba < 100]");
	new num;
	foreach(new i: Player)
	{
		if(IsPlayerLogged{i})
		{
			GetPlayerPos(playerid,x,y,z);
			if(IsPlayerInRangeOfPoint(i,radius,x,y,z))
			{
                position_unjail[0] = x;
                position_unjail[1] = y;
                position_unjail[2] = z;
				num++;
			}
		}
	}
    f(global_str,128,"[Informacija] {FFFFFF}Jus sekmingai suteikete zvaigzdziu %d zaideju savo spindulyje.",num);
    SCM(playerid,COLOR_GREEN,global_str);
	f(global_str, 100,"[A] %s suteike zvaigzdziu %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:freezeall(playerid, params[])
{
	new Float:radius,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",radius)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /freezeall [spindulys]");
    if(radius<1 || radius > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /freezeall [spindulys > 0 arba < 100]");
    new num;
    foreach(new i: Player)
    {
        GetPlayerPos(playerid,x,y,z);
        if(IsPlayerInRangeOfPoint(i,radius,x,y,z))
		{
		    TogglePlayerControllable(i,false);
			num++;
		}
	}
    f(global_str, 128,"[Informacija] {FFFFFF}Jus sekmingai uzsaldete %d zaideju jusu spindulyje.",num);
    SCM(playerid,COLOR_GREEN,global_str);
	f(global_str,100,"[A] %s uzsalde %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:unfreezeall(playerid, params[])
{
	new Float:radius,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",radius)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /unfreezeall [spindulys]");
    if(radius<1 || radius > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /unfreezeall [spindulys > 0 arba < 100]");
    new num;
	foreach(new i: Player)
    {
        GetPlayerPos(playerid,x,y,z);
        if(IsPlayerInRangeOfPoint(i,radius,x,y,z))
		{
		    TogglePlayerControllable(i,true);
			num++;
		}
	}
    f(global_str,145,"[Informacija] {FFFFFF}Jus sekmingai atsildete %d zaideju savo spindulyje.",num);
    SCM(playerid,COLOR_GREEN,global_str);
	f(global_str,100,"[A] %s atsilde %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:armourall(playerid, params[])
{
	new Float:id,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /armourall [spindulys]");
    if(id<1 || id > 100) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /armourall [spindulys > 0 arba < 100]");
    new num;
    foreach(new i: Player)
    {
        if(IsPlayerLogged{i})
        {
	        GetPlayerPos(playerid,x,y,z);
	        if(IsPlayerInRangeOfPoint(i,id,x,y,z))
	        {
	            UpdatePlayerArmour(i,100);
	            num++;
	        }
		}
    }
    f(global_str,145,"[Informacija] {FFFFFF}Jus sekmingai suteikte sarvus %d zaideju savo spindulyje.",num);
    SCM(playerid,COLOR_GREEN,global_str);
    f(global_str,100,"[A] %s suteike sarvus %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:unarmorall(playerid, params[])
{
	new Float:id,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /unarmourall [spindulys]");
    if(id<1 || id > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /unarmourall [spindulys > 0 arba < 100]");
    new num;
    foreach(new i: Player)
    {
        if(IsPlayerLogged{i})
        {
	        GetPlayerPos(playerid,x,y,z);
	        if(IsPlayerInRangeOfPoint(i,id,x,y,z))
	        {
	            UpdatePlayerArmour(i,0);
	            num++;
	        }
		}
    }
    f(global_str,100,"[A] %s ateme sarvus is %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:setarmour(playerid, params[])
{
	new
		target,
		Float:armour;
	if(sscanf(params, "uf", target, armour))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setarmour [id] [ammount]");
	if(armour > 1000.0)
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setarmour [id] am < 1000");
	if(armour < 0.0)
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setarmour [id] am > 0");
	if(target == INVALID_PLAYER_ID)
		return 0;
	UpdatePlayerArmour(target, armour);
	f(global_str, 145, "[A] A: %s nustate zaidejui %s[%d] sarvus %.0f", PN(playerid), PN(target), target, armour);
	return SendAdminsMessage(COLOR_GREY, global_str);
}
CMD:slapall(playerid, params[])
{
    new Float:id,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /slapall [spindulys]");
    if(id<1 || id > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /slapall [spindulys > 0 arba < 100]");
    new num;
    foreach(new i: Player)
    {
        if(IsPlayerLogged{i})
        {
	        GetPlayerPos(playerid,x,y,z);
	        if(IsPlayerInRangeOfPoint(i,id,x,y,z))
	        {
             	new Float:X,Float:Y,Float:Z;
                GetPlayerPos(i,X,Y,Z);
                SetPlayerPos(i,X,Y,Z+5);
	            num++;
	        }
		}
    }
    f(global_str, 145, "[A] A: %s[%d] dave per uzpakali %d zaideju", PN(playerid),playerid,num);
    return SendAdminsMessage(COLOR_GREEN,global_str);
}
CMD:eatall(playerid, params[])
{
    new Float:id,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /eatall [spindulys]");
    if(id<1 || id > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /eatall [spindulys > 0 arba < 100]");
    new num;
    foreach(new i: Player)
    {
        if(IsPlayerLogged{i})
        {
	        GetPlayerPos(playerid,x,y,z);
	        if(IsPlayerInRangeOfPoint(i,id,x,y,z))
	        {
	            Fullness[i] = 100;
	            SetFullness(i, 100);
	            num++;
	        }
		}
    }
    f(global_str,145,"[Informacija] {FFFFFF}Jus sekmingai suteikete sotuma %d zaideju savo spindulyje.",num);
    SCM(playerid,COLOR_GREEN,global_str);
    f(global_str,100,"[A] %s suteike sotuma %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:hpall(playerid, params[])
{
    new Float:id,Float:x,Float:y,Float:z;
    if(sscanf(params,"f",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /hpall [spindulys]");
    if(id<1 || id > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /hpall [spindulys > 0 arba < 100]");
    new num;
    foreach(new i: Player)
    {
        if(IsPlayerLogged{i})
        {
	        GetPlayerPos(playerid,x,y,z);
	        if(IsPlayerInRangeOfPoint(i,id,x,y,z))
	        {
	            UpdatePlayerHealth(i,100);
	            num++;
	        }
		}
    }
    f(global_str,145,"[Informacija] {FFFFFF}Jus sekmingai suteikete sveikata %d zaideju jusu spindulyje.",num);
    SCM(playerid,COLOR_GREEN,global_str);
    f(global_str,100,"[A] %s suteike sveikata %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:weapall(playerid, params[])
{
	new num, Float:x,Float:y,Float:z,Float:id;
    if(sscanf(params,"f",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /weapall [spindulys]");
    if(id<1 || id > 100)return SCM(playerid,COLOR_OLDRED,!"Naudokite: /weapall [spindulys > 0 arba < 100]");
    GetPlayerPos(playerid,x,y,z);
    foreach(new i: Player)
    {
        if(IsPlayerLogged{i})
        {
	        if(IsPlayerInRangeOfPoint(i,id,x,y,z))
	        {
	            _ResetGun(i);
	            num++;
	        }
		}
    }
    f(global_str,100,"[A] %s ateme ginklus is %d zaideju!",PN(playerid),num);
    SendAdminsMessage(COLOR_GREEN,global_str);
    return 1;
}
CMD:givegun(playerid, params[])
{
	if(sscanf(params, "udd", params[0], params[1], params[2])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /givegun [id] [gunid] [ammo]");
	if(params[0] == INVALID_PLAYER_ID)
	    return 0;
    if(params[1] < 0 || params[1] > 47) return SCM(playerid, COLOR_GREY, !"Ginklo ID negali buti mazesnis nei 0 ir didesnis nei 47!");
	switch(params[1])
	{
		case 35..40,1,2,4,9,16..19,20..22,26..28,44,45:
		{
			if !IsAOwner(playerid) *then
				return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Draudziama isduoti toki ginkla");
		}
	}
 	if(params[2] > 500) return SCM(playerid, COLOR_GREY, !"Ne daugiau kaip 500 soviniu!");
	_GiveGun(params[0], params[1], params[2]);
	f(global_str, 145, "[A] %s [ID: %d] isdave %s zaidejui %s[%d] !", PN(playerid), playerid, GunPN(params[1]), PN(params[0]), params[0]);
	SendAdminsMessage(COLOR_GREY, global_str);
    amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave zaidejui <a href=../pages/user?name=%s>%s</a> ginkla %s[%d]", 5, PN(playerid),PN(params[0]), PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), GunPN(params[1]), params[1]);
	return 1;
}
CMD:smp(playerid, params[])
{
	if(sscanf(params,"s[100]", params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /smp [tekstas]");
	if( IsAIP(params[0]) ) return 0;
	f(global_str,145,"[Renginys] %s: %s!!",PN(playerid),params[0]);
	ProxDetector(100,playerid,global_str,COLOR_GOLD,1);
	return 1;
}
cmd:eventmenu(playerid)
{
 	if AutoSletMP[aWork] *then
	    return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Negalite liesti /eventmenu, kai vyksta automatinis iskritimas!");
	format(global_str, 500, "\
		{9ACD32}» {FFFFFF}Teleportacijos pozicija\n\
	    {9ACD32}» {FFFFFF}\"%s\"\n\
	    {9ACD32}» {FFFFFF}Sveikatos suteikimas: %d\n\
	    {9ACD32}» {FFFFFF}Sarvu suteikimas: %d\n\
	    {9ACD32}» {FFFFFF}Atimti ginklus teleportacijos metu: %s\n\
	    {9ACD32}» {FFFFFF}Pakartotinas teleportas: %s\n\
	    {9ACD32}» {FFFFFF}Zaideju limitas: %d zaideju\n\
		{9ACD32}» {FFFFFF}Teleportacijos veikimo laikas: %d sekundziu\n\
		{9ACD32}» %s{FFFFFF} teleportas", MPName,MPHealth,MPArmour,MPWeapon ? ("{05B212}Ne{FFFFFF}") : ("{FF1C05}Taip{FFFFFF}"),MPTeleport ? ("{FF1C05}Draudziama{FFFFFF}") : ("{05B212}Leidziama{FFFFFF}"),MPPlayerLimit,MPTimeStatic,Teleport ? ("{FF1C05}Sustabdyti{FFFFFF}") : ("{05B212}Paleisti{FFFFFF}"));
	return SPD(playerid, 4690, DIALOG_STYLE_LIST, !"{9ACD32}Teleport Event", global_str, !"Isrinkti", !"Uzdaryti");
}
CMD:sp(playerid, params[])
{
	new targetid; static textplayer[30];
    if(sscanf(params, "us[64]", targetid, textplayer))
    	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sp [id] [Tekstas]");
   	if(targetid == INVALID_PLAYER_ID or targetid == playerid)
    	return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Zaidejas nerastas!");
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> parase zaidejo <a href=../pages/user?name=%s>%s</a> vardu | %s", 5, PN(playerid),PN(targetid), PN(playerid), PN(playerid), PN(targetid), PN(targetid), textplayer);
    return OnPlayerText(targetid, textplayer);
}
CMD:spcme(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
	    return 1;
	new targetid;
    if(sscanf(params, "us[200]", targetid, params[0]))
    	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /spcme [id] [cmd]");
    if(targetid == INVALID_PLAYER_ID) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Zaidejas nerastas!");
	if(!IsPlayerLogged{playerid} || !IsPlayerLogged{targetid})
    	return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Zaidejas nerastas!");
    PC_EmulateCommand(targetid, params[0]);
    return 1;
}
CMD:ao(playerid, params[])
{
    if(PI[playerid][pAdmin] < 4) return 1;
	if(sscanf(params, "s[150]", params[0]))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /ao [tekstas]");
	if(strlen(params[0]) > 150)
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /ao [tekstas]");
    if(IsAIP(params[0]) && PI[playerid][pAdmin] < 6) return 1;
    switch(PI[playerid][pAdmin])
    {
	  	case 4: global_str = "Administratorius";
	  	case 5: global_str = "Kuratorius";
	  	case 6: global_str = "Vyriausiojo Admin. Pav.";
	  	case 7: global_str = "Vyriausias Administratorius";
		case 8: global_str = "Ikurejas";
		default: global_str = "Administratorius";
    }
	if(GetString(PN(playerid),"Developer"))
	{
	    f(global_str, 145, "{%s}%s %s: %s", PI[playerid][pAdmTagColor], PI[playerid][pAdmTag], PN(playerid), params[0]);
	    SCMALL(-1, global_str);
	    return 1;
	}
    if GetString(PI[playerid][pAdmTag], "None") *then
	    f(global_str, 145," %s %s: %s", global_str, PN(playerid), params[0]),
    		SCMALL(COLOR_GOLD, global_str);
	    else
	        f(global_str, 145," {%s}%s {FFD700}%s: %s", PI[playerid][pAdmTagColor], PI[playerid][pAdmTag], PN(playerid), params[0]),
	    		SCMALL(COLOR_GOLD, global_str);
	return 1;
}
CMD:aparkcar(playerid, params[])
{
	new vehid;
	if !sscanf(params, "d", vehid) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /aparkcar [vehicleid]");
	if !IsAOwnableCar(vehid) *then return false;
	DetachTrailerFromVehicle(vehid);
	new number = GetVehicleID(vehid);
	if(CarInfo[number][cShtraf]>0)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus negalite pastatyti sios transporto priemones baudos stovejimo aikstele, nes ji jau ten stovi!");
	SPD(playerid,0,0,!"","Jus pastatete transporto priemone i baudos stovejimo aikstele ir gavote 800$ kaip paskata.", !"Uzdaryti","");
	SetString(CarInfo[number][cShtrafName], PN(playerid));
	new Float:Health,panels,doors_,lights_,tires;
	GetVehicleDamageStatus(vehid,panels,doors_,lights_,tires);
	GetVehicleHealth(vehid,Health);
	CarInfo[number][cShtraf] = 10000;
	CarInfo[number][cKeyIN] = 0;
	GetVehiclePos(vehid,CarInfo[number][cPos_X],CarInfo[number][cPos_Y],CarInfo[number][cPos_Z]);
	GetVehicleZAngle(vehid,CarInfo[number][cPos_A]);
	VehicleInfo[vehid][vAntiRepair]=2;
	VehicleHealth[vehid] = Health;
	SetVehiclePos(vehid, CarInfo[number][cPos_X],CarInfo[number][cPos_Y],CarInfo[number][cPos_Z]);
	SetVehicleHealth(vehid, Health);
	UpdateVehicleDamageStatus(vehid,panels,doors_,lights_,tires);
	SaveOwnableCar(number);
	SetVehicleToRespawn(vehid);
	return false;
}
CMD:agl(playerid, params[])
{
	extract params -> new player:id, days; else
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Naudokite: /agl [id] [days]");
	if(id == INVALID_PLAYER_ID) return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Naudokite: /agl [id] [days]");
	if(days < 1 || days > 365) return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Naudokite: /agl [id] [days (1 - 365]");
	for new i; i < 9; i++ do
		GivePlayerLic(id, i, days);
	SavePlayerLicense(id);
 	return SCMF(playerid, COLOR_VALIK, "[Informacija] {FFFFFF}Jus sekmingai suteikete zaidejui %s(%d) visas licencijas!", PN(id), id);
}
CMD:setname(playerid, params[])
{
	if !IsAOwner(playerid) *then
		return false;
 	new id, name[MAX_PLAYER_NAME];
    if sscanf(params, "us[24]", id, name) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setname [id] [name]");
  	else if IsAOwner(id) && !IsAOwner(playerid) *then
		return CheckAntiSliv(playerid);
	if PI[id][pAdmin] *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Administratoriui draudziama keisti zaidimo Nick!");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return 1;
	if(id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin]) return 1;
    mysql_format(mysql, global_str, 256, "SELECT `ID` FROM `accounts` WHERE `NickName` = '%s' LIMIT 1", name);
    mysql_tquery(mysql, global_str, "MysqlCheckNameSetName", "dds", playerid, id, name);
    return 1;
}
CMD:uvalall(playerid, params[])
{
	extract params -> new org_id; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /uvalall [organizacijos ID (1-28)]");
	if org_id > 28 || org_id < 1 *then return SCM(playerid,COLOR_GREY, !"Nuo 1 iki 28");
	foreach(Player, i)
	{
		if PI[i][pMember] == org_id *then UnInvite(i);
	}
	f(global_str, 128, "[A] %s[%d] isformavo organizacija \'%s\'.", PN(playerid), playerid, OrgInfo[org_id][oName]);
	SendAdminsMessage(COLOR_GREY, global_str);
	f(mysql_string, 128, "UPDATE accounts SET Member = 0, Rank = 0, Leader = 0 WHERE Member = %d", org_id);
	mysql_query(mysql, mysql_string);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pilnai isformavo organizacija %s", 5, PN(playerid),"", PN(playerid), PN(playerid), OrgInfo[org_id][oName]);
	return false;
}
CMD:uval(playerid, data[])
{
	extract data -> new player:targetid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /uval [id]");
	if !IsPlayerOnline(targetid) *then
	    return false;
	else if PI[targetid][pLeader] *then
		return SCM(playerid,COLOR_RED, !"Sis zaidejas yra lyderis, ji galima pasalinti tik per /apanel");
	UnInvite(targetid);
    f(global_str, 145,  "[A] %s[ID: %d] Atleido zaideja %s [%d] is organizacijos", PN(playerid), playerid, PN(targetid), targetid);
	SendAdminsMessage(COLOR_OLDRED, global_str);
 	return SCMF(playerid, COLOR_LIGHTBLUE, "Jus ismetete %s is organizacijos", PN(targetid));
}
CMD:uvaloff(playerid, data[])
{
	extract data -> new string:name[24]; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /uvaloff [name]");
	if !(GetPlayerID(name) == INVALID_PLAYER_ID) *then
		return SCM(playerid, COLOR_OLDRED, !"Zaidejas prisijunges!");
	f(mysql_string, 200, "UPDATE accounts SET Leader = '0', Member = '0', Rank = '0' WHERE `NickName` = '%s' LIMIT 1;", name);
	mysql_query(mysql, mysql_string);
	f(global_str, 145,  "[A] %s[ID: %d] Atleido zaideja %s is organizacijos offline", PN(playerid), playerid, name);
	return SendAdminsMessage(COLOR_OLDRED, global_str);
}
cmd:vikstart(playerid)
{
	if(GetString(PN(playerid),"Milancholi") || GetString(PN(playerid),"Developer")) StartViktorina();
	return 1;
}
cmd:restart(playerid)
{
	if(GetString(PN(playerid),"Milancholi") || GetString(PN(playerid),"Developer"))
	{
		f(global_str, 145, "Gerbiami zaidejai! {%s}%s %s paleido technini restarta", PI[playerid][pAdmTagColor], PI[playerid][pAdmTag], PN(playerid));
		SCMALL(COLOR_LIGHTRED, global_str);
		SendRconCommandf("San Andreas Gyvenimas | %s | Techninis restartas!", Mode_City);
		SaveServerData();
		foreach(Player,i)
		{
			SaveInventory(i);
			Kick(i);
		}
		if getDayEx() == 1 *then
			mysql_tquery(mysql, "UPDATE businesses SET monday = 0, tuesday = 0, wednesday = 0, thursday = 0, friday = 0, saturday = 0, sunday = 0"),
			mysql_tquery(mysql, "DELETE FROM onlineinfo");
		SendRconCommand("gmx");
	}
	return 1;
}
cmd:ot(playerid)
{
	if !ACTIVEpanel[6] *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite /pm.");
	if(ReportID[playerid] != -1)
		return 0;
	if(TotalReport <= 0)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Siuo metu klausimu reporte nera!");
	static stringer[61 - 2 + MAX_PLAYER_NAME];
    global_str = "";
    f(stringer, 90, "[Uzuomina]{FFFFFF} À: %s emesi jusu reporto!", PN(playerid));
    foreach(Player, i)
    {
        if ReportON{i} *then
        {
            if ReportSlot{i} *then continue;
           	GetPVarString(i, "ReportMessage", global_str, 128);
    		f(global_str, 400, "{FFFFFF}Skunda/Klausimas nuo: %s[%i]\n\n{BFE54C}%s\n\n", PN(i), i, global_str);
			ReportID[playerid] = i;
			ReportID[i] = playerid;
			ReportSlot{i} = true;
			SCM(i, COLOR_RED, stringer);
			TotalReport --;
			break;
        }
    }
    SPD(playerid, 6370, DIALOG_STYLE_INPUT, !"", global_str, !"Priimti", !"Atsaukti");
	return 1;
}
CMD:pm(playerid, params[])
{
	new id,
		value;
    if(sscanf(params, "uds[150]", id, value, params[0]))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /pm [id/name] [0-chat/1-dialog] [answer]");
    if(id == INVALID_PLAYER_ID)
		return 0;
	if IsAOwner(id) *then
		return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"{ff0000}Sis zaidejas yra {FFFFFF}Kurejas\nJus negalite siusti jam pranesimu!\nNoredami susisiekti su Kureju >> {8b00ff}DC: Milancholi#8256", !"Uzdaryti", !"");
	f(global_str, 300, "A: %s atsake jums:{FFFFFF} %s", PN(playerid), params[0]);
	if(!value) SCM(id, COLOR_ORANGE, global_str);
    else
	{
		f(global_str, 300, "{FFFFFF}A: %s atsake jums:\n{cccccc} %s",PN(playerid), params[0]);
		SPD(id, 9870, DIALOG_STYLE_MSGBOX,"",global_str, !"Supratau", !"");
		SetPVarString(id, "AdmIDPM", PN(playerid));
	}
	f(global_str, 145, "[A] %s[%d] parase zaidejui %s[%d]:{FFFFFF} %s", PN(playerid), playerid, PN(id), id, params[0]);
    SendAdminsMessage(COLOR_LIGHTBLUE, global_str);
    return 1;
}
alias:report("rep", "ask");
CMD:report(playerid)
{
	if(PI[playerid][pAdmin] != 0) return SCM(playerid, COLOR_GREY, "[Klaida] Adminai negali rasyti reporte!");
	if PI[playerid][pRMuteTime] *then
		return SCMF(playerid, COLOR_GREY, "Jums uzblokuota galimybe rasyti reporta. Likes blokavimo laikas - %d sekundziu.", PI[playerid][pRMuteTime]);
    else if PI[playerid][pMuteTime] *then
		return SendMuteMessage(playerid);
    else if ReReport[playerid] > Global_Time && !GetPlayerADDVIP(playerid) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Reporta galima rasyti kas 3 minutes!");
	else if ReportSend{playerid} *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite uzduoti klausimo reporte!"), SCM(playerid, -1, !"Laukite atsakymo is administracijos!");
	return SPD(playerid, 32, DIALOG_STYLE_INPUT, !"{E88813}Report", !"{ffffff}Jus ruosiates rasyti pranesima Administracijai.\n{ffffff}Pries siusdami pranesima isitikinkite,\n{ffffff}kad ne vienas is punktu neatsake i jusu klausima.\n\n{AA3333}Draudziama:\n{AA3333}1. FLOOD, izeidimai\n{AA3333}2. Prasymai (Duokite pinigu, duokite lyderi, duokite..)\n{AA3333}3. Klaidingos zinutes\n\n{DF4F4F}Uz taisykliu pazeidimus administracija gali: \n{DF4F4F}1. Ispeti (Warn)\n{DF4F4F}2. Ismesti is serverio\n{DF4F4F}3. Uzblokuoti paskyra (Ban)\n{DF4F4F}4. Istrinti paskyra (Dell) \n\n{65C360}Prisiminkite!\n{65C360}Mes visada pasiruose padeti, jei laikotes taisykliu.\n{65C360}Sios taisykles galioja visiems zaidejams San Andreas Gyvenimas\n\n{ffffff}Jei ilgai nesulaukiate atsakymo, palaukite keleta minuciu\n{ffffff}Jus nesate vieni serveryje.\n{E91BE9}Pries uzduodami klausima reporte, pabandykite rasti sprendima naudodami /help.\n{ffffff}Aciu uz supratinguma, su pagarba SAG Administracija\n\n", !"Issiusti", !"Atsaukti");
}
CMD:pgetip(playerid, params[])
{
	if(sscanf(params,"u", params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /pgetip [name/id]");
	if params[0] == INVALID_PLAYER_ID *then
		return false;
	else if CheckFD(params[0], 2) && !IsAOwner(playerid) *then
		return false;
	f(global_str, 100, "- - - - Atitikimas su: %s. - - - -", PlayerIp[params[0]]);
    SCM(playerid,COLOR_ACHAT,global_str);
    SCM(playerid,COLOR_ACHAT," ");
	foreach(new i: Player)
	{
		GetPlayerIp(i,global_str,16);
		if GetString(global_str, PlayerIp[params[0]]) *then
			f(global_str, 50,"- %s[%d]",PN(i),i,global_str),
			SCM(playerid,COLOR_ORANGE, global_str);
	}
    return 1;
}
CMD:spplayer(playerid, params[])
{
	extract params -> new player:target; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /spplayer [id]");
	if(target == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_GREY, !"Sis zaidejas nera prisijunges");
	else if PI[playerid][pAdmin] < PI[target][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if target != playerid && PI[playerid][pAdmin] == PI[target][pAdmin] *then
		return CheckAntiSliv(playerid);
    f(global_str, 145, "<<<<< %s[%d] Uzspawnino zaideja %s[%d]!", PN(playerid), playerid, PN(target), target);
    SendAdminsMessage(COLOR_OLDRED, global_str);
    SCMF(target, COLOR_OLDRED, "A: %s[%d] jus uzspawnino", PN(playerid), playerid);
	PlayerSpawn(target);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> uzspawnino zaideja <a href=../pages/user?name=%s>%s</a>", 5, PN(playerid),PN(target), PN(playerid), PN(playerid), PN(target), PN(target));
}
CMD:pobjectdel(playerid, params[])
{
	new Float:radius;
    if sscanf(params, "f", radius) *then
        return SCM(playerid, COLOR_OLDRED, !"Naudokite: /pobjectdel [spindulys]");
    if !(1.0 <= radius <= 100.0) *then
        return SCM(playerid, COLOR_OLDRED, !"Naudokite: /pobjectdel [spindulys > 0 arba < 100]");
	new count;
	for new i; i < MAX_CREATE_OBJECTS; i++ do
	{
		if BH_Object[i][objItemID] && (BH_Object[i][objHouseID] || BH_Object[i][objBizID]) *then
		{
			if IsPlayerInRangeOfPoint(playerid, radius, BH_Object[i][objPosX], BH_Object[i][objPosY], BH_Object[i][objPosZ]) *then
				f(global_str, 128, "DELETE FROM `bh_objects` WHERE `ID` = '%d'", BH_Object[i][objBaseID]),
				mysql_query(mysql, global_str, false),
				DestroyDynamicObject(BH_Object[i][objID]),
				BH_Object[i][objItemID] =
				BH_Object[i][objBizID] =
				BH_Object[i][objHouseID] = 0,
				count ++;
		}
	}
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pasalino %d nekilnojamojo turto objektu!", 5, PN(playerid), "", PN(playerid), PN(playerid), count);
    SCMF(playerid, COLOR_GREEN, "[Informacija] {FFFFFF}Jus sekmingai pasalinote %d nekilnojamojo turto objektu savo spindulyje.", count);
    f(global_str, 100, "[A] %s pasalino %d nekilnojamojo turto objektu!", PN(playerid), count);
	return SendAdminsMessage(COLOR_GREEN, global_str);
}
CMD:clearhotel(playerid, params[])
{
	new name[24];
	if sscanf(params, "s[24]", name) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /clearhotel [name]");
	f(mysql_string, 128, "SELECT `ID` FROM accounts WHERE NickName = '%s'", name);
	new Cache:result = mysql_query(mysql, mysql_string);
	if cache_get_row_count(mysql) *then
	{
		f(mysql_string, 145, "[A] À: %s[%d] iskeldino zaideja %s is viesbucio.", PN(playerid), playerid, name);
		SendAdminsMessage(COLOR_OLDRED, mysql_string);
		SQL("UPDATE accounts SET From = -1 WHERE NickName = '%s'", name);
	}
	else SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Toks zaidejas neegzistuoja!");
	cache_delete(result, mysql);
	return false;
}
CMD:delhname(playerid, params[])
{
	extract params -> new house; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /delhname [id]");
	if !(0 <= house <= OWNABLEHOUSES) *then
		return false;
	f(global_str, 200, "UPDATE `houses` SET `Name` = '' WHERE `ID` = '%d'", house);
	mysql_tquery(mysql, global_str);
	CallTimeOutFunction("MysqlRefreshMS", 50, false, "dd", 982, house);
	f(global_str, 128, "[A] %s[%d] pasalino namo ¹%d pavadinima", PN(playerid), playerid, house);
	return SendAdminsMessage(COLOR_GREY, global_str);
}
CMD:delbname(playerid, params[])
{
	extract params -> new biz; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /delbname [id]");
	if !(0 <= biz <= OWNABLEBIZES) *then
		return false;
	f(global_str, 200, "UPDATE `businesses` SET `opisanie` = '' WHERE `ID` = '%d'", biz);
	mysql_tquery(mysql, global_str);
	CallTimeOutFunction("MysqlRefreshMS", 50, false, "dd", 583, biz);
	f(global_str, 128, "[A] %s[%d] pasalino verslo ¹%d pavadinima", PN(playerid), playerid, biz);
	return SendAdminsMessage(COLOR_GREY, global_str);
}
cmd:makeadmin(playerid, params[])
{
	if(sscanf(params, "ud", params[0], params[1]))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /makeadmin [name/id] [0-5]");
    if params[1] > 5 && AdminInfo[playerid][admFullDostup] < 2 *then { SCM(playerid, COLOR_OLDRED, !"Naudokite: /makeadmin [name/id] [0-5]"); return false; }
    if params[1] > 8 && AdminInfo[playerid][admFullDostup] == 2 *then { SCM(playerid, COLOR_OLDRED, !"Naudokite: /makeadmin [name/id] [0-8]"); return false; }
    if(params[0] == playerid)
	{
	    SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Negalima redaguoti savo administravimo teisiu lygio.");
    	return false;
	}
	else if PI[playerid][pAdmin] < PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin] *then
		return CheckAntiSliv(playerid);
	f(global_str, 128, "SELECT * FROM admin WHERE name = '%s'", PN(params[0]));
	mysql_tquery(mysql, global_str, "SetAdmin", "isi", playerid, PN(params[0]), params[1]);
	PI[params[0]][pAdmin] = params[1];
	SCMF(params[0], COLOR_OLDRED, "À: %s[%d] âûäàë âàì %d óðîâåíü àäìèí-ïðàâ", PN(playerid), playerid, params[1]);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> paskyre zaideja <a href=../pages/user?name=%s>%s</a> administratoriu %d lygio.", 5, "", "", PN(playerid), PN(playerid), PN(params[0]), PN(params[0]), params[1]);
}
cmd:makeadminoff(playerid, params[])
{
	static name[24]; name[0] = EOS;
	if(sscanf(params, "s[24]d", name, params[1]))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /makeadminoff [name/id] [0-5]");
    if params[1] > 5 && AdminInfo[playerid][admFullDostup] < 2 *then { SCM(playerid, COLOR_OLDRED, !"Naudokite: /makeadmin [name/id] [0-5]"); return false; }
    if params[1] > 8 && AdminInfo[playerid][admFullDostup] == 2 *then { SCM(playerid, COLOR_OLDRED, !"Naudokite: /makeadmin [name/id] [0-8]"); return false; }
	f(global_str, 128, "SELECT * FROM admin WHERE name = '%s'", name);
	mysql_tquery(mysql, global_str, "SetAdmin", "isi", playerid, name, params[1]);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> paskyre zaideja <a href=../pages/user?name=%s>%s</a> administratoriu %d lygio.", 5, "", "", PN(playerid), PN(playerid), name, name, params[1]);
}
CMD:removeitem(playerid, data[])
{
   	extract data -> new player:id, slot; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /removeitem [id] [langelis]");
	slot -= 1;
	if !IsPlayerOnline(id) *then
		return false;
	else if GetInvSet(playerid) >= PI[playerid][pInvCell] *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jusu inventoriuje nera pakankamai vietos!");
	else if !(0 <= slot <= PI[id][pInvCell]) *then
		return false;
	else if !Inventory[id][0][slot] *then
		return false;
	SCMF(id, COLOR_RED, "A: %s ateme is jusu %s (%d vnt.)", PN(playerid), ItemsInfo[Inventory[id][0][slot]][ItemName2], Inventory[id][1][slot]);
	SCMF(playerid, COLOR_GREEN, "Jus sekmingai atemete is %s %s (%d vnt.) is langelio %d!", PN(id), ItemsInfo[Inventory[id][0][slot]][ItemName2], Inventory[id][1][slot], slot + 1 );
	SAMF(COLOR_OLDRED, "[%s] ateme is zaidejo %s[%d] daikta %s (%d vnt.) is langelio %d", PN(playerid), PN(id), id, ItemsInfo[Inventory[id][0][slot]][ItemName2], Inventory[id][1][slot], slot + 1);
	AddItem(playerid, Inventory[id][0][slot], Inventory[id][1][slot], Inventory[id][2][slot], Inventory[id][3][slot]);
	Inventory[id][0][slot] = Inventory[id][1][slot] = Inventory[id][2][slot] = Inventory[id][3][slot] = 0;
	SaveInventory(id), SaveInventory(playerid);
	return true;
}
CMD:removeinv(playerid, data[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract data -> new player:id; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /removeinv [zaidejo ID]");
	if !IsPlayerOnline(id) *then
		return false;
	Inventory[id][0][0] = 313;
	Inventory[id][1][0] = 1;
	Inventory[id][2][0] = Inventory[id][3][0] = 0;
	Inventory[id][4][0] = Inventory[id][5][0] = 0;
	for new i = 1; i < PI[id][pInvCell]; i++ do ClearItem(id, i, Inventory[id][1][i]);
	SCMF(playerid, -1, "Veiksmas atliktas, jus pasalinote zaidejo %s inventoriu", PN(id));
	SCMF(id, COLOR_OLDRED, "[Informacija] {FFFFFF}Jusu inventorius buvo visiskai isvalytas uz serverio taisykliu pazeidima! [%s]", PN(playerid));
	f(global_str, 145, "A: %s isvale inventoriu %s", PN(playerid), PN(id));
	SendAdminsMessage(COLOR_GREY, global_str);
	return SaveInventory(id);
}
CMD:setpaydaybonus(playerid, params[]) {

 	if !CheckFD(playerid, 1) *then
		return false;
	extract params -> new int; else
		return SCM(playerid, COLOR_VALIK, !"/setpaydaybonus [valandu skaicius, kuris bus suteikiamas 1 PayDay]");
	PayDayXBonus = int;
	f(global_str, 128, "Kurejas %s[%d] nustate valandu kaupima /bonus, kaip 1 PayDay = %d valandu.", PN(playerid), playerid, PayDayXBonus);
	SCMALL(COLOR_ORANGE, global_str);
	return SaveInformation();
}
cmd:setdonatex(playerid, params[]) {

	if !IsAOwner(playerid) *then
		return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
	extract params -> new int; else
		return SCM(playerid, COLOR_VALIK, !"/setdonatex [1 Eur = 1 * params]");
	if int < 0 *then
		return false;
	XDonate = int;
	format(global_str, 128, "Kurejas %s[%d] nustate nauja saskaitos papildymo koeficienta. 1 EUR = {FF0000}%d{FFFFFF} SAG-Eur.", PN(playerid), playerid, XDonate);
	SCMALL(COLOR_ORANGE, global_str);
	return SaveInformation();
}
CMD:sletmenu(playerid) return SletMenu(playerid, 8886);
CMD:addbiz(playerid)
{
  	if !CheckFD(playerid, 2) *then
	    return false;
  	return SPD(playerid, 9321, DIALOG_STYLE_LIST, !"Pasirinkite verslo tipa", !"\
	    Parduotuve 24/7\n\
	    Uzkandine \n\
	    Parduotuve 'Degaline' \n\
	    Automobiliu nuoma \n\
	    Baras \nAmunicija \n\
	    Drabuziu parduotuve \n\
	    Imone \n\
	    Tuning salonas\n\
	    Autobazaras\n\
	    Sachta\n\
	    Autosalonas Ekonom klases\n\
	    Autosalonas Vidutines klases\n\
	    Autosalonas Elite klases\n\
	    LS Tuning parduotuve\n\
	    LV Tuning parduotuve\n\
	    Naftos grezinys\n\
	    Drabuziu dirbtuves\n\
		Viesbutis\n\
		Zemes ukio parduotuve\n\
		Zemes ukio technikos nuoma\n\
		Aksesuaru parduotuve\n\
	    Vaizdo ploksciu parduotuve\n\
		Second-Hand\n\
		Autoservisas\n\
		Parduotuve 'Viskas namams'\n\
		Sport Club LV\n\
		Automobiliu dirbtuves\n\
		Striptizo Klubas\n\
		Naftos grezynis (SAG Coins)\n\
		Zvejybos parduotuve\n\
		Parduotuve 'Aksesuaru gaudymas'", !"Isrinkti", !"Atsaukti");
}
CMD:addcar(playerid, data[])
{
    if !CheckFD(playerid, 2) *then
	    return false;
	extract data -> new car; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /addcar [carid]");
	if !ValidVehicleModel(car) or (car > 611 && !(CheckFD(playerid, 1))) *then return SCM(playerid, COLOR_VALIK, !"Neteisingas transporto priemones numeris!");
	new id = AddOwnableCar(playerid, car, "The State");
	if !(id == -1) *then
		SCMF(playerid, COLOR_ORANGE, "The car successfully added | %d", CarInfo[id][cID]),
		amlf("Administratorius <a href=../pages/user?name=%s>%s</a> sukure automobili <a href=../pages/carlog.php?id=%d>¹%d</a>.", 5, PN(playerid),"", PN(playerid), PN(playerid), CarInfo[id][cID], CarInfo[id][cID]);
	return true;
}
CMD:restartreport(playerid)
{
	if(TotalReport <= 0) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Reportas tuscias!");
	TotalReport = 0;
	foreach(new i: Player)
	{
		if(ReportON{i})
		{
			ReportON{i} = ReportSlot{i} = false;
			if(ReportID[i] != -1)
			{
				ReportID[ReportID[i]] =
				ReportID[i] = -1;
			}
		}
	}
	f(global_str, 145, "[A] %s[%d] perkrove reporta!", PN(playerid), playerid);
	SendAdminsMessage(COLOR_GREY, global_str);
	return 1;
}
CMD:clearbiz(playerid, params[])
{
	if sscanf(params, "d", params[0]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /clearbiz [verslo id]");
	if params[0] < 0 || params[0] > OWNABLEBIZES *then return 0;
	SetString(BizData[params[0]][bZam], "none");
	f (global_str, 80, "[Informacija]{FFFFFF} Jus sekmingai isvalete verslo ¹%d pavaduotojus",params[0]);
	SCM(playerid, COLOR_VALIK, global_str);
	return 1;
}
CMD:clearhouse(playerid, params[])
{
	if sscanf(params, "d", params[0]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /clearhouse [houseid]");
	if params[0] < 0 || params[0] > OWNABLEHOUSES *then return 0;
	for new i; i < 5; i++ do SetString(HRoomOwner[params[0]][i], "The State");
	f (global_str, 80, "[Informacija]{FFFFFF} Jus sekmingai isvalete namo ¹%d gyventoju sarasa",params[0]);
	return SCM(playerid, COLOR_VALIK, global_str);
}
CMD:notif(playerid, params[])
{
	if sscanf(params, "us[64]", params[0], params[1]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /notif [id] [msg]");
	if params[0] == INVALID_PLAYER_ID *then return 0;
	f(global_str, 256, "\
	{FFFF00}Nick:{FFFFFF} %s\n\
	{FFFF00}UID bazeje:{FFFFFF} %d\n\n\
	{FFFF00}Pranesimas:{FFFFFF}\n\
	%s\n\n\n\
	{AFAFAF}Zaidejas gaus pranesima ieidamas i zaidima.", PN(params[0]), PI[params[0]][pID], params[1]);
	SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Pranesimas sukurtas", global_str, !"Uzdaryti", !"");
	return CreateNotifPlayer(params[0], params[1]);
}
CMD:bizopen(playerid, params[])
{
	if sscanf(params, "d", params[0]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /bizopen [bizid]");
	if params[0] < 0 || params[0] >= OWNABLEBIZES *then return 0;
	BizData[params[0]][bLock] = 0;
	f(global_str, 80, "[A] A: %s atidare versla ¹%d", PN(playerid), params[0]);
	SendAdminsMessage(COLOR_GREY, global_str);
	return 1;
}
CMD:bizlock(playerid, params[])
{
	if sscanf(params, "d", params[0]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /bizlock [bizid]");
	if params[0] < 0 || params[0] >= OWNABLEBIZES *then return 0;
	BizData[params[0]][bLock] = 1;
	f(global_str, 80, "[A] A: %s uzdare versla ¹%d", PN(playerid), params[0]);
	SendAdminsMessage(COLOR_GREY, global_str);
	return 1;
}
CMD:makefamilyleader(playerid, params[])
{
	if sscanf(params, "s[15]s[25]", global_str, params[1]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /makefamilyleader [family name] [name]");
	f(mysql_string, 128, "SELECT `ownername` FROM family WHERE name = '%s'", global_str);
	new Cache:result = mysql_query(mysql, mysql_string);
	if cache_get_row_count(mysql) *then
	{
		cache_get_row(0, 0, mysql_string, mysql);
		f(mysql_string, 145, "[A] A: %s[%d] perrase seima '%s' is savininko '%s' zaidejui '%s'", PN(playerid), playerid, global_str, mysql_string, params[1]);
		SendAdminsMessage(COLOR_OLDRED, mysql_string);
		f(mysql_string, 128, "UPDATE family SET ownername = '%s' WHERE name = BINARY('%s')", params[1], global_str);
		mysql_query(mysql, mysql_string);
	}
	else SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Tokia seima neegzistuoja!");
	cache_delete(result, mysql);
	return false;
}
CMD:getworld(playerid,params[])
{
 	if !CheckFD(playerid, 1) *then
		return false;
	return SCMF(playerid, COLOR_GREEN, "int - %d, world - %d", GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
}
CMD:adeldesc(playerid, data[])
{
	extract data -> new player:id; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /adeldesc [id/name]");
	DeleteOpisanie(id);
	SetString(PI[id][pOpisanie],"");
	UpdatePlayerDataStr(id, "Opisanie", PI[id][pOpisanie]);
	f(global_str, 100, "[Informacija]{FFFFFF} Jus istrynete aprasyma veikejo%s[ID: %d]", PN(id), id);
	SCM(playerid, COLOR_VALIK, global_str);
	f(global_str, 100, "[A]{FFFFFF} A: %s istryne aprasyma veikejo %s[ID: %d]", PN(playerid),PN(id),id);
	SendAdminsMessage(COLOR_YELLOW, global_str);
	return 1;
}
CMD:setfuel(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new Float:dd;
	    if(sscanf(params, "f", dd)) return 0;
	    Fuel[GetPlayerVehicleID(playerid)] = dd;
	}
	else SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate transporte!");
	return 1;
}
CMD:trremove(playerid, params[])
{
	new i;
	if(sscanf(params, "d", i)) return SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Naudokite: /trremove [¹]");
	if(!IsValidTrailer(i)) return SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Tokia priekaba neegzistuoja!");
	if(!TrailerInfo[i][tParked]) return SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Priekaba nera pastatyta!");
	DestroyDynamicObject(TrailerInfo[i][tObjPark]);
    DestroyDynamicPickup(TrailerInfo[i][tPickup]);
    DestroyDynamic3DTextLabel(TrailerInfo[i][tLabel]);
    new id = GetPlayerID(TrailerInfo[i][tOwner]);
    SetString(TrailerInfo[i][tOwner], "The State");
    SaveTrailer(i);
    if(id != INVALID_PLAYER_ID) SCM(playerid, COLOR_RED, !"( Pranesimas ){FFFFFF}Jusu priekaba buvo evakuota priekabu salono darbuotoju.");
    return 1;
}
CMD:modellimit(playerid)
{
    if !CheckFD(playerid, 2) *then
	    return false;
	return SPD(playerid, 3728, DIALOG_STYLE_LIST, !"{B83434}Galimu automobiliu skaicius", !"{FFFFFF}Biudzeto klase\nVidutine klase\nElite klase\nLuxe klase\nNeteiseta klase\nVice-City klase", !"Isrinkti", !"Uzdaryti");
}
CMD:modellimitadd(playerid, data[])
{
    if !CheckFD(playerid, 2) *then
	    return false;
	extract data -> new type, count; else
		return SCM(playerid, -1, !"/modellimitadd [0 - iki 180000; 1 - iki 1 mln; 2 - kiti; 3 - specialus transportas 4 - priemium; 5 - custom; 6 - vice-city] [skaicius]"),
		SCM(playerid, -1, "Jei nurodysite nuli, visos ribos bus atstatytos.");
	if !(0 <= type <= 6) or !(0 <= count <= 20) *then
		return false;
	switch type do
	{
	    case 6: type = 6;
		case 5: type = 4;
		case 4: type = 3;
		case 3: type = 5;
		case 0,1: type = 1;
	}
	for new i; i < MAX_SELLCARS; i++ do
	{
		if !(SellInfo[i][scType] == type) or !SellInfo[i][scModel] *then continue;
		SellInfo[i][scCount] = count;
	}
	return true;
}
CMD:givemydonate(playerid, params[])
{
   	extract params -> new player:id, money; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /givemydonate [id] [suma]");
	if !ProxDetectorS(10.0, playerid, id) *then
		return SCM(playerid,COLOR_GREY, !"Jus esate toli nuo zaidejo");
	else if playerid == id *then
		return SCM(playerid,COLOR_GREY, !"Negalima perduoti SAG-Coins sau paciam");
	else  if !(1 <= money <= PI[playerid][pVirMoney]) *then
		return SCM(playerid, COLOR_RED,!"[Klaida]{FFFFFF} Jums nepakanka SAG-Coins.");
	else if money > 50000 *then
		return SCM(playerid,COLOR_RED, !"[Klaida]{FFFFFF} Negalima perduoti daugiau nei 50000 SAG-Coins!");
	GiveDonate(playerid, -money);
	GiveDonate(id, money);
	SCMF(playerid, COLOR_VALIK, "[Uzuomina]{FFFFFF} Jus sekmingai perdavete %d SAG-Coins zaidejui %s[%d]!", money,PN(id), id);
	return SAMF(COLOR_VALIK, "[A] %s[%d] perdave %d SAG-Coins zaidejui %s[%d]",PN(playerid), playerid, money, PN(id), id);
}
CMD:ungivedonate(playerid, params[])
{
   	extract params -> new player:targetid, money; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /ungivedonate [targetid] [kiekis]");
	if !ProxDetectorS(10.0, playerid, targetid) *then
		return SCM(playerid,COLOR_GREY, !"Jus toli nuo zaidejo");
	else if playerid == targetid *then
		return SCM(playerid,COLOR_GREY, !"Negalima atimti SAG-Coins is saves");
	else  if !(1 <= money <= PI[targetid][pVirMoney]) *then
		return SCM(playerid, COLOR_RED,!"[Klaida]{FFFFFF} Zaidejas neturi pakankamai SAG-Coins.");
	else if money > 50000 *then
		return SCM(playerid,COLOR_RED, !"[Klaida]{FFFFFF} Negalima atimti daugiau nei 50000 vienu kartu!");
	GiveDonate(targetid, -money);
	GiveDonate(playerid, money);
	SCMF(playerid, COLOR_VALIK, "[Uzuomina]{FFFFFF} Jus sekmingai atemete %d SAG-Coins is zaidejo %s[%d]!", money, PN(targetid), targetid);
	return SAMF(COLOR_VALIK, "[A] %s[%d] ateme %d SAG-Coins is zaidejo %s[%d]", PN(playerid), playerid, money, PN(targetid), targetid);
}
cmd:findfam(playerid, params[])
{
	extract params -> new id; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /findfam [id player]");
    if sscanf(params, "u", id) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /findfam [id player]");
	else if id == INVALID_PLAYER_ID *then
		return SCM(playerid, COLOR_OLDRED, "[Klaida]{FFFFFF} Sio ID nera serveryje!");
	if FP_Data[id][F_FAMILY_ID] == -1 *then
		return SCM(playerid, COLOR_OLDRED, "[Klaida]{FFFFFF} Sis zaidejas nepriklauso jokiai seimai!");
	SCMF(playerid, -1, "[Paieska] Rezultatas: {%s}%s", FamilyColor[GetFamilyDataInt(id, "color")], GetFamilyDataString(FP_Data[id][F_FAMILY_ID], "name"));
	return false;
}
CMD:checkonline(playerid, data[])
{
	extract data -> new player:id, day; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checkonline [playerid] [dienos numeris]"), SCM(playerid, -1, "0 - Sestadienis, 1 - Sekmadienis, 2 - Pirmadienis, 3 - Antradienis, 4 - Treciadienis, 5 - Ketvirtadienis, 6 - Penktadienis"), SCMF(playerid, COLOR_OLDRED, "Siandien savaites dienos numeris: %d", day_of_week);
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return 1;
	if(id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin]) return 1;
	if !IsPlayerOnline(id) *then
		return false;
	else if day > 6 or day < 0 *then
		return false;
	return CheckOnline(playerid, id, day);
}
CMD:muteoff(playerid, params[])
{
	if sscanf(params, "s[24]ds[144]", demote_name, demote_time, demote_reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /muteoff [name] [time] [reason]");
	if !(!IsPlayerOnline(GetPlayerID(demote_name))) *then
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra prisijunges!");
	f(global_str, 250, "SELECT `ID`, `MuteTime`, `Online_status`, `PlayerID` FROM accounts WHERE NickName = BINARY('%s') LIMIT 1;", demote_name);
    mysql_tquery(mysql, global_str, "@GiveOfflineDemote", "dds", playerid, offline_demote_mute, params);
	return true;
}
CMD:jailoff(playerid, params[])
{
	if sscanf(params, "s[24]ds[144]", demote_name, demote_time, demote_reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /jailoff [name] [min`s] [reason]");
	if !(!IsPlayerOnline(GetPlayerID(demote_name))) *then
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra prisijunges!");
	f(global_str, 250, "SELECT `ID`, `JailTime`, `Online_status`, `PlayerID` FROM accounts WHERE NickName = BINARY('%s') LIMIT 1;", demote_name);
    mysql_tquery(mysql, global_str, "@GiveOfflineDemote", "dds", playerid, offline_demote_jail, params);
	return true;
}
CMD:warnoff(playerid, params[])
{
	if sscanf(params, "s[24]s[144]", demote_name, demote_reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /warnoff [nick] [reason]");
	if !(!IsPlayerOnline(GetPlayerID(demote_name))) *then
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra prisijunges!");
	f(global_str, 250, "SELECT `ID`, `Warns`, `Online_status`, `PlayerID` FROM accounts WHERE NickName = BINARY('%s') LIMIT 1;", demote_name);
    mysql_tquery(mysql, global_str, "@GiveOfflineDemote", "dds", playerid, offline_demote_warn, params);
	return true;
}
CMD:banoff(playerid, params[])
{
	if sscanf(params, "ds[24]ds[144]", demote_typeban, demote_name, demote_time, demote_reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /banoff [0 be anuliavimo/1 su anuliavimu] [name] [dienu] [Priezastis]");
	if !(!IsPlayerOnline(GetPlayerID(demote_name))) *then
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra prisijunges!");
	if demote_typeban > 1 || demote_typeban < 0 *then return false;
	if demote_typeban == 1 && !IsAOwner(playerid) *then return false;
	f(global_str, 250, "SELECT `ID`, `LastIP`, `Online_status`, `PlayerID` FROM accounts WHERE NickName = BINARY('%s') LIMIT 1;", demote_name);
    mysql_tquery(mysql, global_str, "@GiveOfflineDemote", "dds", playerid, offline_demote_ban, params);
	return true;
}
CMD:unmuteoff(playerid, data[])
{
	new Name[MAX_PLAYER_NAME], Reason[48];
	if sscanf(data, "s[24]s[48]", Name, Reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unmuteoff [name] [reason]");
	if !(!IsPlayerOnline(GetPlayerID(Name))) *then
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra prisijunges!");
	f(global_str, 145, "A: %s pasalino MUTE offline zaidejui%s, priezastis: %s", PN(playerid), Name, Reason);
	SendAdminsMessage(COLOR_GREY, global_str);
	ANL(Name, global_str);
	mysql_real_escape_string(Name, mysql_string);
	SQL("UPDATE accounts SET MuteTime = 0 WHERE NickName = '%s'", mysql_string);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pasalino MUTE <a href=../pages/user?name=%s>%s</a>. Priezastis: %s", 5, PN(playerid),Name, PN(playerid), PN(playerid), Name, Name, Reason);
}
CMD:unjailoff(playerid, data[])
{
	new Name[MAX_PLAYER_NAME], Reason[48];
	if sscanf(data, "s[24]s[48]", Name, Reason) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unjailoff [name] [reason]");
	if !(!IsPlayerOnline(GetPlayerID(Name))) *then
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra prisijunges!");
	f(global_str, 145, "A: %s islaisvino offline is Demorgano %s, priezastis: %s", PN(playerid), Name, Reason);
	SendAdminsMessage(COLOR_GREY, global_str);
	ANL(Name, global_str);
	mysql_real_escape_string(Name, mysql_string);
	SQL("UPDATE accounts SET Demorgan = 0 WHERE NickName = '%s'", mysql_string);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> islaisvino zaideja <a href=../pages/user?name=%s>%s</a> offline is Demorgano. Priezastis: %s", 5, PN(playerid),Name, PN(playerid), PN(playerid), Name, Name, Reason);
}
CMD:setrazdacha(playerid, data[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract data -> new itemId, count; else
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setrazdacha [daikto ID] [kiekis] {FFFFFF}(Noredami isjungti dalijima, naudokite daikto ID kaip 0)");
	if itemId < 0 or sizeof ItemsInfo < itemId *then
		return SendErrorMessage(playerid);
	if count < 1 or count > ItemsInfo[itemId][ItemQuantity] *then
		return SCMF(playerid, COLOR_OLDRED, "[Klaida]{FFFFFF} Siam daiktui dalijimo kiekis turi buti nuo 1 iki %d vnt.", ItemsInfo[itemId][ItemQuantity] );
	SCMF(playerid, COLOR_VALIK, "[Informacija]{FFFFFF} Jus pastatete daikta %s dalijimui ( %d vnt.)", ItemsInfo[itemId][ItemName2], count);
	RazdachaData[razdacha_itemid] = itemId;
	RazdachaData[razdacha_count] = count;
	return true;
}
CMD:giveitem(playerid, params[])
{
	if !CheckFD(playerid, 1) *then
		return false;
	new id, item, amount, zatochka;
	if sscanf(params,"dddd",id,item,amount,zatochka) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /giveitem [zaidejo ID] [daikto ID] [kiekis] [galandimo lygis]");
	if id == INVALID_PLAYER_ID *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {ffffff}Sis zaidejas yra neprisijunges.");
	if !(1 <= item <= sizeof ItemsInfo-1) *then
		return SCM(playerid, COLOR_OLDRED, !"Neteisingas daikto ID!");
    if item >= 1506 && item <= 1510 && !(1 <= zatochka <= 3) *then
    	return SCM(playerid, COLOR_OLDRED, !"Zenkliuko lygis nuo 1 iki 3");
	if !(0 <= zatochka <= 13) *then
 		return SCM(playerid, COLOR_OLDRED, !"Galandimas nuo 0 iki 13");
	if item > 2309 && !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {ffffff}Jus negalite isduoti sio daikto.");
	if zatochka == 13 && !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {ffffff}Galandimas turi buti ne didesnis 13.");
	else if !IsItemValidGiven(item) && !IsAOwner(playerid) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Sio daikto negalima isduoti.");
	if(id == INVALID_PLAYER_ID) return 0;
	if GetInvSet(id) >= PI[id][pInvCell] *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jis neturi pakankamai vietos inventoriuje!");
	AddItem(id, item, amount, zatochka);
	SCMF(playerid, -1, "[/giveitem] Isduota zaidejui %s[ID: %d], daiktas: %s[itemid: %d], kiekis: %dvnt", PN(id), id, ItemsInfo[item][ItemName2], item, amount);
	SaveInventory(id);
	Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave zaidejui <a href=../pages/user?name=%s>%s</a> daikta %s. Kiekis: %d", 5, PN(playerid),PN(id), PN(playerid), PN(playerid), PN(id), PN(id), ItemsInfo[item][ItemName2], amount);
}
CMD:giveitemall(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	new level;
	if sscanf(params,"dddd", params[0], params[1], level) *then
 		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /giveitemall [daikto ID] [kiekis] [galandimas]");
	if ItemsInfo[params[0]][ItemQuantity] < params[1] or params[0] > sizeof ItemsInfo *then
		return 1;
	else if !IsItemValidGiven(params[0]) && !CheckFD(playerid, 2) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Sio daikto negalima isduoti.");
    else if level < 0 or level > 13 *then
		return false;
	else if level == 13 && !IsAOwner(playerid) *then
	    return false;
	foreach(Player, i)
	{
		if(IsPlayerLogged{i}) AddItem(i, params[0], params[1], level);
	}
	f(global_str, 125, "Kurejas %s isdave visiems zaidejams daikta %s kiekyje %d su galandimu +%d", PN(playerid), ItemsInfo[params[0]][ItemName2], params[1], level);
	SCMALL(COLOR_ORANGE, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave visiems zaidejams daikta %s. Kiekis: %d", 5, PN(playerid), "", PN(playerid), PN(playerid), ItemsInfo[params[0]][ItemName2], params[1]);
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
CMD:addbiletall(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract params -> new count; else
		 return SCM(playerid, COLOR_OLDRED, !"Naudokite: /addbiletall [kiekis]");
	if !(1 <= count <= 100) *then
		return false;
	foreach(Player, i) {
		if(IsPlayerLogged{i})
			PI[i][pBilets] += count;
	}
	f(global_str, 125, "Kurejas %s isdave visiems zaidejams %d bilietu [/bilet]", PN(playerid), count);
	SCMALL(COLOR_ORANGE, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave visiems zaidejams %d bilietu. [/bilet]", 5, PN(playerid), "", PN(playerid), PN(playerid), count);
	return true;
}
CMD:addazall(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract params -> new count; else
		 return SCM(playerid, COLOR_OLDRED, !"Naudokite: /addazall [kiekis]");
	if !(1 <= count <= 1000000) *then
		return false;
	foreach(Player, i) {
		if(IsPlayerLogged{i}) GiveDonate(i, count);
	}
	f(global_str, 125,"Kurejas %s isdave visiems zaidejams %d SAG-Coins", PN(playerid), count);
	SCMALL(COLOR_ORANGE, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave visiems zaidejams %d SAG-Coins. [/donate]", 5, PN(playerid), "", PN(playerid), PN(playerid), count);
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
CMD:addruball(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract params -> new count; else
		 return SCM(playerid, COLOR_OLDRED, !"Naudokite: /addruball [kiekis]");
	if !(1 <= count <= 100) *then
		return false;
	foreach(Player, i) {
		if(IsPlayerLogged{i})
			GiveRoubles(i, count, "isdalijimas visiems zaidejams SAG-Eur");
	}
	f(global_str, 125, "Kurejas %s isdave visiems zaidejams %d SAG-Eur! Naudokite /donate", PN(playerid), count);
	SCMALL(COLOR_ORANGE, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave visiems zaidejams %d SAG-Eur. [/donate]", 5, PN(playerid), "", PN(playerid), PN(playerid), count);
	return true;
}
CMD:addtimeall(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract params -> new count; else
		 return SCM(playerid, COLOR_OLDRED, !"Naudokite: /addtimeall [kiekis]");
	if !(1 <= count <= 20) *then
		return false;
	foreach(Player, i) {
		if(IsPlayerLogged{i}) UpdatePlayerDataInt(i, "PlayHour", PI[i][pPlayHours] += count);
	}
	f(global_str, 125, "Kurejas %s isdave visiems zaidejams %d bonus-valandu [/bonus]", PN(playerid), count);
	SCMALL(COLOR_ORANGE, global_str);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave visiems zaidejams %d bonus-valandu. [/bonus]", 5, PN(playerid), "", PN(playerid), PN(playerid), count);
	return true;
}
CMD:kickall(playerid)
{
	if !IsAOwner(playerid) *then
		return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    foreach(Player, i)
    {
        SaveInventory(i);
        Kick(i);
	}
	return true;
}
CMD:gotolobis(playerid, params[])
{
   	if !CheckFD(playerid, 2) *then
		return false;
	extract params -> new idklad; else
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {ffffff}Naudokite: /gotoklad [id]");
	UpdatePlayerPos(playerid, KladInfo[idklad][kladX], KladInfo[idklad][kladY], KladInfo[idklad][kladZ]);
	return SCMF(playerid, -1, "Jus teleportavotes prie lobio ID:%d", idklad);
}
CMD:btcclose(playerid)
{
    if !CheckFD(playerid, 2) *then
		return false;
	bitcoinclose = !bitcoinclose;
	return SCMF(playerid, COLOR_VALIK, "[Uzuomina] {ffffff}Jus sekmingai %s BTC pirkimo sistema centriniame banke", !bitcoinclose ? "isjungete" : "ijungete");
}
alias:checklauncher("cl", "checkl");
cmd:checklauncher(playerid, data[])
{
    extract data -> new player:targetid; else
		 return SCM(playerid, COLOR_OLDRED, !"Naudokite /checklauncher [id]");
    if targetid == INVALID_PLAYER_ID *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Zaidejas nerastas!");
	return CheckLauncher(playerid, targetid);
}
cmd:giverub(playerid, data[])
{
	if(GetString(PN(playerid),"Developer"))
	{
		extract data -> new player:targetId, count; else
			 return SCM(playerid, COLOR_OLDRED, "Naudokite: /giverub [playerId] [count]");
		if !IsPlayerOnline(targetId) *then
			return false;
		GiveRoubles(targetId, count, (str_f("gavimas SAG-Eur is administratoriaus %s", PlayerName[playerid])));
		SAMF(COLOR_OLDRED, "A: %s[%d] isdave %d SAG-Eur zaidejui %s[%d] !", PlayerName[playerid], playerid, count, PlayerName[targetId], targetId);
		return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave %d SAG-Eur zaidejui <a href=../pages/user?name=%s>%s</a>", 5, PN(playerid), PN(targetId), PN(playerid), PlayerName[playerid], count, PN(targetId), PlayerName[targetId]);
	}
	return 1;
}
CMD:addbilet(playerid, params[])
{
	if !CheckFD(playerid, 1) *then
		return false;
	if(sscanf(params, "ui", params[0], params[1]))
		 return SCM(playerid, COLOR_OLDRED, !"Naudokite: /addbilet [id] [amount]");
	if !(1 <= params[1] <= 100) *then
		return false;
    if(!IsPlayerLogged{params[0]}) return SCM(playerid, -1, "Zaidejas nera autorizuotas!");
    UpdatePlayerDataInt(params[0], "Bilets", PI[params[0]][pBilets] += params[1]);
    f(global_str, 145, "[ADMIN] %s[%d] isdave %d bilietu (/bilet)", PN(playerid), playerid, params[1]);
	SendAdminsMessage(COLOR_RED, global_str);
	return 1;
}
CMD:autoslet(playerid)
{
	if AutoSletMP[aWork] *then
	    return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Automatinis iskritimas jau pradetas! Laukite jo pabaigos.");
	if BotSlet *then
	    return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Automatinis iskritimas jau pradetas! Laukite jo pabaigos.");
	return SPD(playerid, 23050, DIALOG_STYLE_INPUT, !"{FFFFFF}Iskritimo tipas | {ae433d}Automatinis iskritimas", !"{FFFFFF}Ka norite isstatyti iskritimui?\nNamas - 0\nVerslas - 1", !"Toliau", !"Atsaukti");
}
cmd:addcode(playerid, params[])
{
    static text[30];
    if !IsAOwner(playerid) *then
		return false;
    if sscanf(params, "s[30]dd", text, params[1], params[2]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /addcode [name] [naudojimo kiekis] [rodyti bendrajame chate (0 - ne, 1 - taip]");
    if params[1] <= 0 or params[2] > 1 or params[2] < 0 *then return false;
    if IsGiftUsed(text) *then
		return SCMF(playerid, COLOR_OLDRED, "[Klaida] {FFFFFF}Dovana %s jau egzistuoja", text);
    SPD(playerid, 29991, DIALOG_STYLE_LIST, !"{FFFFFF}Pasirinkite priza | {ae433d}Kodu sistema", !"{ae433d}[1] {FFFFFF}SAG-Eur\n{ae433d}[2] {FFFFFF}Daiktas\n{ae433d}[3] {FFFFFF}Automobilis\n{ae433d}[4] {FFFFFF}Admin-teises\n{ae433d}[5] {FFFFFF}VIP\n{ae433d}[6] {FFFFFF}Valandos (/bonus)", !"Isrinkti", !"Atgal");
    return SetPVarString(playerid, "gText", text), Int_SetPlayerData(playerid, "gActivations", params[1]), Int_SetPlayerData(playerid, "gForAll", params[2]);
}
cmd:deladmtag(playerid, params[])
{
    if !CheckFD(playerid, 1) *then
		return false;
	if(sscanf(params, "u", params[0]))
		return SCM(playerid, COLOR_OLDRED, "Naudokite: /deladmtag [id]");
	if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return 1;
	if(params[0] != playerid && PI[playerid][pAdmin] == PI[params[0]][pAdmin]) return 1;
	if PI[params[0]][pAdmin] < 0 *then
		return SCM(playerid, COLOR_OLDRED, "[Klaida] {FFFFFF}Sis zaidejas nera administratorius!");
	if !IsPlayerConnected(params[0]) *then
		return SCM(playerid, COLOR_OLDRED, "[Klaida] {FFFFFF}Zaidejas yra neprisijunges!");
	SetString(PI[params[0]][pAdmTag], "None"), SQL("UPDATE `accounts` SET `AdminTag` = 'None' WHERE `ID` = '%d'", PI[params[0]][pID]);
	SetString(PI[params[0]][pAdmTagColor], "FFFFFF"), SQL("UPDATE `accounts` SET `AdminTagColor` = 'FFFFFF' WHERE `ID` = '%d'", PI[params[0]][pID]);
	return SCM(playerid, COLOR_OLDRED, (str_f("[AdminTag] Jus pasalinote tag administratoriui: %s[%d]", PN(params[0]), params[0]))), SendAdminsMessage(COLOR_OLDRED, (str_f("[AdminTag] À: %s[%d] pasalino tag administratoriui %s[%d]", PN(playerid), playerid, PN(params[0]), params[0])));
}
cmd:givepass(playerid, data[])
{
	extract data -> new player:target; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /givepass [ID (-1 - Isduoti visam serveriui)]");
	if target == INVALID_PLAYER_ID *then
		return 0;
	else if !IsPlayerOnline(target) *then
		return SCM(playerid, COLOR_OLDRED, !"Sis zaidejas dar neautorizuotas");
	if(target == -1)
	{
		foreach(Player, i)
		{
			if !IsValidPassport(i) *then
			PassInfo[i][psDateBirth][0] = 7,
			PassInfo[i][psDateBirth][1] = 2,
			PassInfo[i][psDateBirth][2] = 1995,
			PassInfo[i][psDate][0] = 7,
			PassInfo[i][psDate][1] = 2,
			PassInfo[i][psDate][2] = 2022,
			PassInfo[i][psNumber] = 100000 + random(900000),
			PassInfo[i][psSeria] = 1000 + random(9000),
			OnRegPass(target);
			SCMALL(-1, "{8b00ff}[Informacija]{ffffff} Visam serveriui buvo isduotas pasas!");
		}
	}
	else
	if !IsValidPassport(target) *then
		PassInfo[target][psDateBirth][0] = 7,
		PassInfo[target][psDateBirth][1] = 2,
		PassInfo[target][psDateBirth][2] = 1995,
		PassInfo[target][psDate][0] = 7,
		PassInfo[target][psDate][1] = 2,
		PassInfo[target][psDate][2] = 2022,
		PassInfo[target][psNumber] = 100000 + random(900000),
		PassInfo[target][psSeria] = 1000 + random(9000),
		OnRegPass(target);
	else
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Zaidejas jau turi pasa");
	return SCMF(playerid, COLOR_VALIK, "[Informacija] {FFFFFF}Jus sekmingai isdavete pasa zaidejui %s", PN(target));
}
alias:setfulldostup("setfd","setf", "makedostup", "addfd", "makefd", "makefulldostup", "addfulldstoup");
cmd:setfulldostup(playerid, params[])
{
	if !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
	extract params -> new player:id, level; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setfd [id] [levelfd]");
    if !(0 <= level <= 2) *then
     	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setfd [playerid] [0-2]");
	else if !IsPlayerConnected(id) *then
		return false;
 	SCMF(playerid, COLOR_LIGHTBLUE, "Jus suteikete zaidejui %s(%d) visiska prieiga %d lygio", PN(id), id, level);
 	SAMF(COLOR_RED, "Administratorius: %s(%d) suteike [%d] lygio visiska prieiga administratoriui %s(%d)", PN(playerid), playerid, level, PN(id), id);
 	AdminInfo[id][admFullDostup] = level;
    return SQL("UPDATE accounts SET afulldostup = '%d' WHERE NickName = '%s'", AdminInfo[id][admFullDostup], PN(id));
}
cmd:setbiznalog(playerid, params[])
{
    if !CheckFD(playerid, 1) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    extract params -> new bizid, typenalog; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethousenalog [bizid] [nalogs type]"), SCM(playerid, -1, "Tipai: 0 - Ijungti mokescius , 1 - Isjungti mokescius");
	if !(0 <= typenalog <= 1) *then
		return SCM(playerid, COLOR_OLDRED, !"Neteisingas tipas!");
    SCMF(playerid, COLOR_OLDRED, "[Informacija]{ffffff} Jus sekmingai %s mokescius verslui ¹%d!", !typenalog ? "ijungete" : "isjungete", bizid);
    SAMF(COLOR_OLDRED, "[A] %s[%d] %s mokescius verslui ¹%d!", PN(playerid), playerid, !typenalog ? "ijunge" : "isjunge", bizid);
    amlf("Administratorius <a href=../pages/user?name=%s>%s</a> %s mokescius verslui ¹%d!", 5, PN(playerid), "", PN(playerid), PN(playerid), !typenalog ? "ijunge" : "isjunge", bizid);
	return BizData[bizid][bNoNalogs] = typenalog, UpdateBusinessText(bizid, 1);
}
cmd:sethousenalog(playerid, params[])
{
    if !CheckFD(playerid, 1) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    extract params -> new houseid, typenalog; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethousenalog [houseid] [nalogs type]"), SCM(playerid, -1, "Tipai: 0 - Ijungti mokescius , 1 - Isjungti mokescius");
	if !(0 <= typenalog <= 1) *then
		return SCM(playerid, COLOR_OLDRED, !"Neteisingas tipas!");
    SCMF(playerid, COLOR_OLDRED, "[Informacija]{ffffff} Jus sekmingai %s mokescius namui ¹%d!", !typenalog ? "ijungete" : "isjungete", houseid);
    SAMF(COLOR_OLDRED, "[A] %s[%d] %s mokescius namui ¹%d!", PN(playerid), playerid, !typenalog ? "ijunge" : "isjunge", houseid);
    amlf("Administratorius <a href=../pages/user?name=%s>%s</a> %s mokescius namui ¹%d!", 5, PN(playerid), "", PN(playerid), PN(playerid), !typenalog ? "ijunge" : "isjunge", houseid);
	return HouseInfo[houseid][hNoNalogs] = typenalog, UpdateHouse(houseid);
}
cmd:sethouseowner(playerid, params[])
{
    if !CheckFD(playerid, 1) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    static houseid, owner[124];
    if sscanf(params, "ds[24]", houseid, owner) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /sethouseowner [id] [name]");
    if houseid < 0 || houseid > OWNABLEHOUSES-1 *then
		return 1;
    SCMF(playerid, COLOR_OLDRED, "[Informacija]{ffffff} Jus sekmingai pakeitete namo ¹%d savininka is %s i %s.", houseid, HouseInfo[houseid][hOwner], owner);
    SAMF(COLOR_OLDRED, "[A] %s[%d] pakeite namo ¹%d savininka is %s i %s.", PN(playerid), playerid, houseid, HouseInfo[houseid][hOwner], owner);
    amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pakeite namo ¹%d savininka is %s i %s!", 5, PN(playerid), owner, PN(playerid), PN(playerid), houseid, HouseInfo[houseid][hOwner], owner);
    SetString(HouseInfo[houseid][hOwner], owner);
    HouseInfo[houseid][hNalog] =
	HouseInfo[houseid][hNalog2] = 0;
    return UpdateHouse(houseid);
}
cmd:setbizowner(playerid, params[])
{
    if !CheckFD(playerid, 1) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    static bizid, owner[124];
    if sscanf(params, "ds[24]", bizid, owner) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setbizowner [id] [name]");
    if bizid < 0 || bizid > OWNABLEBIZES-1 *then
		return 1;
    SCMF(playerid, COLOR_OLDRED, "[Informacija]{ffffff} Jus sekmingai pakeitete verslo ¹%d savininka is %s i %s.", bizid, BizData[bizid][bOwner], owner);
    SAMF(COLOR_OLDRED, "[A] %s[%d] pakeite verslo ¹%d savininka is %s i %s.", PN(playerid), playerid, bizid, BizData[bizid][bOwner], owner);
    amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pakeite verslo ¹%d savininka is %s i %s!", 5, PN(playerid), owner, PN(playerid), PN(playerid), bizid, BizData[bizid][bOwner], owner);
    SetString(BizData[bizid][bOwner], owner);
    BizData[bizid][bLevel] = 0;
    SQL("UPDATE `businesses` SET `opisanie` = '' WHERE `ID` = '%d'", bizid);
    return UpdateBusinessText(bizid, 1);
}
cmd:tpplayer(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return 1;
	extract params -> new id, typetp; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /tpplayer [id] [tipas]"), SCM(playerid, -1, !"Tipai: 1 - Autobazaras, 2 - CR, 3 - LV Bankas");
    if id == INVALID_PLAYER_ID *then
		return false;
    if(PI[playerid][pAdmin] < PI[id][pAdmin]) return 1;
    if(id != playerid && PI[playerid][pAdmin] == PI[id][pAdmin]) return 1;
	static Float:TeleportPos[3][3] = {{-2138.8440, -752.1163, 32.0234}, {1128.6570, -1424.4794, 15.7969}, {2375.1499, 2316.6741, 8.1406}};
	static const TeleportName[][] = {"AutoBazaras", "Centrinis Rinkas", "LV Bankas"};
    SCMF(id, COLOR_VALIK, "[Informacija] {FFFFFF}Administratorius %s[%d] teleportavo jus i %s", PN(playerid), playerid, TeleportName[typetp-1]);
    SAMF(COLOR_GREY, "[A] %s[%d] teleportavo %s[%d] i %s", PN(playerid), playerid, PN(id), id, TeleportName[typetp-1]);
    return SetPlayerVirtualWorld(id, 0), SetPlayerInterior(id, 0), UpdatePlayerPos(id, TeleportPos[typetp-1][0], TeleportPos[typetp-1][1], TeleportPos[typetp-1][2]);
}
cmd:updatemodellimitcars(playerid)
{
    if !CheckFD(playerid, 2) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
	return SetTimer("Modellimit", 1, false);
}
cmd:checkadmpass(playerid, params[])
{
	if !CheckFD(playerid, 1) *then return false;
	extract params -> new id; else
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checkadmpass [id]");
	if !IsPlayerOnline(id) or !PI[id][pAdmin] *then return false;
	return SCMF(playerid, COLOR_VALIK, "[Informacija] {FFFFFF}Administratoriaus %s[%d] slaptazodis: %s", PN(id), id, PI[id][pAPass]);
}
cmd:ainvite(playerid)
{
	status_autoinvite = !status_autoinvite;
	return SAMF(COLOR_GREY, "[A] A: %s[%d] %s auto-invite.", PN(playerid), playerid, status_autoinvite ? "atidare" : "uzdare");
}
cmd:changebiz(playerid, params[])
{
 	if !CheckFD(playerid, 2) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    extract params -> new bizid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /changebiz [id]");
    if(bizid > OWNABLEBIZES)
		return 1;
	GetPlayerPos(playerid, BizData[bizid][bEnter_X], BizData[bizid][bEnter_Y], BizData[bizid][bEnter_Z]);
	DelBizData(bizid);
	SetBizData(bizid, B_PICKUP_ID, CreateDynamicPickup(BizData[bizid][bPickup] ? 1239:19132, 23, BizData[bizid][bEnter_X], BizData[bizid][bEnter_Y], BizData[bizid][bEnter_Z], 0, 0));
	SetBizData(bizid, B_AREA_ID, CreateDynamicSphere(BizData[bizid][bEnter_X], BizData[bizid][bEnter_Y], BizData[bizid][bEnter_Z], 2.0, 0, 0));
	SetBizData(bizid, B_TEXT_ID, CreateDynamic3DTextLabel(" Áèçíåñ ",0x4CD10FF,BizData[bizid][bEnter_X], BizData[bizid][bEnter_Y],BizData[bizid][bEnter_Z],20.0));
	if BizData[bizid][bMapIcon] *then
		SetBizData(bizid, B_ICON_ID, CreateDynamicMapIcon(BizData[bizid][bEnter_X], BizData[bizid][bEnter_Y], BizData[bizid][bEnter_Z], BizData[bizid][bMapIcon], 0, -1, -1, -1, 300.0));
	UpdateBusinessText(bizid, 1);
    return SCM(playerid, COLOR_OLDRED, !"business suc transportation to you mark point");
}
cmd:asellsandelis(playerid, params[])
{
	if !CheckFD(playerid, 2) *then
	    return false;
    extract params -> new skladid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /asellsandelis [sandelio id(uid)]");
	if(skladid > OWNABLESKLADS)
	    return 0;
    foreach(new i: Player)
	{
	    if PI[i][pSkladKey] == skladid *then
		{
			PI[i][pSkladKey] = -1;
			SCMF(i, COLOR_RED, "A: %s[%d] anuliavo jusu sandeli ¹%d.", PN(playerid), playerid, skladid);
		}
	}
	f(global_str, 256, "UPDATE `accounts` SET `SkladKey` = '-1' WHERE `NickName` = '%s';", SkladData[skladid][skOwner]);
	mysql_tquery(mysql, global_str);
	SetString(SkladData[skladid][skPassword], "1111");
	SQL("UPDATE `sklads` SET `Owner` = 'The State', `Password` = '1111', `Item` = '0', `ItemCount` = '0', `ItemLevel` = '0', `ItemProc` = '0', `ItemTypeNashiv` = '0', `ItemLvlNashiv` = '0' WHERE `ID` = %d;", SkladData[skladid][skID]);
	amlf("Administratorius <a href=../pages/user?name=%s>%s</a> pardave sandeli %d. Buves savininkas: %s.", 5, PN(playerid),"", PN(playerid), PN(playerid), skladid, SkladData[skladid][skOwner]);
    f(global_str, 145, "A: %s pardave sandeli %d [ %s ]!", PN(playerid), skladid, SkladData[skladid][skOwner]);
    SendAdminsMessage(COLOR_GREY, global_str);
    for new i; i < 150; i++ do
    {
        SkladData[skladid][skItem][i] = 0;
        SkladData[skladid][skItemCount][i] = 0;
        SkladData[skladid][skItemLevel][i] = 0;
		SkladData[skladid][skItemProc][i] = 0;
        SkladData[skladid][skItemTypeNashiv][i] = 0;
        SkladData[skladid][skItemLvlNashiv][i] = 0;
        SkladData[skladid][skItemColor][i] = 0;
    }
    SetString(SkladData[skladid][skOwner], "The State");
	SkladData[skladid][skMoney] = 0;
	UpdateSklad(skladid);
	if(SkladDoors[skladid][spdOpen])
	{
		MoveDynamicObject(SkladDoorObject[skladid], SkladDoors[skladid][spdX], SkladDoors[skladid][spdY], SkladDoors[skladid][spdZ], 4, SkladDoors[skladid][spdrX], SkladDoors[skladid][spdrY], SkladDoors[skladid][spdrZ]);
		SkladDoors[skladid][spdOpen] = false;
		Delete3DTextLabel(Sklad3DText[skladid]);
		DestroyPickup(SkladPickInt[skladid]);
	}
	return Int_SetPlayerData(playerid, "NakazLastTime", Global_Time);
}
cmd:gotosandelis(playerid, params[])
{
	extract params -> new sklid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gotosandelis [uid]");
	new world;
	if sklid > OWNABLESKLADS *then
	    return 0;
	switch sklid do
	{
	    case 0..49: world = 101;
	    case 50..99: world = 102;
	    case 100..149: world = 103;
	    case 150..199: world = 104;
	    case 200..249: world = 105;
	    case 250..299: world = 106;
	    case 300..349: world = 107;
	    case 350..399: world = 108;
	    case 400..449: world = 109;
	    case 450..499: world = 110;
	}
	SetPlayerVirtualWorld(playerid, world), SetPlayerInterior(playerid, 104);
	UpdatePlayerPos(playerid, SkladData[sklid][skCoords][0], SkladData[sklid][skCoords][1], SkladData[sklid][skCoords][2]);
	return SCMF(playerid, -1, "Jus teleportavotes prie sandelio ID:%d", sklid);
}
CMD:checksandelis(playerid, params[])
{
	if sscanf(params, "d", params[0]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checksandelis [uid sandelio]");
	if params[0] < 0 || params[0] > OWNABLESKLADS *then
		return false;
	new item, count;
	global_str = "Pavadinimas\tKiekis\n";
	for new i; i < 150; i++ do
	{
		item = SkladData[params[0]][skItem][i],
		count = SkladData[params[0]][skItemCount][i];
		if !count || !item *then
			continue;
		f(global_str,  sizeof global_str, "%s[%d] %s\t%d\n", global_str, i+1, ItemsInfo[item][ItemName2], count);
	}
	return SPD(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, (str_f("Sandelio ¹%d turinys", params[0])), global_str, !"Uzdaryti", !"");
}
cmd:gototrash(playerid, params[])
{
	extract params -> new trashid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /gototrash [id]");
	SetPlayerVirtualWorld(playerid, 0), SetPlayerInterior(playerid, 0);
	UpdatePlayerPos(playerid, MusorPos[trashid][0], MusorPos[trashid][1], MusorPos[trashid][2]);
	return SCMF(playerid, -1, "Jus teleportavotes prie siuksliadezes ID:%d", trashid);
}
CMD:open_server(playerid, params[])
{
	if !IsAOwner(playerid) *then
	    return false;
	if sscanf(params, "i", params[0]) *then
	    return SCM(playerid, -1, "Naudokite: /open_server [id]"), SCM(playerid, -1, "0 - pasalinti slaptazodi | 1 - nustatyti atsitiktini slaptazodi");
    Open_Server(params[0]);
	return 0;
}
CMD:setlangelis(playerid, params[])
{
	if !IsAOwner(playerid) *then
	    return false;
	if sscanf(params, "ii", params[0], params[1]) *then
	    return SCM(playerid, COLOR_OLDRED, "Naudokite: /setlangelis [id] [langelis]");
	PI[playerid][pInvCell] = params[1];
	UpdatePlayerDataInt(playerid, "InvCell", PI[playerid][pInvCell]);
	SCMF(playerid, COLOR_VALIK, "[Uzuomina]{FFFFFF} Jus nustatete zaidejui %s[%i] langeliu: %i", PN(params[0]), params[0], params[1]);
	return 0;
}
CMD:payday(playerid, params[])
{
	if !IsAOwner(playerid) *then
	    return false;
	if sscanf(params, "i", params[0]) *then
	    return SCM(playerid, -1, "Naudokite: /payday [counts]");
 	PI[playerid][pPlayedTime] = 1201;
	PayDay(params[0]);
	return 0;
}
cmd:createcustomlobis(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2] );
	if Iter_Free(Klad) == -1 *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Visos lobiu vietos uzimtos :(");
	return CreateKlad(Iter_Free(Klad), pos[0], pos[1], pos[2] - 1.3);
}
cmd:giveadmzp(playerid, params[])
{
	if !CheckAdm(playerid, 7) *then
		return false;
	extract params -> new player:target, value; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /giveadmzp [id] [value]");
	AddItem(target, 2467, value);
	SaveInventory(target);
	return SCM(playerid, -1, "Jus sekmingai isdavete admin-atlyginima administratoriui!");
}
cmd:giveadmzpaz(playerid, params[])
{
	new Float:radius = 25,Float:x,Float:y,Float:z;
	new admin_static;
	if !CheckAdm(playerid, 7) *then
		return false;
	extract params -> new value; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /giveadmzpaz [value] (Jus turite buti /AZ)");
	if(value > 100) return SCM(playerid, COLOR_GREY, !"[Klaida] Negalima isduoti daugiau nei 100 admin-atlyginimo!");
	foreach(Admin, i)
    {
		GetPlayerPos(playerid,x,y,z);
		if(IsPlayerInRangeOfPoint(i,radius,x,y,z))
		{
			AddItem(i, 2467, value);
			SaveInventory(i);
			SCMF(i, COLOR_OLDRED, "Administratorius %s[%d] jums isdave admin-atlyginima.", PN(playerid), playerid);
			admin_static++;
		}
	}
	return SCMF(playerid, -1, "Jus sekmingai isdavete admin-atlyginima %i adminams!", admin_static);
}
CMD:createpromo(playerid)
{
	if !CheckAdm(playerid, 5) *then
		return false;
	SPD(playerid, 1994, DIALOG_STYLE_INPUT, "Promocode kurimas", "{ffffff}Nurodykite promocode:\n{ffff00}Pavyzdys:{ffffff} #sag", "Atlikta", "Atsaukti");
	return 1;
}
CMD:dhouse(playerid, params[])
{
    if(AdminInfo[playerid][admFullDostup] < 2) return 0;
    extract params -> new houseid; else
        return SCM(playerid, COLOR_OLDRED, !"Naudokite: /dhouse [id]");
    if(houseid < 0 || houseid > OWNABLEHOUSES)
        return 0;

    // Jei namas turi savininka (nera valstybinis)
    if(!GetString(HouseInfo[houseid][hOwner], "The State"))
    {
        new player = GetPlayerID(HouseInfo[houseid][hOwner]);
        if(IsPlayerOnline(player))
        {
            PI[player][pHouseKey] -1;
            // Jei vartotojo lenteleje stulpelis vadinasi kitaip (pvz. pHouse), pasikeiskite cia:
            mysql_tquery(mysql, "UPDATE users SET HouseKey = -1 WHERE Name = '"__", HouseInfo[houseid][hOwner]); // Jei žaidejas prisijunges
        }
        else
        {
            // Jei neprisijunges - atnaujiname duomenu bazeje pagal žaidejo varda
            mysql_format(mysql, global_str, sizeof(global_str), "UPDATE users SET HouseKey = -1 WHERE Name = '%e' LIMIT 1", HouseInfo[houseid][hOwner]);
            mysql_tquery(mysql, global_str);
        }
    }

    // Ištriname nama iš duomenu bazes pagal jo ID (patikrinkite, ar jusu DB stulpelis vadinasi 'ID' ar 'id')
    mysql_format(mysql, global_str, sizeof(global_str), "DELETE FROM houses WHERE ID = '%d'", houseid);
    mysql_tquery(mysql, global_str);

    // Sunaikiname vizualius elementus (ikonas, tekstus, pickupus)
    if(IsValidDynamicMapIcon(HouseIcon[houseid]))
        DestroyDynamicMapIcon(HouseIcon[houseid]), HouseIcon[houseid] = INVALID_STREAMER_ID;
    if(IsValidDynamicPickup(HouseInfo[houseid][H_PICKUP_ID]))
        DestroyDynamicPickup(HouseInfo[houseid][H_PICKUP_ID]), HouseInfo[houseid][H_PICKUP_ID] = INVALID_STREAMER_ID;
    if(IsValidDynamicArea(HouseInfo[houseid][H_AREA_ID]))
        DestroyDynamicArea(HouseInfo[houseid][H_AREA_ID]), HouseInfo[houseid][H_AREA_ID] = INVALID_STREAMER_ID;
    if(IsValidDynamicPickup(HouseGaragePickup[houseid]))
        DestroyDynamicPickup(HouseGaragePickup[houseid]), HouseGaragePickup[houseid] = INVALID_STREAMER_ID;
    if(IsValidDynamic3DTextLabel(HouseGarage3DText[houseid]))
        DestroyDynamic3DTextLabel(HouseGarage3DText[houseid]), HouseGarage3DText[houseid] = ScriptText3D:INVALID_STREAMER_ID;
    if(IsValidDynamic3DTextLabel(House3DText[houseid]))
        DestroyDynamic3DTextLabel(House3DText[houseid]), House3DText[houseid] = ScriptText3D:INVALID_STREAMER_ID;

    // Svarbu: Atstatome namo kintamuosius atmintyje i pradine (laisvo namo) busena
    format(HouseInfo[houseid][hOwner], MAX_PLAYER_NAME, "The State");
    // Cia galite prideti kitu HouseInfo kintamuju nulinima, pvz., cenu nustatyma iš naujo.

    return SCMF(playerid, -1, "Jus sekmingai pašalinote nama ID:%d", houseid);
}
CMD:dbiz(playerid, params[])
{
	if(AdminInfo[playerid][admFullDostup] < 2) return 0;
	extract params -> new bizid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /dbiz [id]");
	if bizid > OWNABLEBIZES *then
	    return 0;
    f(global_str, 256, "DELETE FROM `businesses` WHERE `ID` = '%d'", bizid);
    DelBizData(bizid);
	return SCMF(playerid, -1, "Jus pasalinote versla ID:%d", bizid);
}
cmd:setqp(playerid, params[])
{
	if(AdminInfo[playerid][admFullDostup] < 2) return 0;
	extract params -> new id, qid, value; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setqp [id] [id quest] [progresas]");
    QuestProgress[id][qid] = value;
	return 1;
}
cmd:setbiztypecost(playerid, params[])
{
	if !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
	new
	    bizid,
	    type;
	if(sscanf(params, "dd", bizid, type))
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setbiztypecost [id] [type]");
    SCM(playerid, COLOR_OLDRED, !"{FFFFFF}0 - MONEY | 1 - SAG-COINS | 2 SAG-EUR");
    BizData[bizid][bCostType] = type;
    UpdateBusinessText(bizid, 1);
    return SCM(playerid, COLOR_RED, !"atlikta");
}
cmd:setbiztype(playerid, params[])//Adm
{
	if !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
    new
	    bizid,
	    type;
	if(sscanf(params, "dd", bizid, type))
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setbiztype [id] [type]");
    if(bizid < 0 || bizid > OWNABLEBIZES-1) return 1;
    BizData[bizid][bState] = type;
    UpdateBusinessText(bizid, 1);
    return SCM(playerid, -1, !"ATLIKTA");
}
CMD:givevideocard(playerid, params[])
{
    if !IsAOwner(playerid) *then
		return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
	new id, count, level;
    if(sscanf(params, "ii", id, count, level)) return SCM(playerid, COLOR_RED, !"Naudokite: /givevideocard [id] [kiekis] [1-10 lvl]");
	AddItem(id, 1503, count, level);
    new scmfstr[145];
	f(scmfstr, sizeof(scmfstr), "[Informacija] {ffffff}Jus sekmingai isdavete vaizdo plokste %s lygio (%d vnt) zaidejui %s[%d]", level, count, PN(id), id);
	SCM(playerid, COLOR_VALIK, scmfstr);
	f(scmfstr, sizeof(scmfstr), "[Informacija] {ffffff}Administratorius %s[%d] isdave jums vaizdo plokste %s lygio (%d vnt)", PN(playerid), playerid, level, count);
	SCM(id, COLOR_VALIK, scmfstr);
	SAMF(COLOR_RED, "Administratorius %s[%d] isdave zaidejui %s[%d] vaizdo plokste %s lygio (%d vnt)", PN(playerid), playerid, PN(id), id, level, count);
	return 1;
}
CMD:getinfocar(playerid, params[])
{
	if !CheckAdm(playerid, 2) *then
		return SCM(playerid, COLOR_OLDRED, NO_ACCES_TEXT);
	extract params -> new carid; else return SendClientMessage(playerid, -1, "{AAFFAA}Naudokite: {AAAAAA}/getinfocar [carid]");
	new Float:car_pos[3];
	GetVehiclePos(carid, car_pos[0], car_pos[1], car_pos[2]);
	SendClientMessagef(playerid, -1, "{AAFFAA}Informacija apie transporta {AFAFAF}#%i", carid);
	return SendClientMessagef(playerid, -1, "{AAFFAA}Modelis %i | X (%f), Y (%f), Z (%f) | VirtualWorld %i", GetVehicleModel(carid), car_pos[0], car_pos[1], car_pos[2], GetVehicleVirtualWorld(carid));
}
CMD:label(playerid, params[])
{
	if(PI[playerid][pAdmin] < 8)
		return SCM(playerid, COLOR_RED, NO_ACCES_TEXT);
	if(!ADuty{playerid})
		return SCM(playerid, COLOR_GREY, NO_DUTY_TEXT);
    if(sscanf(params, "s[128]", params[0]))
        return SendClientMessage(playerid, COLOR_GREEN, "Naudokite: /label [tekstas]"); // patikrinimas i ivesta teksta
    new Float:nxyz[3];
    GetPlayerPos(playerid, nxyz[0], nxyz[1], nxyz[2]); // suzinom koordinates
    static const fmt_str[] = "%s";
    new string[sizeof(fmt_str)-2+128];
    format(string, sizeof(string), fmt_str, params[0]);
    Create3DTextLabel(string,COLOR_GREY,nxyz[0],nxyz[1],nxyz[2],10.0,GetPlayerVirtualWorld(playerid), 1); // kuriam 3D teksta
    return true;
}
CMD:narkfull(playerid, params[])
{
	if(PI[playerid][pAdmin] < 5)
		return SCM(playerid, COLOR_RED, NO_ACCES_TEXT);
	if(!ADuty{playerid})
		return SCM(playerid, COLOR_GREY, NO_DUTY_TEXT);
	GLS[45] += 100000;
	GLS[46] += 100000;
	GLS[47] += 100000;
	GLS[48] += 100000;
	GLS[49] += 100000;
	SendClientMessage(playerid, COLOR_GREY, "Jus sekmingai papildete narkotiku landynes!");
	return 1;
}
CMD:narkprice(playerid, params[])
{
	if(PI[playerid][pAdmin] < 5)
		return SCM(playerid, COLOR_RED, NO_ACCES_TEXT);
	if(!ADuty{playerid})
		return SCM(playerid, COLOR_GREY, NO_DUTY_TEXT);
	GLS[50] = 10000;
	GLS[51] = 10000;
	GLS[52] = 10000;
	GLS[53] = 10000;
	GLS[54] = 10000;
	GLS[55] = 10000;
	GLS[56] = 10000;
	GLS[57] = 10000;
	GLS[58] = 10000;
	GLS[59] = 10000;
	SendClientMessage(playerid, COLOR_GREY, "Jus sekmingai nustatete kainas narkotiku landynese!");
	return 1;
}
cmd:ungiveeur(playerid, params[])
{
    if PI[playerid][pAdmin] < 8 *then return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jus neturite prieigos prie sios komandos.");
   	extract params -> new player:targetid, money; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /ungiveeur [targetid] [kiekis]");
	if !ProxDetectorS(10.0, playerid, targetid) *then
		return SCM(playerid,COLOR_GREY, !"Jus esate per toli nuo zaidejo");
	else if playerid == targetid *then
		return SCM(playerid,COLOR_GREY, !"Negalima atimti SAG-EUR is saves");
	else  if !(1 <= money <= PI[targetid][pRoubles]) *then
		return SCM(playerid, COLOR_RED,!"[Klaida]{FFFFFF} Zaidejas neturi pakankamai SAG-EUR.");
	else if money > 50000 *then
		return SCM(playerid,COLOR_RED, !"[Klaida]{FFFFFF} Negalima atimti daugiau nei 50000 SAG-EUR per karta!");
	GiveRub(targetid, -money);
	GiveRub(playerid, money);
	SCMF(playerid, COLOR_VALIK, "[Uzuomina]{FFFFFF} Jus sekmingai atemete %d SAG-EUR is zaidejo %s[%d]!", money, PN(targetid), targetid);
	return SAMF(COLOR_VALIK, "[A] %s[%d] ateme %d SAG-EUR is zaidejo %s[%d]", PN(playerid), playerid, money, PN(targetid), targetid);
}
CMD:delleur(playerid, params[])
{
    if PI[playerid][pAdmin] < 8 *then return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jus neturite prieigos prie sios komandos.");
	static id;
	if(sscanf(params, "dd", id)) return SendClientMessage(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite /delleur [id]");
	if(id == INVALID_PLAYER_ID) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra neprisijunges!");
	static strings[145];
	format(strings,sizeof(strings),"[A] Administratorius %s anuliavo zaidejui %s SAG-EUR",PN(playerid),PN(id));
	SendAdminsMessage(COLOR_GREY,strings);
	PI[id][pRoubles] = 0;
	UpdatePlayerDataInt(playerid, "Roubles", PI[playerid][pRoubles]);
    return 1;
}
cmd:botandstats(playerid) return SendClientMessagef(playerid, -1, "Is viso sunaudota - %d$", botand_stats_money);
cmd:admins(playerid) return ShowAdminListt(playerid, 0);
cmd:giveitemoff(playerid,data[]) {

	if PI[playerid][pAdmin] < 8 *then return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jus neturite prieigos prie sios komandos.");
	if sscanf(data, "s[24]ii", demote_name, data[0], data[1]) *then
		return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Naudokite: /giveitemoff [nick] [daikto ID] [kiekis]");
	if !(GetPlayerID(demote_name) == INVALID_PLAYER_ID) *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Zaidejas yra prisijunges!");
	if !(1 <= data[0] <= sizeof ItemsInfo-1) *then
		return SCM(playerid, COLOR_RED,"[Klaida]{FFFFFF} Neteisingas daikto kiekis!");
	else if !IsItemValidGiven(data[0]) *then
		return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Sio daikto isduoti negalima.");
	format(global_str, 250, "SELECT `Item`, `ItemKolvo`, `ItemLevel`, `ItemProc`, `InvCell` FROM accounts WHERE NickName = BINARY('%s') LIMIT 1;", demote_name);
    mysql_tquery(mysql, global_str, "@AddItemOFF", "ddds", playerid,data[0],data[1],demote_name);
	return true;
}
CMD:o(playerid, params[])
{
	if PI[playerid][pAdmin] < 4 *then return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jus neturite prieigos prie sios komandos.");
	static Admin[73], text[94];
	Admin[0] = EOS;
	if(sscanf(params, "s[94]", text)) return SCM(playerid, COLOR_RED, !"Naudokite: /o [text]");
	if(strlen(text) > 94) return SCM(playerid, COLOR_RED, !"Naudokite: /o [text]");
	f(global_str, 145," {F12548}[OOC] {FFFFFF}%s: {3C56E5}%s", PN(playerid), text),
	SCMALL(COLOR_GOLD, global_str);
	return 1;
}
CMD:dellveh(playerid, params[])
{
    if(PI[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "");
	extract params -> new carid; else return SendClientMessage(playerid, -1, "{AAFFAA}Naudokite: {AAAAAA}/delveh [carid]");
	DestroyVehicle(carid);
	return SendClientMessagef(playerid, -1, "{AAFFAA}Transportas %i pasalintas", carid);
}
CMD:musicall(playerid, params[])
{
    if PI[playerid][pAdmin] < 8 *then return 1;
	if(!ADuty{playerid}) return SCM(playerid,COLOR_GREY,"");
	if(MusicAll)
	{
		foreach(new i: Player) StopAudioStreamForPlayer(i);
		MusicAll = false;
		return SCM(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus sekmingai isjungete muzika visiems!");
	}
	static url[1024];
	if(sscanf(params,"s[1024]", url)) return SCM(playerid, COLOR_LIGHTRED, !"[Klaida] {FFFFFF}Naudokite: /musicall [url (nuoroda audio-file)]");
	foreach(new i: Player) PlayAudioStreamForPlayer(i, url);
	MusicAll = true;
	return 1;
}
CMD:stopcapt(playerid)
{
	new string[128];
	if(PI[playerid][pAdmin] < 4) return SendClientMessage(playerid, -1, "Negalima");
	if(CaptureTime[0]==0 || CaptureTime[1]==0) return SendClientMessage(playerid, COLOR_GREY, !"Siuo metu niekas nekovoja");
	format(string, sizeof(string), "> Administratorius %s(%d) sustabde kova.", PN(playerid), playerid);
	SendClientMessageToAll(COLOR_RED,string);
	CaptureTime[0]=0; CaptureTime[1]=0;
	UpdateDorm(CaptureDef);
	UpdateDorm(CaptureAtac);
	CaptureDef = -1;
	CaptureAtac = -1;
	CaptureZone = -1;
	SaveGangZone(CaptureZone);
	return true;
}
CMD:unjp(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	PlayerPlaySound(playerid,1063,0.0,0.0,0.0);
	return true;
}
CMD:crash(playerid, params[])
{
    if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, -1, "Naudokite: /crash [zaidejo ID / Vardas / Nicko dalis");
    new giveplayer[MAX_PLAYER_NAME];
    GetPlayerName(params[0], giveplayer, sizeof(giveplayer));
    if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, -1, "Zaidejas yra neprisijunges prie serverio!");
    GameTextForPlayer(params[0], "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
    GameTextForPlayer(params[0], "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
    GameTextForPlayer(params[0], "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
    GameTextForPlayer(params[0], "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
    GameTextForPlayer(params[0], "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
    GameTextForPlayer(params[0], "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
    GameTextForPlayer(params[0], "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
    return 1;
}
CMD:checktime(playerid, params[])
{
	if(PI[playerid][pAdmin] < 5) return SCM(playerid, COLOR_RED, "");
	extract params -> new id; else return SCM(playerid, COLOR_RED, !"Naudokite: /checktime [id]");
	return SCMF(playerid, -1, "Nick: %s suzaide: %d valandu", PN(id), PI[id][pPlayHours]);
}
CMD:checkmult(playerid, params[])
{
	if(PI[playerid][pAdmin] < 6) return SCM(playerid, COLOR_GREY, !"Prieiga uzdrausta!");
	if(sscanf(params, "s[16]", params[0])) return SCM(playerid, COLOR_YELLOW, "Naudokite:{ffffff} /checkmult [IP]");
	f(global_str, 256, "SELECT `ID`,`NickName`,`Money`,`Level`,`VirMoney` FROM `accounts` WHERE `RegIP` REGEXP '%s'", params[0]);
	new Cache:result = mysql_query(mysql, global_str);
	new rows = cache_num_rows();
	if(rows)
	{
		new nn[MAX_PLAYER_NAME], money, idakk, level, vm;
		format(global_str, 64, "Nick\t\t\tPinigai\t\tSAG-Coins\t\tLygis\tID (DB)\n\n");
        for(new i; i<rows; i++)
		{
		    idakk = cache_get_field_content_int(i, "ID");
			cache_get_row(i, 1, nn, mysql, MAX_PLAYER_NAME);
			money = cache_get_field_content_int(i, "Money");
			level = cache_get_field_content_int(i, "Level");
			vm = cache_get_field_content_int(i, "VirMoney");
			f(global_str, 1024, "{ffffff}%s%s\t\t%d$\t\t%d SAG-Coins\t\t%d\t\t%d\n",global_str,nn,money,vm,level,idakk);
		}
		SPD(playerid, 0, 0, params[0], global_str, "Uzdaryti", "");
	}
	else SCM(playerid, COLOR_GREY, "[Klaida] Paskyros su siuo IP nerastos!");
	cache_delete(result);
	return 1;
}
cmd:alogo(playerid)
{
	if(PI[ playerid ][ pAdmin ] > 1) AdminText3D[playerid] = CreateDynamic3DTextLabel("Administratorius", 0xAFAFAFFF, 0.0, 0.0, 0.0, 50.0, playerid,-1, 0, -1, -1, -1);
	return 1;
}
CMD:captureoff(playerid, params[])
{
	if(PI[ playerid ][ pAdmin ] < 4)
		return 1;
	if(usecapt == 0)
	{
		SendClientMessage(playerid,COLOR_GREY,"Jus uzdraudete kova.");
		SAMF(COLOR_LIGHTRED,"{FFFF00}[A] {FFFFFF}Administratorius %s uzdraude kova. {CCCCCC}(/captureoff)", PN(playerid));
		usecapt = 1;
	}
	else
	{
		SendClientMessage(playerid,COLOR_GREY,"Jus leidote kova.");
		SAMF(COLOR_LIGHTRED,"{FFFF00}[A] {FFFFFF}Administratorius %s aktivavo kova. {CCCCCC}(/captureoff)", PN(playerid));
		usecapt = 0;
	}
	return 1;
}
cmd:gl(playerid, params[])
{
	if(PI[ playerid ][ pAdmin ] < 1) return SCM(playerid, -1, "Si funkcija prieinama tik administratoriams!");
	rainbow_status{playerid} = !rainbow_status{playerid};
	SendClientMessage(playerid, 0xFF6600FF, rainbow_status{playerid} ? (!"Jus sekmingai {66CC00}ijungete {FF6600}vaivorykstini clist") : (!"Jus sekmingai {66CC00}isjungete {FF6600}vaivorykstini clist"));
	return 1;
}
cmd:gg(playerid)
{
    if(GetPVarInt(playerid, #AFvr) > gettime() && !IsAOwner(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
	if(PI[ playerid ][ pAdmin ] < 1) return SCM(playerid, -1, "Si funkcija prieinama tik administratoriams!");
	foreach(new i: Player) SCMF(i, -1, "{ffffff}Administratorius {8b00ff}%s{ffffff} linki jums malonaus zaidimo {8b00ff}San Andreas Gyvenimas!", PN(playerid));
    SetPVarInt(playerid, #AFvr, gettime()+60);
	return 1;
}
cmd:up(playerid)
{
	new Float:plocx,Float:plocy,Float:plocz;
	if(PI[playerid][pAdmin] < 1) return 1;
	GetPlayerPos(playerid, plocx, plocy, plocz);
	SetPlayerPos(playerid, plocx, plocy, plocz+2);
	return 1;
}
cmd:down(playerid)
{
	new Float:plocx,Float:plocy,Float:plocz;
	if(PI[playerid][pAdmin] < 1) return 1;
	GetPlayerPos(playerid, plocx, plocy, plocz);
	SetPlayerPos(playerid, plocx, plocy, plocz-2);
	return 1;
}
cmd:left(playerid)
{
	new Float:plocx,Float:plocy,Float:plocz;
	if(PI[playerid][pAdmin] < 1) return 1;
	GetPlayerPos(playerid, plocx, plocy, plocz);
	SetPlayerPos(playerid, plocx, plocy-2, plocz);
	return 1;
}
cmd:right(playerid)
{
	new Float:plocx,Float:plocy,Float:plocz;
	if(PI[playerid][pAdmin] < 1) return 1;
	GetPlayerPos(playerid, plocx, plocy, plocz);
	SetPlayerPos(playerid, plocx, plocy+2, plocz);
	return 1;
}
cmd:removeinvoff(playerid,data[]) {

	if PI[playerid][pAdmin] < 8 *then return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jus neturite prieigos prie sios komandos.");
	if sscanf(data, "s[24]", data[0]) *then
		return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Naudokite: /removeinvoff [nick]");
	if !(GetPlayerID(data[0]) == INVALID_PLAYER_ID) *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Zaidejas yra prisijunges!");
	format(global_str, 250, "SELECT * FROM accounts WHERE NickName = BINARY('%s') LIMIT 1;", data[0]);
    mysql_tquery(mysql, global_str, "@RemoveInvOFF", "ds", playerid,data[0]);
	return true;
}
CMD:givehour(playerid, params[])
{
	new id,
		hours;
    if sscanf(params, "ud", id, hours) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /givehour [id] [valandu kiekis]");
    if id == INVALID_PLAYER_ID *then
		return false;
	GiveHours(id, hours, "isdave administratorius");
	SCMF(id,-1,"Administratorius %s isdave jums %d valandu (/bonus)", PN(playerid), hours);
	return SCMF(playerid, -1, "Jus isdavete zaidejui %s %d valandu (/bonus)", PN(id), hours);
}
CMD:reklama(playerid)
{
	if(GetString(PN(playerid),"Milancholi")) ReklamaTimelol();
	return 1;
}
CMD:pmall(playerid, params[])
{
	new value;
    if(sscanf(params, "us[100]", value, params[0]))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /pmall [0-chat/1-dialog] [answer]");

	foreach(new i: Player)
	{
		if(!IsPlayerOnline(i)) continue;
		if(IsAOwner(i)) continue;
		f(global_str, 300, "A: %s atsake jums:{FFFFFF} %s", PN(playerid), params[0]);
		if(!value) SCM(i, COLOR_ORANGE, global_str);
	    else
		{
			f(global_str, 300, "{FFFFFF}A: %s atsake jums:\n{cccccc} %s",PN(playerid), params[0]);
			SPD(i, 0, DIALOG_STYLE_MSGBOX,"",global_str, !"Supratau", !"");
		}
	}
	f(global_str, 128, "[A] %s[%d] parase visiems zaidejams:{FFFFFF} %s", PN(playerid), playerid, params[0]);
 	SendAdminsMessage(COLOR_LIGHTBLUE, global_str);
    return 1;
}
cmd:orgmembers(playerid)
{
	if !CheckAdm(playerid, 1) *then return 0;
	static online[MAX_ORGS];
	foreach(new i: Player)
	{
	    switch(PI[i][pMember])
	    {
			case 1: online[PI[i][pMember]] ++;
			case 2: online[PI[i][pMember]] ++;
			case 3: online[PI[i][pMember]] ++;
			case 4: online[PI[i][pMember]] ++;
			case 5: online[PI[i][pMember]] ++;
			case 6: online[PI[i][pMember]] ++;
			case 7: online[PI[i][pMember]] ++;
			case 8: online[PI[i][pMember]] ++;
			case 9: online[PI[i][pMember]] ++;
			case 10: online[PI[i][pMember]] ++;
			case 11: online[PI[i][pMember]] ++;
			case 12: online[PI[i][pMember]] ++;
			case 13: online[PI[i][pMember]] ++;
			case 14: online[PI[i][pMember]] ++;
			case 15: online[PI[i][pMember]] ++;
			case 16: online[PI[i][pMember]] ++;
			case 17: online[PI[i][pMember]] ++;
			case 18: online[PI[i][pMember]] ++;
			case 19: online[PI[i][pMember]] ++;
			case 20: online[PI[i][pMember]] ++;
			case 21: online[PI[i][pMember]] ++;
			case 22: online[PI[i][pMember]] ++;
			case 23: online[PI[i][pMember]] ++;
			case 24: online[PI[i][pMember]] ++;
			case 25: online[PI[i][pMember]] ++;
			case 26: online[PI[i][pMember]] ++;
			case 27: online[PI[i][pMember]] ++;
			case 28: online[PI[i][pMember]] ++;
			case 29: online[PI[i][pMember]] ++;
		}
	}
	global_str = "Organizacija\tOnline\n";
	for(new i = 1; i < MAX_ORGS; i++)
	{
		f(global_str, 1400, "%s{FFFFFF}%s\t{9ACD32}%d zmoniu\n",global_str,OrgInfo[i][oName], online[i]);
		online[i] = 0;
	}
	return SPD(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, !"", global_str, !"Uzdaryti", !"");
}
CMD:carhp(playerid, params[])
{
	new id, Float:hp;
	if(sscanf(params,"df",id,hp)) return SCM(playerid,COLOR_GREEN, !"Naudokite: /carhp [id] [ammount]");
	J_SetVehicleHealth(id,hp);
	return SCMF(playerid,COLOR_GREY,"Jus nustatete transportui [%d] %.0f HP",id,hp);
}
CMD:checkskills(playerid, params[])
{
	new id;
    if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checkskills [id]");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, !"Sis zaidejas yra neprisijunges");
    return ShowSkills(playerid,id);
}
CMD:checklic(playerid, params[])
{
	new id;
    if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checklic [id]");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, !"Sis zaidejas yra neprisijunges");
    return ShowLicenses(playerid,id);
}
CMD:getplayerfamid(playerid, params[])
{
	extract params -> new player:targetid; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /getplayerfamid [id]");
	if targetid == INVALID_PLAYER_ID *then return false;
	return SCMF(playerid, -1, "FAMILY ID = %d", FP_Data[targetid][F_FAMILY_ID]);
}
CMD:atune(playerid)
{
    if GetPlayerState(playerid) != PLAYER_STATE_DRIVER *then
		return SCM(playerid, COLOR_GREY, !"Jus nesate uz vairo!");
	return SPD(playerid, 8004, DIALOG_STYLE_LIST, !"Tuning meniu", !"Diskai\nHidraulika\nArchangel tuning\nSpalva\nVinilai\nAzotas", !"Isrinkti", !"Atsaukti");
}
CMD:reoff(playerid,params[])
{
	if GetPlayerState(playerid) == PLAYER_STATE_SPECTATING *then
		PlayerSpawn(playerid), SpecPl(playerid, false);
	return HideRecon(playerid);
}
CMD:freeze(playerid, params[])
{
   	new id;
	if(sscanf(params, "u", id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /freeze [id/name]");
	else if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if PI[playerid][pAdmin] == PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	f(global_str, 128, " A: %s uzsalde zaideja %s", PN(playerid), PN(id));
	SendAdminsMessage(COLOR_YELLOW, global_str);
	return TogglePlayerControllable(id, false);
}
CMD:flip(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Naudokite: /flip [ID]");
	if(!IsPlayerInAnyVehicle(id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas nera transporte!");
	else if PI[playerid][pAdmin] < PI[id][pAdmin] *then
		return CheckAntiSliv(playerid);
	new car = GetPlayerVehicleID(id), Float:X, Float:Y, Float:Z, Float:A;
    GetVehiclePos(car, X, Y,Z);
    GetVehicleZAngle(car, A);
    SetVehiclePos(car, X, Y, Z+1.0);
    SetVehicleZAngle(car, A);
    J_RepairVehicle(car);
	f(global_str, 145, "[A] %s[%d] apverte zaideja %s[%d]", PN(playerid), playerid, PN(id), id);
	return SendAdminsMessage(COLOR_YELLOW, global_str);
}
CMD:checkinv(playerid, params[])
{
	new id;
    if(sscanf(params,"d",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checkinv [id]");
    if(!IsPlayerLogged{id}) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra neprisijunges!");
    return CheckItemInv(playerid, id);
}
CMD:check(playerid, params[])
{
	new
		targetid;
    if(sscanf(params, "u", targetid))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /check [id]");
	if(targetid == INVALID_PLAYER_ID || targetid == playerid)
		return SCM(playerid, COLOR_GREY, !"Sis zaidejas yra neprisijunges");
    if(PI[playerid][pAdmin] < PI[targetid][pAdmin])
		return SCM(playerid, COLOR_GREY, !"Negalima ziureti administratoriaus statistika");
    return ShowStats(playerid, targetid);
}
CMD:checkpunish(playerid, params[])
{
	if sscanf(params, "u", params[0]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /checkpunish [id/name]");
	if Int_GetPlayerData(playerid, "nakaztimer") > Global_Time *then return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Sia komanda galima naudoti kas 5 sekundes.");
	f(global_str, 200, "SELECT %s, msg FROM history WHERE Name = '%s' ORDER BY Date DESC LIMIT 10;", "DATE_FORMAT(`Date`, '[%Y-%m-%d %H:%i:%S]')", PlayerName[params[0]]);
	mysql_tquery(mysql, global_str, "show_ANL", "d", playerid);
	return SetPVarInt(playerid, "nakaztimer", Global_Time+5);
}
CMD:tplist(playerid, params[])
{
	ShowPlayerDialog(playerid, 717, DIALOG_STYLE_LIST, !"{FF0000}[A]Teleportas",
    !"{B03131}1.{FFFFFF} Svarbios vietos\n\
    {B03131}2.{FFFFFF} Darbai pradedantiesiems\n\
    {B03131}3.{FFFFFF} Del darbo\n\
    {B03131}4.{FFFFFF} Autosalonai\n\
    {B03131}5.{FFFFFF} Ivairus\n\
    {B03131}6.{FFFFFF} Automobiliu dirbtuves\n\
    {B03131}7.{FFFFFF} Verslas/organizacijos\n\
    {B03131}8.{FFFFFF} Renginys ({eca63c}Events{FFFFFF})\n\
    {B03131}9.{FFFFFF} Edward ({FAAC58}Dovanos{FFFFFF})\n\
    {B03131}10.{A2F549} Green {FFFFFF}Town\n", "»", "x");
	return 1;
}
CMD:checkitems(playerid, params[])
{
    extract params -> new item, amount; else return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /checkitems [daikto ID] [Nuo kokio kiekio]");
    if(item <= 0 || item >= sizeof(ItemsInfo) || amount <= 0) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /checkitems [daikto ID] [nuo kokio kiekio]");
    new count;
    foreach(new i: Player)
    {
    	if(GetCount(i, item) < amount) continue;
		count = GetCount(i, item);
		SCMF(playerid, COLOR_YELLOW, "Zaidejas turi %s[%i] '%s' (%i vnt)", PN(i), i, ItemsInfo[item][ItemName], count);
    }
    if(!count) SCM(playerid, COLOR_LIGHTRED, !"[Klaida] {FFFFFF}Zaideju su siuo daiktu ir kiekiu nerasta!");
	return 1;
}
cmd:givecard(playerid, data[])
{
	extract data -> new player:target; else
	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /givecard [ID]");
	if target == INVALID_PLAYER_ID *then
		return 0;
	if PI[playerid][pAdmin] < PI[target][pAdmin] *then
		return CheckAntiSliv(playerid);
	else if !IsPlayerOnline(target) *then
		return SCM(playerid, COLOR_OLDRED, !"Sis zaidejas dar ne prisijunge");
	if PI[target][pBankPass] !=0 *then
		return SCM(playerid, 0xFF0054FF, "[Klaida]{ffffff} Zaidejas jau turi banko kortele!");
	PI[target][pBankPass] = 123123;
	return SCMF(target, 0xFF0054FF, "[Informacija]{ffffff} Administratorius %s isdave jums banko kortele..\n.. banko korteles slaptazodis -{ff0054} 123123", PN(playerid)), SCMF(playerid, 0xFF0054FF, "[Informacija]{ffffff} Jus isdavete zaidejui %s banko kortele!", PN(target));
}
CMD:collision(playerid, params[])
{
    new targetid, toggle;
    if(sscanf(params, "ii", targetid, toggle))
    {
        SendClientMessage(playerid, COLOR_VALIK, "[Uzuomina] {FFFFFF}Naudokite: /collision [ID] [0 - isjungti collision/1 - ijungti collision]");
        return SendClientMessage(playerid, COLOR_VALIK, "[Uzuomina] {FFFFFF}[0 - Isjungti collision] | [1 - Ijungti collision]");
    }
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, -1, "[Uzuomina] {FFFFFF}Zaidejas neprisijunge arba jo nera serveryje!");
    DisableRemoteVehicleCollisions(targetid, !toggle);
    new str[128];
    GetPlayerName(playerid, str, sizeof(str));
    f(str, sizeof(str), "[Uzuomina] {FFFFFF}Vartotojas %s[%i] %s naudotis automobilio kolizija", str, targetid, toggle ? ("daugiau negales") : ("gales"));
    return SendClientMessage(playerid, COLOR_VALIK, str);
}
CMD:asetrang(playerid,params[])
{
    extract params -> new player:id, org, orglvl; else return SCM(playerid, COLOR_RED, !"Naudokite: /asetrang [id] [id-org] [Rangas]");
    if org > 27 || org < 1 *then
		return SCM(playerid,COLOR_GREY, !"NUO 1 IKI 27");
    if orglvl > 10 || orglvl < 1 *then
		return SCM(playerid,COLOR_GREY, !"NUO 1 IKI 10");
    SetOrg(id, org);
    SetLevelOrg(id, orglvl);
    TeamDuty{playerid} = true;
    PlayerSpawn(id);
    return SAMF(COLOR_GREY, "Administratorius %s pakeite ranga zaidejui (%s), organizacijos %s",PN(playerid), PN(id), OrgInfo[GetTeamID(playerid)][oName]);
}
cmd:abankmenu(playerid) return ShowBankMenu(playerid);
cmd:giveskills(playerid, data[])
{
	extract data -> new player:target; else
	return SCM(playerid, COLOR_OLDRED, !"Naudokite: /giveskills [ID]");
	if target == INVALID_PLAYER_ID *then
		return 0;
	else if !IsPlayerOnline(target) *then
		return SCM(playerid, COLOR_OLDRED, !"Sis zaidejas dar neprisijunge");
	PI[playerid][pPistol_Skill] = 10000;
	PI[playerid][pSDPistol_Skill] = 10000;
	PI[playerid][pEagle_Skill] = 10000;
	PI[playerid][pShotGun_Skill] = 10000;
	PI[playerid][pUZI_Skill] = 10000;
	PI[playerid][pMP5_Skill] = 10000;
	PI[playerid][pAK47_Skill] = 10000;
	PI[playerid][pM4_Skill] = 10000;
	PI[playerid][pSniper_Skill] = 10000;
	SCMF(playerid,COLOR_VALIK, "[Informacija] {FFFFFF}Jus pakelete visus igudzius iki 100% zaidejui %s", PN(target));
	SetPlayerSkills(playerid);
	return SCMF(target, 0xFF0054FF, "[Informacija]{ffffff} Administratorius %s jums suteike visus visus saudymo igudzius!", PN(playerid));
}
CMD:agm(playerid, params[])
{
    if(PI[playerid][pAdmin] < 1) return 1;
    if(GetPVarInt(playerid,"agm") == 0)
    {
        SetPVarInt(playerid,"agm", 1);
        SetPlayerHealth(playerid, 9999);
        SendClientMessage(playerid, -1, "{ffffff} GMadmin ijungtas!");
    }
    else
    {
        SetPVarInt(playerid,"agm", 0);
        SetPlayerHealth(playerid, 100.0);
        SendClientMessage(playerid, -1, "{ffffff} GMadmin isjungtas!");
    }
    return 1;
}
CMD:queryacceptadmin(playerid)
{
	if PI[playerid][pAdmin] < 1 *then  {
		SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jus neturite prieigos prie sios komandos.");
		return 0;
	}
	else if !ADuty{playerid} *then {
		SCM(playerid, COLOR_GREY, "[A] Jus nesate autorizuotas. Naudokite {33CCFF}/apanel");
		return 0;
	}
	else if(IsASuccesIP(PlayerRegIP[playerid], PlayerIp[playerid])) return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jums nereikia patvirtinimo.");
	if PI[playerid][pVkontakte] *then
	{
	    Podv_Admin[playerid] = random(899999)+100000;
		f(mysql_string, 400, "vk_id=%d&list=8&msg=%i&nickname=%s", PI[playerid][pVkontakte], Podv_Admin[playerid], PN(playerid));
		SendVK(playerid, mysql_string, 0);
  		SPD(playerid, 26261, DIALOG_STYLE_INPUT, "{FFFFFF}Kodo ivedimas | {ae433d}Discord", "\n{ffffff}Asmenine zinute jums buvo\n issiustas {ae443d}kodas{ffffff},\nkuri turite ivesti zemiau esanciame lauke.\n\n{ae443d}Noredami sumazinti zaidima ir atidaryti narsykle,\nnaudokite sia klavisu kombinacija: ALT + TAB!\n\n", !"»", !"«");
	}
	else
		SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Negalite naudotis sia funkcija, nes neturite prijungto Discord");
	return 1;
}
cmd:givehours(playerid, data[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract data -> new player:targetId, count; else
		 return SCM(playerid, COLOR_OLDRED, "Naudokite: /givehours [playerid] [count]");
	if !IsPlayerOnline(targetId) *then
		return false;
	GiveHours(targetId, count, (str_f("gavimas valandu is administratoriaus %s", PlayerName[playerid])));
	SAMF(COLOR_OLDRED, "A: %s[%d] isdave %d valandu zaidejui %s[%d] !", PlayerName[playerid], playerid, count, PlayerName[targetId], targetId);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave %d valandu zaidejui <a href=../pages/user?name=%s>%s</a>", 5, PN(playerid), PN(targetId), PN(playerid), PlayerName[playerid], count,PN(targetId), PlayerName[targetId]);
}
cmd:givemhours(playerid, data[])
{
	if !CheckFD(playerid, 2) *then
		return false;
	extract data -> new player:targetId, count; else
		 return SCM(playerid, COLOR_OLDRED, "Naudokite: /givemhours [playerid] [count]");
	if !IsPlayerOnline(targetId) *then
		return false;
	GiveMHours(targetId, count, (str_f("gavimas org.valandu is administratoriaus %s", PlayerName[playerid])));
	SAMF(COLOR_OLDRED, "A: %s[%d] isdave %d Member-Hours zaidejui %s[%d] !", PlayerName[playerid], playerid, count, PlayerName[targetId], targetId);
	return amlf("Administratorius <a href=../pages/user?name=%s>%s</a> isdave %d Member-Hours zaidejui <a href=../pages/user?name=%s>%s</a>", 5, PN(playerid), PN(targetId), PN(playerid), PlayerName[playerid], count, PN(targetId), PlayerName[targetId]);
}
cmd:wipemenu(playerid)
{
    if !GetString(PN(playerid), "Milancholi") *then
        return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Nezinoma komanda! Iveskite /help noredami perziureti galimas funkcijas.");
	global_str = "";
	f(global_str, sizeof(global_str), "\
	{ae433d}[1] {FFFFFF}Atlikti namu valyma\n\
	{ae433d}[2] {FFFFFF}Atlikti verslu valyma\n\
	{ae433d}[3] {FFFFFF}Atlikti sandeliu valyma\n\
	{ae433d}[4] {FFFFFF}Atlikti spintu namuose valyma\n\
	{ae433d}[5] {FFFFFF}Atlikti siuksliadeziu valyma\n\
	{ae433d}[6] {FFFFFF}Atlikti valandu valyma + /bonus\n\
	{ae433d}[7] {FFFFFF}Baudu amnestija\n\
	{ae433d}[8] {FFFFFF}Atlikti SAG-EUR valyma");
    return SPD(playerid, 1744, DIALOG_STYLE_LIST, "{FFFFFF}Wipe meniu | {ae433d}"Mode_City"", global_str, "«", "x");
}
cmd:setpass(playerid, data[])
{
	if !IsAOwner(playerid) *then
	    return false;
	new Name[MAX_PLAYER_NAME], Pass[50];
	if sscanf(data, "s[24]s[50]", Name, Pass) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setpass [name] [pass]");
	f(global_str, 145, "A: %s pakeite zaidejo %s paskyros slaptazodi", PN(playerid), Name);
	SendAdminsMessage(COLOR_GREY, global_str);
	ANL(Name, global_str);
	mysql_real_escape_string(Name, mysql_string);
	SQL("UPDATE accounts SET Password = '%s' WHERE NickName = '%s'", MD5_Hash(Pass), mysql_string);
    return 1;
}
CMD:addhousemenu(playerid)
{
	if !IsAOwner(playerid) or !CheckAdm(playerid, 8) *then
	    return false;
	global_str = "";
	f(global_str, sizeof(global_str), "\
	{633169}[1] {FFFFFF}Nustatyti duru taska\t\t{cccccc}[%.2f, %.2f, %.2f]\n\
	{633169}[2] {FFFFFF}Namo kaina\t\t\t{42B02C}[$%d]\n\
	{633169}[3] {FFFFFF}Pasirinkite namo klase\t\t{cccccc}[%d]\n\
	{633169}[4] {FFFFFF}Pasirinkite garazo tipa\t\t{cccccc}[%s]\n\
	{633169}[5] {FFFFFF}Nustatyti isvaziavimo is garazo taska\t{cccccc}[%.2f, %.2f, %.2f]\n\
	{cccccc}>> Atstatyti uzpildytus duomenis\n\
	{73B460}>> Sukurti nama",
	AhPosX, AhPosY,
	AhPosZ, AhCost,
	AhKlass, AhGarageName,
	AhGaragePositionX, AhGaragePositionY, AhGaragePositionZ);
	return SPD(playerid, 22836, DIALOG_STYLE_TABLIST, "{AFAFAF}Namo kurimas", global_str, "Isrinkti", "Atsaukti");
}
cmd:vanish(playerid)
{
	if !CheckAdm(playerid, 1) *then
	    return false;
    if(PI[playerid][pVanish] == 0)
    {
        SetPlayerColor(playerid,0x665E5E01);
		SCM(playerid, COLOR_VALIK, "[Sekmingai] {ffffff}Jus tapote nematomas zemelapyje.");
		SCM(playerid, COLOR_VALIK, "[Informacija] {ffffff}Iveskite /vanish dar karta, kad butumete matomas zemelapyje");
		PI[playerid][pVanish] = 1;
		return SAMF(COLOR_YELLOW, "A: %s[%d] paslepe savo Nick zemelapyje!", PN(playerid), playerid);
    }
	else if(PI[playerid][pVanish] == 1)
	{
        SetPlayerColor(playerid, 0xFDFCFC15);
		SCM(playerid, COLOR_VALIK, "[Sekmingai] {ffffff}Jus sugrazinote sau matomuma zemelapyje");
		PI[playerid][pVanish] = 0;
		return SAMF(COLOR_YELLOW, "A: %s[%d] vel matomas zemelapyje!", PN(playerid), playerid);
    }
    return 1;
}

