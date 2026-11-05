// ============================================================================
//  VEH_MENU - Transporto meniu (klavisas "2"):
//    * Twin Turbo / Twin Turbo (2 lygis) ijungimas / isjungimas
//    * Drift-mode (galine pavara, Arizona paketas 220/187)
//    * Vaziavimo stilius (Sport / Comfort)
//    * Variklio detaliu (Alkuninis velenas ... Stabdziai sport+) poveikis
//  Detaliu ir Twin Turbo reiksmes paimtos is Arizona New (HandlingDetail_data),
//  i automobili siunciamos per handling RPC 161 (zr. an_handling.inc).
//  Tekstas prie automobilio isjungiamas: /settings -> Valdymo nustatymai
//  arba paciame meniu (2) -> "Uzuomina prie automobilio".
// ============================================================================
#define VM_DIALOG_MENU      32250
#define VM_DIALOG_INFO      32251
#define VM_TT2_ITEM         3044        // ItemsInfo indeksas: Twin-Turbo (2 lygis)

#include vh_base.inc

// tuning detales (1561..1590) -> Arizona New HandlingDetail_data (0..29), 24 reiksmes
static const Float:VM_PartData[30][24] = {
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,13.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},      // Alkuninis velenas (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,10.5,0.6552,2.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},   // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,20.34,3.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},     // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,2.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},       // Skirstymo velenas (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,4.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},       // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,6.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},       // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.456,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},     // Turbokompresorius (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6552,-2.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},   // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.06,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},      // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.456,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},     // Priverstinis oro kompresorius (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,2.16,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},      // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},       // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,6.95,0.456,3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},    // Cip-tuning STAGE 1
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,7.5,0.4368,20.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},   // STAGE 2
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,72.8,2.16,15.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},    // STAGE 3
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.912,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},     // Sankaba (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,2.16,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},      // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},       // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2184,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},    // Pavaru deze (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.092,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},     // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,2.04,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},      // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.032,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},     // Diferencialas (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.096,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},     // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.16,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},      // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},       // Pakaba (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.8,0.096,0.0,0.0,-0.029,0.0,0.0,0.0,0.0,0.0},  // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.1,0.15,0.0,0.0,-0.09,0.0,0.0,0.0,0.0,0.0},    // (sport+)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.03,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},      // Stabdziai (improv)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,2.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},       // (sport)
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.19,0.0,0.0,0.0,0.0,3.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}       // (sport+)
};
static const Float:VM_TTData[2][24] = {
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,19.5,0.546,3.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},    // Twin Turbo
	{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,42.0,10.092,10.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}   // Twin Turbo (2 lygis)
};
// handling indeksai, kuriuos keicia detales (siunciami modeliams be AN Night duomenu)
static const VM_PartIdx[] = {6, 7, 8, 9, 10, 11, 12, 14, 15, 18};

