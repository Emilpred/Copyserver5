public: UpdateEnchant(playerid, item, stone)
{
	if !pTemp[playerid][tAuthorized] || !EnchantWork{playerid} *then return KillTimer(EnchantTimer[playerid]);

	new progress = EnchantWorkProgress[playerid];

	if progress < 51 *then
		PlayerTextDrawTextSize(playerid, EnchantWorkTD[playerid][18], 2.730324 * progress, 6.469632),
		ShowPlayerTD(playerid, EnchantWorkTD[playerid][18]);

	else if progress == 51 *then
	{
		new status = (GetChanceEnchant(Inventory[playerid][2][item]) * (GetPlayerADDVIP(playerid) ? 2:1) * (Inventory[playerid][0][stone] == 1420 ? 2:1) < 1 + random(1000));

		if status *then
			SCMF(playerid, COLOR_RED, "”вы, вам не удалось улучшить предмет %s с +%d на +%d", ItemsInfo[Inventory[playerid][0][item]][itemName], Inventory[playerid][2][item], Inventory[playerid][2][item] + 1);
		else 
			SCMF(playerid, COLOR_VALIK, "”спех! ¬ам удалось улучшить предмет %s с +%d на +%d", ItemsInfo[Inventory[playerid][0][item]][itemName], Inventory[playerid][2][item], Inventory[playerid][2][item] + 1),
			Inventory[playerid][2][item] ++,
			InventSlotUpdate(playerid, GetInvID(playerid, item, 1), item),
			sendPlayerBattlepassAction(playerid, 0, 16);
		
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][12], SettingData[playerid][sdLanguage] ? (FixText("«ј“ќ„»“№")) : ("ENCHANT")), PlayerTextDrawTextSize(playerid, EnchantWorkTD[playerid][18], 0.0, 6.469632), ShowPlayerTD(playerid, EnchantWorkTD[playerid][18]);
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
		case 12: result = 1;
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

		PlayerTextDrawFont(playerid, EnchantWorkTD[playerid][0], ItemsInfo[item][itemCustom] == 2 ? 100 : 5);
		PlayerTextDrawBackgroundColor(playerid, EnchantWorkTD[playerid][0], ItemsInfo[item][itemColor]);
		PlayerTextDrawSetSelectable(playerid, EnchantWorkTD[playerid][0], true);
		PlayerTextDrawSetPreviewModel(playerid, EnchantWorkTD[playerid][0], ItemsInfo[item][itemModel]);
		PlayerTextDrawSetPreviewRot(playerid, EnchantWorkTD[playerid][0], ItemsInfo[item][itemRotation][0], ItemsInfo[item][itemRotation][1], ItemsInfo[item][itemRotation][2], ItemsInfo[item][itemRotation][3]);
		
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][6], (str_f("+%d", Inventory[playerid][2][slot])));
		if(kamen >= 0) PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][5], (str_f("+%d", Inventory[playerid][2][slot] + 1)));

		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][7], kamen >= 0 ? (str_f("$%d", BizData[BizEntered[playerid]][bItem][0])):"");
		PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][2], kamen >= 0 ? (str_f("CHANCE: %0.1f", float(GetChanceEnchant( Inventory[playerid][2][slot]) * (PI[playerid][pAddVIP] > Global_Time ? 2:1) * (Inventory[playerid][0][kamen] == 1420 ? 2:1) )/10)):"");
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

	PlayerTextDrawSetPreviewModel(playerid, EnchantWorkTD[playerid][1], 16112);
	PlayerTextDrawSetPreviewRot(playerid, EnchantWorkTD[playerid][1], 78.000000, 0.000000, 0.000000, 1.024500);

	if kamen >= 0 *then
	{
		PlayerTextDrawBackgroundColor(playerid, EnchantWorkTD[playerid][1], ItemsInfo[Inventory[playerid][0][kamen]][itemColor]);
		PlayerTextDrawSetPreviewModel(playerid, EnchantWorkTD[playerid][1], ItemsInfo[Inventory[playerid][0][kamen]][itemModel]);
		PlayerTextDrawSetPreviewRot(playerid, EnchantWorkTD[playerid][1], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][0], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][1], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][2], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][3]);
	}

	PlayerTextDrawSetString(playerid, EnchantWorkTD[playerid][8], kamen >= 0 ? (str_f("X %d", Inventory[playerid][1][kamen])):"");
	ShowPlayerTD(playerid, EnchantWorkTD[playerid][1]);

	return PlayerPlaySound(playerid, 6801, 0.0, 0.0, 0.0), ShowPlayerTD(playerid, EnchantWorkTD[playerid][0]);
}

stock ShowEnchantWork(playerid, list)
{
	if EnchantWork{playerid} == true or list == 2 or list > 3 *then return false;
	if list == 3 *then return ShowColorsChange(playerid);

	EnchantWorkItem[playerid][0] = 
	EnchantWorkItem[playerid][1] = 
	EnchantWorkProgress[playerid] = 0;
	EnchantWork{playerid} = true;
	
	#include <textdraws/cataloges/Enchant>

	for new i; i < 29; i++ do 
		ShowPlayerTD(playerid, EnchantWorkTD[playerid][i]);

	ShowInventoryPage(playerid, 485.299988, 138.642853, E_INVENTORY_TYPE_ENCHANT);
	/*else
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
	}*/
	
	return SelectTextDraw(playerid, PI[playerid][pSelectTD]);
}

