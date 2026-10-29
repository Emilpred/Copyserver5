enum bodyguardSettings
{
	actorOwner[MAX_PLAYER_NAME],
   	actorName[24],
  	actorSkin,
  	actorAnimationId,
	actorType,
	actorLevel,
	actorExp,
	actorHealth,
	actorArmour,
	Float:actorEat,
	actorProtection,
	actorDamage,
	actorMaxHP,
	actorSpawn,
	actorGun,
	actorGunAmmo,

	bodyguardTimer
}
new Bodyguard[MAX_PLAYERS][4][bodyguardSettings];

new ReplicBodyguard[MAX_PLAYERS][4][16][120];

enum ReplicOxr
{
	replic[120]
}

new DefaultReplicBodyguard[][ReplicOxr] = {
    "Не нужно трогать меня или моего хозяина!", "Ну всё! ты напросился! А ну, хватай его!", "Если ты ещё раз тронешь моего хозяина, тебе капец!",
    "А я предупреждал! Щемись сынок!", "Ай, мне больно, не надо!", "Шеф, я на месте!", "Супер! Теперь гады не пробьют меня", "Не поздоровится тому, кто тебя тронет",
    "Ништяк! Сейчас подкрепимся", "Немного воды, мне не помешает", "Оо вот это по нашему, будь здоров", "Наркотааа, круто", "Я голоден! Дай мне покушать",
    "Мне нехорошо, дай мне аптечку", "Я умею и так!", "На меня нет места"
};

new answerBodyguard[][] = {
	"Когда его ударили для предупреждения говорит", "Когда его ударили нападает и говорит", "Когда вас ударили для предупреждения говорит",
	"Когда вас ударили нападает и говорит", "Когда вы напали на него говорит", "Когда вы призвали его, говорит",
	"Когда надевает бронежилет, говорит", "Когда получает оружие, говорит", "Когда получает еду, говорит",
	"Когда получает газировку, говорит", "Когда получает алкоголь, говорит", "Когда получает наркотики, говорит",
	"Когда он голоден, раз в минуту говорит", "Когда у него мало здоровья, говорит", "Когда воспроизводит анимацию, говорит",
	"Когда на него нет места в машине, говорит"
};

stock IsValidBodyguard(playerid)
{
	new Cache:result = mysql_query(mysql, (str_f("SELECT * FROM bodyguard WHERE NickName = '%s'", PlayerName[playerid]))), 
		count = cache_get_row_count(mysql);

	cache_delete(result);

	if count *then
		return count;

	return false;
}
#define UpdateBodyguardData(%0,%1,%2) format(mysql_string, 512, %1, %2), UpdateBodyguard_Data(%0, mysql_string)
stock UpdateBodyguard_Data(id, update_string[])
{
	f(global_str, 512, "UPDATE bodyguard SET %s WHERE ID = %d;", update_string, id);
	mysql_query(mysql, global_str);

	return false;
}

