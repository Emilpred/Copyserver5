public: UpdateEnchant(playerid, item, stone)
{
	if !IsPlayerLogged{playerid} || !EnchantWork{playerid} *then return KillTimer(EnchantTimer[playerid]);

	new progress = EnchantWorkProgress[playerid];

	if progress < 51 *then
		PlayerTextDrawTextSize(playerid, EnchantWorkTD[playerid][18], 2.730324 * progress, 6.469632),
		ShowPlayerTD(playerid, EnchantWorkTD[playerid][18]);

	else if progress == 51 *then
	{
		new status = (GetChanceEnchant(Inventory[playerid][2][item]) * (GetPlayerADDVIP(playerid) ? 2:1) * (Inventory[playerid][0][stone] == 1502 ? 2:1) < 1 + random(1000));

		if status *then
			SCMF(playerid, COLOR_RED, "Deja, jums nepavyko patobulinti daikta %s nuo +%d i +%d", ItemsInfo[Inventory[playerid][0][item]][ItemName2], Inventory[playerid][2][item], Inventory[playerid][2][item] + 1);
		else 
			SCMF(playerid, COLOR_VALIK, "Sekme! Jums pavyko patobulinti daikta %s nuo +%d i +%d", ItemsInfo[Inventory[playerid][0][item]][ItemName2], Inventory[playerid][2][item], Inventory[playerid][2][item] + 1),
			Inventory[playerid][2][item] ++,
			InvSlotUpdate(playerid, GetInvID(playerid, item, 1), item);
		
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][12], PI[playerid][pLanguage] ? (FixText("PATOBULINTI")) : ("ENCHANT")), PlayerTextDrawTextSize(playerid, EnchantWorkTD[playerid][18], 0.0, 6.469632), ShowPlayerTD(playerid, EnchantWorkTD[playerid][18]);
		EnchantWorkProgress[playerid] += status ? 100:200;
		return ClearItem(playerid, stone, 1);
	}
	else
	{
		static const color[9][2] = 
		{
			{0xFF4D4D5A, 0x4DFF5A5A},
			{0xFF4D4D50, 0x4DFF5A50},
			{0xFF4D4D46, 0x4DFF5A46},
			{0xFF4D4D3C, 0x4DFF5A3C},
			{0xFF4D4D32, 0x4DFF5A32},
			{0xFF4D4D28, 0x4DFF5A28},
			{0xFF4D4D1E, 0x4DFF5A1E},
			{0xFF4D4D14, 0x4DFF5A14},
			{0xFF4D4D0A, 0x4DFF5A0A}
		};

		new color_mas_id = (progress > 200) ? 1:0, count = color_mas_id ? progress-251:progress-151;

		PlayerTextDrawBoxColor(playerid, EnchantWorkTD[playerid][23], color[count][color_mas_id]);
		PlayerTextDrawBoxColor(playerid, EnchantWorkTD[playerid][22], color[count][color_mas_id]);

		ShowPlayerTD(playerid, EnchantWorkTD[playerid][23]);
		ShowPlayerTD(playerid, EnchantWorkTD[playerid][22]);

		if count == 8 *then return
			PlayerTextDrawBoxColor(playerid, EnchantWorkTD[playerid][23], 0x00000000),
			PlayerTextDrawBoxColor(playerid, EnchantWorkTD[playerid][22], 0x00000000),
			ShowPlayerTD(playerid, EnchantWorkTD[playerid][23]),
			ShowPlayerTD(playerid, EnchantWorkTD[playerid][22]),
			EnchantWorkProgress[playerid] = 0,
			UpdateEnchantWork(playerid),
			KillTimer(EnchantTimer[playerid]);
	}

	return EnchantWorkProgress[playerid]++;
}

stock GetChanceEnchant(level)
{
	new result;

	switch level do
	{
		case 0: result = 500;
		case 1: result = 300;
		case 2: result = 255;
		case 3: result = 200;
		case 4: result = 155;
		case 5: result = 125;
		case 6: result = 90;
		case 7: result = 45;
		case 8: result = 22;
		case 9: result = 10;
		case 10: result = 10;
		case 11: result = 10;
	}
	return result;
}