new bool:VM_TTOff[MAX_VEHICLES];
new bool:VM_DriftCar[MAX_VEHICLES];     // drift handling ijungtas siam automobiliui
new VM_DriftVeh[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
new PlayerText3D:VM_Label[MAX_PLAYERS] = {PlayerText3D:INVALID_3DTEXT_ID, ...};
new bool:VM_HideHint[MAX_PLAYERS];

stock VM_Init()
{
	mysql_tquery(mysql, "ALTER TABLE `accounts` ADD COLUMN IF NOT EXISTS `CarHint` TINYINT(1) NOT NULL DEFAULT 0");
	return 1;
}

// kvieciama OnPlayerLoadData (cache = SELECT * FROM accounts)
stock VM_LoadPlayer(playerid)
{
	VM_HideHint[playerid] = cache_get_field_content_int(0, "CarHint", mysql) ? true : false;
	return 1;
}

stock VM_FindBase(model)
{
	new lo = 0, hi = sizeof(VH_BaseData) - 1, Float:fm = float(model);
	while(lo <= hi)
	{
		new mid = (lo + hi) / 2;
		if(VH_BaseData[mid][0] == fm) return mid;
		if(VH_BaseData[mid][0] < fm) lo = mid + 1;
		else hi = mid - 1;
	}
	return -1;
}

stock bool:VM_IsTTItem(item) return (item == 578 || item == 587 || item == VM_TT2_ITEM);

// 0 - nera, 1 - Twin Turbo, 2 - Twin Turbo (2 lygis)
stock VM_TTLevel(vehicleid)
{
	if(vehicleid < 1 || vehicleid >= MAX_VEHICLES) return 0;
	new mod = VehicleInfo[vehicleid][vModification];
	if(mod == VM_TT2_ITEM) return 2;
	if(mod == 578 || mod == 587) return 1;
	return 0;
}

// Twin Turbo idiegtas ir ijungtas (naudojama sport stiliaus greicio funkcijoms)
stock VM_TTActive(vehicleid)
{
	if(!VM_TTLevel(vehicleid)) return 0;
	return !VM_TTOff[vehicleid];
}

stock VM_ResetVehicle(vehicleid)
{
	if(0 < vehicleid < MAX_VEHICLES) VM_TTOff[vehicleid] = false, VM_DriftCar[vehicleid] = false;
	return 1;
}

// suskaiciuoja detaliu + Twin Turbo priedus. Grazina true jei yra bent vienas.
stock bool:VM_GetOffsets(vehicleid, Float:off[24])
{
	new bool:has = false;
	for(new p; p < 24; p++) off[p] = 0.0;
	if(vehicleid < 1 || vehicleid >= MAX_VEHICLES) return false;

	if(IsAOwnableCar(vehicleid))
	{
		new car = GetVehicleID(vehicleid);
		if(car != -1)
		{
			for(new i; i < 10; i++)
			{
				new item = CarInfo[car][InvTexnicalCar][i];
				if(item < 1561 || item > 1590) continue;
				for(new p; p < 24; p++) off[p] += VM_PartData[item - 1561][p];
				has = true;
			}
		}
	}
	// Drift-mode: mazesnis galiniu ratu sukibimas + didesnis vairo kampas (per handling, be launcherio paketo)
	if(VM_DriftCar[vehicleid])
	{
		off[6] -= 0.15;   // tractionMultiplier
		off[7] -= 0.12;   // tractionLoss
		off[8] += 0.10;   // tractionBias (daugiau sukibimo priekyje -> galas slysta)
		off[14] += 15.0;  // steeringLock
		has = true;
	}
	new tt = VM_TTLevel(vehicleid);
	if(tt && !VM_TTOff[vehicleid])
	{
		for(new p; p < 24; p++) off[p] += VM_TTData[tt - 1][p];
		has = true;
	}
	return has;
}

stock Float:VM_BaseValue(bi, p)
{
	if(bi < 0 || bi >= sizeof(VH_BaseData) || p < 0 || p > 23) return 0.0;
	return VH_BaseData[bi][p + 1];
}

// modeliams be AN Night duomenu: siunciami tik detaliu keiciami indeksai
stock VM_FillParts(bi, Float:off[24], Float:val[24], bool:use[24])
{
	new cnt;
	for(new k; k < sizeof(VM_PartIdx); k++)
	{
		new p = VM_PartIdx[k];
		new Float:v = VH_BaseData[bi][p + 1];
		if(v == 0.0) continue;
		val[p] = v + off[p], use[p] = true, cnt++;
	}
	return cnt;
}

// ankstesnis Arizona paketas 220/187 sukeldavo lagus - drift dabar per handling (RPC 161)
stock VM_CanDrift(vehicleid)
{
	new model = GetVehicleModelEx(vehicleid);
	new idx = AN_FindHandling(model);
	if(idx != -1 && AN_GetValue(idx, 6) != 0.0) return 1;
	return (VM_FindBase(model) != -1);
}

stock VM_DestroyLabel(playerid)
{
	if(VM_Label[playerid] != PlayerText3D:INVALID_3DTEXT_ID)
	{
		DeletePlayer3DTextLabel(playerid, VM_Label[playerid]);
		VM_Label[playerid] = PlayerText3D:INVALID_3DTEXT_ID;
	}
	return 1;
}

stock VM_UpdateLabel(playerid)
{
	VM_DestroyLabel(playerid);
	if(VM_HideHint[playerid] || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 0;
	new veh = GetPlayerVehicleID(playerid);
	if(!veh || !IsAOwnableCar(veh)) return 0;

	new str[200], tt[40];
	switch(VM_TTLevel(veh))
	{
		case 0: format(tt, sizeof tt, "{AFAFAF}nera");
		case 1: format(tt, sizeof tt, "%s", VM_TTOff[veh] ? ("{B83434}OFF") : ("{9ACD32}ON"));
		case 2: format(tt, sizeof tt, "%s", VM_TTOff[veh] ? ("{B83434}OFF") : ("{9ACD32}ON (2 lyg.)"));
	}
	format(str, sizeof str, "{FFFFFF}[ 2 ] {F5DEB3}Transporto meniu\n{AFAFAF}Drift: %s {AFAFAF}| TT: %s",
		VM_DriftVeh[playerid] == veh ? ("{9ACD32}ON") : ("{B83434}OFF"), tt);
	VM_Label[playerid] = CreatePlayer3DTextLabel(playerid, str, 0xFFFFFFFF, 1.6, -0.4, 0.1, 12.0, INVALID_PLAYER_ID, veh, 0);
	return 1;
}

stock VM_DriftOff(playerid)
{
	new veh = VM_DriftVeh[playerid];
	if(veh != INVALID_VEHICLE_ID)
	{
		VM_DriftVeh[playerid] = INVALID_VEHICLE_ID;
		if(0 < veh < MAX_VEHICLES && VM_DriftCar[veh])
		{
			VM_DriftCar[veh] = false;
			AN_SendHandling(veh, INVALID_PLAYER_ID, true);
		}
	}
	return 1;
}

// OnPlayerStateChange
stock VM_OnStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER)
	{
		VM_DriftOff(playerid);
		VM_DestroyLabel(playerid);
	}
	if(newstate == PLAYER_STATE_DRIVER) VM_UpdateLabel(playerid);
	return 1;
}

