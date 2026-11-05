// ============================================================================
//  ADMIN_SOFT - administratoriaus "cheat'ai" (Arizona New /apanel punktas
//  "Admin-soft (flycar, ezda po vode)" - Arizona New turi tik meniu pavadinima,
//  todel funkcijos parasytos is naujo).
//
//  /asoft (arba /apanel -> Admin-soft) - meniu. Atskiros komandos:
//    /afly [1-5]    - skraidymas pesciomis. W/S - pirmyn/atgal i kameros puse,
//                     A/D - i sonus, SHIFT - aukstyn, C - zemyn,
//                     SPACE - greiciau, ALT - leciau.
//    /aflycar [1-5] - skraidantis automobilis. W - pirmyn, S - atgal/stabdyti,
//                     A/D - sukti, SPACE - aukstyn, LCTRL arba H (signalas) - zemyn.
//                     Kryptis aukstyn/zemyn ir pagal kamera (ziurint aukstyn - kyla).
//    /awater        - vaziavimas ir vaiksciojimas vandens pavirsiumi.
//    /agm           - nemirtingumas (sau).
//    /acargm        - nesudauzomas automobilis (taisomas automatiskai).
//  Skraidymas valdomas OnPlayerUpdate (sklandu, be trukciojimu).
//  Veikia tik prisijungus per /apanel (ADuty), nuo 3 admin lygio.
// ============================================================================
#define AS_DIALOG           32260
#define CG_DIALOG           32270   // /casinogames
#define AS_TICK             100

new bool:AS_Fly[MAX_PLAYERS], bool:AS_FlyCar[MAX_PLAYERS], bool:AS_Water[MAX_PLAYERS],
	bool:AS_GM[MAX_PLAYERS], bool:AS_CarGM[MAX_PLAYERS],
	AS_FlySpeed[MAX_PLAYERS] = {2, ...}, AS_CarSpeed[MAX_PLAYERS] = {2, ...},
	AS_FlyAnim[MAX_PLAYERS], AS_WaterObj[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
	Float:AS_WaterPos[MAX_PLAYERS][2], AS_ZTick[MAX_PLAYERS],
	AS_Timer = -1;

stock AS_Init()
{
	if(AS_Timer == -1) AS_Timer = SetTimer("AS_Tick", AS_TICK, true);
	return 1;
}

stock AS_Any(playerid) return (AS_Fly[playerid] || AS_FlyCar[playerid] || AS_Water[playerid] || AS_GM[playerid] || AS_CarGM[playerid]);

stock AS_CanUse(playerid)
{
	if(!PI[playerid][pAdmin] || !ADuty{playerid})
	{
		SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Pirmiausia prisijunkite per /apanel!");
		return 0;
	}
	if(PI[playerid][pAdmin] < 3)
	{
		SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Admin-soft prieinamas nuo 3 administratoriaus lygio!");
		return 0;
	}
	return 1;
}

stock AS_HideWater(playerid)
{
	if(AS_WaterObj[playerid] != INVALID_OBJECT_ID)
	{
		DestroyPlayerObject(playerid, AS_WaterObj[playerid]);
		AS_WaterObj[playerid] = INVALID_OBJECT_ID;
	}
	return 1;
}

stock AS_StopFly(playerid)
{
	if(!AS_Fly[playerid]) return 0;
	AS_Fly[playerid] = false;
	AS_FlyAnim[playerid] = 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		SetPlayerVelocity(playerid, 0.0, 0.0, 0.0);
		ClearAnimations(playerid);
	}
	return 1;
}

stock AS_StartFly(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Skraidyti galima tik pesciomis (automobiliui - /aflycar)!"), 0;
	AS_Fly[playerid] = true;
	AS_FlyAnim[playerid] = 0;
	SetPlayerVelocity(playerid, 0.0, 0.0, 0.35); // pakilti nuo zemes
	return 1;
}

