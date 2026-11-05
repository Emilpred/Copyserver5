// ============================================================================
//  TUNING PREVIEW - tuning salone pasirinkta detale iskart rodoma ant masinos.
//  Idejus i krepseli - detale uzdedama (perziura), isemus is krepselio -
//  grazinama buvusi. Isejus be pirkimo masina perkraunama is DB (HideFullCef).
//  Detales, kuriu masinai nera (kapotas/spoileris/duslintuvas), neleidziama
//  deti i krepseli - zaidejas gauna pranesima.
// ============================================================================
new TP_Backup[MAX_PLAYERS][9], bool:TP_Has[MAX_PLAYERS][9], bool:TP_InCart[MAX_PLAYERS][9], TP_CartVal[MAX_PLAYERS][9];

stock TP_Reset(playerid)
{
	for(new i; i < 9; i++) TP_Has[playerid][i] = TP_InCart[playerid][i] = false, TP_Backup[playerid][i] = TP_CartVal[playerid][i] = 0;
	return 1;
}

stock TP_OtherType(cat) // krepselio kategorija -> vTuning_Other tipas
{
	switch(cat)
	{
		case 3: return 0; // kapotas
		case 5: return 1; // duslintuvas
		case 4: return 2; // spoileris
		case 1: return 3; // diskai
	}
	return -1;
}

// grazina 0, jei detale siai masinai netinka
stock TP_IsCompatible(cat, comp)
{
	switch(cat)
	{
		case 3, 4, 5: return (comp > 0);
		case 1: return (comp > 0 && comp <= TP_WheelCount());
	}
	return 1;
}

stock TP_Preview(playerid, cat, comp)
{
	new carid = GetPlayerVehicleID(playerid);
	if(!carid) return 0;
	switch(cat)
	{
		case 0: // vinilai
		{
			if(!TP_Has[playerid][0]) TP_Backup[playerid][0] = vTuning_Vinyl[carid][0], TP_Has[playerid][0] = true;
			vTuning_Vinyl[carid][0] = comp;
			SetVehicleVinyl(carid, playerid);
		}
		case 1: // diskai
		{
			if(!TP_Has[playerid][1]) TP_Backup[playerid][1] = vTuning_Other[carid][3][0], TP_Has[playerid][1] = true;
			vTuning_Other[carid][3][0] = comp;
			SetVehicleKoleso(carid, playerid);
		}
		case 3, 4, 5: // kapotas / spoileris / duslintuvas
		{
			new t = TP_OtherType(cat);
			if(!TP_Has[playerid][cat]) TP_Backup[playerid][cat] = vTuning_Other[carid][t][0], TP_Has[playerid][cat] = true;
			vTuning_Other[carid][t][0] = comp;
			SetVehicleEventEx(carid, comp, playerid);
		}
	}
	return 1;
}

stock TP_Revert(playerid, cat)
{
	new carid = GetPlayerVehicleID(playerid);
	if(!carid || !TP_Has[playerid][cat]) return 0;
	new old = TP_Backup[playerid][cat];
	switch(cat)
	{
		case 0:
		{
			vTuning_Vinyl[carid][0] = old;
			SetVehicleVinyl(carid, playerid);
		}
		case 1:
		{
			new cur = vTuning_Other[carid][3][0];
			if(old > 0) { vTuning_Other[carid][3][0] = old; SetVehicleKoleso(carid, playerid); }
			else if(cur > 0) RemoveVehicleVisualTuning(carid, TP_WheelUID(cur-1), 3);
		}
		case 3, 4, 5:
		{
			new t = TP_OtherType(cat), cur = vTuning_Other[carid][t][0];
			if(old > 0) { vTuning_Other[carid][t][0] = old; SetVehicleEventEx(carid, old, playerid); }
			else if(cur > 0) RemoveVehicleVisualTuning(carid, cur, t);
		}
	}
	TP_Has[playerid][cat] = false;
	return 1;
}

// ---- perziura paspaudus kortele (launcheris siuncia "updateDashboard" su "component") ----
stock TP_Select(playerid, tuningid)
{
	new cat = GetCartCategory(tuningid);
	switch(cat)
	{
		case 0, 1, 3, 4, 5:
		{
			new comp = GetCartComponent(playerid, tuningid);
			if(!TP_IsCompatible(cat, comp))
				return GameTextForPlayer(playerid, "~r~Netinka siam automobiliui", 1500, 4);
			TP_Preview(playerid, cat, comp);
		}
	}
	return 1;
}

