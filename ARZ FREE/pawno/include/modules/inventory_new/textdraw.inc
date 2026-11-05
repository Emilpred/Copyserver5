    InventoryTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, leftPagePositionX, pagePositionY, !"usebox");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][0], 0.000000, RequestInventoryType[playerid] == InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] != 1 ? 15.194000 : 27.343161);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][0], RequestInventoryType[playerid] != InventoryPlayer && RequestInventoryType[playerid] != InventorySecurity && (RequestInventoryType[playerid] != InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] != 1) ? 180.0 : RequestInventoryType[playerid] == InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] != 1 ? 142.500000 : 333.500000, 0.000000);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][0], 1);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][0], 0xE1E1E1FF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][0], 0x111111FF);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][0], 2);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][0], 0x000000FF);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][0], 0);

    InventoryTextdraw[playerid][1] = CreatePlayerTextDraw(playerid, rightPagePositionX, pagePositionY, !"usebox");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][1], 0.000000, 27.343161);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][1], leftPagePositionX + 0.200012, 0.000000);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][1], 1);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][1], 0xE1E1E1FF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][1], 0x111111FF);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][1], 2);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][1], 0x000000FF);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][1], 0);

    if(RequestInventoryType[playerid] != InventoryPlayer && RequestInventoryType[playerid] != InventoryWorkshop && RequestInventoryType[playerid] != InventorySecurity)
    {
        if(RequestInventoryType[playerid] == InventoryTrade)
            global_str = (SettingData[playerid][sdLanguage] ? FixText("“Œ–√") : "TRADE");  

        else if(RequestInventoryType[playerid] == InventoryShop)
        {
            if(GetPlayerAKioskID(playerid) != INVALID_DATA_ID)
                global_str = (SettingData[playerid][sdLanguage] ? FixText(" »Œ— ") : "KIOSK");
            
            else
                global_str = (SettingData[playerid][sdLanguage] ? FixText("Ã¿√¿«»Õ") : "SHOP");
        }
        else if(RequestInventoryType[playerid] == InventoryWarehouse)
            global_str = (SettingData[playerid][sdLanguage] ? FixText("ÿ ¿‘") : "WAREHOUSE");   

        else if(trunk[playerid] != INVALID_VEHICLE_ID)
            global_str = (SettingData[playerid][sdLanguage] ? FixText("¡¿√¿∆Õ» ") : "TRUNK");   

        else if(musorka[playerid] != INVALID_DATA_ID)
            global_str = (SettingData[playerid][sdLanguage] ? FixText("Ã”—Œ– ¿") : "TRASH");

        InventoryOtherTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 187.500000, 143.659897, global_str);
        PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][0], 0.188333, 1.056592);
        PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][0], 1280.000000, 1280.000000);
        PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][0], 1);
        PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][0], 0xFFFFFFFFFFFFFFFF);
        PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][0], 0);
        PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][0], 0xFFFFFFFF80808080);
        PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][0], 0);
        PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][0], 0);
        PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][0], 0x00000000);
        PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][0], 2);
        PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][0], 1);
        PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][0], 0);
    }

    InventoryTextdraw[playerid][2] = CreatePlayerTextDraw(playerid, leftPagePositionX, pagePositionY + (RequestInventoryType[playerid] != InventoryPlayer && RequestInventoryType[playerid] != InventorySecurity ? 23.600006 : 23.599998), !"usebox");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][2], 0.000000, -0.214150);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][2], RequestInventoryType[playerid] != InventoryPlayer && RequestInventoryType[playerid] != InventorySecurity && (RequestInventoryType[playerid] != InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] != 1) ? 180.0 : RequestInventoryType[playerid] == InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] != 1 ? 142.500000 : 333.500000, 0.000000);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][2], 1);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][2], 0xE1E1E1FF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][2], 0xBF5656FF);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][2], 2);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][2], 0x000000FF);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][2], 0);

    if(RequestInventoryType[playerid] == InventoryPlayer || RequestInventoryType[playerid] == InventorySecurity || (RequestInventoryType[playerid] == InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] == 1))
    {
        static const buttonNames[2][2][8] = { {"HELP", "œŒÃŒŸ‹"}, {"REPORT", "–≈œŒ–“"} };

        for(new i; i < 6; i++)
        {
            InventoryTextdraw[playerid][3 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - 124.401703 + ((41.033905 * (i > 2 ? i - 3 : i)) + (i % 2 ? 19.016937 : 0.0)), pagePositionY + 1.966667 + (i % 2 ? 3.517037 : 0.0), i % 2 ? (i < 4 ? FixText(buttonNames[i - (i > 1 ? 2 : 1)][SettingData[playerid][sdLanguage]]) : !"GPS") : !"LD_SPAC:white");
            PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][3 + i], i % 2 ? 0.188333 : 0.480000, i % 2 ? 1.056592 : 1.120000);
            PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][3 + i], i % 2 ? 1280.000000 : 38.033894, i % 2 ? 1280.000000 : 17.599998);
            PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][3 + i], i % 2 ? 2 : 1);
            PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][3 + i], i % 2 ? 0xFFFFFFFF : 0xBF5656FF);
            PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][3 + i], 0);
            PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][3 + i], 0x80808080);
            PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][3 + i], i % 2 ? 0 : 2);
            PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][3 + i], 0);
            PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][3 + i], 0x000000FF);
            PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][3 + i], i % 2 ? 2 : 4);
            PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][3 + i], 1);
            PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][3 + i], i % 2 ? 0 : 1);
        }

        if(RequestInventoryType[playerid] == InventoryPlayer || (RequestInventoryType[playerid] == InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] == 1))
        {
            if(!IsPlayerInHisVehicle(playerid))
            {
                InventoryTextdraw[playerid][9] = CreatePlayerTextDraw(playerid, leftPagePositionX, pagePositionY + 27.600006, !"usebox");
                PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][9], 0.000000, 8.897720);
                PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][9], 333.500000, 0.000000);
                PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][9], 1);
                PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][9], 0xE1E1E1FF);
                PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][9], 1);
                PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][9], 0x1A1A1AFF);
                PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][9], 2);
                PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][9], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][9], 0x000000FF);
                PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][9], 0);
                PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][9], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][9], 0);
            }

            InventoryTextdraw[playerid][10] = CreatePlayerTextDraw(playerid, leftPagePositionX - 153.136749, pagePositionY + 22.099998, !"LD_SPAC:white");
            PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][10], 0.480000, 1.120000);
            PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][10], 90.072655, 89.200005);
            PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][10], 1);
            PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][10], 0xFFFFFFFF);
            PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][10], 0);
            PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][10], 0x80808080);
            PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][10], 2);
            PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][10], 0);
            PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][10], 0x33333300);
            PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][10], 5);
            PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][10], 1);
            PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][10], 0);
            PlayerTextDrawSetPreviewModel(playerid, InventoryTextdraw[playerid][10], IsPlayerInHisVehicle(playerid) ? GetVehicleModelEx(GetPlayerVehicleID(playerid)) : GetPlayerSkin(playerid));
            PlayerTextDrawSetPreviewRot(playerid, InventoryTextdraw[playerid][10], IsPlayerInHisVehicle(playerid) ? 352.000000 : 0.000000, IsPlayerInHisVehicle(playerid) ? 345.000000 : 0.000000, IsPlayerInHisVehicle(playerid) ? 20.000000 : 0.000000, IsPlayerInHisVehicle(playerid) ? 1.032325 : 1.000000);

            if(RequestInventoryType[playerid] == InventoryPlayer)
            {
                if(!IsPlayerInHisVehicle(playerid))
                {
                    InventoryTextdraw[playerid][11] = CreatePlayerTextDraw(playerid, leftPagePositionX - 116.288849, pagePositionY + 59.023346, !"LD_SPAC:white");
                    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][11], 0.480000, 1.120000);
                    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][11], 16.376846, 15.353293);
                    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][11], 1);
                    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][11], 0xFFFFFFFF);
                    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][11], 0);
                    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][11], 0x80808080);
                    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][11], 2);
                    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][11], 0);
                    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][11], 0x00000000);
                    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][11], 5);
                    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][11], 1);
                    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][11], 1);
                    PlayerTextDrawSetPreviewModel(playerid, InventoryTextdraw[playerid][11], 1314);
                    PlayerTextDrawSetPreviewRot(playerid, InventoryTextdraw[playerid][11], 0.000000, 0.000000, 0.000000, 0.721063);

                    InventoryTextdraw[playerid][12] = CreatePlayerTextDraw(playerid, leftPagePositionX - 124.401703, pagePositionY + 29.100006, !"_");
                    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][12], 0.480000, 1.120000);
                    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][12], 8.500000, 9.833333);
                    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][12], 1);
                    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][12], 0xFFFFFFFF);
                    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][12], 0);
                    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][12], 0x80808080);
                    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][12], 2);
                    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][12], 0);
                    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][12], 0x111111FF);
                    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][12], 5);
                    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][12], 1);
                    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][12], 1);
                    PlayerTextDrawSetPreviewModel(playerid, InventoryTextdraw[playerid][12], 1649);
                    PlayerTextDrawSetPreviewRot(playerid, InventoryTextdraw[playerid][12], 0.000000, 0.000000, 90.000000, 2.000000);

                    InventoryTextdraw[playerid][13] = CreatePlayerTextDraw(playerid, leftPagePositionX - 122.729096, pagePositionY + 30.243134, !"~<~");
                    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][13], 0.134524, 0.754709);
                    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][13], 1280.000000, 1280.000000);
                    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][13], 2);
                    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][13], 0xFFFFFFFF);
                    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][13], 0);
                    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][13], 0x80808080);
                    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][13], 0);
                    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][13], 0);
                    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][13], 0x00000000);
                    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][13], 2);
                    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][13], 1);
                    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][13], 0);

                    for(new i; i < 8; i++)
                    {
                        InventoryTextdraw[playerid][14 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - 58.709686 + (22.667786 * (i % 3)), pagePositionY + 29.100006 + (26.066666 * (i / 3)), (i < 6 ? IntToStr(i + 1) : !"LD_BEAT:chit"));
                        PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][14 + i], (i < 6 ? 0.189748 : 0.480000), (i < 6 ? 0.937500 : 1.120000));
                        PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][14 + i], (i < 6 ? 1280.000000 : 6.800000), (i < 6 ? 1280.000000 : 7.866666));
                        PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][14 + i], (i < 6 ? 3 : 1));
                        PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][14 + i], 0x111111FF);
                        PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][14 + i], 0);
                        PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][14 + i], 0xFFFFFFFF80808080);
                        PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][14 + i], (i < 6 ? 0 : 2));
                        PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][14 + i], (i < 6 ? 1 : 0));
                        PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][14 + i], (i < 6 ? 0x00000000 : 0x000000FF));
                        PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][14 + i], (i < 6 ? 2 : 4));
                        PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][14 + i], 1);
                        PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][14 + i], 0);
                    }

                    f(mysql_string, 24, "ARM: %d", floatround(PI[playerid][pArmour]));
                    InventoryTextdraw[playerid][22] = CreatePlayerTextDraw(playerid, leftPagePositionX - 82.377472, pagePositionY + 32.100006, mysql_string);
                    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][22], 0.125555, 0.704395);
                    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][22], 1280.000000, 1280.000000);
                    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][22], 3);
                    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][22], 0xAAAAAAFF);
                    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][22], 0);
                    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][22], 0x80808080);
                    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][22], 0);
                    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][22], 0);
                    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][22], 0x00000000);
                    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][22], 2);
                    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][22], 1);
                    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][22], 0);

                    f(mysql_string, 24, "HP: %d", floatround(PI[playerid][pHealth]));
                    InventoryTextdraw[playerid][23] = CreatePlayerTextDraw(playerid, leftPagePositionX - 82.377472, pagePositionY + 40.143951, mysql_string);
                    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][23], 0.125555, 0.704395);
                    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][23], 1280.000000, 1280.000000);
                    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][23], 3);
                    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][23], 0xCD3432FF);
                    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][23], 0);
                    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][23], 0x80808080);
                    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][23], 0);
                    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][23], 0);
                    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][23], 0x00000000);
                    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][23], 2);
                    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][23], 1);
                    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][23], 0);

                    static const buttonName[8][2][12] = { {"MENU", "Ã≈Õﬁ"}, {"SETTINGS", "Õ¿—“–Œ… »"}, {"CARS", "“–¿Õ—œŒ–“"}, {"BUSINESS", "¡»«Õ≈—"}, {"DONATE", "ƒŒÕ¿“"}, {"FAMILY", "—≈Ã‹ﬂ"}, {"QUEST", " ¬≈—“€"}, {"REWARDS", "ƒŒ—“»∆≈Õ»ﬂ"}};
                    for(new i, textdrawId; i < 4; i++)
                    {
                        for(new idx; idx < 2; idx++)
                        {
                            textdrawId = i * 4 + idx * 2;

                            InventoryTextdraw[playerid][24 + textdrawId] = CreatePlayerTextDraw(playerid, leftPagePositionX - 124.401703 + (idx ? 61.550842 : 0.0), pagePositionY + 112.300003 + (textdrawId/2 % 4 or (textdrawId/2 >= 4 && !(textdrawId/2 % 4)) ? (33.950012 * i) : 0.0), !"LD_SPAC:white");
                            PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][24 + textdrawId], 0.480000, 1.120000);
                            PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][24 + textdrawId], 58.550858, 30.950008);
                            PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][24 + textdrawId], 1);
                            PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][24 + textdrawId], textdrawId/2 < 4 ? 0xBFAE56FF : 0xBF5656FF);
                            PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][24 + textdrawId], 0);
                            PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][24 + textdrawId], 0x80808080);
                            PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][24 + textdrawId], 2);
                            PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][24 + textdrawId], 0);
                            PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][24 + textdrawId], 0x000000FF);
                            PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][24 + textdrawId], 4);
                            PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][24 + textdrawId], 1);
                            PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][24 + textdrawId], 1);

                            InventoryTextdraw[playerid][24 + textdrawId + 1] = CreatePlayerTextDraw(playerid, leftPagePositionX - 124.401703 + (idx ? 61.550842 : 0.0) + 29.275421, pagePositionY + 112.300003 + (textdrawId/2 % 4 or (textdrawId/2 >= 4 && !(textdrawId/4 % 2)) ? (33.950012 * i) : 0.0) + 10.192047, FixText(buttonName[textdrawId / 2][SettingData[playerid][sdLanguage]]));
                            PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0.188333, 1.056592);
                            PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 1280.000000, 1280.000000);
                            PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 2);
                            PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0xFFFFFFFF);
                            PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0);
                            PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0x80808080);
                            PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0);
                            PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0);
                            PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0x00000000);
                            PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 2);
                            PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 1);
                            PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][24 + textdrawId + 1], 0);

                            if(textdrawId/2 >= 6)
                            {
                                InventoryTextdraw[playerid][40 + idx] = CreatePlayerTextDraw(playerid, leftPagePositionX - (idx ? 5.000031 : 66.550873), pagePositionY + 242.600037, !"usebox");
                                PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][40 + idx], 0.000000, -0.103300);
                                PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][40 + idx], idx ? 400.050842 : 338.500000, 0.000000);
                                PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][40 + idx], 1);
                                PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][40 + idx], 0xE1E1E1FF);
                                PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][40 + idx], 1);
                                PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][40 + idx], 0x111111FF);
                                PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][40 + idx], 2);
                                PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][40 + idx], 0);
                                PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][40 + idx], 0x000000FF);
                                PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][40 + idx], 0);
                                PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][40 + idx], 1);
                                PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][40 + idx], 0);
                            }
                        }
                    }
                }
                else
                {
                    for(new i; i < 2; i++)
                    {
                        InventoryTextdraw[playerid][11 + i * 2] = CreatePlayerTextDraw(playerid, 341.000000, !i ? 130.600006 : 140.420013, !i ? "hud:radar_centre" : "hud:radar_SWEET");
                        PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][11 + i * 2], 0.480000, 1.120000);
                        PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][11 + i * 2], 7.889803, 6.820000);
                        PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][11 + i * 2], 1);
                        PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][11 + i * 2], 0xFFFFFFFFFFFFFFFF);
                        PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][11 + i * 2], 0);
                        PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][11 + i * 2], 0xFFFFFFFF80808080);
                        PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][11 + i * 2], 2);
                        PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][11 + i * 2], 0);
                        PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][11 + i * 2], 0x000000FF);
                        PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][11 + i * 2], 4);
                        PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][11 + i * 2], 1);
                        PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][11 + i * 2], 1);

                        InventoryTextdraw[playerid][11 + i * 2 + 1] = CreatePlayerTextDraw(playerid, 388.240662, !i ? 132.782013 : 142.602020, "usebox");
                        PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 0.000000, 0.279798);
                        PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 348.889801, 0.000000);
                        PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 1);
                        PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 0xFFFFFFFFE1E1E1FF);
                        PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 1);
                        PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 0x6C7B9570);
                        PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 2);
                        PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 0);
                        PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 0x000000FF);
                        PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 0);
                        PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 1);
                        PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][11 + i * 2 + 1], 0);

                        InventoryTextdraw[playerid][11 + i * 2 + 2] = CreatePlayerTextDraw(playerid, !i ? 354.175262 : 385.316589, !i ? 132.782013 : 142.602020, "usebox");
                        PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 0.000000, 0.279798);
                        PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 348.889801, 0.000000);
                        PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 1);
                        PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 0xFFFFFFFFE1E1E1FF);
                        PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 1);
                        PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], !i ? 0x56BF4CFF : 0x407088FF);
                        PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 2);
                        PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 0);
                        PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 0x000000FF);
                        PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 0);
                        PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 1);
                        PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][11 + i * 2 + 2], 0);
                    }

                    static const improveName[4][24] = {"POWER", "SUSTAINABILLITY", "VELOCITY", "MAX SPEED"};
                    static vehicleHandlingId[] = {11, 17, 10, 9};

                    for(new i; i < 4; i++) 
                    {
                        for(new idx; idx < 2; idx++)
                        {
  //                          if(idx)
//                                f(global_str, 6, "%1.f", vehicleModelInfo[SearchVehicleMassiveID(GetVehicleModelEx(GetPlayerVehicleID(playerid)))][vehicleHandlingData][vehicleHandlingId[i]] + VehicleInfo[GetPlayerVehicleID(playerid)][vHandling][vehicleHandlingId[i]] + (i == 1 ? 250.0 : 0.0));

                            global_str = "0.0";
                            
                            InventoryTextdraw[playerid][17 + i * 4 + idx] = CreatePlayerTextDraw(playerid, 401.203369 + (56.745789 * idx), 136.177917 + (16.848008 * i - (i == 1 ? 0.000016 : 0.0)), !idx ? improveName[i] : global_str);
                            PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0.089856, 0.539136);
                            PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 1280.000000, 1280.000000);
                            PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], idx ? 3 : 1);
                            PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0xFFFFFFFFFFFFFFFF);
                            PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0);
                            PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0xFFFFFFFF80808080);
                            PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0);
                            PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0);
                            PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0x00000000);
                            PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 2);
                            PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 1);
                            PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx], 0);

                            InventoryTextdraw[playerid][17 + i * 4 + idx + 2] = CreatePlayerTextDraw(playerid, !idx ? 459.249146 : 414.084137, 143.743195 + (16.848007 * i - (i == 1 ? 0.000015 : 0.0)), "usebox");
                            PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 0.000000, 0.319860);
                            PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 399.703369, 0.000000);
                            PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 1);
                            PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 0xE1E1E1FF);
                            PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 1);
                            PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], !idx ? 0x555555FF : 0x4287C0FF);
                            PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 2);
                            PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 0);
                            PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 0x000000FF);
                            PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 0);
                            PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 1);
                            PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][17 + i * 4 + idx + 2], 0);
                        }
                    }

                    static const titleName[2][2][32] = {{"TECHNICAL MODIFICATION", "VISUAL MODIFICATION"}, {"“≈’Õ»◊≈— »≈ ÃŒƒ»‘» ¿÷»»", "¬»«”¿À‹Õ€≈ ÃŒƒ»‘» ¿÷»»"}};

                    for(new i; i < 2; i++)
                    {
                        InventoryTextdraw[playerid][33 + i] = CreatePlayerTextDraw(playerid, 337.522034, 213.774292 + (i == 1 ? 69.399994 : 0.0), FixText(titleName[SettingData[playerid][sdLanguage]][i]));
                        PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][33 + i], 0.150558, 0.752790);
                        PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][33 + i], 1280.000000, 1280.000000);
                        PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][33 + i], 1);
                        PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][33 + i], 0xFFFFFFFF);
                        PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][33 + i], 0);
                        PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][33 + i], 0x80808080);
                        PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][33 + i], 0);
                        PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][33 + i], 0);
                        PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][33 + i], 0x00000000);
                        PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][33 + i], 2);
                        PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][33 + i], 1);
                        PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][33 + i], 0);
                    }
                }
            }
        }
    }
    else
    {
        if(RequestInventoryType[playerid] == InventoryTrade)
        {
            for(new idx, Float:textdrawPositionFix[][] = { {29.464295, 30.464295, 70.049988, 3.0, 69.049988, 66.049988, 8.70633}, {27.600006, 28.600006, 29.799896, 110.457153, 109.957153, 111.541565, 111.541565} }; idx < 2; idx++)
            {
                for(new i; i < 7; i++)
                {
                    InventoryOtherTextdraw[playerid][1 + idx * 7 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - textdrawPositionFix[0][i], pagePositionY + textdrawPositionFix[1][i] + (98.968262 * idx), 5 <= i <= 6 ? !"_" : i == 4 ? !"LD_SPAC:white" : i == 2 ? PN(InventoryPlayerTrade[!idx ? playerid : InventoryPlayerTrade[playerid][TradePlayer]][TradePlayer]) : !"usebox");
                    PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], !i or i == 1 or i == 3 ? 0.000000 : i == 2 ? 0.157607 : i == 4 ? 0.480000 : 0.170318, !i ? 1.543614 : i == 1 ? 1.321914 : i == 2 ? 0.945736 : i == 3 ? 1.128367 : i == 4 ? 1.120000 : 0.794228);
                    PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], !i ? 209.464294 : i == 1 ? 210.464294 : i == 2 or i >= 5 ? 1280.000000 : i == 3 ? 248.750000 : 63.750000, i == 2 or i >= 5 ? 1280.000000 : i == 4 ? 11.111111 : 0.000000);
                    PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], i == 2 ? 2 : i == 6 ? 3 : 1);
                    PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], !i or i == 1 or i == 3 ? 0xE1E1E1FF : i == 2 ? 0xFFFFFFFF : i == 4 ? 0x000000FF : 0x67B355FF);
                    PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], 0 <= i <= 1 or i == 3 ? 1 : 0);
                    PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], !i or i == 3 ? 0x222222FF : i == 1 ? 0x000000FF : 0x80808080);
                    PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], !i or i == 1 or i == 3 or i == 4 ? 2 : 0);
                    PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], 0);
                    PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], i == 2 or i == 5 or i == 6 ? 0x00000000 : 0x000000FF);
                    PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], i == 4 ? 4 : i == 2 or 5 <= i <= 6 ? 2 : 0);
                    PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], 1);
                    PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][1 + idx * 7 + i], i == 4 && idx == 0 ? 1 : 0);
                }
            }

            static const buttonName[3][2][12] = {{"CONFIRM", "œŒƒ“¬≈–ƒ»“‹"}, {"INFORMATION", "»Õ‘Œ–Ã¿÷»ﬂ"}, {"CANCEL", "Œ“Ã≈Õ¿"}};
            for(new i; i < 6; i++)
            {
                InventoryOtherTextdraw[playerid][15 + i] = CreatePlayerTextDraw(playerid, 184.500000 + (44.5 * (i / 2)) + (i % 2 ? 21.25 : 0.0), 369.695251 + (i % 2 ? 3.250275 : 0.0), i % 2 ? FixText(buttonName[i / 2][SettingData[playerid][sdLanguage]]) : !"LD_SPAC:white");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 0.134524 : 0.480000, i % 2 ? 0.754709 : 1.120000);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 1280.000000 : 42.500000, i % 2 ? 1280.000000 : 14.047619);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 2 : 1);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 0xFFFFFFFF : 0xBF5656FF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][15 + i], 0);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][15 + i], 0x80808080);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 0 : 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][15 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 0x00000000 : 0x000000FF);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 2 : 4);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][15 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][15 + i], i % 2 ? 0 : 1);
            }
        }
        else if(RequestInventoryType[playerid] == InventoryShop)
        {
            static Float:textdrawPositionFix[] = {34.044129, 103.755875, 94.467682, 56.176026, 46.887848, 70.049988};

            for(new i; i < 6; i++)
            {
                InventoryOtherTextdraw[playerid][1 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - textdrawPositionFix[i], pagePositionY + (!i ? 219.600006 : i == 1 or i == 3 ? 219.100006 : 226.578033), !i ? !"usebox" : i == 1 or i == 3 ? !"LD_SPAC:white" : i == 2 ? !"<" : i == 4 ? !">" : !"1");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][1 + i], i == 1 or i == 3 ? 0.480000 : !i ? 0.000000 : 0.125555, i == 1 or i == 3 ? 1.120000 : !i ? 2.335400 : 0.704395);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][1 + i], !i ? 214.044113 : i == 1 or i == 3 ? 19.831934 : 1280.000000, !i ? 0.000000 : i == 1 or i == 3 ? 22.000000 : 1280.000000);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][1 + i], i == 2 or i == 4 or i == 5 ? 2 : 1);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][1 + i], !i ? 0xE1E1E1FF : i == 1 or i == 3 ? 0x1A1A1AFF : 0x777777FF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][1 + i], !i ? 1 : 0);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][1 + i], !i ? 0x050505FF : 0x80808080);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][1 + i], i == 2 or i == 4 or i == 5 ? 0 : 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][1 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][1 + i], !i or i == 1 or i == 3 ? 0x000000FF : 0x00000000);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][1 + i], !i ? 0 : i == 1 or i == 3 ? 4 : 2);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][1 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][1 + i], i == 1 or i == 3 ? 1 : 0);
            }
        }
        else if(RequestInventoryType[playerid] == InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] != 1)
        {
            static Float:textdrawPositionFix[][] = { {0.0, 66.499985, 68.366654, 114.006668, 20.67331, 52.5, 17.5}, {26.51001, 59.906143, 61.772812, 41.250442, 41.250442, 90.762802, 106.476806} };

            for(new i; i < 7; i++)
            {
                InventoryOtherTextdraw[playerid][i] = CreatePlayerTextDraw(playerid, leftPagePositionX - textdrawPositionFix[0][i], pagePositionY + textdrawPositionFix[1][i], !"usebox");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][i], 0.000000, !i ? 0.642721 : i == 1 ? 1.744200 : i == 2 ? 1.330360 : i == 3 or i == 4 ? 4.845565 : i == 5 ? 1.068517 : 0.789814);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][i], !i ? 142.500000 : i == 1 ? 209.000000 : i == 2 ? 210.866669 : i == 3 ? 163.173325 : i == 4 ? 256.506683 : i == 5 ? 195.000000 : 160.000000, 0.000000);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][i], 1);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][i], 0xE1E1E1FF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][i], 1);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][i], !i or i == 2 ? 0x000000FF : i == 1 or i == 6 ? 0x333333FF : 0x00000000);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][i], 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][i], 0x000000FF);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][i], 0);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][i], 0);
            }

            for(new i; i < 2; i++)
            {
                InventoryOtherTextdraw[playerid][7 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - 157.040024, pagePositionY + 106.73677, !"LD_SPAC:WHITE");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][7 + i], 0.480000, 1.120000);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][7 + i], !i ? 136.480072 : 0.000000, 6.537024);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][7 + i], 1);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][7 + i], !i ? 0x000000FF : 0xBF5656FF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][7 + i], 0);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][7 + i], 0x80808080);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][7 + i], 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][7 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][7 + i], 0x000000FF);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][7 + i], 4);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][7 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][7 + i], 0);
            }

            for(new i; i < 4; i++)
            {
                InventoryOtherTextdraw[playerid][9 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - (i < 2 ? 35.0 : 35.880005), pagePositionY + (!i or i == 2 ? 106.476806 : i == 1 ? 113.516678 : 115.276642), !"usebox");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][9 + i], 0.000000, i < 2 ? 0.009444 : -0.185648);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][9 + i], i < 2 ? 177.500000 : 178.379974, 0.000000);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][9 + i], 1);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][9 + i], 0xE1E1E1FF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][9 + i], 1);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][9 + i], i < 2 ? 0x333333FF : 0x111111FF);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][9 + i], 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][9 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][9 + i], 0x000000FF);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][9 + i], 0);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][9 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][9 + i], 0);
            }

            static const buttonName[2][2][10] = { {"ENCHANT", "«¿“Œ◊»“‹"}, {"CLOSE", "«¿ –€“‹"} };
            for(new i; i < 4; i++)
            {
                InventoryOtherTextdraw[playerid][13 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - (i < 2 ? 134.635727 : 83.707138) + (i % 2 ? 20.371445 : 0.0), pagePositionY + 120.009887 + (i % 2 ? 3.844788 : 0.0), i % 2 ? FixText(buttonName[i/2][SettingData[playerid][sdLanguage]]) : "LD_SPAC:WHITE");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 0.148634 : 0.480000, i % 2 ? 0.833871 : 1.120000);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 1280.0 : 40.742882, i % 2 ? 1280.0 : 16.028282);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 2 : 1);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 0xFFFFFFFF : 0xBF5656FF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][13 + i], 0);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][13 + i], 0x80808080);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 0 : 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][13 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 0x00000000 : 0x000000FF);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 2 : 4);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][13 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][13 + i], i % 2 ? 0 : 1);
            }

            static Float:textdrawPositionFix_workshop[][] = { {170.299988, 88.799988, 88.799988, 149.170014, 28.429962}, {5.017044, 66.063522, 91.045822, 106.493255, 106.493255} };

            for(new i; i < 5; i++)
            {
                InventoryOtherTextdraw[playerid][17 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - textdrawPositionFix_workshop[0][i], pagePositionY + textdrawPositionFix_workshop[1][i], !i ? !"WORKSHOP" : "_");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][17 + i], !i ? 0.188333 : i == 1 ? 0.139601 : i == 2 ? 0.160513 : 0.125200, !i ? 1.056592 : i == 1 ? 0.783191 : i == 2 ? 0.900517 : 0.702403);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][17 + i], 1280.000000, 1280.000000);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][17 + i], !i ? 1 : 2);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][17 + i], 0xFFFFFFFF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][17 + i], 0);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][17 + i], 0x80808080);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][17 + i], 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][17 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][17 + i], 0x00000000);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][17 + i], 2);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][17 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][17 + i], 0);
            }

            InventoryOtherTextdraw[playerid][22] = CreatePlayerTextDraw(playerid, 270.529999, 142.452850, "LD_SPAC:WHITE");
            PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][22], 0.480000, 1.120000);
            PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][22], 43.750000, 12.980000);
            PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][22], 1);
            PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][22], 0xFFFFFFFFBF5656FF);
            PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][22], 0);
            PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][22], 0xFFFFFFFF80808080);
            PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][22], 2);
            PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][22], 0);
            PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][22], 0x000000FF);
            PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][22], 4);
            PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][22], 1);
            PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][22], 1);

            InventoryOtherTextdraw[playerid][23] = CreatePlayerTextDraw(playerid, 292.404999, 145.456100, SettingData[playerid][sdLanguage] ? FixText("»Õ‘Œ–Ã¿÷»ﬂ") : "INFORMATION");
            PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][23], 0.124300, 0.697351);
            PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][23], 1280.000000, 1280.000000);
            PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][23], 2);
            PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][23], 0xFFFFFFFFFFFFFFFF);
            PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][23], 0);
            PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][23], 0xFFFFFFFF80808080);
            PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][23], 0);
            PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][23], 0);
            PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][23], 0x00000000);
            PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][23], 2);
            PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][23], 1);
            PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][23], 0);

            InventoryOtherTextdraw[playerid][24] = CreatePlayerTextDraw(playerid, 231.500000, 185.162094, "_");
            PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][24], 0.160513, 0.900517);
            PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][24], 1280.000000, 1280.000000);
            PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][24], 2);
            PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][24], 0xFFFFFFFFFFFFFFFF);
            PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][24], 0);
            PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][24], 0xFFFFFFFF80808080);
            PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][24], 0);
            PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][24], 0);
            PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][24], 0x00000000);
            PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][24], 2);
            PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][24], 1);
            PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][24], 0);
        }
        else
        {
            for(new i; i < (RequestInventoryType[playerid] == InventoryWarehouse ? 3 : (trunk[playerid] != INVALID_VEHICLE_ID ? 1 : 6)); i++)
            {
                InventoryOtherTextdraw[playerid][1 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - (RequestInventoryType[playerid] == InventoryWarehouse ? 79.549988 : (trunk[playerid] != INVALID_VEHICLE_ID ? 70.049988 : 93.799988)) + (9.5 * i), pagePositionY + 212.600006, !"LD_BEAT:chit");
                PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][1 + i], 0.480000, 1.120000);
                PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][1 + i], 8.500000, 9.833333);
                PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][1 + i], 1);
                PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][1 + i], i == 0 ? 0xBF5656FF : 0x333333FF);
                PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][1 + i], 0);
                PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][1 + i], 0xFFFFFFFF80808080);
                PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][1 + i], 2);
                PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][1 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][1 + i], 0x000000FF);
                PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][1 + i], 4);
                PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][1 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][1 + i], 1);
            }

            InventoryOtherTextdraw[playerid][7] = CreatePlayerTextDraw(playerid, 185.677078, 368.626587, "");
            PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][7], 0.235416, 1.320740);
            PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][7], 185.677078, 13.207399);
            PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][7], 1);
            PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][7], 0x67B355FF);
            PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][7], 0);
            PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][7], 0xFFFFFFFF80808080);
            PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][7], 0);
            PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][7], 0);
            PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][7], 0x00000000);
            PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][7], 2);
            PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][7], 1);
            PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][7], 1);
        }
    }

    InventoryTextdraw[playerid][42] = CreatePlayerTextDraw(playerid, rightPagePositionX - 159.299957, pagePositionY + 5.017044, SettingData[playerid][sdLanguage] ? FixText("»Õ¬≈Õ“¿–‹") : "INVENTORY");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][42], 0.188333, 1.056592);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][42], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][42], 1);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][42], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][42], 0);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][42], 0x80808080);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][42], 0);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][42], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][42], 0x00000000);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][42], 2);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][42], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][42], 0);

    InventoryTextdraw[playerid][43] = CreatePlayerTextDraw(playerid, rightPagePositionX, pagePositionY + 23.599998, "usebox");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][43], 0.000000, -0.214150);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][43], leftPagePositionX + 0.200012, 0.000000);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][43], 1);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][43], 0xE1E1E1FF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][43], 1);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][43], 0xBF5656FF);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][43], 2);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][43], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][43], 0x000000FF);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][43], 0);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][43], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][43], 0);

    for(new i; i < 5; i++)
	{
		InventoryTextdraw[playerid][44 + i] = CreatePlayerTextDraw(playerid, rightPagePositionX - 107.049987 + (9.5 * i), pagePositionY + 212.600006, !"LD_BEAT:chit");
		PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][44 + i], 0.480000, 1.120000);
		PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][44 + i], 8.500000, 9.833333);
		PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][44 + i], 1);
		PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][44 + i], PI[playerid][pInvCell] <= 36 * i ? 0x1A1A1AFF : PI[playerid][pInvPage] == i ? 0xBF5656FF : 0x333333FF);
		PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][44 + i], 0);
		PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][44 + i], 0x80808080);
		PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][44 + i], 2);
		PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][44 + i], 0);
		PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][44 + i], 0x000000FF);
		PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][44 + i], 4);
		PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][44 + i], 1);
		PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][44 + i], PI[playerid][pInvCell] <= 36 * i ? 0 : 1);
	}

    if(RequestInventoryType[playerid] == InventoryWorkshop && INVENTORY_REQUEST_OPEN_TYPE[playerid] != 1)
    {
        InventoryOtherTextdraw[playerid][25] = CreatePlayerTextDraw(playerid, 168.033325, 182.280365, "LD_SPAC:white");
        PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][25], 0.480000, 1.120000);
        PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][25], 33.599998, 38.870586);
        PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][25], 1);
        PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][25], 0xFFFFFFFF999999FF);
        PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][25], 0);
        PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][25], 0xFFFFFFFF80808080);
        PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][25], 2);
        PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][25], 0);
        PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][25], 0x333333FF);
        PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][25], 5);
        PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][25], 1);
        PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][25], 0);
        PlayerTextDrawSetPreviewModel(playerid, InventoryOtherTextdraw[playerid][25], 1649);
        PlayerTextDrawSetPreviewRot(playerid, InventoryOtherTextdraw[playerid][25], 0.000000, 0.000000, 90.000000, 2.000000);

        InventoryOtherTextdraw[playerid][26] = CreatePlayerTextDraw(playerid, 261.366699, 193.280365, "LD_SPAC:white");
        PlayerTextDrawLetterSize(playerid, InventoryOtherTextdraw[playerid][26], 0.480000, 1.120000);
        PlayerTextDrawTextSize(playerid, InventoryOtherTextdraw[playerid][26], 18.599998, 23.870586);
        PlayerTextDrawAlignment(playerid, InventoryOtherTextdraw[playerid][26], 1);
        PlayerTextDrawColor(playerid, InventoryOtherTextdraw[playerid][26], 0xFFFFFFFFFFFFFFFF);
        PlayerTextDrawUseBox(playerid, InventoryOtherTextdraw[playerid][26], 0);
        PlayerTextDrawBoxColor(playerid, InventoryOtherTextdraw[playerid][26], 0xFFFFFFFF80808080);
        PlayerTextDrawSetShadow(playerid, InventoryOtherTextdraw[playerid][26], 2);
        PlayerTextDrawSetOutline(playerid, InventoryOtherTextdraw[playerid][26], 0);
        PlayerTextDrawBackgroundColor(playerid, InventoryOtherTextdraw[playerid][26], 0x333333FF);
        PlayerTextDrawFont(playerid, InventoryOtherTextdraw[playerid][26], 5);
        PlayerTextDrawSetProportional(playerid, InventoryOtherTextdraw[playerid][26], 1);
        PlayerTextDrawSetSelectable(playerid, InventoryOtherTextdraw[playerid][26], 1);
        PlayerTextDrawSetPreviewModel(playerid, InventoryOtherTextdraw[playerid][26], 16112);
        PlayerTextDrawSetPreviewRot(playerid, InventoryOtherTextdraw[playerid][26], 78.000000, 0.000000, 0.000000, 1.024500);
    }

    InventoryTextdraw[playerid][50] = CreatePlayerTextDraw(playerid, rightPagePositionX - 46.799987, pagePositionY + 225.43335, !"LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][50], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][50], 42.500000, 19.666666);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][50], 1);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][50], 0xBF5656FF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][50], 0);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][50], 0x80808080);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][50], 2);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][50], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][50], 0x000000FF);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][50], 4);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][50], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][50], 1);

    InventoryTextdraw[playerid][51] = CreatePlayerTextDraw(playerid, rightPagePositionX - 25.549987, pagePositionY + 229.983734, SettingData[playerid][sdLanguage] ? FixText("«¿ –€“‹") : !"CLOSE");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][51], 0.188333, 1.056592);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][51], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][51], 2);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][51], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][51], 0);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][51], 0x80808080);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][51], 0);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][51], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][51], 0x00000000);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][51], 2);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][51], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][51], 0);

    InventoryTextdraw[playerid][52] = CreatePlayerTextDraw(playerid, rightPagePositionX - 21.299987, pagePositionY + 0.966667, !"LD_BEAT:chit");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][52], 0.480000, 1.120000);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][52], 17.000000, 19.666666);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][52], 1);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][52], 0x111111FF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][52], 0);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][52], 0x80808080);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][52], 2);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][52], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][52], 0x000000FF);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][52], 4);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][52], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][52], 1);

    InventoryTextdraw[playerid][53] = CreatePlayerTextDraw(playerid, rightPagePositionX - 12.799987, pagePositionY + 5.517044, !"S");
    PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][53], 0.188333, 1.056592);
    PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][53], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][53], 2);
    PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][53], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][53], 0);
    PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][53], 0x80808080);
    PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][53], 0);
    PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][53], 0);
    PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][53], 0x00000000);
    PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][53], 2);
    PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][53], 1);
    PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][53], 0);

    if(RequestInventoryType[playerid] != InventoryTrade)
    {
        InventoryTextdraw[playerid][54] = CreatePlayerTextDraw(playerid, rightPagePositionX - 162.299957, pagePositionY + 225.43335, !"LD_SPAC:white");
        PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][54], 0.480000, 1.120000);
        PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][54], 42.500000, 19.666666);
        PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][54], 1);
        PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][54], 0xBF5656FF);
        PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][54], 0);
        PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][54], 0x80808080);
        PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][54], 2);
        PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][54], 0);
        PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][54], 0x000000FF);
        PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][54], 4);
        PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][54], 1);
        PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][54], 1);

        static buttonText[32];

        if(RequestInventoryType[playerid] == InventoryPlayer)
        {
            if(!(HouseEntered[playerid] == -1) && HouseEntered[playerid] + 50 == GetPlayerVirtualWorld(playerid) && GetString(HouseInfo[HouseEntered[playerid]][hOwner], PN(playerid))) 
                buttonText = (SettingData[playerid][sdLanguage] ? FixText("ÿ ¿‘") : "WAREHOUSE");

            else if(musorka[playerid] != -1)
                buttonText = (SettingData[playerid][sdLanguage] ? FixText("Ã”—Œ– ¿") : "TRASH");

            else if(IsPlayerInHisVehicle(playerid))
                buttonText = (SettingData[playerid][sdLanguage] ? FixText("¡¿√¿∆Õ» ") : "TRUNK");

            else
                buttonText = (SettingData[playerid][sdLanguage] ? FixText("Œ’–¿ÕÕ» »") : "SECURITY");
        }
        else
            buttonText = (SettingData[playerid][sdLanguage] ? FixText("»Õ¬≈Õ“¿–‹") : "INVENTORY");

        InventoryTextdraw[playerid][55] = CreatePlayerTextDraw(playerid, rightPagePositionX - 141.049957, pagePositionY + 231.040314, buttonText);
        PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][55], 0.150666, 0.845274);
        PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][55], 1280.000000, 1280.000000);
        PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][55], 2);
        PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][55], 0xFFFFFFFF);
        PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][55], 0);
        PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][55], 0x80808080);
        PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][55], 0);
        PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][55], 0);
        PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][55], 0x00000000);
        PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][55], 2);
        PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][55], 1);
        PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][55], 0);
    }

    if(RequestInventoryType[playerid] == InventoryPlayer)
    {
        if(!IsPlayerInHisVehicle(playerid))
        {
            for(new i; i < 8; i++)
            {
                InventoryTextdraw[playerid][56 + i] = CreatePlayerTextDraw(playerid, leftPagePositionX - 79.377472 + (22.667786 * (i % 3)) + (i > 5 ? 10.833893 : 0.0), pagePositionY + 29.100006 + (26.066666 * (i / 3)), !"LD_SPAC:white");
                PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][56 + i], 0.480000, 1.120000);
                PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][56 + i], 21.667797, 25.066668);
                PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][56 + i], 1);
                PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][56 + i], 0xFFFFFFFF);
                PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][56 + i], 0);
                PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][56 + i], 0x80808080);
                PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][56 + i], 2);
                PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][56 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][56 + i], 0x333333FF);
                PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][56 + i], 5);
                PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][56 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][56 + i], 1);
                InventoryUpdateSlot(playerid, i, 2, InventoryTextdraw[playerid][56 + i]);
                CreateSlotInformation(playerid, i, 2, InventoryTextdraw[playerid][56 + i], InventoryAcsBlockTextTextdraw[playerid][i], InventoryAcsBlockColorTextdraw[playerid][i], Float: {0.107488, 0.531073});
            }

            InventoryTextdraw[playerid][64] = CreatePlayerTextDraw(playerid, leftPagePositionX - 97.377472, pagePositionY + 86.633331, !"LD_SPAC:white");
            PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][64], 0.480000, 1.120000);
            PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][64], 17.000000, 19.666666);
            PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][64], 1);
            PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][64], 0xFFFFFFFFFFFFFFFF);
            PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][64], 0);
            PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][64], 0xFFFFFFFF80808080);
            PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][64], 2);
            PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][64], 0);
            PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][64], 0x333333FF);
            PlayerTextDrawFont(playerid, InventoryTextdraw[playerid][64], 5);
            PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][64], 1);
            PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][64], 1);
            InventoryUpdateSlot(playerid, 0, 22, InventoryTextdraw[playerid][64]),
			CreateSlotInformation(playerid, 0, 22, InventoryTextdraw[playerid][64], InventoryTextdraw[playerid][65], InventoryTextdraw[playerid][65], Float:{0.084333, 0.416667}, Float:{1280.0, 1280.0});
        }
        else
        {
            for(new i; i < 3; i++)
            {
                InventoryTextdraw[playerid][35 + i] = CreatePlayerTextDraw(playerid, !i ? 362.024231 : i == 1 ? 343.524231 : 380.524231, 188.133331, !"LD_SPAC:white");
                PlayerTextDrawLetterSize(playerid, InventoryTextdraw[playerid][35 + i], 0.480000, 1.120000);
                PlayerTextDrawTextSize(playerid, InventoryTextdraw[playerid][35 + i], 17.000000, 19.666666);
                PlayerTextDrawAlignment(playerid, InventoryTextdraw[playerid][35 + i], 1);
                PlayerTextDrawColor(playerid, InventoryTextdraw[playerid][35 + i], 0xFFFFFFFFFFFFFFFF);
                PlayerTextDrawUseBox(playerid, InventoryTextdraw[playerid][35 + i], 0);
                PlayerTextDrawBoxColor(playerid, InventoryTextdraw[playerid][35 + i], 0xFFFFFFFF80808080);
                PlayerTextDrawSetShadow(playerid, InventoryTextdraw[playerid][35 + i], 2);
                PlayerTextDrawSetOutline(playerid, InventoryTextdraw[playerid][35 + i], 0);
                PlayerTextDrawBackgroundColor(playerid, InventoryTextdraw[playerid][35 + i], 0x333333FF);
                PlayerTextDrawSetProportional(playerid, InventoryTextdraw[playerid][35 + i], 1);
                PlayerTextDrawSetSelectable(playerid, InventoryTextdraw[playerid][35 + i], 1);
                InventoryUpdateSlot(playerid, 20 + i, (i == 2 ? 36 : 19 - i), InventoryTextdraw[playerid][35 + i]);
                CreateSlotInformation(playerid, 20 + i, (i == 2 ? 36 : 19 - i), InventoryTextdraw[playerid][35 + i], InventoryCarBlockTextTextdraw[playerid][20 + i], InventoryCarBlockColorTextdraw[playerid][20 + i], Float:{0.08011, 0.416666}, Float:{640.0, 640.0});
            }

            for(new i, blockId; i < 4; i++)
            {
                for(new idx; idx < 5; idx++)
                {
                    blockId = idx + i * 5;

                    InventoryCarBlockTextdraw[playerid][blockId] = CreatePlayerTextDraw(playerid, leftPagePositionX - 126.140717 + (24.715943 * idx), pagePositionY + (blockId >= 10 ? 123.180008 : 192.580017) + (26.498993 * (i - (i > 1 ? 2 : 0))), !"LD_SPAC:white");
                    PlayerTextDrawLetterSize(playerid, InventoryCarBlockTextdraw[playerid][blockId], 0.480000, 1.120000);
                    PlayerTextDrawTextSize(playerid, InventoryCarBlockTextdraw[playerid][blockId], 23.727299, 25.439032);
                    PlayerTextDrawAlignment(playerid, InventoryCarBlockTextdraw[playerid][blockId], 1);
                    PlayerTextDrawColor(playerid, InventoryCarBlockTextdraw[playerid][blockId], 0xFFFFFFFF);
                    PlayerTextDrawUseBox(playerid, InventoryCarBlockTextdraw[playerid][blockId], 0);
                    PlayerTextDrawBoxColor(playerid, InventoryCarBlockTextdraw[playerid][blockId], 0x80808080);
                    PlayerTextDrawSetShadow(playerid, InventoryCarBlockTextdraw[playerid][blockId], 2);
                    PlayerTextDrawSetOutline(playerid, InventoryCarBlockTextdraw[playerid][blockId], 0);
                    PlayerTextDrawBackgroundColor(playerid, InventoryCarBlockTextdraw[playerid][blockId], 0x333333FF);
                    PlayerTextDrawSetProportional(playerid, InventoryCarBlockTextdraw[playerid][blockId], 1);
                    PlayerTextDrawSetSelectable(playerid, InventoryCarBlockTextdraw[playerid][blockId], 1);
                    InventoryUpdateSlot(playerid, blockId - (blockId > 9 ? 10 : 0), (0 <= blockId <= 9 ? 12 : 23), InventoryCarBlockTextdraw[playerid][blockId]);
                    CreateSlotInformation(playerid, blockId - (blockId > 9 ? 10 : 0), (0 <= blockId <= 9 ? 12 : 23), InventoryCarBlockTextTextdraw[playerid][blockId], InventoryCarBlockColorTextdraw[playerid][blockId]);
                }
            }
        }
    }