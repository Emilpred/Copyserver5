stock ShowSecondHandTD(playerid)
{
	if SecondHand_Open{playerid} *then
		return false;
		
	SecondHandTD[playerid][9] = CreatePlayerTextDraw(playerid, 156.166000, 120.984299, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][9], 326.000000, 243.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][9], 0x1E1E1EFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][9], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][9], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][9], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][9], 0);

	SecondHandTD[playerid][8] = CreatePlayerTextDraw(playerid, 156.166000, 125.961899, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][8], 326.000000, 234.029907);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][8], 0x141414FF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][8], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][8], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][8], 0);

	SecondHandTD[playerid][7] = CreatePlayerTextDraw(playerid, 156.166306, 109.784203, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][7], 326.049896, 13.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][7], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][7], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD[playerid][7], 19063);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD[playerid][7], 0.000000, 75.000000, 177.000000, 0.234500);

	SecondHandTD[playerid][6] = CreatePlayerTextDraw(playerid, 155.999802, 126.792503, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][6], 326.000000, 233.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][6], 0x0000003A);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][6], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD[playerid][6], 985);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD[playerid][6], 31.000000, 0.000000, 0.000000, 0.093800);

	SecondHandTD[playerid][5] = CreatePlayerTextDraw(playerid, 317.799896, 112.529503, "SECOND HAND");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][5], 0.192300, 0.820100);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][5], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][5], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][5], 0);

	SecondHandTD[playerid][4] = CreatePlayerTextDraw(playerid, 409.666595, 325.488800, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][4], 27.000000, 33.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][4], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][4], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][4], 0);

	SecondHandTD[playerid][3] = CreatePlayerTextDraw(playerid, 412.166901, 328.789001, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][3], 22.000000, 26.309900);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][3], 0x1E1E1EFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][3], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][3], 0);

	SecondHandTD[playerid][2] = CreatePlayerTextDraw(playerid, 424.866608, 332.696106, "L");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][2], 0.225600, 1.392500);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][2], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][2], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][2], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][2], 0);

	SecondHandTD[playerid][1] = CreatePlayerTextDraw(playerid, 450.866608, 333.940704, "10:00");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][1], 0.257600, 1.521100);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][1], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][1], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][1], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][1], 0);

	SecondHandTD[playerid][0] = CreatePlayerTextDraw(playerid, 474.899902, 110.640701, "X");
	PlayerTextDrawLetterSize(playerid, SecondHandTD[playerid][0], 0.219600, 1.039899);
	PlayerTextDrawTextSize(playerid, SecondHandTD[playerid][0], 10.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, SecondHandTD[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD[playerid][0], 0x000000FF);
	PlayerTextDrawFont(playerid, SecondHandTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, SecondHandTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD[playerid][0], 1);

	SecondHandTD_Click[playerid][9] = CreatePlayerTextDraw(playerid, 253.866394, 207.037094, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][9], 60.000000, 77.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][9], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][9], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][9], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][9], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][9], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][9], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][9], 2689);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][9], 227.000000, 333.000000, 177.000000, 0.782000);
	
	SecondHandTD_Click[playerid][8] = CreatePlayerTextDraw(playerid, 187.199799, 116.192596, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][8], 60.000000, 77.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][8], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][8], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][8], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][8], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][8], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][8], 2704);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][8], 227.000000, 118.000000, 0.000000, 0.782000);
	
	SecondHandTD_Click[playerid][7] = CreatePlayerTextDraw(playerid, 389.200012, 241.881500, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][7], 60.000000, 77.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][7], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][7], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][7], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][7], 2689);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][7], 227.000000, 217.000000, 0.000000, 0.782000);
	
	SecondHandTD_Click[playerid][6] = CreatePlayerTextDraw(playerid, 333.533203, 202.888794, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][6], 60.000000, 77.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][6], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][6], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][6], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][6], 2706);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][6], 227.000000, 183.000000, 0.000000, 0.782000);
	
	SecondHandTD_Click[playerid][5] = CreatePlayerTextDraw(playerid, 260.866302, 122.414703, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][5], 60.000000, 77.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][5], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][5], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][5], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][5], 2705);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][5], 221.000000, 190.000000, 177.000000, 0.782000);
	
	SecondHandTD_Click[playerid][4] = CreatePlayerTextDraw(playerid, 376.200104, 97.940697, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][4], 94.000000, 105.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][4], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][4], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][4], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][4], 2846);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][4], 339.000000, 360.000000, 360.000000, 1.308599);

	SecondHandTD_Click[playerid][3] = CreatePlayerTextDraw(playerid, 251.866501, 271.748291, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][3], 93.000000, 113.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][3], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][3], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][3], 2844);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][3], 339.000000, 360.000000, 360.000000, 1.183500);

	SecondHandTD_Click[playerid][2] = CreatePlayerTextDraw(playerid, 395.866302, 201.229706, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][2], 98.000000, 127.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][2], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][2], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][2], 2845);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][2], 332.000000, 360.000000, 263.000000, 0.547399);

	SecondHandTD_Click[playerid][1] = CreatePlayerTextDraw(playerid, 180.532898, 247.688705, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][1], 92.000000, 119.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][1], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][1], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][1], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][1], 2844);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][1], 339.000000, 360.000000, 316.000000, 0.823700);

	SecondHandTD_Click[playerid][0] = CreatePlayerTextDraw(playerid, 322.199707, 120.340797, "");
	PlayerTextDrawLetterSize(playerid, SecondHandTD_Click[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SecondHandTD_Click[playerid][0], 70.000000, 95.000000);
	PlayerTextDrawAlignment(playerid, SecondHandTD_Click[playerid][0], 1);
	PlayerTextDrawColor(playerid, SecondHandTD_Click[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SecondHandTD_Click[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, SecondHandTD_Click[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SecondHandTD_Click[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, SecondHandTD_Click[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, SecondHandTD_Click[playerid][0], 0x00000000);
	PlayerTextDrawFont(playerid, SecondHandTD_Click[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, SecondHandTD_Click[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, SecondHandTD_Click[playerid][0], 1);
	PlayerTextDrawSetPreviewModel(playerid, SecondHandTD_Click[playerid][0], 2845);
	PlayerTextDrawSetPreviewRot(playerid, SecondHandTD_Click[playerid][0], 284.000000, 360.000000, 298.000000, 0.808099);
	
	SecondHand_Open{playerid} = true;
	
	Int_SetPlayerData(playerid, "SecondHand_PlayerTime", Global_Time + 30);
	

	for new i; i < 10; i++ do
	{
		ShowPlayerTD(playerid, SecondHandTD[playerid][i]);
		
		SetPosTD(playerid, SecondHandTD_Click[playerid][i], floatrandom(135.0, 400.0), floatrandom(90.0, 300.0));
		
		ShowPlayerTD(playerid, SecondHandTD_Click[playerid][i]);
	}
	
	SelectTextDraw(playerid, 0xA52A2AFF);
	
	return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"{00ff00}Подсказка", !"{ffffff}Необходимо убирать грязные и рваные вещи (кликнуть на них)\nЕсли вы уберёте на хорошие вещи, то будете заморожены на 5 секунд.", !"Закрыть", !"");
}

stock DestroySecondHandTD(playerid)
{
	for new i; i < 10; i++ do
		DestroyPlayerTD(playerid, SecondHandTD[playerid][i]),
		DestroyPlayerTD(playerid, SecondHandTD_Click[playerid][i]);
	
	CancelSelectTextDraw(playerid);
	
	DPlayerData(playerid, "SecondHand_PlayerTime");
	DPlayerData(playerid, "SecondIDPICK");
	DPlayerData(playerid, "SecondHandBLOCK");
	
	return SecondHand_Open{playerid} = false;
}