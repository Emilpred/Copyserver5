

stock TakeBonus(playerid, PlayerText:click_td)
{

	f(global_str, 128, "SELECT COUNT(*) FROM accounts WHERE `Referal` = '%s' AND `Level` >= 8;", PN(playerid));
	new Cache:result = mysql_query(mysql, global_str), count = cache_get_row_int(0, 0, mysql);
	
	cache_delete(result, mysql);

	if count < 12 *then
		return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Информация", !"{cccccc}Недостаточно приглашенных игроков (возможно еще не все дошли до 8 уровня)", !"Закрыть", !"");

	new id = 0;
	
	if click_td == BonusTD[playerid][17] *then
		id = 1;

	else if click_td == BonusTD[playerid][15] *then
		id = 2;



	return SCMF(playerid, -1 , "%d", id);
}

stock ShowBonus(playerid)
{
	if Int_GetPlayerData(playerid, "AmericanBonus") *then
		return false;

	BonusTD[playerid][25] = CreatePlayerTextDraw(playerid, 180.666107, 152.925507, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][25], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][25], 277.000000, 107.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][25], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][25], 0x1E1E1EFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][25], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][25], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][25], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][25], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][25], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][25], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][25], 0);

	BonusTD[playerid][24] = CreatePlayerTextDraw(playerid, 180.532806, 158.733002, "");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][24], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][24], 277.299103, 2.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][24], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][24], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][24], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][24], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][24], 0x00000000);
	PlayerTextDrawFont(playerid, BonusTD[playerid][24], 5);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][24], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][24], 0);
	PlayerTextDrawSetPreviewModel(playerid, BonusTD[playerid][24], 19063);
	PlayerTextDrawSetPreviewRot(playerid, BonusTD[playerid][24], 0.000000, 0.000000, 50.000000, 0.234500);

	BonusTD[playerid][23] = CreatePlayerTextDraw(playerid, 180.532806, 144.214203, "");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][23], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][23], 277.180115, 12.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][23], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][23], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][23], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][23], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][23], 0x00000000);
	PlayerTextDrawFont(playerid, BonusTD[playerid][23], 5);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][23], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][23], 0);
	PlayerTextDrawSetPreviewModel(playerid, BonusTD[playerid][23], 19063);
	PlayerTextDrawSetPreviewRot(playerid, BonusTD[playerid][23], 0.000000, 75.000000, 177.000000, 0.234500);

	BonusTD[playerid][22] = CreatePlayerTextDraw(playerid, 215.000000, 146.774002, PI[playerid][pLanguage] ? FixText("ПРИГЛАСИ ДРУГА") : "INVITE A FRIEND");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][22], 0.159099, 0.757799);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][22], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][22], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][22], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][22], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][22], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][22], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][22], 0);

	BonusTD[playerid][21] = CreatePlayerTextDraw(playerid, 187.799805, 143.725906, "::");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][21], 0.248099, 1.218199);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][21], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][21], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][21], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][21], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][21], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][21], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][21], 2);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][21], 0);

	BonusTD[playerid][20] = CreatePlayerTextDraw(playerid, 180.666306, 163.710602, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][20], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][20], 276.989807, 71.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][20], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][20], 0x141414FF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][20], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][20], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][20], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][20], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][20], 0);

	BonusTD[playerid][19] = CreatePlayerTextDraw(playerid, 204.666702, 161.636902, "particle:lamp_shad_64");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][19], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][19], 71.000000, 73.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][19], 0x000000A3);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][19], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][19], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][19], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][19], 1);

	BonusTD[playerid][18] = CreatePlayerTextDraw(playerid, 208.666504, 157.488800, "");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][18], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][18], 70.000000, 86.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][18], 0xC0C0C0FF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][18], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][18], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][18], 0x1E1E1E00);
	PlayerTextDrawFont(playerid, BonusTD[playerid][18], 5);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][18], 0);
	PlayerTextDrawSetPreviewModel(playerid, BonusTD[playerid][18], 3254);
	PlayerTextDrawSetPreviewRot(playerid, BonusTD[playerid][18], 343.000000, 0.000000, 329.000000, 0.792400);

	BonusTD[playerid][17] = CreatePlayerTextDraw(playerid, 285.000000, 161.636902, "particle:lamp_shad_64");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][17], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][17], 71.000000, 73.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][17], 0x000000A3);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][17], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][17], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][17], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][17], 1);

	BonusTD[playerid][16] = CreatePlayerTextDraw(playerid, 289.000000, 157.488800, "");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][16], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][16], 70.000000, 86.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][16], 0xC0C0C0FF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][16], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][16], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][16], 0x1E1E1E00);
	PlayerTextDrawFont(playerid, BonusTD[playerid][16], 5);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][16], 0);
	PlayerTextDrawSetPreviewModel(playerid, BonusTD[playerid][16], 3266);
	PlayerTextDrawSetPreviewRot(playerid, BonusTD[playerid][16], 343.000000, 0.000000, 329.000000, 0.792400);

	BonusTD[playerid][15] = CreatePlayerTextDraw(playerid, 366.333405, 161.636902, "particle:lamp_shad_64");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][15], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][15], 71.000000, 73.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][15], 0x000000A3);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][15], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][15], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][15], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][15], 1);

	BonusTD[playerid][14] = CreatePlayerTextDraw(playerid, 370.333405, 157.488800, "");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][14], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][14], 70.000000, 86.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][14], 0xC0C0C0FF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][14], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][14], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][14], 0x1E1E1E00);
	PlayerTextDrawFont(playerid, BonusTD[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][14], 0);
	PlayerTextDrawSetPreviewModel(playerid, BonusTD[playerid][14], 3348);
	PlayerTextDrawSetPreviewRot(playerid, BonusTD[playerid][14], 343.000000, 0.000000, 329.000000, 0.792400);

	BonusTD[playerid][13] = CreatePlayerTextDraw(playerid, 240.666504, 171.748001, "Chevrolet Corvette");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][13], 0.169499, 0.757799);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][13], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][13], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][13], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][13], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][13], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][13], 255);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][13], 0x0000000E);
	PlayerTextDrawFont(playerid, BonusTD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][13], 0);

	BonusTD[playerid][12] = CreatePlayerTextDraw(playerid, 322.333099, 171.748001, "Dodge Ram");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][12], 0.169499, 0.757799);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][12], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][12], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][12], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][12], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][12], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][12], 255);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][12], 0x0000000E);
	PlayerTextDrawFont(playerid, BonusTD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][12], 0);

	BonusTD[playerid][11] = CreatePlayerTextDraw(playerid, 403.133209, 171.748001, "Ford Mustang Shelby GT500");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][11], 0.169499, 0.757799);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][11], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][11], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][11], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][11], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][11], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][11], 255);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][11], 0x0000000E);
	PlayerTextDrawFont(playerid, BonusTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][11], 0);

	BonusTD[playerid][10] = CreatePlayerTextDraw(playerid, 218.932800, 249.592102, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][10], 199.649597, 4.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][10], 0x141414FF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][10], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][10], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][10], 0);

	BonusTD[playerid][9] = CreatePlayerTextDraw(playerid, 220.232803, 250.936401, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][9], 0.000000, 1.570000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][9], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][9], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][9], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][9], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][9], 0);
	
	f(global_str, 128, "SELECT COUNT(*) FROM accounts WHERE `Referal` = '%s' AND `Level` >= 8;", PN(playerid));
	new Cache:result = mysql_query(mysql, global_str);

	format(global_str, 15, "%d/12", cache_get_row_int(0, 0, mysql));

	cache_delete(result, mysql);

	BonusTD[playerid][8] = CreatePlayerTextDraw(playerid, 284.733307, 238.503601, global_str);
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][8], 0.148900, 0.952700);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][8], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][8], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][8], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][8], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][8], 0);

	BonusTD[playerid][7] = CreatePlayerTextDraw(playerid, 220.199905, 240.792603, PI[playerid][pLanguage] ? FixText("ПРИГЛАШЕННЫХ ДРУЗЕИ") : "INVITED FRIENDS");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][7], 0.157900, 0.662500);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][7], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][7], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][7], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][7], 0);

	BonusTD[playerid][6] = CreatePlayerTextDraw(playerid, 185.799393, 241.095703, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][6], 30.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][6], 0xA52A2A7F);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][6], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][6], 1);

	BonusTD[playerid][5] = CreatePlayerTextDraw(playerid, 200.999802, 243.211105, PI[playerid][pLanguage] ? FixText("ИНФО") : "INFO");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][5], 0.174300, 0.799300);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][5], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][5], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][5], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][5], 0);

	BonusTD[playerid][4] = CreatePlayerTextDraw(playerid, 180.666107, 261.606903, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][4], 277.000000, 33.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][4], 0x1E1E1EFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][4], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][4], 0);

	BonusTD[playerid][3] = CreatePlayerTextDraw(playerid, 319.100006, 264.837006, PI[playerid][pLanguage] ? FixText("ИНФОРМАЦИЯ") : "INFORMATION");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][3], 0.174300, 0.799300);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][3], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][3], 0xFFFFFF7F);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][3], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][3], 0);

	BonusTD[playerid][2] = CreatePlayerTextDraw(playerid, 319.100006, 274.918610, PI[playerid][pLanguage] ? FixText("Игрок сможет получить 1-ин из 3-х автомобилей~n~когда на его ник зарегистрируются 12 человек и достигнут 8-го уровня") : "The player will be able to get 1-in of 3 cars for free ~ n ~ when 12 people are registered on his nickname and reach the 8th level");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][2], 0.144600, 0.741199);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][2], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][2], 0xFFFFFF7F);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][2], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][2], 0);

	BonusTD[playerid][1] = CreatePlayerTextDraw(playerid, 422.799500, 241.095703, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][1], 30.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, BonusTD[playerid][1], 0xA52A2AFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][1], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][1], 1);

	BonusTD[playerid][0] = CreatePlayerTextDraw(playerid, 438.333191, 243.211105, PI[playerid][pLanguage] ? FixText("ЗАКРЫТЬ"): "CLOSE");
	PlayerTextDrawLetterSize(playerid, BonusTD[playerid][0], 0.174300, 0.799300);
	PlayerTextDrawTextSize(playerid, BonusTD[playerid][0], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, BonusTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, BonusTD[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, BonusTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, BonusTD[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, BonusTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, BonusTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, BonusTD[playerid][0], 0x000000FF);
	PlayerTextDrawFont(playerid, BonusTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, BonusTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, BonusTD[playerid][0], 0);

	for new i; i < 26; i ++ do
		ShowPlayerTD(playerid, BonusTD[playerid][i]);

	Int_SetPlayerData(playerid, "AmericanBonus", true);

	return SelectTextDraw(playerid, 0xA52A2AFF);
}

stock HideBonus(playerid)
{
	for new i; i < 26; i ++ do
		DestroyPlayerTD(playerid, BonusTD[playerid][i]);

	return DPlayerData(playerid, "AmericanBonus"), CancelSelectTextDraw(playerid);
}