stock LoadBodyguard(playerid)
{
	f(mysql_string, 128, "SELECT * FROM `bodyguard` WHERE `NickName` = '%s'", PN(playerid));
	new Cache:result = mysql_query(mysql, mysql_string);

	for new i; i < cache_get_row_count(mysql); i++ do
	{
	    cache_get_field_content(i, "NickName", Bodyguard[playerid][i][actorOwner], mysql);
 		cache_get_field_content(i, "actorName", Bodyguard[playerid][i][actorName], mysql);

		Bodyguard[playerid][i][actorSkin] = cache_get_row_int(i, 3, mysql);
		Bodyguard[playerid][i][actorAnimationId] = cache_get_row_int(i, 4, mysql);

		Bodyguard[playerid][i][actorType] = cache_get_row_int(i, 5, mysql);
		Bodyguard[playerid][i][actorLevel] = cache_get_row_int(i, 6, mysql);
		Bodyguard[playerid][i][actorExp] = cache_get_row_int(i, 7, mysql);
		Bodyguard[playerid][i][actorHealth] = cache_get_row_int(i, 8, mysql);
		Bodyguard[playerid][i][actorArmour] = cache_get_row_int(i, 9, mysql);
		Bodyguard[playerid][i][actorEat] = cache_get_row_float(i, 10, mysql);
		Bodyguard[playerid][i][actorProtection] = cache_get_row_int(i, 11, mysql);
		Bodyguard[playerid][i][actorDamage] = cache_get_row_int(i, 12, mysql);
		Bodyguard[playerid][i][actorMaxHP] = cache_get_row_int(i, 13, mysql);
		Bodyguard[playerid][i][actorSpawn] = cache_get_row_int(i, 14, mysql);

		cache_get_field_content(i, "ReplicWarn", ReplicBodyguard[playerid][i][0], mysql); // 15
		cache_get_field_content(i, "ReplicAttack", ReplicBodyguard[playerid][i][1], mysql); // 16
		cache_get_field_content(i, "ReplicWarnTwo", ReplicBodyguard[playerid][i][2], mysql); // 17
		cache_get_field_content(i, "ReplicAttackTwo", ReplicBodyguard[playerid][i][3], mysql); // 18
		cache_get_field_content(i, "ReplicFriendlyFire", ReplicBodyguard[playerid][i][4], mysql); // 19
		cache_get_field_content(i, "ReplicSpawn", ReplicBodyguard[playerid][i][5], mysql); // 20
		cache_get_field_content(i, "ReplicUseArmor", ReplicBodyguard[playerid][i][6], mysql); // 21
		cache_get_field_content(i, "ReplicGiveGun", ReplicBodyguard[playerid][i][7], mysql); // 22
		cache_get_field_content(i, "ReplicGiveEat", ReplicBodyguard[playerid][i][8], mysql); // 23
		cache_get_field_content(i, "ReplicGiveWater", ReplicBodyguard[playerid][i][9], mysql); // 24
		cache_get_field_content(i, "ReplicGiveBeer", ReplicBodyguard[playerid][i][10], mysql); // 25
		cache_get_field_content(i, "ReplicGiveNarko", ReplicBodyguard[playerid][i][11], mysql); // 26
		cache_get_field_content(i, "ReplicHungry", ReplicBodyguard[playerid][i][12], mysql); // 27
		cache_get_field_content(i, "ReplicLowHP", ReplicBodyguard[playerid][i][13], mysql); // 28
		cache_get_field_content(i, "ReplicAnim", ReplicBodyguard[playerid][i][14], mysql); // 29
		cache_get_field_content(i, "ReplicNoAuto", ReplicBodyguard[playerid][i][15], mysql); // 30

		Bodyguard[playerid][i][actorGun] = cache_get_row_int(i, 31, mysql);
		Bodyguard[playerid][i][actorGunAmmo] = cache_get_row_int(i, 32, mysql);
	}

	return cache_delete(result);
}

stock BodyguardCheckNextLevel(playerid, slot)
{
	if Bodyguard[playerid][slot][actorExp] >= (Bodyguard[playerid][slot][actorLevel] + 1)*4  *then
	{
        while Bodyguard[playerid][slot][actorExp] >= (Bodyguard[playerid][slot][actorLevel]+1)*4 do
		{
			Bodyguard[playerid][slot][actorLevel] ++;

			Bodyguard[playerid][slot][actorExp] = 0;
			UpdateBodyguardData(PI[playerid][pID], "actorExp = %d", 0);

		}
		SCMF(playerid, COLOR_VALIK, "Поздравляем! Ваш охранник '%s' достиг %d-го уровня!", Bodyguard[playerid][slot][actorName], Bodyguard[playerid][slot][actorLevel]);
		UpdateBodyguardData(PI[playerid][pID], "actorLevel = %d", Bodyguard[playerid][slot][actorLevel]);

		return 1;
	}
	return 0;
}

stock CloseBodyguardTD(playerid)
{
    if !bodyguardTDOpen{playerid} *then
		return false;

	for new i; i < 107; i++ do
   		DestroyPlayerTD(playerid, bodyguardTD[playerid][i]);

    bodyguardTDOpen{playerid} = false;

	return 1;
}

enum bodyguardActors
{
	bodyguardNPC,
	bodyguardNPCPlayer,
	bodyguardTimer,
	bodyguardTarget,
	bodyguardAtack,
	bodyguardSlot,
	Text3D:bodyguardText3D
}
new BodyguardActors[MAX_PLAYERS][bodyguardActors];

stock BodyguardTakeDamage(level)
{
	switch level do {
		case 1..3:
			return level + 2;
	}

	return false;
}

public: FCNPC_BodyguardChatBubble(playerid, type)
{
	SetPlayerChatBubble(BodyguardActors[playerid][bodyguardNPC], ReplicBodyguard[playerid][BodyguardActors[playerid][bodyguardSlot]][type], COLOR_WHITE, 10.0, 5000);

	return 1;
}

