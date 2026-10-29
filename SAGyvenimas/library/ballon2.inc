stock CreateSharik(playerid, objectid)
{
    if(GetPlayerState(playerid) != 1 || GetPlayerInterior(playerid) > 0) return 0;
    SharInfo[playerid][sharVehicle] = INVALID_VEHICLE_ID;
	new Float:X, Float:Y, Float:Z, Float:A;
	GetPlayerPos(playerid, X, Y, Z); Y += 2.5;
	GetPlayerFacingAngle(playerid, A);
	f(global_str, 100,"Noredami surinkti Oro Baliona\n\tPaspauskite H\n\n{FFFFFF}[Savininkas %s]",PN(playerid));
	SharInfo[playerid][sharText] = Create3DTextLabel(global_str, 0x73B461FF, X,Y,Z-1.0, 4.0, 0,0);
	
	SharInfo[playerid][sharObject][0] = CreateDynamicObject(objectid, X, Y, Z-1.0, 0.000000, 0.000000, 145.481644, -1, -1, -1, STREAMER_OBJECT_SD, 100.0); // 4
	SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 3, 19480, "signsurf", "sign", 0);
    SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 2, 19480, "signsurf", "sign", 0);
    SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 1, 19480, "signsurf", "sign", 0);
    SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 0, 18754, "basesections", "metalflooring4", 0);
	DeletePVar(playerid, "state_object_shar");

	SharInfo[playerid][sharPos][0] = X;
	SharInfo[playerid][sharPos][1] = Y;
	SharInfo[playerid][sharPos][2] = Z;
	RemovePlayerAttachedObject(playerid, 4);
	Streamer_Update(playerid);
	return true;
}
stock SharMenuShow(playerid)
{
	SharTD_TD[playerid][9] = CreatePlayerTextDraw(playerid, 396.299988, 177.500000, "usebox");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][9], 0.000000, 8.543000);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][9], 243.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][9], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][9], 0xE1E1E1FF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][9], 0x111111FF);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][9], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][9], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][9], 0);

	SharTD_TD[playerid][8] = CreatePlayerTextDraw(playerid, 250.000000, 197.000000, "LD_BEAT:CHIT");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][8], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][8], 17.500000, 23.333334);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][8], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][8], 0x602B2BFF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][8], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][8], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][8], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][8], 0);

	SharTD_TD[playerid][7] = CreatePlayerTextDraw(playerid, 257.591064, 201.120682, "LD_SPAC:WHITE");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][7], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][7], 124.817879, 15.091980);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][7], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][7], 0x602B2BFF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][7], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][7], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][7], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][7], 0);

	SharTD_TD[playerid][6] = CreatePlayerTextDraw(playerid, 373.658936, 197.000000, "LD_BEAT:CHIT");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][6], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][6], 17.500000, 23.333334);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][6], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][6], 0x602B2BFF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][6], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][6], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][6], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][6], 0);

	SharTD_TD[playerid][5] = CreatePlayerTextDraw(playerid, 396.299988, 226.833328, "usebox");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][5], 0.000000, 2.326162);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][5], 243.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][5], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][5], 0xE1E1E1FF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][5], InventColor[PI[playerid][pInvColors]][1]);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][5], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][5], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][5], 0);

	SharTD_TD[playerid][4] = CreatePlayerTextDraw(playerid, 320.000000, 230.117737, "");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][4], 0.326087, 1.434783);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][4], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][4], 2);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][4], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][4], 0x00000000);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][4], 0);

	SharTD_TD[playerid][3] = CreatePlayerTextDraw(playerid, 260.091064, 181.000000, "your progress");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][3], 0.125000, 0.746667);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][3], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][3], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][3], 0x999999FF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][3], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][3], 0x00000000);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][3], 0);

	SharTD_TD[playerid][2] = CreatePlayerTextDraw(playerid, 257.591064, 188.466660, "");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][2], 0.156250, 0.933333);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][2], 1280.000000, 1280.000000);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][2], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][2], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][2], 0x00000000);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][2], 0);

    SharTD_TD[playerid][10] = CreatePlayerTextDraw(playerid, 250.000000, 197.000000, "LD_BEAT:CHIT");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][10], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][10], 17.500000, 23.333334);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][10], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][10], InventColor[PI[playerid][pInvColors]][1]);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][10], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][10], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][10], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][10], 0);

	SharTD_TD[playerid][1] = CreatePlayerTextDraw(playerid, 250.000000, 197.000000, "LD_BEAT:CHIT");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][1], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][1], 17.500000, 23.333334);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][1], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][1], InventColor[PI[playerid][pInvColors]][1]);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][1], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][1], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][1], 0);

	SharTD_TD[playerid][0] = CreatePlayerTextDraw(playerid, 257.591064, 201.120682, "LD_SPAC:WHITE");
	PlayerTextDrawLetterSize(playerid, SharTD_TD[playerid][0], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][0], 7.489073, 15.091980);
	PlayerTextDrawAlignment(playerid, SharTD_TD[playerid][0], 1);
	PlayerTextDrawColor(playerid, SharTD_TD[playerid][0], InventColor[PI[playerid][pInvColors]][1]);
	PlayerTextDrawUseBox(playerid, SharTD_TD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, SharTD_TD[playerid][0], 0x80808080);
	PlayerTextDrawSetShadow(playerid, SharTD_TD[playerid][0], 2);
	PlayerTextDrawSetOutline(playerid, SharTD_TD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, SharTD_TD[playerid][0], 0x000000FF);
	PlayerTextDrawFont(playerid, SharTD_TD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, SharTD_TD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, SharTD_TD[playerid][0], 0);
	//

	TogglePlayerControllable(playerid, false);
	for new i; i < 11; i++ do ShowPlayerTD(playerid, SharTD_TD[playerid][i]);
	return UpdateSharMenu(playerid);
}
stock SharMenuHide(playerid)
{
    TogglePlayerControllable(playerid, true);
	for new i; i < 11; i++ do DestroyPlayerTD(playerid, SharTD_TD[playerid][i]);
	return true;
}
stock SharKey(playerid, value)
{
    SharInfo[playerid][sharProgress] += (value == SharInfo[playerid][sharKey]) ? 15:-5;
	f(global_str, 70, "~n~~n~~n~~n~~n~~n~~n~~n~%s", (value == SharInfo[playerid][sharKey]) ? "~g~SUCESSFULLY":"~r~FAILED");
	GameTextForPlayer(playerid, global_str, 1000, 3);
	SharInfo[playerid][sharKey] = 1+random(3);
    if SharInfo[playerid][sharProgress] <= 0 || (19332 > ItemsInfo[AksSlot[playerid][0][4]][ItemModel] > 19338) *then { SharMenuHide(playerid); return ResetShar(playerid); }
    UpdateSharMenu(playerid);
	//
	new objectid = ItemsInfo[AksSlot[playerid][0][4]][ItemModel];
	//
	if SharInfo[playerid][sharProgress] > 95 *then
	{
		SharInfo[playerid][sharKey] = 0;
		SharMenuHide(playerid);

		new Float:X = SharInfo[playerid][sharPos][0],Float:Y = SharInfo[playerid][sharPos][1],Float:Z = SharInfo[playerid][sharPos][2];
		Delete3DTextLabel(SharInfo[playerid][sharText]);
		SharInfo[playerid][sharText] = Create3DTextLabel("{F79E45}[ Oro Balionas ]\n\n{F5CC02}Noredami valdyti oro baliona 'F'\nNoredami uzimti keleivio vieta, paspauskite `G`\n{FF6347}Valdyti gali tik savininkas{ffffff}",
		-1, X,Y,Z-1.0, 4.0, 0,0);
		SharInfo[playerid][sharVehicle] = J_AddStaticVehicleEx(487, X, Y, Z, 0.0, 1,1);
		LinkVehicleToInterior(SharInfo[playerid][sharVehicle], -100);
		PutPlayerInVehicle(playerid, SharInfo[playerid][sharVehicle], 0);

		Attach3DTextLabelToVehicle(SharInfo[playerid][sharText], SharInfo[playerid][sharVehicle], 0.0, 0.0, 2.0 );
		DestroyDynamicObjectModel(-1, SharInfo[playerid][sharObject][0], objectid);
        //
		SharInfo[playerid][sharObject][0] = CreateDynamicObject(objectid, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, -1, -1, -1, STREAMER_OBJECT_SD, 100.0); // 4
        SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 2, 8618, "ceasersign", "ceaserspillar01_128", 0);
		AttachDynamicObjectToVehicle(SharInfo[playerid][sharObject][0], SharInfo[playerid][sharVehicle], 0.000000, 0.779000, -1.000000, 0.000000, 0.000000, 0.000000);
		//
		SharInfo[playerid][sharObject][1] = CreateDynamicObject(2923, 0.000000, 0.000000, 0.137820, 0.000000, 0.000000, 0.000000, 0, 0, -1, STREAMER_OBJECT_SD, 300.0);
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][1], 0, 15046, "svcunthoose", "mplid02", 0xFFFFFFFF);
		AttachDynamicObjectToVehicle(SharInfo[playerid][sharObject][1], SharInfo[playerid][sharVehicle], 0.000000, 0.779000, -0.862180, 0.000000, 0.000000, 0.000000);
		//
		SharInfo[playerid][sharObject][2] = CreateDynamicObject(19131, -0.021178, 0.621863, 1.562280, 0.000000, 0.000000, 90.000000, 0, 0, -1, STREAMER_OBJECT_SD, 300.0); // 2
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][2], 1, 1560, "7_11_door", "CJ_CHROME2", 0);
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][2], 0, 1414, "break_street1", "CJ_TV_SCREEN", 0);
		AttachDynamicObjectToVehicle(SharInfo[playerid][sharObject][2], SharInfo[playerid][sharVehicle], -0.021178, 1.400863, 0.562280, 0.000000, 0.000000, 90.000000);

		SharInfo[playerid][sharObject][3] = CreateDynamicObject(19131, -0.581178, -0.008135, 1.562280, 0.000000, 0.000000, 0.000000, 0, 0, -1, STREAMER_OBJECT_SD, 300.0); // 2
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][3], 1, 1560, "7_11_door", "CJ_CHROME2", 0);
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][3], 0, 1414, "break_street1", "CJ_TV_SCREEN", 0);
		AttachDynamicObjectToVehicle(SharInfo[playerid][sharObject][3], SharInfo[playerid][sharVehicle], -0.581178, 0.770865, 0.562280, 0.000000, 0.000000, 0.000000);

		SharInfo[playerid][sharObject][4] = CreateDynamicObject(19131, -0.021178, -0.598135, 1.562280, 0.000000, 0.000000, 90.000000, 0, 0, -1, STREAMER_OBJECT_SD, 300.0); // 2
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][4], 1, 1560, "7_11_door", "CJ_CHROME2", 0);
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][4], 0, 1414, "break_street1", "CJ_TV_SCREEN", 0);
		AttachDynamicObjectToVehicle(SharInfo[playerid][sharObject][4], SharInfo[playerid][sharVehicle], -0.021178, 0.180865, 0.562280, 0.000000, 0.000000, 90.000000);

		SharInfo[playerid][sharObject][5] = CreateDynamicObject(19131, 0.588821, -0.008135, 1.562280, 0.000000, 0.000000, 0.000000, 0, 0, -1, STREAMER_OBJECT_SD, 300.0); // 2
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][5], 1, 1560, "7_11_door", "CJ_CHROME2", 0);
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][5], 0, 1414, "break_street1", "CJ_TV_SCREEN", 0);
		AttachDynamicObjectToVehicle(SharInfo[playerid][sharObject][5], SharInfo[playerid][sharVehicle], 0.588821, 0.770865, 0.562280, 0.000000, 0.000000, 0.000000);
		//
		SetEngineStatus(SharInfo[playerid][sharVehicle], true, playerid);
		DeletePVar(playerid, "state_object_shar");
	}
	return ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 2, 0, 0, 0, 0, 0);
}
stock ResetShar(playerid)
{
	SharInfo[playerid][sharStatus] = false;
	SharInfo[playerid][sharPos][0] =
	SharInfo[playerid][sharPos][1] =
	SharInfo[playerid][sharPos][2] = 0.0;
	SharInfo[playerid][sharProgress] =
	SharInfo[playerid][sharKey] = 0;
	Delete3DTextLabel(SharInfo[playerid][sharText]);
	DestroyDynamicObject(SharInfo[playerid][sharObject][0]);
	DestroyDynamicObjectModel(SharInfo[playerid][sharVehicle], SharInfo[playerid][sharObject][1], 2923);
	DestroyDynamicObjectModel(SharInfo[playerid][sharVehicle], SharInfo[playerid][sharObject][2], 19131);
	DestroyDynamicObjectModel(SharInfo[playerid][sharVehicle], SharInfo[playerid][sharObject][3], 19131);
	DestroyDynamicObjectModel(SharInfo[playerid][sharVehicle], SharInfo[playerid][sharObject][4], 19131);
	DestroyDynamicObjectModel(SharInfo[playerid][sharVehicle], SharInfo[playerid][sharObject][5], 19131);
	if IsValidVehicle(SharInfo[playerid][sharVehicle]) *then DestroyVehicleEx(SharInfo[playerid][sharVehicle]);
	SharInfo[playerid][sharVehicle] = INVALID_VEHICLE_ID;
	if(19339 > ItemsInfo[AksSlot[playerid][0][4]][ItemModel] > 19331) SetPlayerAccessory(playerid, AksSlot[playerid][0][4], 4);
	return true;
}
stock UpdateSharMenu(playerid)
{
    new progress = SharInfo[playerid][sharProgress], Float:x, Float:y, Float:z, constructor_state = GetPVarInt(playerid, "state_object_shar"), objectid = ItemsInfo[AksSlot[playerid][0][4]][ItemModel]; global_str = "";
	switch SharInfo[playerid][sharKey] do
	    { case 1: global_str = "LALT"; case 2: global_str = "H"; case 3: global_str = "SPACE"; }
    
    f(global_str, 125, "~w~PRESSED [ ~b~%s~w~ ]", global_str);
    PlayerTextDrawSetString(playerid, SharTD_TD[playerid][4], global_str);
    f(global_str, 50, "%d%% to compile", progress);
    PlayerTextDrawSetString(playerid, SharTD_TD[playerid][2], global_str);
    // size
	if IsValidPlayerTextDraw(playerid, SharTD_TD[playerid][10]) *then
		SetPosTD(playerid, SharTD_TD[playerid][10], 250.000000+(float(progress)*1.25), 197.000000),
		ShowPlayerTD(playerid, SharTD_TD[playerid][10]);
    
	PlayerTextDrawTextSize(playerid, SharTD_TD[playerid][0], 1.489073+(float(progress)*1.25), 15.091980);
    ShowPlayerTD(playerid, SharTD_TD[playerid][0]);
    //
	GetObjectPos(SharInfo[playerid][sharObject][0], x,y,z);

	if SharInfo[playerid][sharProgress] >= 30 && SharInfo[playerid][sharProgress] < 50 && !(constructor_state == 1) *then {
		DestroyDynamicObjectModel(-1, SharInfo[playerid][sharObject][0], objectid);
		SharInfo[playerid][sharObject][0] = CreateDynamicObject(objectid, x,y,z, 0.000000, 0.000000, 145.481644, -1, -1, -1, STREAMER_OBJECT_SD, 100.0); // 4
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 3, 19480, "signsurf", "sign", 0);
  		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 2, 19480, "signsurf", "sign", 0);
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 1, 19480, "signsurf", "sign", 0);
		SetPVarInt(playerid, "state_object_shar", 1);
	}
	else if SharInfo[playerid][sharProgress] >= 50 && SharInfo[playerid][sharProgress] < 75 && !(constructor_state == 2) *then {
		DestroyDynamicObjectModel(-1, SharInfo[playerid][sharObject][0], objectid);
		SharInfo[playerid][sharObject][0] = CreateDynamicObject(objectid, x,y,z, 0.000000, 0.000000, 145.481644, -1, -1, -1, STREAMER_OBJECT_SD, 100.0); // 4
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 3, 19480, "signsurf", "sign", 0);
  		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 2, 19480, "signsurf", "sign", 0);
		SetPVarInt(playerid, "state_object_shar", 2);
    }
	else if SharInfo[playerid][sharProgress] >= 75 && !(constructor_state == 3) *then {
		DestroyDynamicObjectModel(-1, SharInfo[playerid][sharObject][0], objectid);
		SharInfo[playerid][sharObject][0] = CreateDynamicObject(objectid, x,y,z, 0.000000, 0.000000, 145.481644, -1, -1, -1, STREAMER_OBJECT_SD, 100.0); // 4
		SetPVarInt(playerid, "state_object_shar", 3);
	}
	else if constructor_state && SharInfo[playerid][sharProgress] < 30 *then
	{
		DestroyDynamicObjectModel(-1, SharInfo[playerid][sharObject][0], objectid);
		SharInfo[playerid][sharObject][0] = CreateDynamicObject(objectid, x,y,z, 0.000000, 0.000000, 145.481644, -1, -1, -1, STREAMER_OBJECT_SD, 100.0); // 4
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 3, 19480, "signsurf", "sign", 0);
  		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 2, 19480, "signsurf", "sign", 0);
		SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 1, 19480, "signsurf", "sign", 0);
  	 	SetDynamicObjectMaterial(SharInfo[playerid][sharObject][0], 0, 18754, "basesections", "metalflooring4", 0);
		DeletePVar(playerid, "state_object_shar");
	}

	if !(GetPVarInt(playerid, "state_object_shar") == constructor_state) *then Streamer_Update(playerid);
	//
    return false;
}