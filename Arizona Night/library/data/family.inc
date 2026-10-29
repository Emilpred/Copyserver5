enum data_player_family
{
	F_FAMILY_ID,
	F_FAMILY_MUTE,
	F_FAMILY_RANG,
	F_FAMILY_CHAT,
	F_FAMILY_PERCENT_DEPOSIT,
	F_FAMILY_SPAWN_DATA,
	F_FAMILY_SPAWN_TYPE,
	F_FAMILY_PICK_KV,
  F_FAMILT_IDCAR_BUS[6],
  F_FAMILY_IDCAR_CARS[20],
  F_FAMILY_RANK_CARS[20],
  F_FAMILY_PLAYER_CARS[20],
  Text3D:F_FAMILY_3DTEXT_CARS[20]
};

new FP_Data[MAX_PLAYERS][data_player_family];

enum fkv_data_int_enum
{
	kvInterior,
	Float:kvInt_X,
	Float:kvInt_Y,
	Float:kvInt_Z,
	Float:kvInt_A,
	
	kvE_Interior,
	kvE_World,
	Float:kvE_Int_X,
	Float:kvE_Int_Y,
	Float:kvE_Int_Z,
  Float:kvAutoparkPos[3]
};

new FKV_Data_Int[3][fkv_data_int_enum] = 
{//2504.7102, 2242.5874, 10.820 | 
/*
Create3DTextLabel("[ {ffffff}Семейный автопарк {D45B5B}]", 0xFFFFFFFFD45B5BFF, -2017.0059, 445.0810, 35.1723, 10.0000, 0, 0); // sf
CreatePickup(15591, 1, -2017.0059, 445.0810, 35.1723, -1);

Create3DTextLabel("[ {ffffff}Семейный автопарк {D45B5B}]", 0xFFFFFFFFD45B5BFF, 1794.3065, 413.8255, 20.2294, 10.0000, 0, 0);
CreatePickup(15591, 1, 1794.3065, 413.8255, 20.2294, -1); // ls


*/
	{205, -1513.1442, 2722.3933, 1500.9674, 269.2998, 206, 15, 2786.0383, 735.7945, 1500.1187, {1794.3065, 413.8255, 20.2294}}, // ls
	{209, -1207.6504, 2382.3752, 1500.9667, 90.1508, 208, 10, -1205.1815,2382.4709,1500.9667, {-2017.0059, 445.0810, 35.1723}}, // cf
	{210, 1444.0739, -1065.3568, 1601.9919, 353.0435, 207, 10, 1488.0049, 1524.5972, 1601.0859, {2504.7102, 2242.5874, 10.820}} // lv
};

new FKV_Data_Int_Exit[2];

enum fkv_data_enum
{
	kvSqlId,
	kvFamilyId,
	kvStatus,
	kvDataId,
	kvPickup,
	Text3D:kvTextLabel,
	kvLevel[12],
	kvHealths,
	kvArmours,
	kvNalog,
	kvMoney,
	kvMonets
};

new FKV_Data[79][fkv_data_enum];

new Text3D:FamilyText[MAX_PLAYERS];

new
	const FamilyLevelName[12][23] =
	{
		"Дополнительный респект",
		"Успех в работе",
		"Бизнессмены в долгу",
		"Неунаваемый",
		"Медики в долгку",
		"Белый список",
		"Банковские махинации",
		"Мародеры",
		"Рыбный цех",
		"Третий заместитель",
		"Быстрые налоги",
		"Вместительные фургоны"
	};
	
new 
	const FamilyLevel[12] =
	{
		1000, 1200, 900, 800, 1100, 2000, 4000, 7000, 6000, 7500, 12500, 16000
	};
	
new 
	const FamilyColor[31][][] =
	{
		{"FF5E5E", 0xFF5E5EFF},
		{"FFFFFF", 0xFFFFFFFF},
		{"E65075", 0xE65075FF},
		{"EFA4B7", 0xEFA4B7FF},
		{"905B69", 0x905B69FF},
		{"D052CE", 0xD052CEFF},
		{"FF00FC", 0xFF00FCFF},
		{"5D395D", 0x5D395DFF},
		{"8E38EA", 0x8E38EAFF},
		{"6B21BB", 0x6B21BBFF},
		{"2F00FF", 0x2F00FFFF},
		{"7456F8", 0x7456F8FF},
		{"5287F1", 0x5287F1FF},
		{"1DBAF2", 0x1DBAF2FF},
		{"308EB0", 0x308EB0FF},
		{"30B061", 0x30B061FF},
		{"20F271", 0x20F271FF},
		{"107135", 0x107135FF},
		{"47EB2A", 0x47EB2AFF},
		{"9EE991", 0x9EE991FF},
		{"C2D95E", 0xC2D95EFF},
		{"D1FF00", 0xD1FF00FF},
		{"7B9022", 0x7B9022FF},
		{"FFC900", 0xFFC900FF},
		{"E8CA60", 0xE8CA60FF},
		{"6B5B1F", 0x6B5B1FFF},
		{"FF8400", 0xFF8400FF},
		{"C04312", 0xC04312FF},
		{"5C4C45", 0x5C4C45FF},
		{"373534", 0x373534FF},
		{"351204", 0x351204FF}
	};
	
