	AuctionTD[playerid][0] = CreatePlayerTextDraw(playerid, 167.0000, 114.9185, "Box"); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][0], 0.0000, 25.9666);
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][0], 474.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, AuctionTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, AuctionTD[playerid][0], 471802265);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][0], 5);

	AuctionTD[playerid][1] = CreatePlayerTextDraw(playerid, 165.6666, 139.2369, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][1], 310.0000, 1.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][1], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][1], 0);

	AuctionTD[playerid][2] = CreatePlayerTextDraw(playerid, 171.0000, 117.4073, FixText("аукцион")); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][2], 0.5996, 1.7576);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][2], 0);

	AuctionTD[playerid][3] = CreatePlayerTextDraw(playerid, 266.9999, 115.5925, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][3], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][3], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][3], true);

	AuctionTD[playerid][4] = CreatePlayerTextDraw(playerid, 315.0000, 115.5925, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][4], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][4], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][4], true);

	AuctionTD[playerid][5] = CreatePlayerTextDraw(playerid, 363.0000, 115.5925, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][5], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][5], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][5], true);

	AuctionTD[playerid][6] = CreatePlayerTextDraw(playerid, 411.0000, 115.5925, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][6], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][6], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][6], true);

	AuctionTD[playerid][7] = CreatePlayerTextDraw(playerid, 289.0000, 116.1629, FixText("Дома")); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][7], 0.3549, 1.3718);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][7], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][7], 0);

	AuctionTD[playerid][8] = CreatePlayerTextDraw(playerid, 337.6667, 115.7481, FixText("Бизнесы")); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][8], 0.3070, 1.4548);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][8], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][8], 0);

	AuctionTD[playerid][9] = CreatePlayerTextDraw(playerid, 386.6667, 116.1629, FixText("Машины")); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][9], 0.3070, 1.4548);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][9], 2);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][9], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][9], 0);

	AuctionTD[playerid][10] = CreatePlayerTextDraw(playerid, 414.3333, 116.9925, FixText("Предметы")); // 11 - 14 SELECTOR
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][10], 0.2456, 1.2266);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][10], 0);

	AuctionTD[playerid][11] = CreatePlayerTextDraw(playerid, 267.0000, 131.7703, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][11], 45.0000, 2.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][11], 0);

	AuctionTD[playerid][12] = CreatePlayerTextDraw(playerid, 315.0001, 131.7703, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][12], 45.0000, 2.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][12], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][12], 0);

	AuctionTD[playerid][13] = CreatePlayerTextDraw(playerid, 363.0001, 131.7704, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][13], 45.0000, 2.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][13], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][13], 0);

	AuctionTD[playerid][14] = CreatePlayerTextDraw(playerid, 411.0000, 131.3556, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][14], 45.0000, 2.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][14], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][14], 0);

    AuctionTD[playerid][15] = CreatePlayerTextDraw(playerid, 165.6667, 323.8298, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][15], 309.0000, 1.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][15], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][15], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][15], 0);

	AuctionTD[playerid][16] = CreatePlayerTextDraw(playerid, 455.3333, 117.2518, "LD_BEAT:chit"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][16], 20.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][16], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][16], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][16], true);

	AuctionTD[playerid][17] = CreatePlayerTextDraw(playerid, 164.6666, 325.4888, "LD_BEAT:chit"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][17], 25.0000, 25.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][17], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][17], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][17], 0);

	AuctionTD[playerid][18] = CreatePlayerTextDraw(playerid, 225.0000, 325.4888, "LD_BEAT:chit"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][18], 25.0000, 25.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][18], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][18], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][18], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][18], 0);

	AuctionTD[playerid][19] = CreatePlayerTextDraw(playerid, 176.6666, 329.6370, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][19], 61.0000, 16.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][19], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][19], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][19], 0);

	AuctionTD[playerid][20] = CreatePlayerTextDraw(playerid, 206.6665, 333.5258, "CSC: NaN"); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][20], 0.1710, 0.8616);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][20], 2);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][20], 1734399231);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][20], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][20], 0);

	AuctionTD[playerid][21] = CreatePlayerTextDraw(playerid, 463.6666, 119.0666, "!"); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][21], 0.4000, 1.6000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][21], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][21], -1084860673);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][21], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][21], 0);

	AuctionTD[playerid][22] = CreatePlayerTextDraw(playerid, 419.6667, 327.5628, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][22], 53.0000, 19.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][22], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][22], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][22], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][22], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][22], true);

	AuctionTD[playerid][23] = CreatePlayerTextDraw(playerid, 447.3333, 329.3778, FixText("Закрыть")); // пусто
	PlayerTextDrawLetterSize(playerid, AuctionTD[playerid][23], 0.3176, 1.4340);
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][23], 0.0000, -14.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][23], 2);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][23], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][23], 0);

	AuctionTD[playerid][24] = CreatePlayerTextDraw(playerid, 283.6666, 330.4666, "LD_BEAT:left"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][24], 15.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][24], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][24], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][24], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][24], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][24], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][24], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][24], true);

	AuctionTD[playerid][25] = CreatePlayerTextDraw(playerid, 350.0000, 330.4666, "LD_BEAT:right"); // пусто
	PlayerTextDrawTextSize(playerid, AuctionTD[playerid][25], 15.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, AuctionTD[playerid][25], 1);
	PlayerTextDrawColor(playerid, AuctionTD[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionTD[playerid][25], 255);
	PlayerTextDrawFont(playerid, AuctionTD[playerid][25], 4);
	PlayerTextDrawSetProportional(playerid, AuctionTD[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, AuctionTD[playerid][25], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionTD[playerid][25], true);