stock FCNPC_BodyguardCreate(playerid, slot)
{
	f(global_str, 34, "%s(%d)", Bodyguard[playerid][slot][actorName], playerid);
	new npcid = FCNPC_Create(global_str);

	BodyguardActors[playerid][bodyguardNPC] = npcid;
	BodyguardActors[playerid][bodyguardSlot] = slot;
	BodyguardActors[npcid][bodyguardNPCPlayer] = playerid;

    new Float:X, Float:Y, Float:Z, Float:A;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);

	X += (4 * floatsin(-Float:A, degrees));
	Y += (4 * floatcos(-Float:A, degrees));

	FCNPC_Spawn(npcid, Bodyguard[playerid][slot][actorSkin], X, Y, Z);
	FCNPC_SetPosition(npcid, X, Y, Z);

	FCNPC_SetVirtualWorld(npcid, GetPlayerVirtualWorld(playerid));
 	FCNPC_SetInterior(npcid, GetPlayerInterior(playerid));

	SetPlayerColor(npcid, 0xFFFFFF00);
	BodyguardActors[npcid][bodyguardAtack] = -1;

	CallRemoteFunction("FCNPC_SetCustomSkin", "dd", npcid, Bodyguard[playerid][slot][actorSkin]);

	FCNPC_GoToPlayer(npcid, playerid);

	FCNPC_FollowPlayer(playerid, playerid);

	FCNPC_SetHealth(npcid, float( Bodyguard[playerid][slot][actorMaxHP] ));

	if Bodyguard[playerid][slot][actorGun] > 1 *then
	{
		FCNPC_SetWeapon(npcid, Bodyguard[playerid][slot][actorGun]);
		FCNPC_GiveAmmo(npcid, Bodyguard[playerid][slot][actorGunAmmo]);
	}

	CallTimeOutFunction("FCNPC_BodyguardChatBubble", 1000, false, "dd", playerid, 5);

    static const BodyguardTypeColor[][] = {0xAAAAAAFF, 0x68FE40FF, 0x25CAFFFF, 0xD239CCFF};
	f(global_str, 50, "Охранник %s\n{ffffff}%s", PN(playerid), Bodyguard[playerid][slot][actorName]);
	BodyguardActors[npcid][bodyguardText3D] = Create3DTextLabel(global_str, BodyguardTypeColor[Bodyguard[playerid][slot][actorType]-1][0], 0.0, 0.0, 0.0, 10.0, -1);
	Attach3DTextLabelToPlayer(BodyguardActors[npcid][bodyguardText3D], npcid, 0.0, 0.0, 0.2);

	return npcid;
}

stock FCNPC_BodyguardDrop(playerid, slot)
{
	new npcid = BodyguardActors[playerid][bodyguardNPC];

	if !Bodyguard[playerid][slot][actorSpawn] or !(npcid == INVALID_PLAYER_ID) *then
		return SCM(playerid, -1, "Сначала удалить охранника с сервера!");

	return SQL("DELETE FROM `bodyguard` WHERE `NickName` = '%s' AND `actorName` = '%s'", PN(playerid), Bodyguard[playerid][slot][actorName]);
}

stock FCNPC_BodyguardDelete(playerid)
{
	new npcid = BodyguardActors[playerid][bodyguardNPC];

	FCNPC_Destroy(npcid);
	FCNPC_UnFollowPlayer(playerid);
	Delete3DTextLabel(BodyguardActors[npcid][bodyguardText3D]);

    BodyguardActors[playerid][bodyguardNPC] =
	BodyguardActors[playerid][bodyguardTarget] = INVALID_PLAYER_ID;
}

stock FCNPC_SetFollowTimer(npcid)
{
	if BodyguardActors[npcid][bodyguardTarget] != INVALID_PLAYER_ID *then
		BodyguardActors[npcid][bodyguardTimer] = SetTimerEx("BG_SetFollowPosition", 300, true, "ii", npcid, BodyguardActors[npcid][bodyguardTarget]);
}

stock FCNPC_FollowPlayer(playerid, targetid)
{
    new npcid = BodyguardActors[playerid][bodyguardNPC];

	FCNPC_UnFollowPlayer(playerid);
	BodyguardActors[npcid][bodyguardTarget] = targetid;

	if !BG_SetFollowPosition(npcid, targetid) *then
		FCNPC_SetFollowTimer(npcid);
}

stock FCNPC_UnFollowPlayer(playerid)
{
	new npcid = BodyguardActors[playerid][bodyguardNPC];

	if BodyguardActors[npcid][bodyguardTimer] != 0 *then
		KillTimer(BodyguardActors[npcid][bodyguardTimer]), BodyguardActors[npcid][bodyguardTimer] = 0;

	if BodyguardActors[npcid][bodyguardTarget] == INVALID_PLAYER_ID *then
		return 0;

	BodyguardActors[npcid][bodyguardTarget] = INVALID_PLAYER_ID;

	return 1;
}

