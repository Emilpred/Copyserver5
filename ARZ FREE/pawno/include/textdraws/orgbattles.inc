    OrgBattlesTD[playerid][0] = CreatePlayerTextDraw(playerid, 12.000000, 150.154907, !"LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][0], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][0], 75.000000, 149.000000);
	PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][0], 0x1E1E1EA7);
	PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][0], 0x000000FF);
	PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][0], 0);

    OrgBattlesTD[playerid][1] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 19.149902 : 18.649902, OrgBattlesState == 2 ? 175.021805 : 173.755203, !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][1], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][1], OrgBattlesState == 2 ? 33.000000 : 29.000000, 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][1], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][1], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][1], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][1], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][1], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][1], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][1], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][1], OrgBattlesState == 2 ? 1254 : 18659);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][1], 0.000000, OrgBattlesState == 2 ? 0.000000 : 23.000000, OrgBattlesState == 2 ? 0.000000 : 270.000000, 0.742600);

    OrgBattlesTD[playerid][2] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 51.399902 : 19.149902, OrgBattlesState == 2 ? 174.921799 : 172.821701, !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][2], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][2], OrgBattlesState == 2 ? 35.000000 : 29.000000, 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][2], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][2], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][2], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][2], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][2], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][2], OrgBattlesState == 2 ? 1254 : 18659);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][2], 0.000000, OrgBattlesState == 2 ? 0.000000 : 23.000000, OrgBattlesState == 2 ? 0.000000 : 270.000000, 0.742600);

    OrgBattlesTD[playerid][3] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 19.149902 : 50.899902, OrgBattlesState == 2 ? 212.944199 : 173.755203, !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][3], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][3], OrgBattlesState == 2 ? 34.679798 : 29.000000, 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][3], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][3], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][3], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][3], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][3], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][3], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][3], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][3], OrgBattlesState == 2 ? 1254 : 18665);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][3], 0.000000, OrgBattlesState == 2 ? 0.000000 : 23.000000, OrgBattlesState == 2 ? 0.000000 : 270.000000, 0.742600);

    OrgBattlesTD[playerid][4] = CreatePlayerTextDraw(playerid, 51.399902, OrgBattlesState == 2 ? 213.144302 : 172.821701, !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][4], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][4], OrgBattlesState == 2 ? 35.000000 : 29.000000, 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][4], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][4], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][4], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][4], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][4], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][4], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][4], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][4], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][4], OrgBattlesState == 2 ? 1254 : 18665);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][4], 0.000000, OrgBattlesState == 2 ? 0.000000 : 23.000000, OrgBattlesState == 2 ? 0.000000 : 270.000000, 0.742600);

    OrgBattlesTD[playerid][5] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 19.149902 : 18.649902, OrgBattlesState == 2 ? 249.477600 : 210.777603, !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][5], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][5], OrgBattlesState == 2 ? 33.860001 : 29.000000, 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][5], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][5], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][5], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][5], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][5], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][5], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][5], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][5], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][5], OrgBattlesState == 2 ? 1254 : 18667);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][5], 0.000000, OrgBattlesState == 2 ? 0.000000 : 23.000000, OrgBattlesState == 2 ? 0.000000 : 270.000000, 0.742600);

    OrgBattlesTD[playerid][6] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 35.465088 : 19.149902, OrgBattlesState == 2 ? 179.666794 : 209.844101, OrgBattlesState == 2 ? !"RUSSIAN" : !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][6], OrgBattlesState == 2 ? 0.165500 : 0.480000, OrgBattlesState == 2 ? 0.865000 : 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][6], OrgBattlesState == 2 ? 1280.000000 : 29.000000, OrgBattlesState == 2 ? 1280.000000 : 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][6], OrgBattlesState == 2 ? 2 : 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][6], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][6], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][6], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][6], 0x00FFFF00);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][6], OrgBattlesState == 2 ? 1 : 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][6], OrgBattlesState == 2 ? 1 : 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][6], 0);
    if OrgBattlesState == 1 *then 
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][6], 18667),
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][6], 0.000000, 23.000000, 270.000000, 0.742600);

    OrgBattlesTD[playerid][7] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 35.893311 : 50.899902, OrgBattlesState == 2 ? 186.455994 : 210.777603, OrgBattlesState == 2 ? !"MAFIA" : !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][7], OrgBattlesState == 2 ? 0.242000 : 0.480000, OrgBattlesState == 2 ? 0.954400 : 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][7], OrgBattlesState == 2 ? 1280.000000 : 29.000000, OrgBattlesState == 2 ? 1280.000000 : 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][7], OrgBattlesState == 2 ? 2 : 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][7], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][7], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][7], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][7], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][7], OrgBattlesState == 2 ? 1 : 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][7], OrgBattlesState == 2 ? 1 : 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][7], 0);
    if OrgBattlesState == 1 *then 
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][7], 18661),
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][7], 0.000000, 23.000000, 270.000000, 0.742600);

    OrgBattlesTD[playerid][8] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 68.429321 : 51.399902, OrgBattlesState == 2 ? 182.956100 : 209.844101, OrgBattlesState == 2 ? !"YAKUZA" : !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][8], OrgBattlesState == 2 ? 0.189500 : 0.480000, OrgBattlesState == 2 ? 0.946600 : 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][8], OrgBattlesState == 2 ? 1280.000000 : 29.000000, OrgBattlesState == 2 ? 1280.000000 : 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][8], OrgBattlesState == 2 ? 2 : 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][8], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][8], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][8], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][8], 0xFFFF0000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][8], OrgBattlesState == 2 ? 1 : 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][8], OrgBattlesState == 2 ? 1 : 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][8], 0);
    if OrgBattlesState == 1 *then 
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][8], 18661),
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][8], 0.000000, 23.000000, 270.000000, 0.742600);

    OrgBattlesTD[playerid][9] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 36.569214 : 18.649902, OrgBattlesState == 2 ? 217.567001 : 248.110901, OrgBattlesState == 2 ? !"LA_COSA" : !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][9], OrgBattlesState == 2 ? 0.167600 : 0.480000, OrgBattlesState == 2 ? 0.798800 : 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][9], OrgBattlesState == 2 ? 1280.000000 : 29.000000, OrgBattlesState == 2 ? 1280.000000 : 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][9], OrgBattlesState == 2 ? 2 : 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][9], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][9], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][9], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][9], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][9], OrgBattlesState == 2 ? 1 : 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][9], OrgBattlesState == 2 ? 1 : 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][9], 0);
    if OrgBattlesState == 1 *then 
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][9], 18663),
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][9], 0.000000, 23.000000, 270.000000, 0.742600);

    OrgBattlesTD[playerid][10] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 36.834290 : 19.149902, OrgBattlesState == 2 ? 224.156296 : 247.177505, OrgBattlesState == 2 ? !"NOSTRA" : !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][10], OrgBattlesState == 2 ? 0.182700 : 0.480000, OrgBattlesState == 2 ? 0.841600 : 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][10], OrgBattlesState == 2 ? 1280.000000 : 29.000000, OrgBattlesState == 2 ? 1280.000000 : 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][10], OrgBattlesState == 2 ? 2 : 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][10], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][10], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][10], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][10], 0xFFA50000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][10], OrgBattlesState == 2 ? 1 : 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][10], OrgBattlesState == 2 ? 1 : 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][10], 0);
    if OrgBattlesState == 1 *then 
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][10], 18663),
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][10], 0.000000, 23.000000, 270.000000, 0.742600);

    OrgBattlesTD[playerid][11] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 68.894592 : 50.899902, OrgBattlesState == 2 ? 217.178101 : 248.110901, OrgBattlesState == 2 ? !"BIKERS" : !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][11], OrgBattlesState == 2 ? 0.199500 : 0.480000, OrgBattlesState == 2 ? 0.915500 : 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][11], OrgBattlesState == 2 ? 1280.000000 : 29.000000, OrgBattlesState == 2 ? 1280.000000 : 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][11], OrgBattlesState == 2 ? 2 : 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][11], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][11], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][11], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][11], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][11], OrgBattlesState == 2 ? 1 : 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][11], OrgBattlesState == 2 ? 1 : 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][11], 0);
    if OrgBattlesState == 1 *then 
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][11], 18660),
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][11], 0.000000, 23.000000, 270.000000, 0.742600);

    OrgBattlesTD[playerid][12] = CreatePlayerTextDraw(playerid, OrgBattlesState == 2 ? 69.127075 : 51.399902, OrgBattlesState == 2 ? 224.878601 : 247.177505, OrgBattlesState == 2 ? !"WARLOCK" : !"");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][12], OrgBattlesState == 2 ? 0.137900 : 0.480000, OrgBattlesState == 2 ? 0.857200 : 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][12], OrgBattlesState == 2 ? 1280.000000 : 29.000000, OrgBattlesState == 2 ? 1280.000000 : 34.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][12], OrgBattlesState == 2 ? 2 : 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][12], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][12], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][12], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][12], 0xFFFFFF00);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][12], OrgBattlesState == 2 ? 1 : 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][12], OrgBattlesState == 2 ? 1 : 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][12], 0);
    if OrgBattlesState == 1 *then 
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][12], 18660),
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][12], 0.000000, 23.000000, 270.000000, 0.742600);

    if OrgBattlesState == 2 *then 
    {
        OrgBattlesTD[playerid][13] = CreatePlayerTextDraw(playerid, 36.103882, 256.822906, !"TIERRA");
        PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][13], 0.188100, 0.868800);
        PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][13], 1280.000000, 1280.000000);
        PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][13], 2);
        PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][13], 0xFFFFFFFF);
        PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][13], 0);
        PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][13], 0x80808080);
        PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][13], 0);
        PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][13], 0);
        PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][13], 0x000000FF);
        PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][13], 1);
        PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][13], 1);
        PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][13], 0);

        OrgBattlesTD[playerid][14] = CreatePlayerTextDraw(playerid, 36.103882, 262.623291, !"ROBADA");
        PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][14], 0.159500, 0.880500);
        PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][14], 1280.000000, 1280.000000);
        PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][14], 2);
        PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][14], 0xFFFFFFFF);
        PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][14], 0);
        PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][14], 0x80808080);
        PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][14], 0);
        PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][14], 0);
        PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][14], 0x000000FF);
        PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][14], 1);
        PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][14], 1);
        PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][14], 0);

        OrgBattlesTD[playerid][15] = CreatePlayerTextDraw(playerid, 36.103882, 250.622498, !"BIKERS");
        PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][15], 0.199500, 0.915500);
        PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][15], 1280.000000, 1280.000000);
        PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][15], 2);
        PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][15], 0xFFFFFFFF);
        PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][15], 0);
        PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][15], 0x80808080);
        PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][15], 0);
        PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][15], 0);
        PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][15], 0x000000FF);
        PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][15], 1);
        PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][15], 1);
        PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][15], 0);
    }

    OrgBattlesTD[playerid][16] = CreatePlayerTextDraw(playerid, 50.149902, 157.421906, (str_f("BATTLE_FOR_%s~n~02:00:00", OrgBattlesState == 1 ? "DRUGDEN" : "OILRIGS")));
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][16], 0.132800, 0.666400);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][16], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][16], 2);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][16], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][16], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][16], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][16], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][16], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][16], 1);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][16], 1);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][16], 0);

    OrgBattlesTD[playerid][17] = CreatePlayerTextDraw(playerid, 22.399902, 195.844101, !"particle:bloodpool_64");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][17], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][17], 14.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][17], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][17], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][17], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][17], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][17], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][17], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][17], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][17], 4);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][17], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][17], 0);

    OrgBattlesTD[playerid][18] = CreatePlayerTextDraw(playerid, 30.462891, 194.055496, !"_");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][18], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][18], 20.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][18], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][18], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][18], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][18], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][18], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][18], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][18], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][18], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][18], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][18], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][18], 19474);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][18], 270.000000, 0.000000, 90.000000, 1.000000);

    OrgBattlesTD[playerid][19] = CreatePlayerTextDraw(playerid, 41.211426, 200.878098, !"0");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][19], 0.162300, 0.740500);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][19], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][19], 2);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][19], 0xC0C0C0FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][19], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][19], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][19], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][19], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][19], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][19], 1);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][19], 1);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][19], 0);

    OrgBattlesTD[playerid][20] = CreatePlayerTextDraw(playerid, 54.649902, 195.844101, !"particle:bloodpool_64");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][20], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][20], 14.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][20], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][20], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][20], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][20], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][20], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][20], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][20], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][20], 4);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][20], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][20], 0);

    OrgBattlesTD[playerid][21] = CreatePlayerTextDraw(playerid, 62.712891, 194.055496, !"_");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][21], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][21], 20.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][21], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][21], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][21], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][21], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][21], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][21], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][21], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][21], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][21], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][21], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][21], 19474);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][21], 270.000000, 0.000000, 90.000000, 1.000000);

    OrgBattlesTD[playerid][22] = CreatePlayerTextDraw(playerid, 73.461426, 200.878098, !"0");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][22], 0.162300, 0.740500);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][22], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][22], 2);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][22], 0xC0C0C0FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][22], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][22], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][22], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][22], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][22], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][22], 1);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][22], 1);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][22], 0);

    OrgBattlesTD[playerid][23] = CreatePlayerTextDraw(playerid, 22.399902, 232.866302, !"particle:bloodpool_64");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][23], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][23], 14.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][23], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][23], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][23], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][23], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][23], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][23], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][23], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][23], 4);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][23], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][23], 0);

    OrgBattlesTD[playerid][24] = CreatePlayerTextDraw(playerid, 30.462891, 231.077698, !"_");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][24], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][24], 20.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][24], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][24], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][24], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][24], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][24], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][24], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][24], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][24], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][24], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][24], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][24], 19474);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][24], 270.000000, 0.000000, 90.000000, 1.000000);

    OrgBattlesTD[playerid][25] = CreatePlayerTextDraw(playerid, 41.211426, 237.900299, !"0");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][25], 0.162300, 0.740500);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][25], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][25], 2);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][25], 0xC0C0C0FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][25], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][25], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][25], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][25], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][25], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][25], 1);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][25], 1);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][25], 0);

    OrgBattlesTD[playerid][26] = CreatePlayerTextDraw(playerid, 54.649902, 232.866302, !"particle:bloodpool_64");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][26], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][26], 14.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][26], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][26], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][26], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][26], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][26], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][26], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][26], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][26], 4);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][26], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][26], 0);

    OrgBattlesTD[playerid][27] = CreatePlayerTextDraw(playerid, 62.712891, 231.077698, !"_");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][27], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][27], 20.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][27], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][27], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][27], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][27], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][27], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][27], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][27], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][27], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][27], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][27], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][27], 19474);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][27], 270.000000, 0.000000, 90.000000, 1.000000);

    OrgBattlesTD[playerid][28] = CreatePlayerTextDraw(playerid, 73.461426, 237.900299, !"0");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][28], 0.162300, 0.740500);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][28], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][28], 2);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][28], 0xC0C0C0FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][28], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][28], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][28], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][28], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][28], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][28], 1);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][28], 1);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][28], 0);

    OrgBattlesTD[playerid][29] = CreatePlayerTextDraw(playerid, 22.399902, 270.199890, !"particle:bloodpool_64");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][29], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][29], 14.000000, 16.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][29], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][29], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][29], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][29], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][29], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][29], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][29], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][29], 4);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][29], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][29], 0);

    OrgBattlesTD[playerid][30] = CreatePlayerTextDraw(playerid, 30.462891, 268.411316, !"_");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][30], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][30], 20.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][30], 1);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][30], 0x000000FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][30], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][30], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][30], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][30], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][30], 0x00000000);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][30], 5);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][30], 0);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][30], 0);
    PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][30], 19474);
    PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][30], 270.000000, 0.000000, 90.000000, 1.000000);

    OrgBattlesTD[playerid][31] = CreatePlayerTextDraw(playerid, 41.211426, 275.233887, !"0");
    PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][31], 0.162300, 0.740500);
    PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][31], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][31], 2);
    PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][31], 0xC0C0C0FF);
    PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][31], 0);
    PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][31], 0x80808080);
    PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][31], 0);
    PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][31], 0);
    PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][31], 0x000000FF);
    PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][31], 1);
    PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][31], 1);
    PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][31], 0);

    if OrgBattlesState == 1 *then
    {
        OrgBattlesTD[playerid][32] = CreatePlayerTextDraw(playerid, 54.649902, 270.199890, !"particle:bloodpool_64");
        PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][32], 0.480000, 1.120000);
        PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][32], 14.000000, 16.000000);
        PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][32], 1);
        PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][32], 0x000000FF);
        PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][32], 0);
        PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][32], 0x80808080);
        PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][32], 0);
        PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][32], 0);
        PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][32], 0x000000FF);
        PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][32], 4);
        PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][32], 0);
        PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][32], 0);

        OrgBattlesTD[playerid][33] = CreatePlayerTextDraw(playerid, 62.712891, 268.411316, !"_");
        PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][33], 0.480000, 1.120000);
        PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][33], 20.000000, 21.000000);
        PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][33], 1);
        PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][33], 0x000000FF);
        PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][33], 0);
        PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][33], 0x80808080);
        PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][33], 0);
        PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][33], 0);
        PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][33], 0x00000000);
        PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][33], 5);
        PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][33], 0);
        PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][33], 0);
        PlayerTextDrawSetPreviewModel(playerid, OrgBattlesTD[playerid][33], 19474);
        PlayerTextDrawSetPreviewRot(playerid, OrgBattlesTD[playerid][33], 270.000000, 0.000000, 90.000000, 1.000000);

        OrgBattlesTD[playerid][34] = CreatePlayerTextDraw(playerid, 73.461426, 275.233887, !"0");
        PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][34], 0.162300, 0.740500);
        PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][34], 1280.000000, 1280.000000);
        PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][34], 2);
        PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][34], 0xC0C0C0FF);
        PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][34], 0);
        PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][34], 0x80808080);
        PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][34], 0);
        PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][34], 0);
        PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][34], 0x000000FF);
        PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][34], 1);
        PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][34], 1);
        PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][34], 0);
    }

    OrgBattlesTD[playerid][35] = CreatePlayerTextDraw(playerid, 28.899902, 198.488602, !"0");
	PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][35], 0.219500, 1.102200);
	PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][35], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][35], 2);
	PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][35], OrgBattlesState == 2 ? 0x7697D9FF : 0x00932799);
	PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][35], 0);
	PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][35], 0x80808080);
	PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][35], 0);
	PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][35], 255);
	PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][35], 0x000000FF);
	PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][35], 0);

	OrgBattlesTD[playerid][36] = CreatePlayerTextDraw(playerid, 61.149902, 198.488602, !"0");
	PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][36], 0.219500, 1.102200);
	PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][36], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][36], 2);
	PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][36], OrgBattlesState == 2 ? 0x96020280 : 0xD1DB1C99);
	PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][36], 0);
	PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][36], 0x80808080);
	PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][36], 0);
	PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][36], 255);
	PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][36], 0x000000FF);
	PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][36], 1);
	PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][36], 0);

	OrgBattlesTD[playerid][37] = CreatePlayerTextDraw(playerid, 28.899902, 235.510803, !"0");
	PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][37], 0.219500, 1.102200);
	PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][37], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][37], 2);
	PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][37], OrgBattlesState == 2 ? 0x99336680 : 0xCC00CC99);
	PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][37], 0);
	PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][37], 0x80808080);
	PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][37], 0);
	PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][37], 255);
	PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][37], 0x000000FF);
	PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][37], 1);
	PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][37], 0);

	OrgBattlesTD[playerid][38] = CreatePlayerTextDraw(playerid, 61.149902, 235.510803, !"0");
	PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][38], 0.219500, 1.102200);
	PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][38], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][38], 2);
	PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][38], OrgBattlesState == 2 ? 0xBA541D80 : 0x00FFE299);
	PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][38], 0);
	PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][38], 0x80808080);
	PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][38], 0);
	PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][38], 255);
	PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][38], 0x000000FF);
	PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][38], 1);
	PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][38], 1);
	PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][38], 0);

	OrgBattlesTD[playerid][39] = CreatePlayerTextDraw(playerid, 28.899902, 272.844116, !"0");
	PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][39], 0.219500, 1.102200);
	PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][39], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][39], 2);
	PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][39], OrgBattlesState == 2 ? 0xA8787880 : 0x6666FF99);
	PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][39], 0);
	PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][39], 0x80808080);
	PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][39], 0);
	PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][39], 255);
	PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][39], 0x000000FF);
	PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][39], 1);
	PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][39], 1);
	PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][39], 0);

    if OrgBattlesState == 1 *then
    {
        OrgBattlesTD[playerid][40] = CreatePlayerTextDraw(playerid, 61.149902, 272.844116, !"0");
        PlayerTextDrawLetterSize(playerid, OrgBattlesTD[playerid][40], 0.219500, 1.102200);
        PlayerTextDrawTextSize(playerid, OrgBattlesTD[playerid][40], 1280.000000, 1280.000000);
        PlayerTextDrawAlignment(playerid, OrgBattlesTD[playerid][40], 2);
        PlayerTextDrawColor(playerid, OrgBattlesTD[playerid][40], 0xA8787880);
        PlayerTextDrawUseBox(playerid, OrgBattlesTD[playerid][40], 0);
        PlayerTextDrawBoxColor(playerid, OrgBattlesTD[playerid][40], 0x80808080);
        PlayerTextDrawSetShadow(playerid, OrgBattlesTD[playerid][40], 0);
        PlayerTextDrawSetOutline(playerid, OrgBattlesTD[playerid][40], 255);
        PlayerTextDrawBackgroundColor(playerid, OrgBattlesTD[playerid][40], 0x000000FF);
        PlayerTextDrawFont(playerid, OrgBattlesTD[playerid][40], 1);
        PlayerTextDrawSetProportional(playerid, OrgBattlesTD[playerid][40], 1);
        PlayerTextDrawSetSelectable(playerid, OrgBattlesTD[playerid][40], 0);
    }