stock AS_SetGM(playerid, bool:on)
{
	AS_GM[playerid] = on;
	if(on) SetPlayerHealth(playerid, Float:0x7F800000);
	else UpdatePlayerHealth(playerid, 100.0);
	return 1;
}

stock AS_OnDisconnect(playerid)
{
	if(AS_GM[playerid]) PI[playerid][pHealth] = 100.0;
	AS_Fly[playerid] = AS_FlyCar[playerid] = AS_Water[playerid] = AS_GM[playerid] = AS_CarGM[playerid] = false;
	AS_FlySpeed[playerid] = AS_CarSpeed[playerid] = 2;
	AS_FlyAnim[playerid] = 0;
	AS_WaterObj[playerid] = INVALID_OBJECT_ID;
	return 1;
}

// administratorius atsijunge nuo /apanel arba prarado teises
stock AS_DisableAll(playerid)
{
	AS_StopFly(playerid);
	if(AS_GM[playerid]) AS_SetGM(playerid, false);
	AS_FlyCar[playerid] = AS_Water[playerid] = AS_CarGM[playerid] = false;
	AS_HideWater(playerid);
	return 1;
}

// kvieciama is OnPlayerUpdate (~30 kartu per sekunde) - sklandus skraidymas
stock AS_OnUpdate(playerid)
{
	if(!AS_Fly[playerid] && !AS_FlyCar[playerid]) return 1;
	if(!ADuty{playerid}) return 1;
	new pst = GetPlayerState(playerid);
	if(AS_Fly[playerid])
	{
		if(pst == PLAYER_STATE_ONFOOT) AS_FlyUpdate(playerid);
		else if(pst != PLAYER_STATE_NONE) AS_Fly[playerid] = false, AS_FlyAnim[playerid] = 0; // isedus i transporta
	}
	if(AS_FlyCar[playerid] && pst == PLAYER_STATE_DRIVER) AS_FlyCarUpdate(playerid);
	return 1;
}

