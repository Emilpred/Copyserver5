stock GetCountUsedObj(id, type = 0, interior_find = 0)
{
	f(mysql_string, 150, "SELECT * FROM `bh_objects` WHERE `%s` = '%d' AND Interior %s= 0;", !type ? "HouseID":"BizID", id, !interior_find ? "":"!" );

    new use_obj,
        Cache:result = mysql_query(mysql, mysql_string);
	
    use_obj = cache_get_row_count(mysql);
    cache_delete(result, mysql);
    return use_obj;
}

stock ShowListUsedObj(playerid, id, type, type_list)
{
	f(mysql_string, 150, "SELECT * FROM `bh_objects` WHERE `%s` = '%d' AND Interior %s= 0;", !type ? "HouseID":"BizID", id, type_list ? "!":"");

    new Cache:result = mysql_query(mysql, mysql_string);
	
	global_str = "";
	
	new count = type ? BizData[id][bObjectCount][type_list]:HouseInfo[id][hObjectCount][type_list];
	
	for new i; i < count; i++ do
	{
		if cache_get_row_count() > i *then
			format(mysql_string, 128, "{FFFFFF}[%d] %s\n", i + 1, ItemsInfo[cache_get_row_int(i, 12, mysql)][ItemName2]);
		else
			format(mysql_string, 128, "{AFAFAF}[%d] Vieta laisva\n", i + 1);
	
		strcat(global_str, mysql_string);
	}
	
	strcat(global_str, "{FFFF00}Nusipirkti papildoma vieta");
	
	spdList(playerid, 0, id);
	spdList(playerid, 1, type);
	spdList(playerid, 2, type_list);
	spdList(playerid, 3, count);
	
	cache_delete(result, mysql);
	 
	return SPD(playerid, 2435, DIALOG_STYLE_LIST, !type_list ? !"Objektai lauke":!"Objektai interjere", global_str, !"Issirinkti", !"Atgal");
}

stock GetEditBH_object_distance(playerid, Float:x, Float:y, Float:z, &biz = -1, &house = -1)
{
	new Float:distance = 21.0;
	
	if !(BizEntered[playerid] == -1) && GetString(BizData[BizEntered[playerid]][bOwner], PN(playerid)) && GetPlayerVirtualWorld(playerid) == BizEntered[playerid] + 100 *then
		distance = PointToPoint(x,y,z, BizData[BizEntered[playerid]][bExit_X], BizData[BizEntered[playerid]][bExit_Y], BizData[BizEntered[playerid]][bExit_Z]), biz = BizEntered[playerid];
	
	else if !(HouseEntered[playerid] == -1) && GetString(HouseInfo[HouseEntered[playerid]][hOwner], PN(playerid)) && GetPlayerVirtualWorld(playerid) == HouseEntered[playerid] + 50 *then
		distance = PointToPoint(x,y,z, HouseInfo[HouseEntered[playerid]][hExit_X], HouseInfo[HouseEntered[playerid]][hExit_Y], HouseInfo[HouseEntered[playerid]][hExit_Z]), house = HouseEntered[playerid];
		
	else
	{
		for new i; i < OWNABLEHOUSES; i++ do
		{
			if GetString(HouseInfo[i][hOwner], PN(playerid)) *then
			{
				if distance > PointToPoint(x,y,z, HouseInfo[i][hEnter_X],HouseInfo[i][hEnter_Y],HouseInfo[i][hEnter_Z]) *then
					distance = PointToPoint(x,y,z, HouseInfo[i][hEnter_X],HouseInfo[i][hEnter_Y],HouseInfo[i][hEnter_Z]), house = i;
			}
			
			if i < OWNABLEBIZES && GetString(BizData[i][bOwner],PN(playerid)) *then
			{
				if distance > PointToPoint(x,y,z, BizData[i][bEnter_X],BizData[i][bEnter_Y],BizData[i][bEnter_Z]) *then
					distance = PointToPoint(x,y,z, BizData[i][bEnter_X],BizData[i][bEnter_Y],BizData[i][bEnter_Z]), biz = i;
			}
		
		}
	}
	
	return _:distance;
}

