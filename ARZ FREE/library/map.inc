//mysql ++
stock GetAdminMappingFREE()
{
	for new i = 1; i < sizeof AdminMapping; i++ do
	{
		if !IsValidDynamicObject(AdminMapping[i][AM_Object]) && (!AdminMapping[i][AM_Object] or AdminMapping[i][AM_Object] == INVALID_STREAMER_ID) *then
			return i;
	}
	
	return -1;
}

stock IsAdminMapping(playerid, objectId)
{
	for new i = 1; i < sizeof AdminMapping; i++ do
	{
		if AdminMapping[i][AM_Object] == objectId *then
			return true, Int_SetPlayerData(playerid, "AdminMappingID", i);
	}
	
	return false;
}

stock AdminMapping_Remove(ID)
{	
	format(global_str, 128, "SELECT `idx` FROM map_objects WHERE pUID = '%d'", ID);
	
	new 
		Cache:result = mysql_query(mysql, global_str),
		count = cache_num_rows();
		
	for new i, idx; i < count; i++ do
	{
		cache_get_value_index_int(i, 0, idx);
		
		DestroyDynamicObject(AdminMapping[idx][AM_Object]), AdminMapping[idx][AM_Object] = INVALID_STREAMER_ID;
		
		AdminMapping[idx][AM_UID] = 0;
		
		AdminMapping[idx][AM_Pos][0] =
		AdminMapping[idx][AM_Pos][1] =
		AdminMapping[idx][AM_Pos][2] =
		AdminMapping[idx][AM_Rot][0] =
		AdminMapping[idx][AM_Rot][1] =
		AdminMapping[idx][AM_Rot][2] = 0.0;
		
	}
	
	cache_delete(result);

	SQL("DELETE FROM map_objects WHERE pUID = '%d'", ID);
		
	return count;
}


stock AdminMapping_Edit(playerid, idx)
{
	spdList(playerid, 0, idx);
			
	format(mysql_string, 256, "SELECT `Owner`, `pUID`, %s, `Story`, `Model` FROM map_objects WHERE ID = '%d' LIMIT 1;", "DATE_FORMAT(`Date`, '%H:%i:%S %d/%m/%Y')", AdminMapping[idx][AM_UID]);
	new Cache:result = mysql_query(mysql, mysql_string);
			
	if cache_num_rows() *then
	{
		new intData[2];
		cache_get_value_index(0, 0, SQL_GET_ROW_STR[0]);
		cache_get_value_index_int(0, 1, intData[0]);
		cache_get_value_index(0, 2, SQL_GET_ROW_STR[1]);
		cache_get_value_index(0, 3, SQL_GET_ROW_STR[2]);
		cache_get_value_index_int(0, 4, intData[1]);
				
		format(global_str, 1024, "\
		Назад\n\
		Телепортироваться\n\
		Удалить\n\
		-----------------------------\n\
		UID объекта в базе: %d\n\
		Создатель: %s [uid: %d]\n\
		Дата создания: %s\n\
		Группа: Без названия [0]\n\
		Метка: %s\n\
		Модель объекта: %d\n\
		Координаты: %f,%f,%f,%f,%f,%f",
		AdminMapping[idx][AM_UID],
		SQL_GET_ROW_STR[0], intData[0],
		SQL_GET_ROW_STR[1],
		SQL_GET_ROW_STR[2],
		intData[1],
		AdminMapping[idx][AM_Pos][0], AdminMapping[idx][AM_Pos][1], AdminMapping[idx][AM_Pos][2],
		AdminMapping[idx][AM_Rot][0], AdminMapping[idx][AM_Rot][1], AdminMapping[idx][AM_Rot][2] );
	}

	cache_delete(result);
			
	return SPD(playerid, 7793, DIALOG_STYLE_LIST, !"Информация о выбраном объекте", global_str, !"Выбрать", "Закрыть");
}

stock AdminMapping_Create(playerid, model, const Story[])
{
	new id = GetAdminMappingFREE();
			
	if id == -1 *then
		return SendErrorMessage(playerid);
			
	GetPlayerPos(playerid, AdminMapping[id][AM_Pos][0], AdminMapping[id][AM_Pos][1], AdminMapping[id][AM_Pos][2]);
			
	AdminMapping[id][AM_Object] = CreateDynamicObject(model, AdminMapping[id][AM_Pos][0], AdminMapping[id][AM_Pos][1] + 2.5, AdminMapping[id][AM_Pos][2], 0.0, 0.0, 0.0);
			
	Int_SetPlayerData(playerid, "AdminMappingID", id);
	
	format(global_str, 1024, "INSERT INTO map_objects (`idx`, `pUID`, `Owner`, `Model`, `X`, `Y`, `Z`, `RX`, `RY`, `RZ`, `Story`, `Date`) VALUES ('%d', '%d', '%s', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%s', CURRENT_TIMESTAMP())", id, PI[playerid][pID], PN(playerid), model,  AdminMapping[id][AM_Pos][0], AdminMapping[id][AM_Pos][1], AdminMapping[id][AM_Pos][2], 0.0, 0.0, 0.0, Story);
	mysql_tquery(mysql, global_str, "AdminMapping_CreateSQL", "dd", playerid, id);
	
	return true;
}