stock AS_FlyUpdate(playerid)
{
	new keys, ud, lr, Float:fx, Float:fy, Float:fz;
	GetPlayerKeys(playerid, keys, ud, lr);
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);

	new Float:spd = 0.18 * float(AS_FlySpeed[playerid]);
	if(keys & KEY_SPRINT) spd *= 2.5;
	else if(keys & KEY_WALK) spd *= 0.3;

	new Float:vx, Float:vy, Float:vz, bool:moving;
	if(ud < 0) vx += fx, vy += fy, vz += fz, moving = true;
	else if(ud > 0) vx -= fx, vy -= fy, vz -= fz, moving = true;
	if(lr < 0) vx -= fy, vy += fx, moving = true;
	else if(lr > 0) vx += fy, vy -= fx, moving = true;
	if(keys & KEY_JUMP) vz += 1.0, moving = true;
	if(keys & KEY_CROUCH) vz -= 1.0, moving = true;

	// gravitacijos kompensacija - kabo ore, kai niekas nespaudziama
	SetPlayerVelocity(playerid, vx * spd, vy * spd, vz * spd + 0.012);

	if(moving && (ud || lr)) SetPlayerFacingAngle(playerid, 360.0 - atan2(fx, fy));

	new want = moving ? 2 : 1;
	if(AS_FlyAnim[playerid] != want)
	{
		AS_FlyAnim[playerid] = want;
		if(want == 2) ApplyAnimation(playerid, "PARACHUTE", "FALL_SkyDive_Accel", 4.1, 1, 0, 0, 0, 0, 1);
		else ApplyAnimation(playerid, "PARACHUTE", "FALL_SkyDive", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

stock AS_FlyCarUpdate(playerid)
{
	new veh = GetPlayerVehicleID(playerid), keys, ud, lr;
	GetPlayerKeys(playerid, keys, ud, lr);

	new Float:fx, Float:fy, Float:fz, Float:a;
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);
	GetVehicleZAngle(veh, a);

	// sukimas A/D
	if(lr < 0) a += 3.5;
	else if(lr > 0) a -= 3.5;

	new Float:spd = 0.22 * float(AS_CarSpeed[playerid]);
	new Float:hx = -floatsin(a, degrees), Float:hy = floatcos(a, degrees);
	new Float:vx, Float:vy, Float:vz;

	if(keys & KEY_SPRINT)       vx = hx * spd, vy = hy * spd, vz = fz * spd * 0.8;
	else if(keys & KEY_JUMP)    vx = -hx * spd * 0.4, vy = -hy * spd * 0.4;
	else
	{
		GetVehicleVelocity(veh, vx, vy, vz);
		vx *= 0.92, vy *= 0.92, vz = 0.0;
	}
	if(keys & KEY_HANDBRAKE) vz = 0.25 * float(AS_CarSpeed[playerid]) * 0.5;
	else if((keys & KEY_ACTION) || (keys & KEY_CROUCH)) vz = -0.25 * float(AS_CarSpeed[playerid]) * 0.5;
	if(ud < 0) vz = 0.2;
	else if(ud > 0) vz = -0.2;

	vz += 0.011; // gravitacijos kompensacija
	// kryptis keiciama sukant; kas ~0.5 s automobilis istiesinamas (kad neapsiverstu ore)
	if(lr || ++AS_ZTick[playerid] >= 15)
	{
		AS_ZTick[playerid] = 0;
		SetVehicleZAngle(veh, a);
	}
	SetVehicleVelocity(veh, vx, vy, vz);
	return 1;
}

forward AS_Tick();
public AS_Tick()
{
	foreach(new i : Player)
	{
		if(!AS_Any(i)) continue;
		if(!ADuty{i} || !PI[i][pAdmin]) { AS_DisableAll(i); continue; }

		if(AS_Water[i]) AS_WaterTick(i, GetPlayerState(i));
		if(AS_GM[i])
		{
			new Float:hp;
			GetPlayerHealth(i, hp);
			if(hp < 1000.0) SetPlayerHealth(i, Float:0x7F800000);
			if(PI[i][pHealth] < 100.0) PI[i][pHealth] = 100.0;
		}
		if(AS_CarGM[i] && IsPlayerInAnyVehicle(i))
		{
			new veh = GetPlayerVehicleID(i), Float:vhp;
			GetVehicleHealth(veh, vhp);
			if(vhp < 999.0)
			{
				VehicleInfo[veh][vAntiRepair] = 3;
				VehicleHealth[veh] = 1000.0;
				RepairVehicle(veh);
				SetVehicleHealth(veh, 1000.0);
			}
		}
	}
	return 1;
}

// nematoma 25x25 m plokste (18981, kaip pokerio grindys) vandens lygyje po admin
stock AS_WaterTick(playerid, pst)
{
	new Float:x, Float:y, Float:z, Float:vx, Float:vy, Float:vz, veh = INVALID_VEHICLE_ID;
	if(pst == PLAYER_STATE_DRIVER)
	{
		veh = GetPlayerVehicleID(playerid);
		GetVehiclePos(veh, x, y, z);
		GetVehicleVelocity(veh, vx, vy, vz);
	}
	else if(pst == PLAYER_STATE_ONFOOT)
	{
		GetPlayerPos(playerid, x, y, z);
		GetPlayerVelocity(playerid, vx, vy, vz);
	}
	else return AS_HideWater(playerid);

	if(z > 12.0 || z < -15.0 || GetPlayerInterior(playerid) || GetPlayerVirtualWorld(playerid)) return AS_HideWater(playerid);

	// jei jau nugrimzdo - iskelti i pavirsiu
	if(z < -0.8)
	{
		if(veh != INVALID_VEHICLE_ID) SetVehiclePos(veh, x, y, 1.2);
		else SetPlayerPos(playerid, x, y, 1.3);
	}
	// plokste perkeliama tik kai priartejama prie jos krasto (kad nesitrauktu)
	new Float:px = x + vx * 6.0, Float:py = y + vy * 6.0;
	if(AS_WaterObj[playerid] == INVALID_OBJECT_ID)
	{
		AS_WaterObj[playerid] = CreatePlayerObject(playerid, 18981, px, py, -0.52, 0.0, 90.0, 0.0, 300.0);
		SetPlayerObjectMaterial(playerid, AS_WaterObj[playerid], 0, 14544, "ab_woozieb", "otb_wind", 0x00000000);
		AS_WaterPos[playerid][0] = px, AS_WaterPos[playerid][1] = py;
	}
	else if(floatabs(x - AS_WaterPos[playerid][0]) > 6.0 || floatabs(y - AS_WaterPos[playerid][1]) > 6.0)
	{
		SetPlayerObjectPos(playerid, AS_WaterObj[playerid], px, py, -0.52);
		AS_WaterPos[playerid][0] = px, AS_WaterPos[playerid][1] = py;
	}
	return 1;
}

stock AS_ShowMenu(playerid)
{
	if(!AS_CanUse(playerid)) return 1;
	static str[900];
	format(str, sizeof str, "Funkcija\tBusena\n\
		{FFFFFF}Skraidymas pesciomis {AFAFAF}(/afly)\t%s\n\
		{FFFFFF}Skraidantis automobilis {AFAFAF}(/aflycar)\t%s\n\
		{FFFFFF}Vaziavimas vandeniu {AFAFAF}(/awater)\t%s\n\
		{FFFFFF}Nemirtingumas {AFAFAF}(/agm)\t%s\n\
		{FFFFFF}Nesudauzomas automobilis {AFAFAF}(/acargm)\t%s\n\
		{FFFFFF}Skraidymo greitis\t{F5DEB3}%d / 5\n\
		{FFFFFF}Automobilio skraidymo greitis\t{F5DEB3}%d / 5\n\
		{FFFFFF}Valdymas {AFAFAF}(pagalba)\t{AFAFAF}[ perziureti ]\n\
		{B83434}Isjungti viska",
		AS_Fly[playerid] ? ("{9ACD32}[ ijungta ]") : ("{B83434}[ isjungta ]"),
		AS_FlyCar[playerid] ? ("{9ACD32}[ ijungta ]") : ("{B83434}[ isjungta ]"),
		AS_Water[playerid] ? ("{9ACD32}[ ijungta ]") : ("{B83434}[ isjungta ]"),
		AS_GM[playerid] ? ("{9ACD32}[ ijungta ]") : ("{B83434}[ isjungta ]"),
		AS_CarGM[playerid] ? ("{9ACD32}[ ijungta ]") : ("{B83434}[ isjungta ]"),
		AS_FlySpeed[playerid], AS_CarSpeed[playerid]);
	return SPD(playerid, AS_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "{BFBBBA}Admin-soft", str, "Pasirinkti", "Uzdaryti");
}

stock AS_ShowHelp(playerid)
{
	static str[900];
	str = "{F5DEB3}Skraidymas pesciomis (/afly):{FFFFFF}\n\
W / S - pirmyn / atgal (ten, kur ziuri kamera)\n\
A / D - i sonus\n\
SHIFT - aukstyn, C - zemyn\n\
SPACE - greiciau, ALT - leciau\n\n\
{F5DEB3}Skraidantis automobilis (/aflycar):{FFFFFF}\n\
W - pirmyn (kamera ziuri aukstyn - kyla, zemyn - leidziasi)\n\
S - atgal / stabdyti, A / D - sukti\n\
SPACE - aukstyn, LCTRL arba H - zemyn\n\
Nieko nespaudziant automobilis kabo ore\n\n\
{F5DEB3}Vaziavimas vandeniu (/awater):{FFFFFF}\n\
Po jumis atsiranda nematomas pavirsius vandens lygyje\n\
(veikia ir pesciomis, ir automobiliu)";
	return SPD(playerid, AS_DIALOG + 1, DIALOG_STYLE_MSGBOX, "{BFBBBA}Admin-soft valdymas", str, "Atgal", "");
}

stock AS_Toggle(playerid, what)
{
	switch(what)
	{
		case 0:
		{
			if(AS_Fly[playerid]) AS_StopFly(playerid), SCM(playerid, 0xFF6347FF, !"[Admin-soft] {FFFFFF}Skraidymas isjungtas.");
			else if(AS_StartFly(playerid)) SCM(playerid, 0x9ACD32FF, !"[Admin-soft] {FFFFFF}Skraidymas ijungtas. W/S/A/D - kryptis, SHIFT - aukstyn, C - zemyn, SPACE - greiciau.");
		}
		case 1:
		{
			AS_FlyCar[playerid] = !AS_FlyCar[playerid];
			if(AS_FlyCar[playerid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.3);
			SCM(playerid, AS_FlyCar[playerid] ? 0x9ACD32FF : 0xFF6347FF, AS_FlyCar[playerid] ? ("[Admin-soft] {FFFFFF}Skraidantis automobilis ijungtas. W - pirmyn, A/D - sukti, SPACE - aukstyn, LCTRL - zemyn.") : ("[Admin-soft] {FFFFFF}Skraidantis automobilis isjungtas."));
		}
		case 2:
		{
			AS_Water[playerid] = !AS_Water[playerid];
			if(!AS_Water[playerid]) AS_HideWater(playerid);
			SCM(playerid, AS_Water[playerid] ? 0x9ACD32FF : 0xFF6347FF, AS_Water[playerid] ? ("[Admin-soft] {FFFFFF}Vaziavimas vandeniu ijungtas.") : ("[Admin-soft] {FFFFFF}Vaziavimas vandeniu isjungtas."));
		}
		case 3:
		{
			AS_SetGM(playerid, !AS_GM[playerid]);
			SCM(playerid, AS_GM[playerid] ? 0x9ACD32FF : 0xFF6347FF, AS_GM[playerid] ? ("[Admin-soft] {FFFFFF}Nemirtingumas ijungtas.") : ("[Admin-soft] {FFFFFF}Nemirtingumas isjungtas."));
		}
		case 4:
		{
			AS_CarGM[playerid] = !AS_CarGM[playerid];
			SCM(playerid, AS_CarGM[playerid] ? 0x9ACD32FF : 0xFF6347FF, AS_CarGM[playerid] ? ("[Admin-soft] {FFFFFF}Nesudauzomas automobilis ijungtas.") : ("[Admin-soft] {FFFFFF}Nesudauzomas automobilis isjungtas."));
		}
	}
	return 1;
}

stock AS_OnDialog(playerid, dialogid, response, listitem)
{
	if(dialogid == CG_DIALOG) return CG_OnDialog(playerid, response, listitem), 1;
	if(dialogid == AS_DIALOG + 1) return AS_ShowMenu(playerid), 1;
	if(dialogid != AS_DIALOG) return 0;
	if(!response || !AS_CanUse(playerid)) return 1;
	switch(listitem)
	{
		case 0..4: AS_Toggle(playerid, listitem);
		case 5: AS_FlySpeed[playerid] = AS_FlySpeed[playerid] >= 5 ? 1 : AS_FlySpeed[playerid] + 1;
		case 6: AS_CarSpeed[playerid] = AS_CarSpeed[playerid] >= 5 ? 1 : AS_CarSpeed[playerid] + 1;
		case 7: return AS_ShowHelp(playerid), 1;
		case 8: AS_DisableAll(playerid), SCM(playerid, 0xFF6347FF, !"[Admin-soft] {FFFFFF}Visos funkcijos isjungtos.");
	}
	return AS_ShowMenu(playerid), 1;
}

CMD:asoft(playerid) return AS_ShowMenu(playerid);

CMD:afly(playerid, params[])
{
	if(!AS_CanUse(playerid)) return 1;
	new spd;
	if(!sscanf(params, "d", spd) && 1 <= spd <= 5) AS_FlySpeed[playerid] = spd;
	return AS_Toggle(playerid, 0);
}

CMD:aflycar(playerid, params[])
{
	if(!AS_CanUse(playerid)) return 1;
	new spd;
	if(!sscanf(params, "d", spd) && 1 <= spd <= 5) AS_CarSpeed[playerid] = spd;
	return AS_Toggle(playerid, 1);
}

CMD:awater(playerid)
{
	if(!AS_CanUse(playerid)) return 1;
	return AS_Toggle(playerid, 2);
}

CMD:agm(playerid)
{
	if(!AS_CanUse(playerid)) return 1;
	return AS_Toggle(playerid, 3);
}

CMD:acargm(playerid)
{
	if(!AS_CanUse(playerid)) return 1;
	return AS_Toggle(playerid, 4);
}


// ============================================================================
//  /casinogames - casino zaidimu ijungimas / isjungimas (admin 8 lygis)
//  Black Jack (filterscripts/blackjack.amx) ir Amerikietiska rulete
//  (filterscripts/roulette.amx). Busena issaugoma filterscript'u DB, todel
//  islieka po serverio perkrovimo. Isjungiant - zaidejai pakeliami nuo stalu,
//  nesibaige statymai uzbaigiami / grazinami.
// ============================================================================

// 2 - ijungta, 1 - isjungta, 0 - filterscript neikeltas
stock CG_State(game) return CallRemoteFunction(game == 0 ? ("BJ_IsEnabled") : ("RL_IsEnabled"), "");

stock CG_StateText(st)
{
	new s[40];
	if(st == 2) s = "{9ACD32}[ ijungta ]";
	else if(st == 1) s = "{B83434}[ isjungta ]";
	else s = "{AFAFAF}[ neikeltas ]";
	return s;
}

stock CG_CanUse(playerid)
{
	if(!PI[playerid][pAdmin] || !ADuty{playerid})
	{
		SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Pirmiausia prisijunkite per /apanel!");
		return 0;
	}
	if(PI[playerid][pAdmin] < 8)
	{
		SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Casino zaidimu nustatymai prieinami nuo 8 administratoriaus lygio!");
		return 0;
	}
	return 1;
}

stock CG_ShowMenu(playerid)
{
	if(!CG_CanUse(playerid)) return 1;
	static str[300];
	format(str, sizeof str, "Zaidimas\tBusena\n{FFFFFF}Black Jack\t%s\n{FFFFFF}Amerikietiska rulete\t%s",
		CG_StateText(CG_State(0)), CG_StateText(CG_State(1)));
	return SPD(playerid, CG_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "{BFBBBA}Casino zaidimai", str, "Keisti", "Uzdaryti");
}

stock CG_OnDialog(playerid, response, listitem)
{
	if(!response || !CG_CanUse(playerid)) return 1;
	if(listitem < 0 || listitem > 1) return 1;
	new st = CG_State(listitem), msg[144], name[MAX_PLAYER_NAME];
	if(st == 0)
	{
		SCM(playerid, COLOR_RED, listitem == 0 ? ("[Klaida] {FFFFFF}blackjack filterscript neikeltas (server.cfg -> filterscripts).") : ("[Klaida] {FFFFFF}roulette filterscript neikeltas (server.cfg -> filterscripts)."));
		return CG_ShowMenu(playerid);
	}
	new on = (st == 1);
	CallRemoteFunction(listitem == 0 ? ("BJ_SetEnabled") : ("RL_SetEnabled"), "i", on);
	GetPlayerName(playerid, name, sizeof name);
	format(msg, sizeof msg, "[A] %s %s casino zaidima \"%s\".", name, on ? ("ijunge") : ("isjunge"), listitem == 0 ? ("Black Jack") : ("Amerikietiska rulete"));
	for(new i = 0; i < MAX_PLAYERS; i++)
		if(IsPlayerConnected(i) && PI[i][pAdmin] > 0) SCM(i, on ? 0x9ACD32FF : 0xFF6347FF, msg);
	return CG_ShowMenu(playerid);
}

CMD:casinogames(playerid) return CG_ShowMenu(playerid);
CMD:cgames(playerid) return CG_ShowMenu(playerid);
