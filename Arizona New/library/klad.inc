
stock SendkladProgress(id, progress, rand_id)
{
	pTemp[id][kladPercent] = progress;
	
	if progress == 15 *then
	{
		GameTextForPlayer(id, "~g~SUCCESSFULLY", 1500, 3);
		
		new kId = pTemp[id][kladID];
		
		KladInfo[kId][kladOpen] = true;
		
		if IsValidDynamicObject(KladInfo[kId][kladObject][2]) *then
			DestroyDynamicObject(KladInfo[kId][kladObject][2]), KladInfo[kId][kladObject][2] = INVALID_OBJECT_ID;
		
		ClearAnimationsEx(id);
		
	}
	else
	{
		GameTextForPlayer(id, rand_id <= 3 ? "~w~PRESS: ~r~N":"~w~PRESS: ~r~Y", 1500, 3);
		pTemp[id][kladKey] = rand_id <= 3 ? KEY_NO:KEY_YES;
		
		ApplyAnimationEx(id, !"SWORD", !"sword_4", 4.0, 1, 0, 0, 0, 0);
	}
	
	return true;
}

stock CreateKlad(id, Float:X, Float:Y, Float:Z)
{	
	if id == -1 *then
		return false;
	
	KladInfo[id][kladX] = X;
	KladInfo[id][kladY] = Y;
	KladInfo[id][kladZ] = Z;
	
	KladInfo[id][kladObject][0] = CreateDynamicObject(2680, X+0.1, Y+0.55, Z+0.45, 0.0, -89.100021, 0.5, 0, 0, -1, 5.00, 5.00);
    KladInfo[id][kladObject][1] = CreateDynamicObject(11713, X+0.1, Y+0.55, Z+0.35, 0.0, -89.100021, 0.5, 0, 0, -1, 5.00, 5.00);
            
	KladInfo[id][kladObject][2] = CreateDynamicObject(16302, X, Y, Z-4.5, 0.0, 0.0, 0.0, 0, 0, -1, 15.00, 15.00);
    SetDynamicObjectMaterial(KladInfo[id][kladObject][2], 0, 10756, "airportroads_sfse", "stones256128", 0);
	
	KladInfo[id][kladCaptcha] = random(sizeof captcha_klad);
		
	Iter_Add(Klad, id);
	
	return KladInfo[id][kladStatus] = true, KladInfo[id][kladOpen] = false;
}