public: BG_SetFollowPosition(npcid, playerid)
{
	new
		Float:X, Float:Y, Float:Z,
		Float:min_distance, Float:range, Float:speed;

	GetPlayerPos(playerid, X, Y, Z);

	if FCNPC_GetVehicleID(npcid) != INVALID_VEHICLE_ID *then
		min_distance = -3.0, range = -min_distance + 1.0, speed = 0.8;
	else
		min_distance = -1.0, range = -min_distance + 0.5, speed = FCNPC_MOVE_SPEED_AUTO;

	if !IsPlayerInRangeOfPoint(npcid, range, X, Y, Z) *then
	{
		FCNPC_GoToPlayer(npcid, playerid, .speed = speed, .min_distance = min_distance);
		KillTimer(BodyguardActors[npcid][bodyguardTimer]);
		BodyguardActors[npcid][bodyguardTimer] = 0;

		return 1;
	}

	return 0;
}

public FCNPC_OnUpdate(npcid)
{
	new Float:X, Float:Y, Float:Z, Float:A;
	GetPlayerPos(BodyguardActors[npcid][bodyguardNPCPlayer], X, Y, Z);
	GetPlayerFacingAngle(BodyguardActors[npcid][bodyguardNPCPlayer], A);

	if !IsPlayerInRangeOfPoint(npcid, 30.0, X, Y, Z) *then
	{
		FCNPC_SetVirtualWorld(npcid, GetPlayerVirtualWorld(BodyguardActors[npcid][bodyguardNPCPlayer]));
		FCNPC_SetInterior(npcid, GetPlayerInterior(BodyguardActors[npcid][bodyguardNPCPlayer]));

		X += (4 * floatsin(-Float:A, degrees));
		Y += (4 * floatcos(-Float:A, degrees));

		FCNPC_SetPosition(npcid, X, Y, Z);
		FCNPC_SetFollowTimer(npcid);
	}

	if BodyguardActors[npcid][bodyguardAtack] != -1 *then
	{
		GetPlayerPos(BodyguardActors[npcid][bodyguardAtack], X, Y, Z);

		if FCNPC_GetWeapon(npcid) > 1 && !IsPlayerInRangeOfPoint(npcid, 25.0, X, Y, Z) *then
			return FCNPC_SetPosition(npcid, X, Y, Z-25), FCNPC_StopAim(npcid), FCNPC_StopAttack(npcid), BodyguardActors[npcid][bodyguardAtack] = -1;

		if !IsPlayerInRangeOfPoint(npcid, 25.0, X, Y, Z) *then
			return BodyguardActors[npcid][bodyguardAtack] = -1, FCNPC_StopAttack(npcid), FCNPC_GoToPlayer(npcid, BodyguardActors[npcid][bodyguardAtack]);

		FCNPC_GoToPlayer(npcid, BodyguardActors[npcid][bodyguardAtack]);
	}
	return 1;
}

public FCNPC_OnTakeDamage(npcid, issuerid, Float:amount, weaponid, bodypart)
{
	new pId = BodyguardActors[npcid][bodyguardNPCPlayer], slot = BodyguardActors[pId][bodyguardSlot];

	if !IsPlayerConnected(issuerid) || !FCNPC_IsValid(npcid) *then
		return 1;

	if issuerid == pId *then
		return FCNPC_BodyguardChatBubble(pId, 4);

	if !(issuerid == INVALID_PLAYER_ID) && BodyguardTakeDamage(Bodyguard[pId][slot][actorType]) *then
		amount += float(BodyguardTakeDamage(Bodyguard[pId][slot][actorType]));


	BodyguardActors[npcid][bodyguardAtack] = issuerid;
	if !Bodyguard[pId][slot][actorGun] *then FCNPC_GoToPlayer(npcid, issuerid);
	//FCNPC_SetWeapon(npcid, 0);
	//FCNPC_MeleeAttack(npcid, -1, true);
	FCNPC_BodyguardChatBubble(pId, 1);

	if FCNPC_GetWeapon(npcid) > 1 *then
	{
		FCNPC_Stop(npcid);
		FCNPC_UseReloading(npcid, true);
		FCNPC_AimAtPlayer(npcid, issuerid, true);
	}
	return 1;
}

public: FCNPC_OnGiveDamage(npcid, damagedid, Float:amount, weaponid, bodypart)
{
    if !IsPlayerConnected(damagedid) || !FCNPC_IsValid(npcid) *then
		return 1;

	return 1;
}

public FCNPC_OnReachDestination(npcid)
{
	FCNPC_SetFollowTimer(npcid);

	return 1;
}

