stock CloseGetGunOrg(playerid)
{
	for new i; i < 18; i++ do {
	if i < 5 *then DestroyPlayerTD(playerid, FillUp[playerid][i]);
	TextDrawHideForPlayer(playerid, GetGunTD[i]); }
	//
	DeletePVar(playerid, "openGetGun");
	CancelSelectTextDraw(playerid);
	return false;
}
stock UpdateGetGunOrg(playerid, id = 0)
{
	// ids mas
	new r, l, Float:x, Float:y;
	
	//levo
	l = id-1;
	if l < 0 *then
		PlayerTextDrawSetPreviewModel(playerid, FillUp[playerid][4], 19300),
		SetPosTD(playerid, FillUp[playerid][4], 218.000000, 169.000000);
	else 
		GetGunPosOrg(GetGunMas[l][getModel], 4, x, y),
		SetPosTD(playerid, FillUp[playerid][4], x, y),
		PlayerTextDrawSetPreviewModel(playerid, FillUp[playerid][4], GetGunMas[l][getModel]),
		PlayerTextDrawSetPreviewRot(playerid, FillUp[playerid][4], GetGunMas[l][getRot][0], GetGunMas[l][getRot][1], GetGunMas[l][getRot][2], GetGunMas[l][getRot][3]);
	
	PlayerTextDrawShow(playerid, FillUp[playerid][4]);
	//center
	PlayerTextDrawSetPreviewModel(playerid, FillUp[playerid][3], GetGunMas[id][getModel]);
	PlayerTextDrawSetPreviewRot(playerid, FillUp[playerid][3], GetGunMas[id][getRot][0], GetGunMas[id][getRot][1], GetGunMas[id][getRot][2], GetGunMas[id][getRot][3]);
	GetGunPosOrg(GetGunMas[id][getModel], 3, x, y);
	SetPosTD(playerid, FillUp[playerid][3], x, y);
	PlayerTextDrawShow(playerid, FillUp[playerid][3]);
	//prava
	r = id+1;
	if r >= sizeof GetGunMas *then 
		PlayerTextDrawSetPreviewModel(playerid, FillUp[playerid][2], 19300),
		SetPosTD(playerid, FillUp[playerid][2], 349.000000, 179.000000);
	else	
		GetGunPosOrg(GetGunMas[r][getModel], 2, x, y),
		SetPosTD(playerid, FillUp[playerid][2], x, y),
		PlayerTextDrawSetPreviewModel(playerid, FillUp[playerid][2], GetGunMas[r][getModel]),
		PlayerTextDrawSetPreviewRot(playerid, FillUp[playerid][2], GetGunMas[r][getRot][0], GetGunMas[r][getRot][1], GetGunMas[r][getRot][2], GetGunMas[r][getRot][3]);

	PlayerTextDrawShow(playerid, FillUp[playerid][2]);
	//
	PlayerTextDrawSetString(playerid, FillUp[playerid][1], GetGunMas[id][getName]);
	return false;
}
stock GetGunPosOrg(model, tdID, &Float:position_x, &Float:position_y)
{
	for new i; i < 16; i++ do
		if PositionGetGun[i][posGunModel] == model && PositionGetGun[i][posGunTD] == tdID *then
			position_x = PositionGetGun[i][posGunPos][0], position_y = PositionGetGun[i][posGunPos][1];
}
stock TakeGetGunOrg(playerid)
{
	if !IsACop(playerid) *then return false;
	
	new team = GetTeamID(playerid), id = selectgun[playerid];
	
	if OrgInfo[team][oMats] < GetGunMas[id][getMaterials] *then
		return SCM(playerid, COLOR_RED, !"[Ошибка] {FFFFFF}На складе организации недостаточно патронов!");
	
	OrgInfo[team][oMats] -= GetGunMas[id][getMaterials];
	
	if GetGunMas[id][getID] == -1 *then UpdatePlayerArmour(playerid, 150.0);
	else _GiveGun(playerid, GetGunMas[id][getID], GetGunMas[id][getAmmo]);
	
	SCMF(playerid, COLOR_VALIK, "[Информация]{FFFFFF} Вы взяли %s.", GetGunMas[id][getNameRu]);
	
	PlayerTextDrawSetString(playerid, FillUp[playerid][0], IntToStr(OrgInfo[team][oMats]));
	return false;
}