stock VM_OnDisconnect(playerid)
{
	VM_DriftOff(playerid);
	VM_DestroyLabel(playerid);
	VM_HideHint[playerid] = false;
	return 1;
}

// klavisas "2" automobilyje
stock VM_OnKey2(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 0;
	new veh = GetPlayerVehicleID(playerid);
	if(!IsAOwnableCar(veh))
	{
		if(VehicleInfo[veh][vModification]) callcmd::style(playerid);
		return 1;
	}
	return VM_ShowMenu(playerid);
}

stock VM_ShowMenu(playerid)
{
	new veh = GetPlayerVehicleID(playerid);
	if(!veh) return 0;
	static str[900];
	new tt[48], style[48], parts;
	switch(VM_TTLevel(veh))
	{
		case 0: format(tt, sizeof tt, "{AFAFAF}[ neidiegtas ]");
		case 1: format(tt, sizeof tt, "%s", VM_TTOff[veh] ? ("{B83434}[ isjungtas ]") : ("{9ACD32}[ ijungtas ]"));
		case 2: format(tt, sizeof tt, "%s", VM_TTOff[veh] ? ("{B83434}[ isjungtas ]") : ("{9ACD32}[ ijungtas - 2 lygis ]"));
	}
	if(!VehicleInfo[veh][vModification]) format(style, sizeof style, "{AFAFAF}[ reikia modifikacijos ]");
	else format(style, sizeof style, "%s", VehicleInfo[veh][vStyle] ? ("{E4A72B}[ Sport ]") : ("{73B461}[ Comfort ]"));

	new car = GetVehicleID(veh);
	if(car != -1) for(new i; i < 10; i++) if(1561 <= CarInfo[car][InvTexnicalCar][i] <= 1590) parts++;

	format(str, sizeof str, "Funkcija\tBusena\n\
		{FFFFFF}Twin Turbo\t%s\n\
		{FFFFFF}Drift-mode\t%s\n\
		{FFFFFF}Vaziavimo stilius\t%s\n\
		{FFFFFF}Variklio detales ir galia\t{AFAFAF}[ idiegta: %d ]\n\
		{FFFFFF}Uzuomina prie automobilio\t%s",
		tt,
		VM_DriftVeh[playerid] == veh ? ("{9ACD32}[ ijungtas ]") : ("{B83434}[ isjungtas ]"),
		style, parts,
		VM_HideHint[playerid] ? ("{B83434}[ paslepta ]") : ("{9ACD32}[ rodoma ]"));
	return SPD(playerid, VM_DIALOG_MENU, DIALOG_STYLE_TABLIST_HEADERS, "{BFBBBA}Transporto valdymas", str, "Pasirinkti", "Uzdaryti");
}

stock VM_IsHintHidden(playerid) return VM_HideHint[playerid] ? 1 : 0;

stock VM_SetHint(playerid, bool:hide)
{
	VM_HideHint[playerid] = hide;
	UpdatePlayerDataInt(playerid, "CarHint", hide ? 1 : 0);
	VM_UpdateLabel(playerid);
	return 1;
}