new	
	const FamilyType_EN[7][12] = { 
		"Family", 
		"Corporation", 
		"Crew",
		"Squad", 
		"Brotherhood", 
		"Dynasty", 
		"Empire"
	};

new	
	const FamilyType_RU[7][12] = { 
		"Семья", 
		"Корпорация", 
		"Команда", 
		"Отряд", 
		"Братство", 
		"Dynasty", 
		"Empire" 
	};
	
enum family_shop_enum
{
	F_S_Cost,
	F_S_ItemId
};

new
	const FamilyShop[23][family_shop_enum] =
	{
		{500,0},
		{300,0},
		{300,0},
		{1800,0},
		{1900,0},
		{2100,0},
		{2300,0},
		{2400,0},
		{2500,0},
		{2600,0},
		{2800,0},
		{2900,0},
		{3000,0},
		{3200,0},
		{3400,0},
		{3500,0},
		{2500,0},
		{2800,0},
		{3400,0},
		{3600,0},
		{4200,0},
		{4600,0},
		{5000,1159}
	};

stock showFamilyCaptureTD(playerid)
{    
	if familyCaptureTDOpen{playerid} *then
		return false;
		
    familyCaptureTD[playerid][16] = CreatePlayerTextDraw(playerid, 182.999802, 58.762699, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][16], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][16], 272.609497, 313.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][16], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][16], 0x1E1E1EFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][16], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][16], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][16], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][16], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][16], 4);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][16], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][16], 0);

    familyCaptureTD[playerid][15] = CreatePlayerTextDraw(playerid, 183.233200, 64.829300, "");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][15], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][15], 272.459412, 3.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][15], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][15], 0xA52A2AFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][15], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][15], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][15], 0x00000000);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][15], 5);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][15], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][15], 0);
    PlayerTextDrawSetPreviewModel(playerid, familyCaptureTD[playerid][15], 19063);
    PlayerTextDrawSetPreviewRot(playerid, familyCaptureTD[playerid][15], 0.000000, 0.000000, 50.000000, 0.234500);

    familyCaptureTD[playerid][14] = CreatePlayerTextDraw(playerid, 183.133102, 49.636501, "");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][14], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][14], 272.370300, 12.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][14], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][14], 0xA52A2AFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][14], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][14], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][14], 0x00000000);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][14], 5);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][14], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][14], 0);
    PlayerTextDrawSetPreviewModel(playerid, familyCaptureTD[playerid][14], 19063);
    PlayerTextDrawSetPreviewRot(playerid, familyCaptureTD[playerid][14], 0.000000, 75.000000, 177.000000, 0.234500);

    familyCaptureTD[playerid][13] = CreatePlayerTextDraw(playerid, 187.033203, 71.836700, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][13], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][13], 264.000000, 258.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][13], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][13], 0x141414FF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][13], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][13], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][13], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][13], 4);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][13], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][13], 0);

    familyCaptureTD[playerid][12] = CreatePlayerTextDraw(playerid, 188.666504, 73.695999, "samaps:gtasamapbit2");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][12], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][12], 261.000000, 291.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][12], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][12], 0xCAC3CCFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][12], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][12], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][12], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][12], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][12], 0);

    familyCaptureTD[playerid][11] = CreatePlayerTextDraw(playerid, 183.333206, 318.436707, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][11], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][11], 270.000000, 48.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][11], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][11], 0x1E1E1EFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][11], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][11], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][11], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][11], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][11], 0);

    familyCaptureTD[playerid][10] = CreatePlayerTextDraw(playerid, 187.033203, 318.051514, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][10], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][10], 264.000000, 1.469900);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][10], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][10], 0x141414FF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][10], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][10], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][10], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][10], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][10], 0);

    familyCaptureTD[playerid][9] = CreatePlayerTextDraw(playerid, 296.633698, 330.459412, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][9], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][9], 46.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][9], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][9], 0x915C4AFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][9], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][9], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][9], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][9], 4);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][9], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][9], 1);

    familyCaptureTD[playerid][8] = CreatePlayerTextDraw(playerid, 317.199585, 348.407501, "U");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][8], 0.397700, -1.656200);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][8], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][8], 2);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][8], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][8], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][8], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][8], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][8], 0);

    familyCaptureTD[playerid][7] = CreatePlayerTextDraw(playerid, 317.932800, 344.259308, "EXIT");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][7], 0.170800, 0.770200);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][7], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][7], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][7], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][7], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][7], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][7], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][7], 0);

    familyCaptureTD[playerid][6] = CreatePlayerTextDraw(playerid, 310.900208, 342.422211, "");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][6], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][6], 7.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][6], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][6], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][6], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][6], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][6], 0x00000000);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][6], 5);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][6], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][6], 0);
    PlayerTextDrawSetPreviewModel(playerid, familyCaptureTD[playerid][6], 19177);
    PlayerTextDrawSetPreviewRot(playerid, familyCaptureTD[playerid][6], 167.000000, 0.000000, 0.000000, 0.182400);

    familyCaptureTD[playerid][5] = CreatePlayerTextDraw(playerid, 316.233307, 52.281399, SettingData[playerid][sdLanguage] ? FixText("ВОЙНА ЗА ТЕРРИТОРИИ") : "WAR FOR TERRITORY");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][5], 0.169599, 0.803499);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][5], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][5], 2);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][5], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][5], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][5], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][5], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][5], 0);

    familyCaptureTD[playerid][4] = CreatePlayerTextDraw(playerid, 441.566589, 70.948097, "::");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][4], 0.493299, 2.139199);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][4], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][4], 2);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][4], 0xA52A2AFF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][4], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][4], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][4], 255);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][4], 0x141414FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][4], 2);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][4], 0);

    familyCaptureTD[playerid][3] = CreatePlayerTextDraw(playerid, 194.433395, 221.111099, "-~n~-~n~-~n~-~n~-~n~-~n~-~n~-~n~-~n~-~n~");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][3], 0.464899, 1.044100);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][3], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][3], 2);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][3], 0x141414FF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][3], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][3], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][3], 0x141414FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][3], 2);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][3], 0);

    familyCaptureTD[playerid][2] = CreatePlayerTextDraw(playerid, 193.333298, 226.762894, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][2], 1.000000, 85.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][2], 0x141414FF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][2], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][2], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][2], 0x000000FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][2], 0);

    familyCaptureTD[playerid][1] = CreatePlayerTextDraw(playerid, 204.733505, 304.074097, "500");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][1], 0.146599, 1.006800);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][1], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][1], 2);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][1], 0x141414FF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][1], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][1], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][1], 0x141414FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][1], 2);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][1], 0);

    familyCaptureTD[playerid][0] = CreatePlayerTextDraw(playerid, 213.133499, 307.807404, "KM");
    PlayerTextDrawLetterSize(playerid, familyCaptureTD[playerid][0], 0.117600, 0.496499);
    PlayerTextDrawTextSize(playerid, familyCaptureTD[playerid][0], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, familyCaptureTD[playerid][0], 2);
    PlayerTextDrawColor(playerid, familyCaptureTD[playerid][0], 0x141414FF);
    PlayerTextDrawUseBox(playerid, familyCaptureTD[playerid][0], 0);
    PlayerTextDrawBoxColor(playerid, familyCaptureTD[playerid][0], 0x80808080);
    PlayerTextDrawSetShadow(playerid, familyCaptureTD[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, familyCaptureTD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, familyCaptureTD[playerid][0], 0x141414FF);
    PlayerTextDrawFont(playerid, familyCaptureTD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, familyCaptureTD[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, familyCaptureTD[playerid][0], 0);

    for new i = 0, td; i < 17; i++ do
	{	
		if i < 13 *then 
		{
			for new s; s < 12; s++ do
			{
				td = s + i * 12;

				familyZoneTD[playerid][td] = CreatePlayerTextDraw(playerid, 296.466614 + (10.823181 * s), 111.762848 + (13.09716 * i), "_");
				PlayerTextDrawLetterSize(playerid, familyZoneTD[playerid][td], 0.140000, 1.086518);
				PlayerTextDrawTextSize(playerid, familyZoneTD[playerid][td], 304.609772 + (10.823181 * s), 10.500000);
				PlayerTextDrawAlignment(playerid, familyZoneTD[playerid][td], 1);
				PlayerTextDrawColor(playerid, familyZoneTD[playerid][td], 0xFFFFFFFF);
				PlayerTextDrawUseBox(playerid, familyZoneTD[playerid][td], 1);
				PlayerTextDrawBoxColor(playerid, familyZoneTD[playerid][td], GangZoneInfo[td + 131][familyOwnerId] == -1 ? 0xFFFFFF80 : TeamColors[GetFamilyDataInt(GangZoneInfo[td + 131][familyOwnerId], "color")][1]);
				PlayerTextDrawSetShadow(playerid, familyZoneTD[playerid][td], 0);
				PlayerTextDrawSetOutline(playerid, familyZoneTD[playerid][td], 0);
				PlayerTextDrawBackgroundColor(playerid, familyZoneTD[playerid][td], 0x000000FF);
				PlayerTextDrawFont(playerid, familyZoneTD[playerid][td], 1);
				PlayerTextDrawSetProportional(playerid, familyZoneTD[playerid][td], 1);
				PlayerTextDrawSetSelectable(playerid, familyZoneTD[playerid][td], true);
				ShowPlayerTD(playerid, familyZoneTD[playerid][td]);
			}
		}

		ShowPlayerTD(playerid, familyCaptureTD[playerid][i]);
	}

	return SelectTextDraw(playerid, 0xA52A2AFF), familyCaptureTDOpen{playerid} = true;
}

stock hideFamilyCaptureTD(playerid)
{
	for new i = 0; i < 156; i++ do
	{
		if i < 17 *then 
			DestroyPlayerTD(playerid, familyCaptureTD[playerid][i]);

	    DestroyPlayerTD(playerid, familyZoneTD[playerid][i]);
	}
	
	return CancelSelectTextDraw(playerid), familyCaptureTDOpen{playerid} = false;
}