
	InfoText[playerid] = CreatePlayerTextDraw(playerid, 400,300,"_");
	PlayerTextDrawBackgroundColor(playerid, InfoText[playerid],0x000000FF);
	PlayerTextDrawFont(playerid, InfoText[playerid],2);
	PlayerTextDrawLetterSize(playerid, InfoText[playerid],0.42,1.1);
	PlayerTextDrawColor(playerid, InfoText[playerid],COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, InfoText[playerid],1);
	PlayerTextDrawSetProportional(playerid, InfoText[playerid],1);
	PlayerTextDrawSetShadow(playerid, InfoText[playerid],1);
	PlayerTextDrawShow(playerid,InfoText[playerid]);