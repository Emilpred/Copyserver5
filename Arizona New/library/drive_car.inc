const auto_drive_biz = 262;

static const auto_drive_car[] =
{
	612,
	613,
	614,
	662,
	663,
	665,
	666,
	667,
	668,
	699,
	793,
	794,
	909,
	965,
	1194,
	1195,
	1196,
	1197,
	1198,
	1199,
	1200,
	1201,
	1202,
	1203,
	1204,
	1205,
	3155,
	3156,
	3157,
	3158,
	3194,
	3195,
	3196,
	3197,
	3198,
	3199,
	3200,
	3201,
	3202,
	3203,
	3204,
	3205,
	3206,
	3207,
	3208,
	3209,
	3210,
	3211,
	3212,
	3213,
	3215,
	3216,
	3217,
	3218,
	3219,
	3232,
	3233,
	3234,
	3235,
	3236,
	3237,
	3238,
	3239,
	3240,
	3245,
	3247,
	3248,
	3251,
	3254,
	3266,
	3348,
	3974,
	4542,
	4543,
	4544,
	4545,
	4546,
	4547,
	4548
};

stock AutoDriveRent(playerid, car)
{
	PI[playerid][plveh] = J_AddStaticVehicleEx(auto_drive_car[car], -1650.1343, 1222.9695, 6.9697, 226.2663, 1, 1);
	SetPlayerVirtualWorld(playerid, playerid + 50);
	SetVehicleVirtualWorld(PI[playerid][plveh], playerid + 50);
	PutPlayerInVehicle(playerid, PI[playerid][plveh], 0);

	GiveBizMoney(auto_drive_biz, 10000);

	return HideMenuDrive(playerid);
}

stock ShowCarList(playerid, page = 1)
{
	for new i; i < 8; i ++ do
	{
		if i + (8 * (page -1)) < sizeof auto_drive_car *then
		{
			PlayerTextDrawSetString(playerid, DriveAutoTD_Name[playerid][i], GetVehicleName(auto_drive_car[i + (8 * (page -1))], true));
			PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][i], auto_drive_car[i + (8 * (page -1))]);
			PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][i], 0xA52A2A59);

			ShowPlayerTD(playerid, DriveAutoTD_Click[playerid][i]),
			ShowPlayerTD(playerid, DriveAutoTD_Veh[playerid][i]),
			ShowPlayerTD(playerid, DriveAutoTD_Name[playerid][i]);
		}
		else
			PlayerTextDrawHide(playerid, DriveAutoTD_Click[playerid][i]),
			PlayerTextDrawHide(playerid, DriveAutoTD_Veh[playerid][i]),
			PlayerTextDrawHide(playerid, DriveAutoTD_Name[playerid][i]);
	}

	auto_drive_select[playerid] = -1;
	return SetPVarInt(playerid, "AutoDrive", page);
}