stock UpdateEnchantWork(playerid)
{
	new slot = EnchantWorkItem[playerid][0] -1, kamen = EnchantWorkItem[playerid][1] -1, item;

	if BizEntered[playerid] == -1 *then
		return DestroyEnchantWork(playerid);
		
	else if slot >= 0 && IsAAks(Inventory[playerid][0][slot]) *then
	{
		item = Inventory[playerid][0][slot];

		PlayerTextDrawBackgroundColor(playerid, EnchantWorkTD[playerid][0], ItemsInfo[item][ItemColor]);
		PlayerTextDrawSetSelectable(playerid, EnchantWorkTD[playerid][0], true);
		PlayerTextDrawSetPreviewModel(playerid, EnchantWorkTD[playerid][0], ItemsInfo[item][ItemModel]);
		PlayerTextDrawSetPreviewRot(playerid, EnchantWorkTD[playerid][0], ItemsInfo[item][POSTDx], ItemsInfo[item][POSTDy], ItemsInfo[item][POSTDz], ItemsInfo[item][POSTDc]);
		
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][6], (str_f("+%d", Inventory[playerid][2][slot])));
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][5], (str_f("+%d", Inventory[playerid][2][slot] + 1)));

		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][7], kamen >= 0 ? (str_f("%d BTC", BizData[BizEntered[playerid]][bItem][0])):"");
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][2], kamen >= 0 ? (str_f("CHANCE: %0.1f", float(GetChanceEnchant( Inventory[playerid][2][slot]) * (PI[playerid][pAddVIP] > Global_Time ? 2:1) * (Inventory[playerid][0][kamen] == 1502 ? 2:1) )/10)):"");
	}
	else
	{
		PlayerTextDrawBackgroundColor(playerid, EnchantWorkTD[playerid][0], 0x333333FF);
		PlayerTextDrawSetSelectable(playerid, EnchantWorkTD[playerid][0], false);
		PlayerTextDrawSetPreviewModel(playerid, EnchantWorkTD[playerid][0], 1649);
		PlayerTextDrawSetPreviewRot(playerid, EnchantWorkTD[playerid][0], 0.000000, 0.000000, 90.000000, 2.000000);
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][6], "");
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][5], "");
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][7], "");
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][2], "");
	}

	PlayerTextDrawBackgroundColor(playerid, EnchantWorkTD[playerid][1], 0x333333FF);
	PlayerTextDrawSetPreviewModel(playerid, EnchantWorkTD[playerid][1], 1649);
	PlayerTextDrawSetPreviewRot(playerid, EnchantWorkTD[playerid][1], 0.000000, 0.000000, 90.000000, 2.000000);

	if kamen >= 0 *then
	{
		PlayerTextDrawBackgroundColor(playerid, EnchantWorkTD[playerid][1], ItemsInfo[Inventory[playerid][0][kamen]][ItemColor]);
		PlayerTextDrawSetSelectable(playerid, EnchantWorkTD[playerid][1], true);
		PlayerTextDrawSetPreviewModel(playerid, EnchantWorkTD[playerid][1], ItemsInfo[Inventory[playerid][0][kamen]][ItemModel]);
		PlayerTextDrawSetPreviewRot(playerid, EnchantWorkTD[playerid][1], ItemsInfo[Inventory[playerid][0][kamen]][POSTDx], ItemsInfo[Inventory[playerid][0][kamen]][POSTDy], ItemsInfo[Inventory[playerid][0][kamen]][POSTDz], ItemsInfo[Inventory[playerid][0][kamen]][POSTDc]);
	}

	PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][8], kamen >= 0 ? (str_f("X %d", Inventory[playerid][1][kamen])):"");
	PlayerTextDrawSetSelectable(playerid, EnchantWorkTD[playerid][1], kamen >= 0 ? true:false);
	PlayerTextDrawColor(playerid, EnchantWorkTD[playerid][1], kamen >= 0 ? 0xFFFFFFFF:0x999999FF);
	ShowPlayerTD(playerid, EnchantWorkTD[playerid][1]);

	return PlayerPlaySound(playerid, 6801, 0.0, 0.0, 0.0), ShowPlayerTD(playerid, EnchantWorkTD[playerid][0]);
}

stock ShowEnchantWork(playerid, list)
{
	if EnchantWork{playerid} == true or list > 1 *then return false;

	EnchantWorkItem[playerid][0] = 
	EnchantWorkItem[playerid][1] = 
	EnchantWorkProgress[playerid] = 0;
	
	EnchantWork{playerid} = true;
	
	if !list || list == 2 *then
	{
		#include <textdraws/cataloges/Enchant>
		for new i; i < (!list ? 29:30); i++ do ShowPlayerTD(playerid, EnchantWorkTD[playerid][i]);
		
		ShowInventoryPage(playerid, 485.299988 - 5.799865 * InventorySize[playerid][0], 138.642853, E_INVENTORY_TYPE_ENCHANT);
	}
	else
	{
		InventoryOpen{playerid} = true;
		
		ShowInventoryTextDraw(playerid, 462.401703 + InventoryPos[playerid][0], 101.500000 + InventoryPos[playerid][1]);
		
		InventoryOpen{playerid} = false;
		
		ShowInventoryPage(playerid, 627.401672, 101.500000, E_INVENTORY_TYPE_ENCHANT_2);
		
		for new i; i < 8; i++ do
			PlayerTextDrawSetSelectable(playerid, InvItemSlot[playerid][i], false),
			PlayerTextDrawColor(playerid, InvItemSlot[playerid][i], 0x999999FF),
			ShowPlayerTD(playerid, InvItemSlot[playerid][i]);
		
		PlayerTextDrawSetSelectable(playerid, InvTextDraws[playerid][2], false),
		PlayerTextDrawColor(playerid, InvTextDraws[playerid][2], 0x999999FF),
		ShowPlayerTD(playerid, InvTextDraws[playerid][2]);
	}
	
	return SelectTextDraw(playerid, PI[playerid][pSelectTD]);
}

stock DestroyEnchantWork(playerid)
{
	for new i; i < 29; i++ do DestroyPlayerTD(playerid, EnchantWorkTD[playerid][i]);
	
	EnchantWork{playerid} = false;

	if EnchantWorkItem[playerid][0] - 1 >= 0 *then InventSlotUse[playerid][EnchantWorkItem[playerid][0] - 1] = false; 
	if EnchantWorkItem[playerid][1] - 1 >= 0 *then InventSlotUse[playerid][EnchantWorkItem[playerid][1] - 1] = false; 

	CancelSelectTextDraw(playerid);
	KillTimer(EnchantTimer[playerid]);
	
	return HideInvent(playerid);
}
