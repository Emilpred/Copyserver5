    ColorsChangeTD[playerid][0] = CreatePlayerTextDraw(playerid, 144.0000, 137.1428, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][0], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][0], 175.0000, 140.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][0], 286331391);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][0], 0);

    ColorsChangeTD[playerid][1] = CreatePlayerTextDraw(playerid, 144.0000, 161.1428, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][1], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][1], 175.0000, 1.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][1], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][1], 0);

    ColorsChangeTD[playerid][2] = CreatePlayerTextDraw(playerid, 186.3000, 202.8036, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][2], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][2], 21.0000, 2.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][2], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][2], 0);

    ColorsChangeTD[playerid][3] = CreatePlayerTextDraw(playerid, 104.9997, 137.1427, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][3], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][3], 36.0000, 140.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][3], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][3], 286331391);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][3], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][3], 0);

    ColorsChangeTD[playerid][4] = CreatePlayerTextDraw(playerid, 105.6666, 162.3428, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][4], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][4], 35.0000, -1.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][4], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][4], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][4], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][4], 0);

    ColorsChangeTD[playerid][5] = CreatePlayerTextDraw(playerid, 122.6666, 143.9555, !SettingData[playerid][sdLanguage] ? "COLOR" : FixText("÷¬≈“")); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][5], 0.1949, 1.2180);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][5], 1280.0000, 1280.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][5], 2);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][5], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][5], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][5], 0);

    ColorsChangeTD[playerid][6] = CreatePlayerTextDraw(playerid, 165.3332, 143.9555, !SettingData[playerid][sdLanguage] ? "PAINTING" : FixText("œŒ –¿—»“‹")); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][6], 0.1949, 1.2180);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][6], 1280.0000, 1280.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][6], 2);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][6], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][6], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][6], 0);

    ColorsChangeTD[playerid][7] = CreatePlayerTextDraw(playerid, 281.3333, 144.7852, !SettingData[playerid][sdLanguage] ? "INFORMATION" : FixText("»Õ‘Œ–Ã¿÷»ﬂ")); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][7], 0.1823, 0.9290);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][7], 65.0000, 1.1282);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][7], 2);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][7], -1);
    PlayerTextDrawUseBox(playerid, ColorsChangeTD[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid, ColorsChangeTD[playerid][7], 16777216);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][7], 91);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][7], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][7], 0);

    ColorsChangeTD[playerid][8] = CreatePlayerTextDraw(playerid, 207.6665, 257.6148, !SettingData[playerid][sdLanguage] ? "PAINT" : FixText(" –¿—»“‹")); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][8], 0.1490, 0.8751);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][8], 54.0000, 1.1282);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][8], 2);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][8], -1);
    PlayerTextDrawUseBox(playerid, ColorsChangeTD[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, ColorsChangeTD[playerid][8], 16777216);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][8], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][8], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][8], 0);

    ColorsChangeTD[playerid][9] = CreatePlayerTextDraw(playerid, 256.3330, 257.2000, !SettingData[playerid][sdLanguage] ? "CANCEL" : FixText("«¿ –€“‹")); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][9], 0.1490, 0.8751);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][9], 54.0000, 1.1282);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][9], 2);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][9], -1);
    PlayerTextDrawUseBox(playerid, ColorsChangeTD[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, ColorsChangeTD[playerid][9], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][9], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][9], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][9], 0);

    ColorsChangeTD[playerid][10] = CreatePlayerTextDraw(playerid, 257.7333, 203.1183, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][10], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][10], 21.0000, 2.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][10], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][10], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][10], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][10], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][10], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][10], true);

    ColorsChangeTD[playerid][11] = CreatePlayerTextDraw(playerid, 216.4001, 215.5630, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][11], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][11], 33.0000, 2.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][11], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][11], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][11], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][11], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][11], 0);

    ColorsChangeTD[playerid][12] = CreatePlayerTextDraw(playerid, 254.0000, 141.7259, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][12], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][12], 54.0000, 16.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][12], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][12], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][12], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][12], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][12], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][12], true);

    ColorsChangeTD[playerid][13] = CreatePlayerTextDraw(playerid, 185.9998, 253.7259, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][13], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][13], 44.0000, 16.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][13], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][13], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][13], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][13], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][13], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][13], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][13], 0);

    ColorsChangeTD[playerid][14] = CreatePlayerTextDraw(playerid, 235.0000, 253.7259, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][14], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][14], 44.0000, 16.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][14], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][14], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][14], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][14], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][14], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][14], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][14], true);

    ColorsChangeTD[playerid][15] = CreatePlayerTextDraw(playerid, 107.2994, 176.1555, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][15], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][15], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][15], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][15], -858993409);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][15], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][15], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][15], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][15], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][15], true);

    ColorsChangeTD[playerid][16] = CreatePlayerTextDraw(playerid, 124.3294, 176.1555, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][16], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][16], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][16], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][16], -870045953);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][16], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][16], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][16], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][16], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][16], true);

    ColorsChangeTD[playerid][17] = CreatePlayerTextDraw(playerid, 107.2994, 193.5554, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][17], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][17], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][17], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][17], -864541441);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][17], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][17], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][17], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][17], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][17], true);

    ColorsChangeTD[playerid][18] = CreatePlayerTextDraw(playerid, 124.3294, 193.5554, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][18], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][18], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][18], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][18], -423878913);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][18], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][18], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][18], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][18], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][18], true);

    ColorsChangeTD[playerid][19] = CreatePlayerTextDraw(playerid, 107.2994, 210.9555, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][19], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][19], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][19], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][19], -707314433);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][19], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][19], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][19], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][19], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][19], true);

    ColorsChangeTD[playerid][20] = CreatePlayerTextDraw(playerid, 124.3294, 210.9555, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][20], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][20], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][20], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][20], 1020739839);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][20], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][20], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][20], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][20], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][20], true);

    ColorsChangeTD[playerid][21] = CreatePlayerTextDraw(playerid, 107.2994, 228.3553, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][21], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][21], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][21], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][21], 1020778495);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][21], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][21], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][21], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][21], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][21], true);

    ColorsChangeTD[playerid][22] = CreatePlayerTextDraw(playerid, 124.3294, 228.3553, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][22], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][22], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][22], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][22], 1010751487);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][22], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][22], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][22], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][22], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][22], true);

    ColorsChangeTD[playerid][23] = CreatePlayerTextDraw(playerid, 107.2994, 245.7554, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][23], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][23], 15.0000, 15.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][23], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][23], -683879169);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][23], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][23], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][23], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][23], 0);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][23], true);

    ColorsChangeTD[playerid][24] = CreatePlayerTextDraw(playerid, 185.9996, 178.6443, "LD_SPAC:white"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][24], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][24], 21.0000, 25.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][24], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][24], -1717986817);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][24], 858993663);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][24], 5);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][24], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][24], 2);
    PlayerTextDrawSetPreviewModel(playerid, ColorsChangeTD[playerid][24], 11722);
    PlayerTextDrawSetPreviewRot(playerid, ColorsChangeTD[playerid][24], 333.0000, 347.0000, 0.0000, 1.0000);

    ColorsChangeTD[playerid][25] = CreatePlayerTextDraw(playerid, 206.1761, 198.5596, "0/7"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][25], 0.0833, 0.4237);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][25], 1280.0000, 1280.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][25], 3);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][25], 1995136682);
    PlayerTextDrawSetOutline(playerid, ColorsChangeTD[playerid][25], 1);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][25], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][25], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][25], 0);

    ColorsChangeTD[playerid][26] = CreatePlayerTextDraw(playerid, 216.3329, 178.6441, "LD_SPAC:white"); //  œ–≈ƒÃ≈“  Œ“Œ–€… Õ”∆ÕŒ œŒ –¿—»“‹
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][26], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][26], 33.0000, 37.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][26], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][26], -1);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][26], 858993663);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][26], 5);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][26], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][26], 2);
    PlayerTextDrawSetSelectable(playerid, ColorsChangeTD[playerid][26], 0);
    PlayerTextDrawSetPreviewModel(playerid, ColorsChangeTD[playerid][26], 1649);
    PlayerTextDrawSetPreviewRot(playerid, ColorsChangeTD[playerid][26], 0.0000, 0.0000, 90.0000, 0.6036);

    ColorsChangeTD[playerid][27] = CreatePlayerTextDraw(playerid, 257.6661, 178.6443, "LD_SPAC:white"); // ÚÓ˜ËÎ¸Ì˚È Í‡ÏÂÌ¸
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][27], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][27], 21.0000, 25.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][27], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][27], -1717986817);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][27], 858993663);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][27], 5);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][27], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][27], 2);
    PlayerTextDrawSetPreviewModel(playerid, ColorsChangeTD[playerid][27], 16112);
    PlayerTextDrawSetPreviewRot(playerid, ColorsChangeTD[playerid][27], 78.0000, 0.0000, 0.0000, 1.0245);

    ColorsChangeTD[playerid][28] = CreatePlayerTextDraw(playerid, 277.8427, 198.5596, "0/1"); // ÔÛÒÚÓ
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][28], 0.0833, 0.4237);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][28], 1280.0000, 1280.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][28], 3);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][28], 1995136682);
    PlayerTextDrawSetOutline(playerid, ColorsChangeTD[playerid][28], 1);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][28], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][28], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][28], 0);

    ColorsChangeTD[playerid][30] = CreatePlayerTextDraw(playerid, 207.9998, 222.1999, "LD_SPAC:white"); // œŒﬂ¬À≈Õ»≈ »Õ‘ Œ «¿“Œ◊ ≈ (4)
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][30], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][30], 50.0000, 12.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][30], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][30], 92);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][30], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][30], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][30], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][30], 0);

    ColorsChangeTD[playerid][31] = CreatePlayerTextDraw(playerid, 207.9998, 235.4739, "LD_SPAC:white"); // œŒﬂ¬À≈Õ»≈ »Õ‘ Œ «¿“Œ◊ ≈ (4)
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][31], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][31], 50.0000, 12.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][31], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][31], 92);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][31], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][31], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][31], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][31], 0);            
    
    ColorsChangeTD[playerid][32] = CreatePlayerTextDraw(playerid, 233.9998, 237.2888, "$50000"); // œŒﬂ¬À≈Õ»≈ »Õ‘ Œ «¿“Œ◊ ≈ (3)
    PlayerTextDrawLetterSize(playerid,  ColorsChangeTD[playerid][32], 0.1490, 0.8751);
    PlayerTextDrawTextSize(playerid,  ColorsChangeTD[playerid][32], 54.0000, 1.1282);
    PlayerTextDrawAlignment(playerid,  ColorsChangeTD[playerid][32], 2);
    PlayerTextDrawColor(playerid,  ColorsChangeTD[playerid][32], -1);
    PlayerTextDrawUseBox(playerid,  ColorsChangeTD[playerid][32], 1);
    PlayerTextDrawBoxColor(playerid,  ColorsChangeTD[playerid][32], 16777216);
    PlayerTextDrawBackgroundColor(playerid,  ColorsChangeTD[playerid][32], 255);
    PlayerTextDrawFont(playerid,  ColorsChangeTD[playerid][32], 2);
    PlayerTextDrawSetProportional(playerid,  ColorsChangeTD[playerid][32], 1);
    PlayerTextDrawSetShadow(playerid,  ColorsChangeTD[playerid][32], 0);

    ColorsChangeTD[playerid][33] = CreatePlayerTextDraw(playerid, 208.0001, 222.6145, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][33], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][33], 2.0000, 11.0000);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][33], 1);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][33], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][33], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][33], 4);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][33], 0);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][33], 0);

    ColorsChangeTD[playerid][34] = CreatePlayerTextDraw(playerid, 208.0000, 235.8885, "LD_SPAC:white"); // œŒﬂ¬À≈Õ»≈ »Õ‘ Œ «¿“Œ◊ ≈ (2)
    PlayerTextDrawLetterSize(playerid,  ColorsChangeTD[playerid][34], 0.4799, 1.1200);
    PlayerTextDrawTextSize(playerid,  ColorsChangeTD[playerid][34], 2.0000, 11.0000);
    PlayerTextDrawAlignment(playerid,  ColorsChangeTD[playerid][34], 1);
    PlayerTextDrawColor(playerid,  ColorsChangeTD[playerid][34], PI[playerid][pColorInv]);
    PlayerTextDrawBackgroundColor(playerid,  ColorsChangeTD[playerid][34], 255);
    PlayerTextDrawFont(playerid,  ColorsChangeTD[playerid][34], 4);
    PlayerTextDrawSetProportional(playerid,  ColorsChangeTD[playerid][34], 0);
    PlayerTextDrawSetShadow(playerid,  ColorsChangeTD[playerid][34], 0);

    ColorsChangeTD[playerid][35] = CreatePlayerTextDraw(playerid, 233.9998, 223.6000, !SettingData[playerid][sdLanguage] ? "CHANCE:5.0" : FixText("ÿ¿Õ—:5.0")); // œŒﬂ¬À≈Õ»≈ »Õ‘ Œ «¿“Œ◊ ≈ (5)
    PlayerTextDrawLetterSize(playerid, ColorsChangeTD[playerid][35], 0.1490, 0.8751);
    PlayerTextDrawTextSize(playerid, ColorsChangeTD[playerid][35], 54.0000, 1.1282);
    PlayerTextDrawAlignment(playerid, ColorsChangeTD[playerid][35], 2);
    PlayerTextDrawColor(playerid, ColorsChangeTD[playerid][35], -1);
    PlayerTextDrawUseBox(playerid, ColorsChangeTD[playerid][35], 1);
    PlayerTextDrawBoxColor(playerid, ColorsChangeTD[playerid][35], 16777216);
    PlayerTextDrawBackgroundColor(playerid, ColorsChangeTD[playerid][35], 255);
    PlayerTextDrawFont(playerid, ColorsChangeTD[playerid][35], 2);
    PlayerTextDrawSetProportional(playerid, ColorsChangeTD[playerid][35], 1);
    PlayerTextDrawSetShadow(playerid, ColorsChangeTD[playerid][35], 0);