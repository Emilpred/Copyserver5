stock PaintAcs(playerid, type)
{
	new color = PI[playerid][pColorInv];
	switch type do
	{
	    case 0:
	    {
		    ChangeColor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 144.0000, 137.1428, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][0], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][0], 175.0000, 140.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][0], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][0], 286331391);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][0], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][0], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][0], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][0], 0);

		    ChangeColor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 144.0000, 161.1428, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][1], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][1], 175.0000, 1.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][1], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][1], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][1], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][1], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][1], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][1], 0);

		    ChangeColor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 186.3000, 202.8036, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][2], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][2], 21.0000, 2.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][2], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][2], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][2], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][2], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][2], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][2], 0);

		    ChangeColor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 104.9997, 137.1427, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][3], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][3], 36.0000, 140.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][3], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][3], 286331391);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][3], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][3], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][3], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][3], 0);

		    ChangeColor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 105.6666, 162.3428, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][4], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][4], 35.0000, -1.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][4], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][4], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][4], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][4], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][4], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][4], 0);

		    ChangeColor_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 122.6666, 143.9555, SettingData[playerid][sdLanguage] ? "COLOR" : FixText("����")); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][5], 0.1949, 1.2180);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][5], 1280.0000, 1280.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][5], 2);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][5], -1);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][5], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][5], 2);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][5], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][5], 0);

		    ChangeColor_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 165.3332, 143.9555, SettingData[playerid][sdLanguage] ? "PAINTING" : FixText("���������")); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][6], 0.1949, 1.2180);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][6], 1280.0000, 1280.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][6], 2);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][6], -1);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][6], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][6], 2);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][6], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][6], 0);

		    ChangeColor_PTD[playerid][7] = CreatePlayerTextDraw(playerid, 281.3333, 144.7852, SettingData[playerid][sdLanguage] ? "INFORMATION" : FixText("����������")); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][7], 0.1823, 0.9290);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][7], 65.0000, 1.1282);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][7], 2);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][7], -1);
		    PlayerTextDrawUseBox(playerid, ChangeColor_PTD[playerid][7], 1);
		    PlayerTextDrawBoxColor(playerid, ChangeColor_PTD[playerid][7], 16777216);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][7], 91);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][7], 2);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][7], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][7], 0);

		    ChangeColor_PTD[playerid][8] = CreatePlayerTextDraw(playerid, 207.6665, 257.6148, SettingData[playerid][sdLanguage] ? "PAINT" : FixText("�������")); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][8], 0.1490, 0.8751);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][8], 54.0000, 1.1282);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][8], 2);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][8], -1);
		    PlayerTextDrawUseBox(playerid, ChangeColor_PTD[playerid][8], 1);
		    PlayerTextDrawBoxColor(playerid, ChangeColor_PTD[playerid][8], 16777216);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][8], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][8], 2);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][8], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][8], 0);

		    ChangeColor_PTD[playerid][9] = CreatePlayerTextDraw(playerid, 256.3330, 257.2000, SettingData[playerid][sdLanguage] ? "CANCEL" : FixText("�������")); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][9], 0.1490, 0.8751);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][9], 54.0000, 1.1282);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][9], 2);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][9], -1);
		    PlayerTextDrawUseBox(playerid, ChangeColor_PTD[playerid][9], 1);
		    PlayerTextDrawBoxColor(playerid, ChangeColor_PTD[playerid][9], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][9], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][9], 2);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][9], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][9], 0);

		    ChangeColor_PTD[playerid][10] = CreatePlayerTextDraw(playerid, 257.7333, 203.1183, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][10], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][10], 21.0000, 2.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][10], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][10], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][10], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][10], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][10], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][10], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][10], true);

		    ChangeColor_PTD[playerid][11] = CreatePlayerTextDraw(playerid, 216.4001, 215.5630, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][11], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][11], 33.0000, 2.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][11], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][11], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][11], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][11], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][11], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][11], 0);

		    ChangeColor_PTD[playerid][12] = CreatePlayerTextDraw(playerid, 254.0000, 141.7259, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][12], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][12], 54.0000, 16.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][12], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][12], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][12], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][12], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][12], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][12], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][12], true);

		    ChangeColor_PTD[playerid][13] = CreatePlayerTextDraw(playerid, 185.9998, 253.7259, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][13], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][13], 44.0000, 16.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][13], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][13], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][13], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][13], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][13], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][13], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][13], true);

		    ChangeColor_PTD[playerid][14] = CreatePlayerTextDraw(playerid, 235.0000, 253.7259, "LD_SPAC:white"); // пусто
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][14], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][14], 44.0000, 16.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][14], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][14], color);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][14], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][14], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][14], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][14], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][14], true);

		    ChangeColor_PTD[playerid][15] = CreatePlayerTextDraw(playerid, 107.2994, 176.1555, "LD_SPAC:white"); // белый
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][15], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][15], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][15], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][15], -858993409);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][15], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][15], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][15], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][15], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][15], true);

		    ChangeColor_PTD[playerid][16] = CreatePlayerTextDraw(playerid, 124.3294, 176.1555, "LD_SPAC:white"); // красный
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][16], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][16], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][16], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][16], -870045953);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][16], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][16], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][16], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][16], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][16], true);

		    ChangeColor_PTD[playerid][17] = CreatePlayerTextDraw(playerid, 107.2994, 193.5554, "LD_SPAC:white"); // тёмно-оранжевый
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][17], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][17], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][17], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][17], -864541441);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][17], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][17], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][17], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][17], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][17], true);

		    ChangeColor_PTD[playerid][18] = CreatePlayerTextDraw(playerid, 124.3294, 193.5554, "LD_SPAC:white"); // желтый
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][18], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][18], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][18], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][18], -423878913);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][18], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][18], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][18], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][18], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][18], true);

		    ChangeColor_PTD[playerid][19] = CreatePlayerTextDraw(playerid, 107.2994, 210.9555, "LD_SPAC:white"); // светло-желтый
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][19], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][19], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][19], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][19], -707314433);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][19], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][19], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][19], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][19], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][19], true);

		    ChangeColor_PTD[playerid][20] = CreatePlayerTextDraw(playerid, 124.3294, 210.9555, "LD_SPAC:white"); // зелёный
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][20], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][20], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][20], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][20], 1020739839);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][20], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][20], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][20], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][20], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][20], true);

		    ChangeColor_PTD[playerid][21] = CreatePlayerTextDraw(playerid, 107.2994, 228.3553, "LD_SPAC:white"); // берёзовый
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][21], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][21], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][21], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][21], 1020778495);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][21], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][21], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][21], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][21], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][21], true);

		    ChangeColor_PTD[playerid][22] = CreatePlayerTextDraw(playerid, 124.3294, 228.3553, "LD_SPAC:white"); 
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][22], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][22], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][22], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][22], 1010751487);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][22], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][22], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][22], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][22], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][22], true);

		    ChangeColor_PTD[playerid][23] = CreatePlayerTextDraw(playerid, 107.2994, 245.7554, "LD_SPAC:white"); 
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][23], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][23], 15.0000, 15.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][23], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][23], -683879169);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][23], 255);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][23], 4);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][23], 0);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][23], 0);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][23], true);

		    ChangeColor_PTD[playerid][24] = CreatePlayerTextDraw(playerid, 185.9996, 178.6443, "LD_SPAC:white"); 
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][24], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][24], 21.0000, 25.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][24], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][24], -1717986817);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][24], 858993663);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][24], 5);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][24], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][24], 2);
		    PlayerTextDrawSetPreviewModel(playerid, ChangeColor_PTD[playerid][24], 11722);
		    PlayerTextDrawSetPreviewRot(playerid, ChangeColor_PTD[playerid][24], 333.0000, 347.0000, 0.0000, 1.0000);

		    ChangeColor_PTD[playerid][25] = CreatePlayerTextDraw(playerid, 206.1761, 198.5596, "7/7"); 
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][25], 0.0833, 0.4237);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][25], 1280.0000, 1280.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][25], 3);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][25], 1995136682);
		    PlayerTextDrawSetOutline(playerid, ChangeColor_PTD[playerid][25], 1);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][25], 2);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][25], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][25], 0);

		    ChangeColor_PTD[playerid][26] = CreatePlayerTextDraw(playerid, 216.3329, 178.6441, "LD_SPAC:white"); 
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][26], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][26], 33.0000, 37.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][26], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][26], -1);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][26], 858993663);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][26], 5);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][26], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][26], 2);
		    PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][26], 0);
		    PlayerTextDrawSetPreviewModel(playerid, ChangeColor_PTD[playerid][26], 1649);
		    PlayerTextDrawSetPreviewRot(playerid, ChangeColor_PTD[playerid][26], 0.0000, 0.0000, 90.0000, 0.6036);

		    ChangeColor_PTD[playerid][27] = CreatePlayerTextDraw(playerid, 257.6661, 178.6443, "LD_SPAC:white");
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][27], 0.4799, 1.1200);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][27], 21.0000, 25.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][27], 1);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][27], -1717986817);
		    PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][27], 858993663);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][27], 5);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][27], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][27], 2);
		    PlayerTextDrawSetPreviewModel(playerid, ChangeColor_PTD[playerid][27], 16112);
		    PlayerTextDrawSetPreviewRot(playerid, ChangeColor_PTD[playerid][27], 78.0000, 0.0000, 0.0000, 1.0245);

		    ChangeColor_PTD[playerid][28] = CreatePlayerTextDraw(playerid, 277.8427, 198.5596, "1/1"); 
		    PlayerTextDrawLetterSize(playerid, ChangeColor_PTD[playerid][28], 0.0833, 0.4237);
		    PlayerTextDrawTextSize(playerid, ChangeColor_PTD[playerid][28], 1280.0000, 1280.0000);
		    PlayerTextDrawAlignment(playerid, ChangeColor_PTD[playerid][28], 3);
		    PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][28], 1995136682);
		    PlayerTextDrawSetOutline(playerid, ChangeColor_PTD[playerid][28], 1);
		    PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][28], 2);
		    PlayerTextDrawSetProportional(playerid, ChangeColor_PTD[playerid][28], 1);
		    PlayerTextDrawSetShadow(playerid, ChangeColor_PTD[playerid][28], 0);
			
			
			InfoColorChange[playerid][0] = CreatePlayerTextDraw(playerid, 207.9998, 222.1999, "LD_SPAC:white"); // ПОЯВЛЕНИЕ ИНФ О ЗАТОЧКЕ (4)
            PlayerTextDrawLetterSize(playerid, InfoColorChange[playerid][0], 0.4799, 1.1200);
            PlayerTextDrawTextSize(playerid, InfoColorChange[playerid][0], 50.0000, 12.0000);
            PlayerTextDrawAlignment(playerid, InfoColorChange[playerid][0], 1);
            PlayerTextDrawColor(playerid, InfoColorChange[playerid][0], 92);
            PlayerTextDrawBackgroundColor(playerid, InfoColorChange[playerid][0], 255);
            PlayerTextDrawFont(playerid, InfoColorChange[playerid][0], 4);
            PlayerTextDrawSetProportional(playerid, InfoColorChange[playerid][0], 0);
            PlayerTextDrawSetShadow(playerid, InfoColorChange[playerid][0], 0);

            InfoColorChange[playerid][1] = CreatePlayerTextDraw(playerid, 207.9998, 235.4739, "LD_SPAC:white"); // ПОЯВЛЕНИЕ ИНФ О ЗАТОЧКЕ (4)
            PlayerTextDrawLetterSize(playerid, InfoColorChange[playerid][1], 0.4799, 1.1200);
            PlayerTextDrawTextSize(playerid, InfoColorChange[playerid][1], 50.0000, 12.0000);
            PlayerTextDrawAlignment(playerid, InfoColorChange[playerid][1], 1);
            PlayerTextDrawColor(playerid, InfoColorChange[playerid][1], 92);
            PlayerTextDrawBackgroundColor(playerid, InfoColorChange[playerid][1], 255);
            PlayerTextDrawFont(playerid, InfoColorChange[playerid][1], 4);
            PlayerTextDrawSetProportional(playerid, InfoColorChange[playerid][1], 0);
            PlayerTextDrawSetShadow(playerid, InfoColorChange[playerid][1], 0);            
            
            InfoColorChange[playerid][2] = CreatePlayerTextDraw(playerid, 233.9998, 237.2888, "$50000"); // ПОЯВЛЕНИЕ ИНФ О ЗАТОЧКЕ (3)
            PlayerTextDrawLetterSize(playerid,  InfoColorChange[playerid][2], 0.1490, 0.8751);
            PlayerTextDrawTextSize(playerid,  InfoColorChange[playerid][2], 54.0000, 1.1282);
            PlayerTextDrawAlignment(playerid,  InfoColorChange[playerid][2], 2);
            PlayerTextDrawColor(playerid,  InfoColorChange[playerid][2], -1);
            PlayerTextDrawUseBox(playerid,  InfoColorChange[playerid][2], 1);
            PlayerTextDrawBoxColor(playerid,  InfoColorChange[playerid][2], 16777216);
            PlayerTextDrawBackgroundColor(playerid,  InfoColorChange[playerid][2], 255);
            PlayerTextDrawFont(playerid,  InfoColorChange[playerid][2], 2);
            PlayerTextDrawSetProportional(playerid,  InfoColorChange[playerid][2], 1);
            PlayerTextDrawSetShadow(playerid,  InfoColorChange[playerid][2], 0);

            InfoColorChange[playerid][3] = CreatePlayerTextDraw(playerid, 208.0001, 222.6145, "LD_SPAC:white");
            PlayerTextDrawLetterSize(playerid, InfoColorChange[playerid][3], 0.4799, 1.1200);
            PlayerTextDrawTextSize(playerid, InfoColorChange[playerid][3], 2.0000, 11.0000);
            PlayerTextDrawAlignment(playerid, InfoColorChange[playerid][3], 1);
            PlayerTextDrawColor(playerid, InfoColorChange[playerid][3], color);
            PlayerTextDrawBackgroundColor(playerid, InfoColorChange[playerid][3], 255);
            PlayerTextDrawFont(playerid, InfoColorChange[playerid][3], 4);
            PlayerTextDrawSetProportional(playerid, InfoColorChange[playerid][3], 0);
            PlayerTextDrawSetShadow(playerid, InfoColorChange[playerid][3], 0);

            InfoColorChange[playerid][4] = CreatePlayerTextDraw(playerid, 208.0000, 235.8885, "LD_SPAC:white"); // ПОЯВЛЕНИЕ ИНФ О ЗАТОЧКЕ (2)
            PlayerTextDrawLetterSize(playerid,  InfoColorChange[playerid][4], 0.4799, 1.1200);
            PlayerTextDrawTextSize(playerid,  InfoColorChange[playerid][4], 2.0000, 11.0000);
            PlayerTextDrawAlignment(playerid,  InfoColorChange[playerid][4], 1);
            PlayerTextDrawColor(playerid,  InfoColorChange[playerid][4], color);
            PlayerTextDrawBackgroundColor(playerid,  InfoColorChange[playerid][4], 255);
            PlayerTextDrawFont(playerid,  InfoColorChange[playerid][4], 4);
            PlayerTextDrawSetProportional(playerid,  InfoColorChange[playerid][4], 0);
            PlayerTextDrawSetShadow(playerid,  InfoColorChange[playerid][4], 0);

            InfoColorChange[playerid][5] = CreatePlayerTextDraw(playerid, 233.9998, 223.6000, "CHANCE:30.0"); // ПОЯВЛЕНИЕ ИНФ О ЗАТОЧКЕ (5)
            PlayerTextDrawLetterSize(playerid, InfoColorChange[playerid][5], 0.1490, 0.8751);
            PlayerTextDrawTextSize(playerid, InfoColorChange[playerid][5], 54.0000, 1.1282);
            PlayerTextDrawAlignment(playerid, InfoColorChange[playerid][5], 2);
            PlayerTextDrawColor(playerid, InfoColorChange[playerid][5], -1);
            PlayerTextDrawUseBox(playerid, InfoColorChange[playerid][5], 1);
            PlayerTextDrawBoxColor(playerid, InfoColorChange[playerid][5], 16777216);
            PlayerTextDrawBackgroundColor(playerid, InfoColorChange[playerid][5], 255);
            PlayerTextDrawFont(playerid, InfoColorChange[playerid][5], 2);
            PlayerTextDrawSetProportional(playerid, InfoColorChange[playerid][5], 1);
            PlayerTextDrawSetShadow(playerid, InfoColorChange[playerid][5], 0);

		    for(new i; i < 29; i++)
			{
				ShowPlayerTD(playerid, ChangeColor_PTD[playerid][i]);
				if(i < 6) ShowPlayerTD(playerid, InfoColorChange[playerid][i]);
			}
				
			ColorPaint{playerid} = true;
			ShowPlayerTD(playerid, EnchantWorkTD[playerid][18]);

			ShowInventoryPage(playerid, 485.299988, 138.642853, E_INVENTORY_TYPE_COLOR);

            SelectTextDraw(playerid, PI[playerid][pSelectTD]);
	    }
	    case 1:
	    {
     		for(new i; i < 29; i++)
			{
	            DestroyPlayerTD(playerid, ChangeColor_PTD[playerid][i]);
				if(i < 6) DestroyPlayerTD(playerid, InfoColorChange[playerid][i]);
			}
			if(IsPlayerTextDrawVisible(playerid, ChangeColor_A[playerid])) DestroyPlayerTD(playerid, ChangeColor_A[playerid]);
			if PaintColorItem[playerid][0] - 1 >= 0 *then InventSlotUse[playerid][PaintColorItem[playerid][0] - 1] = false;
			if PaintColorItem[playerid][1] - 1 >= 0 *then InventSlotUse[playerid][PaintColorItem[playerid][1] - 1] = false;
			if PaintColorItem[playerid][2] - 1 >= 0 *then InventSlotUse[playerid][PaintColorItem[playerid][2] - 1] = false;

			PaintColorItem[playerid][0] = 0;
			PaintColorItem[playerid][1] = 0;
			PaintColorItem[playerid][2] = 0;
			selectColorPaint[playerid] = -1;
            CancelSelectTextDraw(playerid);
			ColorPaint{playerid} = false;

           	return HideInvent(playerid);
	    }
	}
	return 0;
}
stock DestroyColorPaint(playerid)
{
	for(new i; i < 29; i++)
	{
 		DestroyPlayerTD(playerid, ChangeColor_PTD[playerid][i]);
		if(i < 6) DestroyPlayerTD(playerid, InfoColorChange[playerid][i]);
	}
	if(IsPlayerTextDrawVisible(playerid, ChangeColor_A[playerid])) DestroyPlayerTD(playerid, ChangeColor_A[playerid]);
	if PaintColorItem[playerid][0] - 1 >= 0 *then InventSlotUse[playerid][PaintColorItem[playerid][0] - 1] = false;
	if PaintColorItem[playerid][1] - 1 >= 0 *then InventSlotUse[playerid][PaintColorItem[playerid][1] - 1] = false;
	if PaintColorItem[playerid][2] - 1 >= 0 *then InventSlotUse[playerid][PaintColorItem[playerid][2] - 1] = false;
	PaintColorItem[playerid][0] = 0;
	PaintColorItem[playerid][1] = 0;
	PaintColorItem[playerid][2] = 0;
	selectColorPaint[playerid] = -1;

	CancelSelectTextDraw(playerid);
	ColorPaint{playerid} = false;

	return HideInvent(playerid);
}
stock UpdateColorPaint(playerid)
{
	new slot = PaintColorItem[playerid][0] -1, kamen = PaintColorItem[playerid][1] -1, item;
	new color_k = PaintColorItem[playerid][2] - 1;


	if slot >= 0 && IsAAks(Inventory[playerid][0][slot]) *then
	{
		item = Inventory[playerid][0][slot];

		PlayerTextDrawFont(playerid, ChangeColor_PTD[playerid][26], ItemsInfo[item][itemCustom] == 2 ? 100 : 5);
		PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][26], ItemsInfo[item][itemColor]);
		PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][26], true);
		PlayerTextDrawSetPreviewModel(playerid, ChangeColor_PTD[playerid][26], ItemsInfo[item][itemModel]);
		PlayerTextDrawSetPreviewRot(playerid, ChangeColor_PTD[playerid][26], ItemsInfo[item][itemRotation][0], ItemsInfo[item][itemRotation][1], ItemsInfo[item][itemRotation][2], ItemsInfo[item][itemRotation][3]);
	}
	else
	{
		PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][26], 0x333333FF);
		PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][26], false);
		PlayerTextDrawSetPreviewModel(playerid, ChangeColor_PTD[playerid][26], 1649);
		PlayerTextDrawSetPreviewRot(playerid, ChangeColor_PTD[playerid][26], 0.000000, 0.000000, 90.000000, 2.000000);
	}
	ShowPlayerTD(playerid, ChangeColor_PTD[playerid][26]);

	if kamen >= 0 *then
	{
		PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][27], ItemsInfo[Inventory[playerid][0][kamen]][itemColor]);
		PlayerTextDrawSetPreviewModel(playerid, ChangeColor_PTD[playerid][27], ItemsInfo[Inventory[playerid][0][kamen]][itemModel]);
		PlayerTextDrawSetPreviewRot(playerid, ChangeColor_PTD[playerid][27], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][0], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][1], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][2], ItemsInfo[Inventory[playerid][0][kamen]][itemRotation][3]);
		PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][27], kamen >= 0 ? true:false);
		PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][27], setUP[playerid][0] > 0 ? 0xFFFFFFFF:0x999999FF);
		ShowPlayerTD(playerid, ChangeColor_PTD[playerid][27]);
		
	}
	if color_k >= 0 *then
	{
		PlayerTextDrawBackgroundColor(playerid, ChangeColor_PTD[playerid][24], ItemsInfo[809][itemColor]);
		PlayerTextDrawSetPreviewModel(playerid, ChangeColor_PTD[playerid][24], ItemsInfo[809][itemModel]);
		PlayerTextDrawSetPreviewRot(playerid, ChangeColor_PTD[playerid][24], ItemsInfo[809][itemRotation][0], ItemsInfo[809][itemRotation][1], ItemsInfo[809][itemRotation][2], ItemsInfo[809][itemRotation][3]);
	
		PlayerTextDrawSetSelectable(playerid, ChangeColor_PTD[playerid][24], color_k >= 0 ? true:false);
		PlayerTextDrawColor(playerid, ChangeColor_PTD[playerid][24], setUP[playerid][1] > 0 ? 0xFFFFFFFF:0x999999FF);
		ShowPlayerTD(playerid, ChangeColor_PTD[playerid][24]);
	}
	PlayerTextDrawSetStringf(playerid, InfoColorChange[playerid][2], "$%d", BizData[BizEntered[playerid]][bItem][2]);
	for(new k; k < 6; k++) { PlayerTextDrawShow(playerid, InfoColorChange[playerid][k]); }
	return PlayerPlaySound(playerid, 6801, 0.0, 0.0, 0.0), ShowPlayerTD(playerid, ChangeColor_PTD[playerid][26]);
}