stock CreateEditBH_object(playerid, itemid, type)
{
	new
		Float:x, Float:y, Float:z;
			
	GetPlayerPos(playerid, x, y, z);
	
	new biz = -1, house = -1, Float:distance = Float:GetEditBH_object_distance(playerid, x,y,z, biz, house);
	
	type = type > 0 ? 1:0;
	
	if !(biz == -1) && GetCountUsedObj(biz, 1, type) >= BizData[biz][bObjectCount][type] *then
		return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Jusu versle nera vietos, nusipirkite papildomu vietu.");
	
	else if !(house == -1) && GetCountUsedObj(house, 0, type) >= HouseInfo[house][hObjectCount][type] *then
		return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Jusu name nera vietos, nusipirkite papildomu vietu."); 
		

	else if MAX_CREATE_OBJECTS <= TOTALOBJECTS *then 
		return SCM(playerid, -1, "LIMIT OBJECTS IN SERVER CREATED");
	
	if distance > 20.0 *then 
		return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Jus negalite irengti sio objekto, galima tik ne toliau kaip 20 metru nuo savo nekilnojamojo turto!");
		
 	if biz != -1 && itemid == 2420 || itemid == 2421 *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Lysves galima irengti tik salia namo!");
	
	/*EditObjectPlayer[playerid] = CreateDynamicObject(ItemsInfo[itemid][ItemModel], x+2, y+2, z, 0, 0, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	EditDynamicObject(playerid, EditObjectPlayer[playerid]);
	

	Int_SetPlayerData(playerid, "install_house_obj", PickInvent[playerid] + 1);*/
	
	new id = PickInvent[playerid] + 1;
			
	BH_Object[TOTALOBJECTS][objModel] = ItemsInfo[itemid][ItemModel];//GetDynamicObjectModel(objectid);
			
	DestroyDynamicObject(EditObjectPlayer[playerid]);
			
	if Float:GetEditBH_object_distance(playerid, x,y,z, BH_Object[TOTALOBJECTS][objBizID], BH_Object[TOTALOBJECTS][objHouseID]) > 20.0 *then 
		return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Jus negalite irengti sio objekto, galima tik ne toliau kaip 20 metru nuo savo nekilnojamojo turto!");
			
			
	new item = Inventory[playerid][0][id-1];
			
	if ItemsInfo[item][ItemModel] == BH_Object[TOTALOBJECTS][objModel] *then
		ClearItem(playerid, id-1, 1);
	else 
	{
		return SCMF(playerid, -1, "Klaida, parasykite Kurejui | Code: %d %d %d", item, ItemsInfo[item][ItemModel], BH_Object[TOTALOBJECTS][objModel]);
	}
			
	BH_Object[TOTALOBJECTS][objPosX] = x+2;
	BH_Object[TOTALOBJECTS][objPosY] = y+2;
	BH_Object[TOTALOBJECTS][objPosZ] = z;

	/*BH_Object[TOTALOBJECTS][objRotX] = rx;
	BH_Object[TOTALOBJECTS][objRotY] = ry;
	BH_Object[TOTALOBJECTS][objRotZ] = rz;*/
		
	BH_Object[TOTALOBJECTS][objItemID] = item;
	BH_Object[TOTALOBJECTS][objWorld] = GetPlayerVirtualWorld(playerid);
	BH_Object[TOTALOBJECTS][objInterior] = GetPlayerInterior(playerid);
	
	BH_Object[TOTALOBJECTS][objScore] = 0;
	BH_Object[TOTALOBJECTS][objTimer] = 10800;
			
	f(global_str, 400, "INSERT INTO `bh_objects` (`Model`, `PosX`, `PosY`, `PosZ`, `RotX`, `RotY`, `RotZ`, `HouseID`, `BizID`, `Owner`, `Date`, `ItemID`, `World`, `Interior`) VALUES (%d, '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%s', CURRENT_TIMESTAMP(), '%d', '%d', '%d')",
		BH_Object[TOTALOBJECTS][objModel],
		BH_Object[TOTALOBJECTS][objPosX],
		BH_Object[TOTALOBJECTS][objPosY],
		BH_Object[TOTALOBJECTS][objPosZ],
		BH_Object[TOTALOBJECTS][objRotX],
		BH_Object[TOTALOBJECTS][objRotY],
		BH_Object[TOTALOBJECTS][objRotZ],
		BH_Object[TOTALOBJECTS][objHouseID], BH_Object[TOTALOBJECTS][objBizID], PN(playerid), item,
		BH_Object[TOTALOBJECTS][objWorld],
		BH_Object[TOTALOBJECTS][objInterior] );
			
	mysql_tquery(mysql, global_str, "Create_BH_Object", "d", TOTALOBJECTS);
			
	return SCM(playerid, 0x6495EDFF, !"[Informacija]{FFFFFF} Jus sekmingai perkelete objekta. Jei norite ji pasalinti arba perkelti, iveskite /pobject salia jo.");
   
	//return SCM(playerid, COLOR_VALIK, !"[Uzuomina]{FFFFFF} Noredami issaugoti padeties pakeitima – paspauskite diskelio mygtuka, noredami atsaukti – paspauskite ESC.");
}

public: Create_BH_Object(id)
{
	BH_Object[id][objBaseID] = cache_insert_id(mysql);
	
	BH_Object[id][objID] = CreateDynamicObject(BH_Object[id][objModel], BH_Object[id][objPosX], BH_Object[id][objPosY], BH_Object[id][objPosZ], BH_Object[id][objRotX], BH_Object[id][objRotY], BH_Object[id][objRotZ], BH_Object[id][objWorld], BH_Object[id][objInterior]);
	
	return TOTALOBJECTS ++;	
}