stock DestroyEnchantWork(playerid)
{
	for new i; i < 29; i++ do 
		DestroyPlayerTD(playerid, EnchantWorkTD[playerid][i]);
	
	EnchantWork{playerid} = false;

	if EnchantWorkItem[playerid][0] - 1 >= 0 *then InventSlotUse[playerid][EnchantWorkItem[playerid][0] - 1] = false; 
	if EnchantWorkItem[playerid][1] - 1 >= 0 *then InventSlotUse[playerid][EnchantWorkItem[playerid][1] - 1] = false; 

	CancelSelectTextDraw(playerid);
	KillTimer(EnchantTimer[playerid]);
	
	return HideInvent(playerid);
}

stock ShowColorsChange(playerid)
{
	if ChangeColor{playerid} == true *then return false;

	ChangeColorItem[playerid][0] = 
	ChangeColorItem[playerid][1] = 
	ChangeColorItem[playerid][2] = 0;
    ChangeColor{playerid} = true;
	SetPVarInt(playerid, "idcolorchange", 0);

	#include <textdraws/cataloges/Colors>

	for new i; i < 29; i++ do
		ShowPlayerTD(playerid, ColorsChangeTD[playerid][i]);

	ShowInventoryPage(playerid, 485.299988, 138.642853, E_INVENTORY_TYPE_COLOR);

	return SelectTextDraw(playerid, PI[playerid][pSelectTD]);
}

stock DestroyColorsChange(playerid)
{
	for new i; i < 36; i++ do 
		DestroyPlayerTD(playerid, ColorsChangeTD[playerid][i]);
	
	ChangeColor{playerid} = false;

	if ChangeColorItem[playerid][0] - 1 >= 0 *then InventSlotUse[playerid][ChangeColorItem[playerid][0] - 1] = false; 
	if ChangeColorItem[playerid][1] - 1 >= 0 *then InventSlotUse[playerid][ChangeColorItem[playerid][1] - 1] = false; 
	if ChangeColorItem[playerid][1] - 1 >= 0 *then InventSlotUse[playerid][ChangeColorItem[playerid][2] - 1] = false; 

	CancelSelectTextDraw(playerid);
	
	return HideInvent(playerid);
}

stock UpdateChangeColor(playerid)
{
	new slot = ChangeColorItem[playerid][0] -1, kamen = ChangeColorItem[playerid][1] -1, krasitel = ChangeColorItem[playerid][2] -1, item;

	if BizEntered[playerid] == -1 *then
		return DestroyColorsChange(playerid);
		
	else if slot >= 0 && IsAAks(Inventory[playerid][0][slot]) *then
	{
		item = Inventory[playerid][0][slot];

		PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][26], ItemsInfo[item][itemCustom] == 2 ? 100 : 5);
		PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][26], ItemsInfo[item][itemColor]);
		PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][26], true);
		PlayerTextDrawSetPreviewModel(playerid, ColorsChangeTD[playerid][26], ItemsInfo[item][itemModel]);
		PlayerTextDrawSetPreviewRot(playerid, ColorsChangeTD[playerid][26], ItemsInfo[item][itemRotation][0], ItemsInfo[item][itemRotation][1], ItemsInfo[item][itemRotation][2], ItemsInfo[item][itemRotation][3]);
	}
	else
	{
		PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][26], 0x333333FF);
		PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][26], false);
		PlayerTextDrawSetPreviewModel(playerid, ColorsChangeTD[playerid][26], 1649);
		PlayerTextDrawSetPreviewRot(playerid, ColorsChangeTD[playerid][26], 0.000000, 0.000000, 90.000000, 2.000000);
		PlayerTextDrawSetString(playerid, ColorsChangeTD[playerid][28], "0/1");
		PlayerTextDrawSetString(playerid, ColorsChangeTD[playerid][26], "0/7");

		for(new i = 30; i < 36; i++)
			DestroyPlayerTD(playerid, ColorsChangeTD[playerid][i]);
	}

	PlayerTextDrawSetPreviewModel(playerid, ColorsChangeTD[playerid][24], 11722);
	PlayerTextDrawSetPreviewRot(playerid, ColorsChangeTD[playerid][24], 333.0000, 347.0000, 0.0000, 1.0000);
	PlayerTextDrawSetPreviewModel(playerid, ColorsChangeTD[playerid][27], 16112);
	PlayerTextDrawSetPreviewRot(playerid, ColorsChangeTD[playerid][27], 78.000000, 0.000000, 0.000000, 1.024500);

	if kamen >= 0 *then
	{
		PlayerTextDrawSetString(playerid, ColorsChangeTD[playerid][28], (str_f("%d/1", Inventory[playerid][1][kamen])));
		PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][27], -1);
		PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][27], true);
	}

	if krasitel >= 0 *then
	{
		PlayerTextDrawSetString(playerid, ColorsChangeTD[playerid][25], (str_f("%d/7", Inventory[playerid][1][krasitel])));
		PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][24], Inventory[playerid][1][krasitel] >= 7 ? -1 : -1717986817);
		PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][24], Inventory[playerid][1][krasitel] >= 7 ? 1 : 0);
	}

	if kamen >= 0 && slot >= 0 && krasitel >= 0 *then
	{
		for(new i = 30; i < 36; i++)
			ShowPlayerTD(playerid, ColorsChangeTD[playerid][i]);

		PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][13], 1);
		PlayerTextDrawShow(playerid, ColorsChangeTD[playerid][13]);
	}

	ShowPlayerTD(playerid, ColorsChangeTD[playerid][24]), ShowPlayerTD(playerid, ColorsChangeTD[playerid][27]);
	return PlayerPlaySound(playerid, 6801, 0.0, 0.0, 0.0), ShowPlayerTD(playerid, ColorsChangeTD[playerid][26]);
}

stock IsAChangeColorItem(itemid)
{
	if(IsAAks(itemid) && ItemsInfo[itemid][itemColored]) return true;
	else if(itemid == 809) return true;
	else if(itemid == 1187) return true;
	return false;
}