stock CreatreMenuDrive(playerid)
{
	if GetPVarInt(playerid, "AutoDrive") *then
		return false;

 	DriveAutoTD[playerid][22] = CreatePlayerTextDraw(playerid, 180.666107, 105.636398, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][22], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][22], 277.000000, 269.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][22], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][22], 0x1E1E1EFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][22], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][22], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][22], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][22], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][22], 0);

	DriveAutoTD[playerid][21] = CreatePlayerTextDraw(playerid, 180.532806, 128.866302, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][21], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][21], 277.299103, 2.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][21], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][21], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][21], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][21], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][21], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][21], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][21], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD[playerid][21], 19063);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD[playerid][21], 0.000000, 0.000000, 50.000000, 0.234500);

	DriveAutoTD[playerid][20] = CreatePlayerTextDraw(playerid, 180.532806, 79.502800, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][20], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][20], 277.269104, 46.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][20], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][20], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][20], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][20], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][20], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][20], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][20], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD[playerid][20], 19063);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD[playerid][20], 0.000000, 75.000000, 177.000000, 0.234500);

	DriveAutoTD[playerid][19] = CreatePlayerTextDraw(playerid, 180.666306, 134.673401, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][19], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][19], 277.000000, 233.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][19], 0x141414FF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][19], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][19], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][19], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][19], 0);

	DriveAutoTD[playerid][18] = CreatePlayerTextDraw(playerid, 224.666504, 103.218201, SettingData[playerid][sdLanguage] ? FixText("“≈—“-ƒ–¿»¬") : "TEST DRIVE");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][18], 0.291700, 1.350900);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][18], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][18], 0xFF6E5AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][18], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][18], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][18], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][18], 0);

	DriveAutoTD[playerid][17] = CreatePlayerTextDraw(playerid, 224.233200, 88.640602, SettingData[playerid][sdLanguage] ? FixText("—œŒ–“»¬Õ€»") : "SPORT");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][17], 0.404100, 1.865300);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][17], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][17], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][17], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][17], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][17], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][17], 0);

	DriveAutoTD[playerid][16] = CreatePlayerTextDraw(playerid, 193.666702, 85.725700, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][16], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][16], 31.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][16], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][16], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][16], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][16], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][16], 0);

	DriveAutoTD[playerid][15] = CreatePlayerTextDraw(playerid, 197.800003, 91.118401, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][15], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][15], 23.000000, 18.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][15], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][15], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][15], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][15], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][15], 0);

	DriveAutoTD[playerid][14] = CreatePlayerTextDraw(playerid, 209.799805, 84.222000, "._.");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][14], 0.505200, 3.549499);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][14], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][14], 2);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][14], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][14], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][14], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][14], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][14], 0);

	DriveAutoTD[playerid][13] = CreatePlayerTextDraw(playerid, 256.000000, 354.681396, SettingData[playerid][sdLanguage] ? FixText("¬ ÒÎÛ˜‡Â ÔÓ‚ÂÊ‰ÂÌËˇ, ‚˚ ÓÔÎ‡ÚËÚÂ ÂÏÓÌÚ") : "In case of damage, you will pay for the repair");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][13], 0.184300, 0.874000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][13], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][13], 0xFFFFFF4A);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][13], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][13], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][13], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][13], 0);

	DriveAutoTD[playerid][12] = CreatePlayerTextDraw(playerid, 201.199905, 106.666702, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][12], 16.000000, 8.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][12], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][12], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][12], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][12], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][12], 0);

	DriveAutoTD[playerid][11] = CreatePlayerTextDraw(playerid, 194.600006, 99.929604, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][11], 29.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][11], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][11], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][11], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][11], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][11], 0);

	DriveAutoTD[playerid][10] = CreatePlayerTextDraw(playerid, 320.333313, 141.466507, SettingData[playerid][sdLanguage] ? FixText("ƒŒ—“”œÕ€» “–¿Õ—œŒ–“") : "ACCESSIBLE_TRANSPORT");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][10], 0.216600, 1.039800);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][10], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][10], 2);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][10], 0xA35148FF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][10], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][10], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][10], 0);

	DriveAutoTD[playerid][9] = CreatePlayerTextDraw(playerid, 283.599915, 330.051910, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][9], 35.000000, 16.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][9], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][9], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][9], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][9], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][9], 1);

	DriveAutoTD[playerid][8] = CreatePlayerTextDraw(playerid, 320.600006, 330.051910, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][8], 35.000000, 16.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][8], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][8], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][8], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][8], 1);

	DriveAutoTD[playerid][7] = CreatePlayerTextDraw(playerid, 401.600006, 330.051910, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][7], 47.000000, 16.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][7], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][7], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][7], 1);

	DriveAutoTD[playerid][6] = CreatePlayerTextDraw(playerid, 301.000000, 329.577698, "<<<");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][6], 0.287900, 1.699399);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][6], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][6], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][6], 0);

	DriveAutoTD[playerid][5] = CreatePlayerTextDraw(playerid, 338.666504, 329.577698, ">>>");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][5], 0.287900, 1.699399);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][5], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][5], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][5], 0);

	DriveAutoTD[playerid][4] = CreatePlayerTextDraw(playerid, 425.333313, 333.411102, SettingData[playerid][sdLanguage] ? FixText("œ–»Õﬂ“‹") : "ACCEPT");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][4], 0.185200, 0.878099);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][4], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][4], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][4], 0);

	DriveAutoTD[playerid][3] = CreatePlayerTextDraw(playerid, 190.533401, 324.399994, SettingData[playerid][sdLanguage] ? FixText("  ÓÔÎ‡ÚÂ:") : "To pay:");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][3], 0.216600, 1.039800);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][3], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][3], 0xA35148FF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][3], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][3], 0);

	DriveAutoTD[playerid][2] = CreatePlayerTextDraw(playerid, 189.533401, 331.037201, "10_000$");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][2], 0.235499, 1.765900);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][2], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][2], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][2], 0);

	DriveAutoTD[playerid][1] = CreatePlayerTextDraw(playerid, 435.933411, 86.140800, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][1], 13.000000, 13.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][1], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][1], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][1], 1);

	DriveAutoTD[playerid][0] = CreatePlayerTextDraw(playerid, 442.866394, 86.081299, "X");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD[playerid][0], 0.258500, 1.243100);
	PlayerTextDrawTextSize(playerid, DriveAutoTD[playerid][0], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, DriveAutoTD[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD[playerid][0], 0x000000FF);
	PlayerTextDrawFont(playerid, DriveAutoTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD[playerid][0], 0);

	DriveAutoTD_Click[playerid][0] = CreatePlayerTextDraw(playerid, 190.000000, 147.533203, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][0], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][0], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][0], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][0], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][0], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][0], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][0], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Click[playerid][1] = CreatePlayerTextDraw(playerid, 257.666595, 147.533203, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][1], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][1], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][1], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][1], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][1], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][1], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][1], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Click[playerid][2] = CreatePlayerTextDraw(playerid, 324.000000, 147.533203, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][2], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][2], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][2], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][2], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][2], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][2], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Click[playerid][3] = CreatePlayerTextDraw(playerid, 391.666901, 147.533203, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][3], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][3], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][3], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][3], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][3], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][3], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Click[playerid][4] = CreatePlayerTextDraw(playerid, 190.000000, 223.029602, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][4], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][4], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][4], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][4], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][4], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][4], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][4], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Click[playerid][5] = CreatePlayerTextDraw(playerid, 257.666595, 223.029602, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][5], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][5], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][5], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][5], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][5], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][5], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][5], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Click[playerid][6] = CreatePlayerTextDraw(playerid, 324.000000, 223.029602, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][6], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][6], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][6], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][6], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][6], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][6], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][6], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Click[playerid][7] = CreatePlayerTextDraw(playerid, 391.666901, 223.029602, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Click[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Click[playerid][7], 57.000000, 76.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Click[playerid][7], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Click[playerid][7], 0xA52A2A59);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Click[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Click[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Click[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Click[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Click[playerid][7], 0xA52A2A00);
	PlayerTextDrawFont(playerid, DriveAutoTD_Click[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Click[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Click[playerid][7], 1);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Click[playerid][7], 1316);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Click[playerid][7], 162.000000, 162.000000, 0.000000, 0.542200);

	DriveAutoTD_Veh[playerid][0] = CreatePlayerTextDraw(playerid, 176.333405, 148.777603, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][0], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][0], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][0], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][0], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][0], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][0], 1, 1);

	DriveAutoTD_Veh[playerid][1] = CreatePlayerTextDraw(playerid, 244.000000, 148.777603, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][1], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][1], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][1], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][1], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][1], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][1], 1, 1);

	DriveAutoTD_Veh[playerid][2] = CreatePlayerTextDraw(playerid, 310.333405, 148.777603, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][2], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][2], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][2], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][2], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][2], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][2], 1, 1);

	DriveAutoTD_Veh[playerid][3] = CreatePlayerTextDraw(playerid, 378.000305, 148.777603, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][3], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][3], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][3], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][3], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][3], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][3], 1, 1);

	DriveAutoTD_Veh[playerid][4] = CreatePlayerTextDraw(playerid, 176.333405, 224.274002, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][4], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][4], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][4], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][4], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][4], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][4], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][4], 1, 1);

	DriveAutoTD_Veh[playerid][5] = CreatePlayerTextDraw(playerid, 244.000000, 224.274002, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][5], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][5], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][5], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][5], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][5], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][5], 1, 1);

	DriveAutoTD_Veh[playerid][6] = CreatePlayerTextDraw(playerid, 310.333405, 224.274002, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][6], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][6], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][6], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][6], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][6], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][6], 1, 1);

	DriveAutoTD_Veh[playerid][7] = CreatePlayerTextDraw(playerid, 378.000305, 224.274002, "");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Veh[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Veh[playerid][7], 72.000000, 80.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Veh[playerid][7], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Veh[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Veh[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Veh[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Veh[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Veh[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Veh[playerid][7], 0x00000000);
	PlayerTextDrawFont(playerid, DriveAutoTD_Veh[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Veh[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Veh[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, DriveAutoTD_Veh[playerid][7], 411);
	PlayerTextDrawSetPreviewRot(playerid, DriveAutoTD_Veh[playerid][7], 344.000000, 0.000000, 35.000000, 0.808000);
	PlayerTextDrawSetPreviewVehCol(playerid, DriveAutoTD_Veh[playerid][7], 1, 1);

	DriveAutoTD_Name[playerid][0] = CreatePlayerTextDraw(playerid, 190.333374, 161.807343, "Mercedes GT63s AMG");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][0], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][0], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][0], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][0], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][0], 0);

	DriveAutoTD_Name[playerid][1] = CreatePlayerTextDraw(playerid, 257.999969, 161.807343, "Mercedes G63 AMG");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][1], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][1], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][1], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][1], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][1], 0);

	DriveAutoTD_Name[playerid][2] = CreatePlayerTextDraw(playerid, 324.333374, 161.807343, "Audi RS6");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][2], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][2], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][2], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][2], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][2], 0);

	DriveAutoTD_Name[playerid][3] = CreatePlayerTextDraw(playerid, 392.000275, 161.807343, "BMW X5");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][3], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][3], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][3], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][3], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][3], 0);
	
	DriveAutoTD_Name[playerid][4] = CreatePlayerTextDraw(playerid, 190.333374, 237.303741, "Chevrolet Corvette");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][4], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][4], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][4], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][4], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][4], 0);

	DriveAutoTD_Name[playerid][5] = CreatePlayerTextDraw(playerid, 257.999969, 237.303741, "Chevrolet Cruze");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][5], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][5], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][5], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][5], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][5], 0);


	DriveAutoTD_Name[playerid][6] = CreatePlayerTextDraw(playerid, 324.333374, 237.303741, "Lexus LX");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][6], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][6], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][6], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][6], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][6], 0);

	DriveAutoTD_Name[playerid][7] = CreatePlayerTextDraw(playerid, 392.000275, 237.303741, "Porsche 911");
	PlayerTextDrawLetterSize(playerid, DriveAutoTD_Name[playerid][7], 0.149831, 0.757833);
	PlayerTextDrawTextSize(playerid, DriveAutoTD_Name[playerid][7], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, DriveAutoTD_Name[playerid][7], 1);
	PlayerTextDrawColor(playerid, DriveAutoTD_Name[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, DriveAutoTD_Name[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, DriveAutoTD_Name[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, DriveAutoTD_Name[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, DriveAutoTD_Name[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, DriveAutoTD_Name[playerid][7], 0xA52A2AFF);
	PlayerTextDrawFont(playerid, DriveAutoTD_Name[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, DriveAutoTD_Name[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, DriveAutoTD_Name[playerid][7], 0);
	

	for new i; i < 23; i++ do ShowPlayerTD(playerid, DriveAutoTD[playerid][i]);
	
	ShowCarList(playerid);

	return SelectTextDraw(playerid, -1);
}

stock HideMenuDrive(playerid)
{
	for new i; i < 23; i++ do
	{
		if i < 8 *then
			DestroyPlayerTD(playerid, DriveAutoTD_Click[playerid][i]),
			DestroyPlayerTD(playerid, DriveAutoTD_Veh[playerid][i]),
			DestroyPlayerTD(playerid, DriveAutoTD_Name[playerid][i]);

		DestroyPlayerTD(playerid, DriveAutoTD[playerid][i]);
	}

	CancelSelectTextDraw(playerid);
	
	return DeletePVar(playerid, "AutoDrive");
}