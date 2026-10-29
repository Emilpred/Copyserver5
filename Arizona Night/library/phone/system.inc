enum phone_shop_data
{
    shop_phoneId,
    shop_phoneCost,
    shop_phoneIdColor[11]
};

new PhoneShop[3][phone_shop_data] =
{
    {329, 200, {1476, 329, 1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485}},
    {1487, 400, {1486, 1487, 1488, 1489, 1490, 1491, 1492, 1493, 1494, 1495, 1496}},
    {382, 600, {382, 383, 1474, 384, 389, 1475, 385, 386, 387, 388, 1473}}
};

new PhoneBuyData[MAX_PLAYERS];

new
    PhoneColor[MAX_PLAYERS],
    PhoneOpen[MAX_PLAYERS];

stock GetPhoneID(itemId) {
    
    switch itemId do {

        case 719..729: 
            return 0; // iphone x
        
        case 708..718:
            return 1; // Samsung Galaxy_S10

        case 675..685:
            return 2; // Xiaomi
        
        case 697..707:
            return 3; // Google Pixel 3
        
        case 686..696:
            return 4; // Huawei P20 PRO

    }

    return INVALID_DATA_ID;
}

stock ShowPhoneMenu(playerid)
{
    f(global_str, 550, "\
    {B03131}[1]{FFFFFF} Настройки\n\
    {B03131}[2]{FFFFFF} Таймер (Будильник)\n\
    {B03131}[3]{FFFFFF} Номера/мониторинг гос. работников\n\
    {B03131}[4]{FFFFFF} Селфи{B03131}\n\
    {B03131}[5]{FFFFFF} Радио[%s{FFFFFF}]\n\
    {B03131}[6]{FFFFFF} Проверить баланс\n\
    {B03131}[7]{FFFFFF} Перевести телефон в режим \"%s\"\n\
    {B03131}[8]{FFFFFF} Убрать телефон\n\
    %s", PlayerPlayed{playerid} ? ("{7def58}ВКЛ") : ("{ef5858}ВЫКЛ"), PI[playerid][pPhoneInfo][1] ? ("Самолет") : ("Обычный"),
    !(FP_Data[playerid][F_FAMILY_ID] == -1) ?  (GetFamilyDataInt(FP_Data[playerid][F_FAMILY_ID], "brend") ? "\n{B03131}[9]{FFFFFF} Отдел коммерции\n{B03131}[10]{FFFFFF} Отдел недвижимости":""): "");
    
    return SPD(playerid, 966, DIALOG_STYLE_LIST, !"Меню", global_str, !"Принять", !"Отмена");
}

stock IsPhoneModel(modelId)
{
    if modelId >= 18865 && modelId <= 18874 or modelId == 19513 *then
        return true;

    return false;
}

stock GetPhoneColorIdByModel(modelId)
{
    switch modelId do
    {
        case 18866: return 0;
        case 18872: return 2;
        case 18871: return 3;
        case 18867: return 4;
        case 19513: return 5;
        case 18865: return 6;
        case 18873: return 7;
        case 18868: return 9;
        case 18869: return 8;
        case 18870: return 10;
    }

    return 1;
}

stock GetPhoneColorNameByModel(modelId)
{
    new Color[14];

    switch modelId do
    {
        case 18865: Color = "оранжевый";
        case 18866: Color = "голубой";
        case 18867: Color = "красный";
        case 18868: Color = "черный";
        case 18869: Color = "розовый";
        case 18870: Color = "темно красный";
        case 18871: Color = "зеленый";
        case 18872: Color = "синий";
        case 18873: Color = "золотой";
        case 18874: Color = "белый";
        case 19513: Color = "серебряный";

        default: Color = "none";
    }

    return Color;
}

stock ShowPlayerBuyPhone(playerid, bool:update = true)
{
    if update *then 
        PhoneBuyData[playerid] = -1;

    format(global_str, 300, "\
    {FFFFFF}Наименование\t{FFFFFF}Показатель\n\
    Модель:\t%s\n\
    {FFFFFF}Цвет:\t%s\n\
    {FFFFFF}Купить:\t{73B461}${FFFFFF}%d", 
    !(PhoneBuyData[playerid] == -1) ? (str_f("%s", ItemsInfo[PhoneBuyData[playerid]][itemEng_name])):"Выбрать", 
    !(PhoneBuyData[playerid] == -1) && !GetString(GetPhoneColorNameByModel(ItemsInfo[PhoneBuyData[playerid]][itemModel]), "белый") ? 
    GetPhoneColorNameByModel(ItemsInfo[PhoneBuyData[playerid]][itemModel]):"Стандартный", 
    !(PhoneBuyData[playerid] == -1) ? (PhoneShop[gpdList(playerid, 0)][shop_phoneCost] + (!GetString(GetPhoneColorNameByModel(ItemsInfo[PhoneBuyData[playerid]][itemModel]), "белый") ? 200000:0)):0);

    return SPD(playerid, 2000, DIALOG_STYLE_TABLIST_HEADERS, !"{FFFFFF}Определение | {ae433d}Мобильное устройство", global_str, !"»", !"«");
}