public: AdminMapping_CreateSQL(playerid, id)
{
	AdminMapping[id][AM_UID] = cache_insert_id();
	
	SCMF(playerid, COLOR_LIGHTBLUE, "[Admin Mapping] Объект создан, установите его в нужной позиции и нажмите на кнопку сохранения или ESC. [%d*%d]", id, AdminMapping[id][AM_UID]);
			
	SCM(playerid, -1, "[Admin Mapping] Объекту присвоена группа: Без названия [ID: 0].");
	
	EditDynamicObject(playerid, AdminMapping[id][AM_Object]);
}

stock AdminMapping_Update(id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	SetDynamicObjectPos(AdminMapping[id][AM_Object], AdminMapping[id][AM_Pos][0] = x, AdminMapping[id][AM_Pos][1] = y, AdminMapping[id][AM_Pos][2] = z);
	SetDynamicObjectRot(AdminMapping[id][AM_Object], AdminMapping[id][AM_Rot][0] = rx, AdminMapping[id][AM_Rot][1] = ry, AdminMapping[id][AM_Rot][2] = rz);
			
	SQL("UPDATE map_objects SET X = '%f', Y = '%f', Z = '%f', RX = '%f', RY = '%f', RZ = '%f' WHERE ID = '%d'", x,y,z, rx,ry,rz, AdminMapping[id][AM_UID]);

	return true;
}

stock AdminMapping_Load()
{
	new 
		Cache:result = mysql_query(mysql, "SELECT * FROM map_objects"),
		count = cache_num_rows();
		
	for new i, idx, model; i < count; i++ do
	{
		cache_get_value_index_int(i, 1, idx);
		cache_get_value_index_int(i, 0, AdminMapping[idx][AM_UID]);
		cache_get_value_index_int(i, 4, model);
		cache_get_value_index_float(i, 5, AdminMapping[idx][AM_Pos][0]);
		cache_get_value_index_float(i, 6, AdminMapping[idx][AM_Pos][1]);
		cache_get_value_index_float(i, 7, AdminMapping[idx][AM_Pos][2]);
		cache_get_value_index_float(i, 8, AdminMapping[idx][AM_Rot][0]);
		cache_get_value_index_float(i, 9, AdminMapping[idx][AM_Rot][1]);
		cache_get_value_index_float(i, 10, AdminMapping[idx][AM_Rot][2]);
		
		AdminMapping[idx][AM_Object] = CreateDynamicObject(
			model,
			
			AdminMapping[idx][AM_Pos][0],
			AdminMapping[idx][AM_Pos][1],
			AdminMapping[idx][AM_Pos][2],
			
			AdminMapping[idx][AM_Rot][0],
			AdminMapping[idx][AM_Rot][1],
			AdminMapping[idx][AM_Rot][2]
		);
		
	}
	
	cache_delete(result);

	return true;
}

stock AdminMapping_ListObject(playerid, page, type = 0)
{
	if !type *then
		format(global_str, 300, "SELECT `idx`, `Model`, `Story`, `Owner`, %s FROM map_objects WHERE pUID = '%d' LIMIT %d, 25", "DATE_FORMAT(`Date`, '%H:%i:%S %d/%m/%Y')", PI[playerid][pID], 25 * page );
	
	else
		format(global_str, 300, "SELECT `idx`, `Model`, `Story`, `Owner`, %s FROM map_objects LIMIT %d, 25", "DATE_FORMAT(`Date`, '%H:%i:%S %d/%m/%Y')", 25 * page );
	
	new Cache:result = mysql_query(mysql, global_str), count = cache_num_rows();

	global_str = "{FFFFFF}[idx*uid]\t{FFFFFF}Модель, Группа||Метка\t{FFFFFF}Создатель, Дата\n";

	for new i, idx, int; i < count; i++ do
	{
		cache_get_value_index_int(i, 0, idx);
		cache_get_value_index_int(i, 1, int);
		cache_get_value_index(i, 2, SQL_GET_ROW_STR[0]);
		cache_get_value_index(i, 3, SQL_GET_ROW_STR[1]);
		cache_get_value_index(i, 4, SQL_GET_ROW_STR[2]);
		
		spdList(playerid, i, idx);
		
		format(mysql_string, 256, "[%d*%d]\t%d, M:%s\t(%s, %s)\n", idx, AdminMapping[idx][AM_UID], int, SQL_GET_ROW_STR[0], SQL_GET_ROW_STR[1], SQL_GET_ROW_STR[2]);
		strcat(global_str, mysql_string);
	}
	
	if count >= 25 *then
		strcat(global_str, "{FF0000}- следующая страница >>");

	cache_delete(result);
	
	AdminMapping_List[playerid][0] = page, AdminMapping_List[playerid][1] = type;
	
	return SPD(playerid, 7792, DIALOG_STYLE_TABLIST_HEADERS, !type ? !"Admin My List Objects":!"Admin All List Objects", global_str, !"Выбрать", !"Назад");
}