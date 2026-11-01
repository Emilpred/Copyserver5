// ============================================================================
//  TUNING PREVIEW - tuning salone pasirinkta detale iskart rodoma ant masinos.
//  Idejus i krepseli - detale uzdedama (perziura), isemus is krepselio -
//  grazinama buvusi. Isejus be pirkimo masina perkraunama is DB (HideFullCef).
//  Detales, kuriu masinai nera (kapotas/spoileris/duslintuvas), neleidziama
//  deti i krepseli - zaidejas gauna pranesima.
// ============================================================================
new TP_Backup[MAX_PLAYERS][9], bool:TP_Has[MAX_PLAYERS][9];

stock TP_Reset(playerid)
{
	for(new i; i < 9; i++) TP_Has[playerid][i] = false, TP_Backup[playerid][i] = 0;
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