stock VM_ShowInfo(playerid)
{
	new veh = GetPlayerVehicleID(playerid);
	if(!veh) return 0;
	static str[1400];
	new Float:off[24], car = GetVehicleID(veh), model = GetVehicleModelEx(veh), cnt;
	VM_GetOffsets(veh, off);

	str = "{FFFFFF}Idiegtos variklio detales:\n";
	if(car != -1)
	{
		for(new i; i < 10; i++)
		{
			new item = CarInfo[car][InvTexnicalCar][i];
			if(item < 1561 || item > 1590) continue;
			format(str, sizeof str, "%s{9ACD32}- {FFFFFF}%s\n", str, ItemsInfo[item][ItemName2]);
			cnt++;
		}
	}
	if(!cnt) strcat(str, "{AFAFAF}- nera (detales dedamos per automobilio inventoriu)\n");
	if(VM_TTLevel(veh)) format(str, sizeof str, "%s{9ACD32}- {FFFFFF}%s %s\n", str, VM_TTLevel(veh) == 2 ? ("Twin Turbo (2 lygis)") : ("Twin Turbo"), VM_TTOff[veh] ? ("{B83434}(isjungtas)") : ("{9ACD32}(ijungtas)"));

	new idx = AN_FindHandling(model), bi = VM_FindBase(model);
	if(idx == -1 && bi == -1)
	{
		strcat(str, "\n{FF6347}Sio modelio launcheris nepalaiko handling keitimo,\ndetales automobilio galios nepakeis.");
	}
	else
	{
		new Float:vel, Float:acc, Float:brk;
		if(idx != -1) vel = AN_GetValue(idx, 9), acc = AN_GetValue(idx, 10), brk = AN_GetValue(idx, 12);
		if(bi != -1)
		{
			if(vel == 0.0) vel = VH_BaseData[bi][10];
			if(acc == 0.0) acc = VH_BaseData[bi][11];
			if(brk == 0.0) brk = VH_BaseData[bi][13];
		}
		format(str, sizeof str, "%s\n{FFFFFF}Maks. greitis: {F5DEB3}%.1f {9ACD32}(+%.1f)\n{FFFFFF}Isibegejimas (galia): {F5DEB3}%.2f {9ACD32}(+%.2f)\n{FFFFFF}Stabdziai: {F5DEB3}%.2f {9ACD32}(+%.2f)\n{FFFFFF}Vairo kampas: {9ACD32}+%.1f",
			str, vel, off[9], acc, off[10], brk, off[12], off[14]);
	}
	return SPD(playerid, VM_DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{BFBBBA}Variklio detales", str, "Atgal", "");
}

stock VM_OnDialog(playerid, dialogid, response, listitem)
{
	if(dialogid == 3004) // /settings -> Valdymo nustatymai
	{
		if(!response) return ShowUpdateSettings(playerid), 1;
		switch(listitem)
		{
			case 0: SettingData[playerid][sdUseFishingRod] = !SettingData[playerid][sdUseFishingRod];
			case 3: VM_SetHint(playerid, !VM_HideHint[playerid]);
		}
		return ShowControlSettings(playerid), 1;
	}
	if(dialogid == VM_DIALOG_INFO)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) VM_ShowMenu(playerid);
		return 1;
	}
	if(dialogid != VM_DIALOG_MENU) return 0;
	if(!response) return 1;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus turite buti vairuotojo vietoje!"), 1;

	new veh = GetPlayerVehicleID(playerid);
	switch(listitem)
	{
		case 0:
		{
			if(!VM_TTLevel(veh))
				return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Siame automobilyje neidiegtas Twin Turbo! (dedamas per automobilio inventoriu)"), VM_ShowMenu(playerid), 1;
			VM_TTOff[veh] = !VM_TTOff[veh];
			AN_SendHandling(veh, INVALID_PLAYER_ID, true);
			GameTextForPlayer(playerid, VM_TTOff[veh] ? ("~w~TWIN TURBO ~r~OFF") : ("~w~TWIN TURBO ~g~ON"), 2000, 4);
			PlayerPlaySound(playerid, 32000, 0.0, 0.0, 0.0);
		}
		case 1:
		{
			if(VM_DriftVeh[playerid] == veh)
			{
				VM_DriftOff(playerid);
				GameTextForPlayer(playerid, "~w~DRIFT MODE ~r~OFF", 2000, 4);
			}
			else
			{
				if(!VM_CanDrift(veh))
					return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sio automobilio modelis nepalaiko Drift-mode."), VM_ShowMenu(playerid), 1;
				VM_DriftOff(playerid);
				VM_DriftVeh[playerid] = veh;
				VM_DriftCar[veh] = true;
				AN_SendHandling(veh, INVALID_PLAYER_ID, true);
				GameTextForPlayer(playerid, "~w~DRIFT MODE ~g~ON", 2000, 4);
				SCM(playerid, 0x9ACD32FF, !"[Drift-mode] {FFFFFF}Ijungta: galiniai ratai slysta lengviau, didesnis vairo kampas. Isjungiama per meniu (2) arba islipus.");
			}
			PlayerPlaySound(playerid, 32000, 0.0, 0.0, 0.0);
		}
		case 2:
		{
			if(!VehicleInfo[veh][vModification])
				return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Vaziavimo stilius keiciamas tik su modifikacija (pvz. Twin Turbo)!"), VM_ShowMenu(playerid), 1;
			callcmd::style(playerid);
		}
		case 3: return VM_ShowInfo(playerid), 1;
		case 4: VM_SetHint(playerid, !VM_HideHint[playerid]);
	}
	VM_UpdateLabel(playerid);
	VM_ShowMenu(playerid);
	return 1;
}