stock TP_CartAdded(playerid, cat, comp)
{
	if(cat < 0 || cat > 8) return 0;
	TP_InCart[playerid][cat] = true;
	TP_CartVal[playerid][cat] = comp;
	return 1;
}

stock TP_CartRemoved(playerid, cat)
{
	if(cat < 0 || cat > 8) return 0;
	TP_InCart[playerid][cat] = false;
	TP_CartVal[playerid][cat] = 0;
	return TP_Revert(playerid, cat);
}

// keiciant kategorija: neperkuptos perziuros nuimamos, krepselio detales lieka
stock TP_CategoryChanged(playerid)
{
	for(new cat; cat < 9; cat++)
	{
		if(!TP_Has[playerid][cat]) continue;
		if(TP_InCart[playerid][cat]) TP_Preview(playerid, cat, TP_CartVal[playerid][cat]);
		else TP_Revert(playerid, cat);
	}
	return 1;
}

// ---- kameros (kaip Arizona New) ----
stock TP_Camera(playerid, id)
{
	static const Float:tpcam[][6] =
	{
		{1537.4742, 959.5036, 11.4604, 1532.2782, 956.5036, 9.4604},   // 0 diskai
		{1535.3762, 960.9677, 11.4604, 1531.3762, 954.0395, 9.4604},   // 1 kapotas
		{1535.8762, 951.5395, 12.4604, 1531.8762, 958.4677, 8.4604},   // 2 sparnas
		{1535.8762, 951.5395, 10.9604, 1531.8762, 958.4677, 9.9604},   // 3 duslintuvas / dumai
		{1536.1262, 960.9007, 10.4604, 1531.6262, 953.1065, 10.4604},  // 4 priekine pakaba
		{1536.1262, 953.1065, 10.4604, 1531.6262, 960.9007, 10.4604},  // 5 galine pakaba
		{1536.8762, 962.1998, 11.4604, 1530.8762, 951.8074, 9.4604},   // 6 bendras vaizdas
		{1535.3762, 960.9677, 11.4604, 1531.3762, 954.0395, 9.4604},   // 7 priekinis stiklas
		{1536.9073, 959.2536, 11.4604, 1530.8451, 955.7536, 9.4604},   // 8 sonai priekis
		{1536.9073, 955.7536, 11.4604, 1530.8451, 959.2536, 9.4604},   // 9 sonai galas
		{1535.6262, 953.6065, 11.4604, 1531.1262, 961.4007, 9.4604},   // 10 galinis stiklas
		{1533.8762, 963.0036, 10.4604, 1533.8762, 952.0036, 10.4604},  // 11 priekiniai zibintai
		{1533.8762, 952.5036, 10.4604, 1533.8762, 962.5036, 10.4604}   // 12 galiniai zibintai
	};
	if(id < 0 || id >= sizeof(tpcam)) id = 6;
	new Float:cp[3], Float:cv[3];
	GetPlayerCameraPos(playerid, cp[0], cp[1], cp[2]);
	GetPlayerCameraFrontVector(playerid, cv[0], cv[1], cv[2]);
	InterpolateCameraPos(playerid, cp[0], cp[1], cp[2], tpcam[id][0], tpcam[id][1], tpcam[id][2], 800, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, cp[0] + cv[0], cp[1] + cv[1], cp[2] + cv[2], tpcam[id][3], tpcam[id][4], tpcam[id][5], 800, CAMERA_MOVE);
	return 1;
}

stock TP_CategoryCamera(category)
{
	switch(category)
	{
		case 1: return 0;  // diskai
		case 2: return 1;  // kapotas
		case 3: return 2;  // sparnas
		case 4: return 3;  // duslintuvas
		case 8: return 11; // zibintu spalva
		case 9: return 3;  // dumu spalva
	}
	return 6;
}

stock TP_ComponentCamera(tuningid)
{
	switch(tuningid)
	{
		case 48: return 4;
		case 49, 90: return 5;
		case 67: return 7;
		case 68: return 8;
		case 69: return 9;
		case 70: return 10;
		case 71: return 11;
		case 72: return 12;
	}
	return -1;
}
