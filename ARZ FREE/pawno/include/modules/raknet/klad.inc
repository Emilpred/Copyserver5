stock showPlayerKlad(playerid, kladid)
{
    if(pTemp[playerid][showedKladMenu])
        return false;

    pTemp[playerid][showedKladMenu] = true;

	executeEvent(playerid, 0, !"window.executeEvent('event.setActiveView', `[\"MountainTestDrive\"]`);");
    executeEvent(playerid, 0, !"window.executeEvent('event.mountain.testDrive.initializeText', `[{\"title\":\"Клад\",\"desc\":\"Список доступных предметов\"}]`);");

    global_str = "";

    for(new i, string[256]; i <= 4; i++)
    {
        new item = random(sizeof(ItemsInfo));

        pTemp[playerid][kladPrize][i] = item;

        format(string, sizeof(string), "\
            {\
                \"id\":%d,\
                \"title\":\"%s\",\
                \"img\":\"%i\",\
                \"color\":858993663\
            }%s\
        ", i, ItemsInfo[item][itemName], item, i == 4 ? "" : ",");

        strcat(global_str, string);

        string = "";
    }
    executeEvent(playerid, 0, (str_f("window.executeEvent('event.mountain.testDrive.addVehicles', `[[%s]]`);", global_str)));

    cursorPlayer(playerid, 0, true);

    return clearKlad(kladid);
}

stock clearKlad(kladid)
{
    KladInfo[kladid][kladStatus] = false;

    return Iter_Remove(Klad, kladid);
}

cmd:gotoklad(playerid, params[])
{
    if(PI[playerid][pAdmin] < 8)
        return false;

    if(sscanf(params, "d", params[0]))
        return SCM(playerid, COLOR_OLDRED, "[Ошибка] {ffffff}Используйте: /gotoklad [id]");

    UpdatePlayerPos(playerid, KladInfo[params[0]][kladX], KladInfo[params[0]][kladY], KladInfo[params[0]][kladZ]);

    GameTextForPlayer(playerid, FixText("ВЫ НАШЛИ ЗОНУ КЛАДА!"), 2000, 4);

    return SCMF(playerid, -1, "Вы телепортировались к кладу ID:%d", params[0]);
}

cmd:klad(playerid, params[])
    searchMetalDetector[playerid] = !searchMetalDetector[playerid];