public FCNPC_OnDeath(npcid, killerid, reason)
{
    new pId = BodyguardActors[npcid][bodyguardNPCPlayer], slot = BodyguardActors[pId][bodyguardSlot];
	Bodyguard[pId][slot][actorSpawn] = !Bodyguard[pId][slot][actorSpawn];
		
	return 1;
}

stock CreatePlayerBodyguard(playerid, itemId, bodyguard_name[])
{
	static 
        bodyguardType[] = {2, 1, 3, 4, 3, 3, 4, 4, 4, 4, 4, 4, 4 ,4, 4, 4, 2, 2, 4, 4, 4, 4, 4, 4}, 
		bodyguardProtection[] = {2, 1, 3, 4, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 4, 4, 4, 4, 4, 4}, 
        bodyguardDamage[] = {2, 1, 3, 4, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 4, 4, 4, 4, 4, 4}, 
		bodyguardMaxHP[] = {110, 100, 120, 130, 1200, 1200, 1300, 1300, 1300, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 110, 110, 1500, 1500, 1500, 1500, 1500, 1500};

	new items_security[25] = {2511, 2512, 2513, 2514, 2515, 2516, 2717, 2518, 2519, 2628, 2629, 2630, 2631, 2632, 2633, 2634, 2635, 2636, 2637, 2638, 2639, 2640, 2641};

	f(mysql_string, 128, "SELECT * FROM `bodyguard` WHERE `NickName` = '%s'", PN(playerid));
	new Cache:result = mysql_query(mysql, mysql_string);
	
	if cache_get_row_count(mysql) == 4 *then
		SCM(playerid, COLOR_OLDRED, "[Ошибка]{FFFFFF} Вы не можете иметь больше 4-х спутников!"), cache_delete(result);
	else
	{
		for new i; i < sizeof items_security; i++ do
		{
			if items_security[i] == itemId *then
				SQL("INSERT INTO bodyguard (`NickName`, `actorName`, `actorSkin`, `actorAnimationId`, `actorType`, `actorProtection`, `actorDamage`, `actorMaxHP`, `ReplicWarn`, `ReplicAttack`, `ReplicWarnTwo`, `ReplicAttackTwo`, `ReplicFriendlyFire`, `ReplicSpawn`, `ReplicUseArmor`, `ReplicGiveGun`, `ReplicGiveEat`, `ReplicGiveWater`, `ReplicGiveBeer`, `ReplicGiveNarko`, `ReplicHungry`, `ReplicLowHP`, `ReplicAnim`, `ReplicNoAuto`) VALUES ('%s', '%s', '%d', '1', '%d', '%d', '%d', '%d', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')", PlayerName[playerid], bodyguard_name, ItemsInfo[itemId][ItemModel], bodyguardType[i], bodyguardProtection[i], bodyguardDamage[i], bodyguardMaxHP[i], DefaultReplicBodyguard[0], DefaultReplicBodyguard[1], DefaultReplicBodyguard[2], DefaultReplicBodyguard[3], DefaultReplicBodyguard[4], DefaultReplicBodyguard[5], DefaultReplicBodyguard[6], DefaultReplicBodyguard[7], DefaultReplicBodyguard[8], DefaultReplicBodyguard[9], DefaultReplicBodyguard[10], DefaultReplicBodyguard[11], DefaultReplicBodyguard[12], DefaultReplicBodyguard[13], DefaultReplicBodyguard[14], DefaultReplicBodyguard[15]);
		}

		DeleteItem(playerid, itemId);
		
		SCM(playerid, 0xA7BB4DFF, !"[Информация] {FFFFFF}Вы успешно активировали сертификат охранника!"), SCMF(playerid, 0xA7BB4DFF, "[Информация] {FFFFFF}Ваш новый спутник с именем %s был создан!", bodyguard_name),
		SCM(playerid, 0xA7BB4DFF, !"[Информация] {FFFFFF}Вы можете начать управлять им в специальной вкладке в инвентаре!"), CallTimeOutFunction("@LoadPlayerBodyguards", 150, false, "d", playerid);
	}

	return 1;
}

stock ShowBodyguardTD(playerid)
{
    static const BodyguardFonColor[][] = {0xAAAAAAFF, 0x68FE40FF, 0x25CAFFFF, 0xD239CCFF};

	pTemp[playerid][tItemId] = -1;

	#include textdraws/bodyguard

	for new i; i < 107; i++ do
		ShowPlayerTD(playerid, bodyguardTD[playerid][i]);
	    
    bodyguardTDOpen{playerid} = true;

	return 1;
}

public: @LoadPlayerBodyguards(playerid)
	return LoadBodyguard(playerid);
