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
	F_FAMILY_DCAPT
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
	Float:kvE_Int_Z
};

new FKV_Data_Int[3][fkv_data_int_enum] = 
{
	{205, -1513.1442, 2722.3933, 1500.9674, 269.2998, 206, 15, 2786.0383, 735.7945, 1500.1187},
	{209, -1207.5916,2382.5349,1500.9667,91.1680, 208, 10, 1888.9617,730.6089,1500.1459},
	{210, 1444.0739, -1065.3568, 1601.9919, 353.0435, 207, 10, 1488.0049, 1524.5972, 1601.0859}
};

new FKV_Data_Int_Exit[3];

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
		"Papildoma pagarba",
		"Laime darbe",
		"Verslininkai skoluose",
		"Nezinomas",
		"Medikai skoluose",
		"Baltas sarasas",
		"Banko machinacijos",
		"Morder",
		"Zuviu",
		"Treciasis pavaduotojas",
		"Greiti mokesciai",
		"Sunkvezimiai"
	};
	
new 
	const FamilyLevel[12] =
	{
		1000, 1200, 900, 800, 1100, 2000, 4000, 7000, 6000, 7500, 12500, 16000
	};
	
new 
	const FamilyColor[31][7] =
	{
		{"FF5E5E"},
		{"FFFFFF"},
		{"E65075"},
		{"EFA4B7"},
		{"905B69"},
		{"D052CE"},
		{"FF00FC"},
		{"5D395D"},
		{"8E38EA"},
		{"6B21BB"},
		{"2F00FF"},
		{"7456F8"},
		{"5287F1"},
		{"1DBAF2"},
		{"308EB0"},
		{"30B061"},
		{"20F271"},
		{"107135"},
		{"47EB2A"},
		{"9EE991"},
		{"C2D95E"},
		{"D1FF00"},
		{"7B9022"},
		{"FFC900"},
		{"E8CA60"},
		{"6B5B1F"},
		{"FF8400"},
		{"C04312"},
		{"5C4C45"},
		{"373534"},
		{"351204"}
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
		"Seima", 
		"Korporacija", 
		"Komanda", 
		"Burys", 
		"Brolyste", 
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