stock ShowPlayerKlad(playerid, bool:status = true)
{	
	if !status *then
	{		
		for new i; i < 6; i++ do
		{
			DestroyPlayerTD(playerid, KladTD[playerid][i]);
			
			if i < 3 *then
			{
				for new z; z < 5; z++ do
					DestroyPlayerTD(playerid, PrizeKladTD[playerid][i][z]);
			}
		}
		
		return CancelSelectTextDraw(playerid);
	}
	
	KladTD[playerid][5] = CreatePlayerTextDraw(playerid, 174.165894, 147.532501, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, KladTD[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, KladTD[playerid][5], 288.000000, 220.000000);
	PlayerTextDrawAlignment(playerid, KladTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, KladTD[playerid][5], 0x1E1E1EFF);
	PlayerTextDrawUseBox(playerid, KladTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, KladTD[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, KladTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, KladTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, KladTD[playerid][5], 0x000000FF);
	PlayerTextDrawFont(playerid, KladTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, KladTD[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, KladTD[playerid][5], 0);

	KladTD[playerid][4] = CreatePlayerTextDraw(playerid, 174.165894, 152.510101, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, KladTD[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, KladTD[playerid][4], 288.000000, 194.000000);
	PlayerTextDrawAlignment(playerid, KladTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, KladTD[playerid][4], 0x141414FF);
	PlayerTextDrawUseBox(playerid, KladTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, KladTD[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, KladTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, KladTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, KladTD[playerid][4], 0x000000FF);
	PlayerTextDrawFont(playerid, KladTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, KladTD[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, KladTD[playerid][4], 0);

	KladTD[playerid][3] = CreatePlayerTextDraw(playerid, 174.166199, 147.947205, "");
	PlayerTextDrawLetterSize(playerid, KladTD[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, KladTD[playerid][3], 288.000000, -12.000000);
	PlayerTextDrawAlignment(playerid, KladTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, KladTD[playerid][3], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, KladTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, KladTD[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, KladTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, KladTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, KladTD[playerid][3], 0x00000000);
	PlayerTextDrawFont(playerid, KladTD[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, KladTD[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, KladTD[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, KladTD[playerid][3], 19063);
	PlayerTextDrawSetPreviewRot(playerid, KladTD[playerid][3], 0.000000, 75.000000, 177.000000, 0.234500);

	KladTD[playerid][2] = CreatePlayerTextDraw(playerid, 174.333099, 350.103607, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, KladTD[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, KladTD[playerid][2], 287.929901, 2.000000);
	PlayerTextDrawAlignment(playerid, KladTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, KladTD[playerid][2], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, KladTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, KladTD[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, KladTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, KladTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, KladTD[playerid][2], 0x000000FF);
	PlayerTextDrawFont(playerid, KladTD[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, KladTD[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, KladTD[playerid][2], 0);

	KladTD[playerid][1] = CreatePlayerTextDraw(playerid, 455.333405, 136.588806, "X");
	PlayerTextDrawLetterSize(playerid, KladTD[playerid][1], 0.222499, 1.015100);
	PlayerTextDrawTextSize(playerid, KladTD[playerid][1], 10.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, KladTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, KladTD[playerid][1], 0xFFFFFF80);
	PlayerTextDrawUseBox(playerid, KladTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, KladTD[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, KladTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, KladTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, KladTD[playerid][1], 0x000000FF);
	PlayerTextDrawFont(playerid, KladTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, KladTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, KladTD[playerid][1], 1);

	KladTD[playerid][0] = CreatePlayerTextDraw(playerid, 318.666504, 137.948105, SettingData[playerid][sdLanguage] ? FixText("ÂÛ ÎÒÊÐÛËÈ ÊËÀÄ"):"YOU OPENED A TREASURE");
	PlayerTextDrawLetterSize(playerid, KladTD[playerid][0], 0.171200, 0.832400);
	PlayerTextDrawTextSize(playerid, KladTD[playerid][0], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, KladTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, KladTD[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, KladTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, KladTD[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, KladTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, KladTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, KladTD[playerid][0], 0x000000FF);
	PlayerTextDrawFont(playerid, KladTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, KladTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, KladTD[playerid][0], 0);
	
	for new i; i < 6; i++ do
		ShowPlayerTD(playerid, KladTD[playerid][i]);

	return SelectTextDraw(playerid, 0xA52A2AFF);
}

stock CreateKladTD(playerid, num_prize, itemId, Float:X = 208.066605, Float:Y = 226.288803)
{
	X += 87.667007 * num_prize;

	PrizeKladTD[playerid][num_prize][0] = CreatePlayerTextDraw(playerid, X, Y, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, PrizeKladTD[playerid][num_prize][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PrizeKladTD[playerid][num_prize][0], 43.970001, 12.000000);
	PlayerTextDrawAlignment(playerid, PrizeKladTD[playerid][num_prize][0], 1);
	PlayerTextDrawColor(playerid, PrizeKladTD[playerid][num_prize][0], 0x323232FF);
	PlayerTextDrawUseBox(playerid, PrizeKladTD[playerid][num_prize][0], 0);
	PlayerTextDrawBoxColor(playerid, PrizeKladTD[playerid][num_prize][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, PrizeKladTD[playerid][num_prize][0], 0);
	PlayerTextDrawSetOutline(playerid, PrizeKladTD[playerid][num_prize][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PrizeKladTD[playerid][num_prize][0], 0x000000FF);
	PlayerTextDrawFont(playerid, PrizeKladTD[playerid][num_prize][0], 4);
	PlayerTextDrawSetProportional(playerid, PrizeKladTD[playerid][num_prize][0], 0);
	PlayerTextDrawSetSelectable(playerid, PrizeKladTD[playerid][num_prize][0], 1);

	PrizeKladTD[playerid][num_prize][1] = CreatePlayerTextDraw(playerid, X + 0.00009099999, Y - 53.451996, "");
	PlayerTextDrawLetterSize(playerid, PrizeKladTD[playerid][num_prize][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PrizeKladTD[playerid][num_prize][1], 44.000000, 49.000000);
	PlayerTextDrawAlignment(playerid, PrizeKladTD[playerid][num_prize][1], 1);
	PlayerTextDrawColor(playerid, PrizeKladTD[playerid][num_prize][1], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, PrizeKladTD[playerid][num_prize][1], 0);
	PlayerTextDrawBoxColor(playerid, PrizeKladTD[playerid][num_prize][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, PrizeKladTD[playerid][num_prize][1], 0);
	PlayerTextDrawSetOutline(playerid, PrizeKladTD[playerid][num_prize][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PrizeKladTD[playerid][num_prize][1], 0x00000000);
	PlayerTextDrawFont(playerid, PrizeKladTD[playerid][num_prize][1], 5);
	PlayerTextDrawSetProportional(playerid, PrizeKladTD[playerid][num_prize][1], 0);
	PlayerTextDrawSetSelectable(playerid, PrizeKladTD[playerid][num_prize][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, PrizeKladTD[playerid][num_prize][1], ItemsInfo[itemId][itemModel]);
	PlayerTextDrawSetPreviewRot(playerid, PrizeKladTD[playerid][num_prize][1], ItemsInfo[itemId][itemRotation][0], ItemsInfo[itemId][itemRotation][1], ItemsInfo[itemId][itemRotation][2], ItemsInfo[itemId][itemRotation][3]);

	PrizeKladTD[playerid][num_prize][2] = CreatePlayerTextDraw(playerid, X + 22.799987, Y - 64.696396, ItemsInfo[itemId][itemEng_name]);
	PlayerTextDrawLetterSize(playerid, PrizeKladTD[playerid][num_prize][2], 0.168500, 0.683200);
	PlayerTextDrawTextSize(playerid, PrizeKladTD[playerid][num_prize][2], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, PrizeKladTD[playerid][num_prize][2], 2);
	PlayerTextDrawColor(playerid, PrizeKladTD[playerid][num_prize][2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, PrizeKladTD[playerid][num_prize][2], 0);
	PlayerTextDrawBoxColor(playerid, PrizeKladTD[playerid][num_prize][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, PrizeKladTD[playerid][num_prize][2], 0);
	PlayerTextDrawSetOutline(playerid, PrizeKladTD[playerid][num_prize][2], 0);
	PlayerTextDrawBackgroundColor(playerid, PrizeKladTD[playerid][num_prize][2], 0x000000FF);
	PlayerTextDrawFont(playerid, PrizeKladTD[playerid][num_prize][2], 1);
	PlayerTextDrawSetProportional(playerid, PrizeKladTD[playerid][num_prize][2], 1);
	PlayerTextDrawSetSelectable(playerid, PrizeKladTD[playerid][num_prize][2], 0);

	PrizeKladTD[playerid][num_prize][3] = CreatePlayerTextDraw(playerid, X + 22.799987, Y + 1.57399, SettingData[playerid][sdLanguage] ? FixText("ÂÇßÒÜ"):"TAKE");
	PlayerTextDrawLetterSize(playerid, PrizeKladTD[playerid][num_prize][3], 0.208499, 0.861500);
	PlayerTextDrawTextSize(playerid, PrizeKladTD[playerid][num_prize][3], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, PrizeKladTD[playerid][num_prize][3], 2);
	PlayerTextDrawColor(playerid, PrizeKladTD[playerid][num_prize][3], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, PrizeKladTD[playerid][num_prize][3], 0);
	PlayerTextDrawBoxColor(playerid, PrizeKladTD[playerid][num_prize][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, PrizeKladTD[playerid][num_prize][3], 0);
	PlayerTextDrawSetOutline(playerid, PrizeKladTD[playerid][num_prize][3], 0);
	PlayerTextDrawBackgroundColor(playerid, PrizeKladTD[playerid][num_prize][3], 0x000000FF);
	PlayerTextDrawFont(playerid, PrizeKladTD[playerid][num_prize][3], 1);
	PlayerTextDrawSetProportional(playerid, PrizeKladTD[playerid][num_prize][3], 1);
	PlayerTextDrawSetSelectable(playerid, PrizeKladTD[playerid][num_prize][3], 0);

	PrizeKladTD[playerid][num_prize][4] = CreatePlayerTextDraw(playerid, X + 0.00009099999, Y - 53.451996, "");
	PlayerTextDrawLetterSize(playerid, PrizeKladTD[playerid][num_prize][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PrizeKladTD[playerid][num_prize][4], 44.000000, 49.000000);
	PlayerTextDrawAlignment(playerid, PrizeKladTD[playerid][num_prize][4], 1);
	PlayerTextDrawColor(playerid, PrizeKladTD[playerid][num_prize][4], 0x7C33A3FF);
	PlayerTextDrawUseBox(playerid, PrizeKladTD[playerid][num_prize][4], 0);
	PlayerTextDrawBoxColor(playerid, PrizeKladTD[playerid][num_prize][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, PrizeKladTD[playerid][num_prize][4], 0);
	PlayerTextDrawSetOutline(playerid, PrizeKladTD[playerid][num_prize][4], 0);
	PlayerTextDrawBackgroundColor(playerid, PrizeKladTD[playerid][num_prize][4], 0x00000040);
	PlayerTextDrawFont(playerid, PrizeKladTD[playerid][num_prize][4], 5);
	PlayerTextDrawSetProportional(playerid, PrizeKladTD[playerid][num_prize][4], 0);
	PlayerTextDrawSetSelectable(playerid, PrizeKladTD[playerid][num_prize][4], 0);
	PlayerTextDrawSetPreviewModel(playerid, PrizeKladTD[playerid][num_prize][4], 2992);
	PlayerTextDrawSetPreviewRot(playerid, PrizeKladTD[playerid][num_prize][4], 259.000000, 0.000000, 26.000000, 0.229300);
	
	for new i; i < 5; i++ do 
		ShowPlayerTD(playerid, PrizeKladTD[playerid][num_prize][i]);
	
	return true;
}