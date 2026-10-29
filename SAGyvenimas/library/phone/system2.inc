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

enum phone_system_name_return
{
    RETURN_DELETE_COUNT_TD,
    RETURN_SHOW_COUNT_TD
};

enum phone_system_data
{
    bool:ph_status,
    
    ph_PhoneNumber[13],
    ph_PhoneAppCall,

    ph_PhoneAppMenu,
    ph_PhoneAppAuction,
    ph_PhoneAppBiz, // (Auction By Coder Supreme)
    ph_PhoneAppCrypto, // Informacijos gavimas apie Kriptovaliuta

    ph_PhoneTimeBoard,
    ph_PhoneTimeMain,
    ph_PhoneTimeARZMob,
    ph_PhoneTimeARZMob2Etap,

    ph_PhoneInput,
    ph_PhoneBank,
    ph_PhoneMessage,
    ph_PhoneContacts,
    ph_PhoneARZMob,

    // Arizona Mobile RentCar
    ph_PhoneARZMobExit,
    ph_PhoneARZMobBalance,
    ph_PhoneARZMobBalanceInput,
    ph_PhoneARZMobFindAuto,
    ph_PhoneARZMobMyRent,
    ph_PhoneARZMobFindTD[5],
    Float:ph_PhoneARZMobFindTDSizeOne,
    ph_PhoneARZMobExit2,
    ph_PhoneARZMobAccept,
    //

    // Arizona VKCoin system phone {IsejimasId, KlickFarmId, pirma tema, antra, trecia, teksto }
    ph_PhoneVKCoinApp,
    ph_PhoneVKCoinKey[6]
    //
};

new PhoneData[][phone_system_data] =
{
    {true, {15,22,24,23,19,21,20,16,18,17,30,2,29}, 45, 34, 16, 2, 12, 56, 47, 46, 24, 4, 18, 41, 43, 49, 1, 15, 6, 31, 22, {61,16,15,13,5}, 0.63611818, 2, 8, 25, {19,12,17,16,15,13} }, // Iphone X
    {true, {18,25,27,26,22,24,23,19,21,20,33,5,32}, 50, 39, 19, 5, 15, 70, 47, 61, 38, 7, 21, 40, 51, 55, 5, 19, 10, 35, 26, {63,19,18,16,8}, 0.66269897, 5, 11, 28, {22,15,20,19,18,16} }, // Samsung Galaxy s10
    {true, {16,24,23,25,21,20,22,18,17,19,31,3,30}, 45, 47, 17, 3, 13, 55, 32, 51, 29, 5, 0, 41, 43, 50, 2, 16, 7, 32, 23, {57,17,16,14,6}, 0.63243285, 3, 9, 24, {20,13,18,17,16,14} }, // Xiaomi
    {true, {16,23,25,24,20,22,21,17,19,18,32,2,31}, 44, 46, 17, 3, 13, 56, 31, 52, 29, 5, 0, 40, 42, 51, 2, 16, 7, 32, 23, {57, 17, 16, 14, 6}, 0.63767131, 3, 9, 24, {20,13,18,17,16,14} }, // Google Pixel 3
    {true, {16,23,25,24,20,22,21,17,19,18,31,2,30}, 44, 46, 17, 3, 13, 55, 32, 52, 29, 5, 0, 40, 42, 49, 2, 16, 7, 32, 23, {60, 16, 15, 13, 6}, 0.63416377, 3, 8, 24, {20,13,18,17,16,14} } // Huawei P20 PRO
};

// {true, ItemId, {0,0,0,0,0,0,0,0,0,0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0, 0,}, 0.0, 0, 0, 0, {0,0,0,0,0,0} } // Shablon

new 
    PhoneColorById[] = {0x4286F4FF, 0xFFFFFFFF, 0x071D42FF, 0x14912DFF, 0x911414FF, 0xEFF2F2FF, 0xFAAC58FF, 0xFFFF00FF, 0xB70C95FF, 0x000000FF, 0xBE2D2DFF}, // zydras, baltas, melynas, zalias, raudonas, sidabrinis, oranzinis, auksinis, rozinis, juodas, tamsiai raudonas
    PlayerText:PhoneTD[MAX_PLAYERS][92] = {{PlayerText:-1, ...}, ...},
    PhoneOpen[MAX_PLAYERS],
    PhoneApp[MAX_PLAYERS],
    PhoneInput[MAX_PLAYERS][11],
    PhoneColor[MAX_PLAYERS],
    get_TDName[100];

stock ClickPhoneTD(playerid, PlayerText:playertextid)
{
    new phoneId = PhoneOpen[playerid];
		
	switch PhoneApp[playerid] do
	{
		case 0: {

			if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneAppCall]] *then
			{
				SCM(playerid, COLOR_LIGHTBLUE,"[Informacija] {FFFFFF}Valstybiniu tarnybu telefono numeriai:");
				SCM(playerid,-1,"{FFFFFF}1.{6495ED} 111 - {FFFFFF}Patikrinti telefono saskaita");
				SCM(playerid,-1,"{FFFFFF}2.{6495ED} 060 - {FFFFFF}Tikslaus laiko tarnyba");
				SCM(playerid,-1,"{FFFFFF}3.{6495ED} 911 - {FFFFFF}Policija");
				SCM(playerid,-1,"{FFFFFF}4.{6495ED} 912 - {FFFFFF}Greitoji pagalba");
				SCM(playerid,-1,"{FFFFFF}5.{6495ED} 913 - {FFFFFF}Taksi");
				SCM(playerid,-1,"{FFFFFF}6.{6495ED} 914 - {FFFFFF}Mechanikai");
				SCM(playerid,-1,"{FFFFFF}7.{6495ED} 8828 - {FFFFFF}Centrinio banko informacijos tarnyba");
				SCM(playerid,-1,"{FFFFFF}8.{6495ED} 997 - {FFFFFF}Gyvenamosios paskirties nekilnojamojo turto tarnyba (suzinoti namo savininka)");

				return CreatePhoneAPK(playerid, phoneId, 1);
			}

			else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneAppMenu]] *then
				return ShowPhoneMenu(playerid);

            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneAppCrypto]] *then
            {
              new minuite;
              gettime(_, minuite, _);
                
              return SPDF(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, !"Valiutos kursas (USD)", "{ffff00}Atnaujinta %d minuciu atgal\t \t \nBitcoin (BTC):\t$%d\t{31B404}[ Jus turite: %d BTC ]\n{cccccc}Litecoin (LTC):\t{cccccc}$1\t \n{cccccc}Ethereum (ETH):\t{cccccc}$1\t \nEURO:\t$%d\t", !"Uzdaryti", !"", minuite, bankbuybitcoin, GetCount(playerid, 1461), GLS[69]);
            }

			else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneAppAuction]] *then
			{
				global_str = "Namo №\tIki pabaigos\tDabartine kaina\tMinimalus statymas\n";
					
				for new i; i < MAX_HOUSES; i++ do
				{
					if HouseInfo[i][hAuction] *then
						f(global_str, sizeof global_str, "%sNamas №%d\t%s\t$%d\t$%d\n", global_str, i, Convert(HouseInfo[i][hAuctionTime]), HouseInfo[i][hAuctionMoney], HouseInfo[i][hAuctionCost][1]);
				}
					
				return SPD(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, !"Namai aukcione", global_str, !"Uzdaryti", !"");
			}

			else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneAppBiz]] *then
				return SPD(playerid, 9930, DIALOG_STYLE_LIST, !"{FFFFFF}Auction |{8C65E9} Meniu", !"{8C65E9}[1]{ffffff} Atidaryti aukcionu meniu\n{8C65E9}[2]{ffffff} Prideti lota i aukciona", !"Isrinkti", !"Uzdaryti");

			else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneBank]] *then
			{
                if !PI[playerid][pBankPass] *then
                    return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"{B03131}Jus negalite naudoti banka/bankomata.{FFFFFF}\nJus neturite banko korteles. Gauti ja galima\nLas Venturas banke, arba is banko darbuotojo!", !"Uzdaryti", !"");

                if !PI[playerid][pKlogin] *then
                    return SPD(playerid, 991, DIALOG_STYLE_INPUT, !"", !"{929290}Jus turite patvirtinti savo korteles PIN-koda.\nIveskite savo koda i eilute.", !"Priimti", !"Uzdaryti");
                
                return SPD(playerid, 6565, DIALOG_STYLE_LIST, !"", !"{FFFFFF}1. Pagrindines saskaitos likutis\n2. Asmeniniu {DBEF2A}saskaitu {FFFFFF}likutis\n3. Pervesti pinigus is pagrindines saskaitos\n4. Papildyti saskaita {DBEF2A}SIM{FFFFFF}", !"Priimti", !"Atsaukti");
            }

			else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneMessage]] *then
			{
				f(global_str, 400,"SELECT t.`Name`, t.`Namez`, t.`Text`, t.`read`, t.`time` FROM `phonemes` AS t JOIN (SELECT `Name`, `Text`, max(`time`) as `mtime` FROM `phonemes` WHERE `Namez`='%s' GROUP BY `Name`) as t1 ON t.`Name`= t1.`Name` AND t.`time` = t1.`mtime` ORDER BY t.`time` DESC;",PN(playerid));
                mysql_tquery(mysql, global_str, "ShowPlayerMessages", "d", playerid);
			}
				
            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneContacts]] *then
			{
				f(global_str, 400, "SELECT `phonebook`.`Namez`,`phonebook`.`Num`,`accounts`.`TelNum`,`accounts`.`Online_status`,`phonebook`.`Group` FROM `phonebook`,`accounts` WHERE `phonebook`.`Name` = '%s' AND `accounts`.`NickName`=`phonebook`.`Namez` ORDER BY `phonebook`.`Group` DESC", PN(playerid));
               	mysql_tquery(mysql, global_str, "MysqlShowContacts", "d", playerid);
			}

			else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMob]] *then
				return CreatePhoneAPK(playerid, phoneId, 2);

            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneVKCoinApp]] *then
                return CreatePhoneAPK(playerid, phoneId, 4), UpdateVKCoin(playerid);
		}

		case 1: {

			for new i; i < 13; i++ do {

				if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneNumber][i]] *then
				{
					if i <= 9 *then
					{							
						if strlen(PhoneInput[playerid]) > 10 *then
							return false; // Если 10 или более цифр - пошел нахуй!
							
						else
						{
							strcat(PhoneInput[playerid], IntToStr(i));
							PlayerTextDrawSetString(playerid, PhoneTD[playerid][PhoneData[phoneId][ph_PhoneInput]], PhoneInput[playerid]);
						}
					}
					else
					{
						switch i do
						{
							case 10: { // Skambucio knopke
								
								if strlen(PhoneInput[playerid]) < 2 *then
									return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Sis rysio tipas neprieinamas");

								else if GetString(PhoneInput[playerid], "138641249") *then // -1-1-1-1-1-1-1-1-1-1-1
								{
									if PI[playerid][pPhonePromo] *then
										return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus jau buvote gave {b03131}\"Slaptas bonusas\"");

									PI[playerid][pPhonePromo] = true;
										
									if PI[playerid][pVipTime] > Global_Time *then
										PI[playerid][pVipTime] += 610000;
									else
										PI[playerid][pVipTime] = Global_Time + 610000;

									GiveRoubles(playerid, 40);

									SPDF(playerid, 0, DIALOG_STYLE_MSGBOX, (str_f("{cccccc}Slaptas bonusas | {b03131}SAGyvenimas %s", Mode_City)), "{FFFFFF}Jus sekmingai ivedete {b03131}slapta promocode, {ffffff}kuri galima ivesti 1 karta per visa zaidima.\nJus gavote bonusa {b03131}\"Slaptas bonusas\".\n\n{FFFFFF}Jus gavote:\n{cccccc}— 40 SAG-EUR [/adonate]\n{cccccc}— %s VIP [Laikas: 21d.]\n\n{FFFFFF}Gero zaidimo {B03131}SAGyvenimas | %s", !"Uzdaryti", !"", Mode_City);

                                    if PI[playerid][pVIP] < 7 *then
                                        PI[playerid][pVIP] = 7;
                                        
									return SQL("update accounts SET `PromoPhone` = 1, `VIP` = '%d', `VipTime` = '%d' WHERE ID = %d;", PI[playerid][pVIP], PI[playerid][pVipTime], PI[playerid][pID]);	
								}

								else if GetString(PhoneInput[playerid], "60") || GetString(PhoneInput[playerid], "060") *then
								{
									new date[6]; //dataTime;
									getdate(date[0], date[1], date[2]);
   									Global_Time = gettime(date[3], date[4], date[5]);

									SPDF(playerid, 0, DIALOG_STYLE_MSGBOX, !"", "{FFFFFF}Sveiki!\nJus paskambinote i tikslaus laiko tarnyba\nSiandienos data: \t{2EA42E}%02d:%02d:%d{FFFFFF}\nDabartinis laikas: \t{345690}%02d:%02d:%02d\n\n\n", !"Uzdaryti", !"", date[2], date[1], date[0], date[3], date[4], date[5]);
								}
									
								else if GetString(PhoneInput[playerid], "8828") *then
									return SPDF(playerid, 0, DIALOG_STYLE_MSGBOX, !"", "Sveiki! Jus paskambinote i centrinio banko informacijos tarnyba!\n{FFE51A}EURO kursas {FFFFFF}%d$", !"Uzdaryti", !"", GLS[69]);
									
								else if GetString(PhoneInput[playerid], "997") *then
									return SPD(playerid, 15374, DIALOG_STYLE_INPUT, !"Nekilnojamojo turto tarnyba", !"{ffffff}Jus paskambinote i gyvenamosios paskirties turto tarnyba.\n\nPas mus galite suzinoti, kas siuo metu yra pasirinkto\ngyvenamojo nekilnojamojo turto savininkas.\nTam reikia zinoti namo numeri.\n\n{ffff00}Iveskite namo numeri:\n\n\n\n{cccccc}Atkreipkite demesi:\n- si informacija pasiekiama zaidejams nuo 15 lygio.\n- Suzinoti namo savininka galima ne dazniau kaip karta per 3 valandas.", !"Toliau", !"Uzdaryti");
										
								else 
									mysql_tquery(mysql, (str_f("SELECT `ID`, `Online_status`, `PlayerID` FROM accounts WHERE TelNum = %s;", PhoneInput[playerid])), "@CallingPhone", "ds", playerid, PhoneInput[playerid]);

								return true;
							}

							case 11: { // Istrinti simboli

								strdel(PhoneInput[playerid], strlen(PhoneInput[playerid]) - 1, strlen(PhoneInput[playerid]) );
								PlayerTextDrawSetString(playerid, PhoneTD[playerid][PhoneData[phoneId][ph_PhoneInput]], PhoneInput[playerid]);

							}

							case 12: // Knopke iseiti atgal i meniu!
								return CreatePhoneAPK(playerid, PhoneOpen[playerid]);
						}
					}
				}
			}

		}

        case 2: {
            
            if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMobExit]] *then
                return ClosePhoneTD(playerid);
            
            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMobBalance]] *then
                return SPDF(playerid, 25116, DIALOG_STYLE_MSGBOX, !"{28e1b9}SAGMobil", "{ffffff}Jusu dabartinis likutis: {33AA33}$%d", !"Uzdaryti", !"", PI[playerid][ArizonaMobileBalance]);
            
            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMobBalanceInput]] *then
                return SPD(playerid, 25117, DIALOG_STYLE_INPUT, !"{28e1b9}SAGMobil", !"{ffffff}Iveskite suma, kuria norite papildyti i savo saskaita:\n\n{28e1b9}Informacija:{ffffff}\n- Minimali suma papildymui $5000;\n- Papildant lesas, jos nurasomos nuo jusu banko saskaitos;\n- Po papildymo lesos negales buti grazintos atgal.", !"Papildyti", !"Atsaukti");
             
            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMobFindAuto]] *then
            {
                global_str = "{CCCCCC}Transporto pavadinimas\t{CCCCCC}Nuomos kaina\t{CCCCCC}Atstumas";
                
                if GetPlayerVirtualWorld(playerid) or GetPlayerInterior(playerid) *then
                    strcat(global_str, "\n{cccccc}Nepavyko rasti laisvu automobiliu nuomai netoliese!");
                
                else {

                    for new i, Float:distance, banId, bool:banIds[sizeof ArizonaMobile], Float:posVeh[3]; i < sizeof ArizonaMobile; i++ do
                    {
                        distance = 0.0;

                        for new z; z < sizeof ArizonaMobile; z++ do
                        {
                            if banIds[z] or !(ArizonaMobile[z][arzmob_PlayerId] == INVALID_PLAYER_ID) *then
                                continue;

                            GetVehiclePos(ArizonaMobile[z][arzmob_VehicleId], posVeh[0], posVeh[1], posVeh[2]);

                            if !distance *then
                                distance = GetPlayerDistanceFromPoint(playerid, posVeh[0], posVeh[1], posVeh[2]);

                            if distance >= GetPlayerDistanceFromPoint(playerid, posVeh[0], posVeh[1], posVeh[2]) *then
                                banId = z,
                                distance = GetPlayerDistanceFromPoint(playerid, posVeh[0], posVeh[1], posVeh[2]);
                        }

                        if !distance *then
                            break;

                        banIds[banId] = true;

                        spdList(playerid, i, banId);

                        strcat(global_str, (str_f("\n{28e1b9}[%d] {ffffff}%s (ID: %d)\t{33AA33}[ $%d / min ]\t{CCCCCC}[ %.2f m. ]", i + 1, GetVehicleName(ArizonaMobile[banId][arzmob_ModelId], true), ArizonaMobile[banId][arzmob_VehicleId], ArizonaMobile[banId][arzmob_CostRent], distance)));
                    }
                    
                }

                return SPD(playerid, 25114, DIALOG_STYLE_TABLIST_HEADERS, !"{28e1b9}Automobiliu paieska netoliese", global_str, !"Toliau", !"Atsaukti");
            }

            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMobMyRent]] *then
            {
                if ARZMobRent_player[playerid] == INVALID_DATA_ID *then
                    return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Siuo metu jus nesate issinuomoje jokios transporto priemones!");

                return SPDF(playerid, 25119, DIALOG_STYLE_MSGBOX, !"{28e1b9}SAGMobil", "{ffffff}Mano nuoma:\n- Automobilio pavadinimas: {28e1b9}%s (ID: %d){ffffff}\n- Nuoma iki: {28e1b9}%s", !"Pazymeti", !"Uzdaryti", GetVehicleName(ArizonaMobile[ARZMobRent_player[playerid]][arzmob_ModelId], true), ArizonaMobile[ARZMobRent_player[playerid]][arzmob_VehicleId], UNIX_TO_DATE(ArizonaMobile[ARZMobRent_player[playerid]][arzmob_TimeRent]));
            }
        }

        case 3: {

            if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMobExit2]] *then
                return ClosePhoneTD(playerid);
            
            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneARZMobAccept]] *then
                return SPD(playerid, 25118, DIALOG_STYLE_TABLIST_HEADERS, !"{28e1b9}Issirinkite nuomos laika", !"{CCCCCC}Nuomos laikas\t{CCCCCC}Nuomos kaina\n{28e1b9}[1] {ffffff}10 minuciu\t{33AA33}[ $15000 ]\n{28e1b9}[2] {ffffff}30 minuciu\t{33AA33}[ $45000 ]\n{28e1b9}[3] {ffffff}60 minuciu\t{33AA33}[ $90000 ]", !"Isrinkti", !"Atsaukti");
        }

        case 4: {

            if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneVKCoinKey][0]] *then
                return CreatePhoneAPK(playerid, phoneId);

            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneVKCoinKey][1]] *then
                return (PI[playerid][VKCoinBalance] += PI[playerid][VKCoin][0]), UpdateVKCoin(playerid);

            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneVKCoinKey][2]] *then
                return SPD(playerid, 25014, DIALOG_STYLE_LIST, !"{FFFFFF} TOP | {B1413D}VKoin", !"{FFFFFF}TOP {f4f142}serverio\n{FFFFFF}TOP {f4f142}SAGyvenimas", !"»", !"x");

            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneVKCoinKey][3]] *then
                return SPD(playerid, 25016, DIALOG_STYLE_LIST, !"{FFFFFF}Operacija  | {B1413D}VKoin", !"{FFFFFF}Ivykdyti {f4f142}operacija\n{FFFFFF}Operaciju {f4f142}istorija\n{FFFFFF}Iskeisti VK i {FF6347}daiktus", !"»", !"x");

            else if playertextid == PhoneTD[playerid][PhoneData[phoneId][ph_PhoneVKCoinKey][4]] *then
                return OpenVKCoinMenu(playerid);
        }
	}

    return true;
}

stock GetPhoneID(itemId) {
    
    switch itemId do {

        case 551, 1497,1498: 
            return 0; // iphone x
        
        case 422, 1499..1501:
            return 1; // Samsung Galaxy_S10

        case 329, 1476..1485:
            return 2; // Xiaomi
        
        case 382..389, 1473..1475:
            return 3; // Google Pixel 3
        
        case 1486..1496:
            return 4; // Huawei P20 PRO

    }

    return INVALID_DATA_ID;
}

stock ShowPhoneMenu(playerid)
{
    f(global_str, 550, "\
    {B03131}[1]{FFFFFF} Nustatymai\n\
    {B03131}[2]{FFFFFF} Laikmatis (Zadintuvas)\n\
    {B03131}[3]{FFFFFF} Numeriai/valstybes tarnautoju stebesena\n\
    {B03131}[4]{FFFFFF} Selfi{B03131}\n\
    {B03131}[5]{FFFFFF} Radijas[%s{FFFFFF}]\n\
    {B03131}[6]{FFFFFF} Patikrinti saskaita\n\
    {B03131}[7]{FFFFFF} Pervesti telefona i rezima \"%s\"\n\
    {B03131}[8]{FFFFFF} Patraukti telefona\n\
    %s", PlayerPlayed{playerid} ? ("{7def58}IJUNG") : ("{ef5858}ISJUNG"), PI[playerid][pTelWork] ? ("Iprastas") : ("Lektuvas"),
    !(FP_Data[playerid][F_FAMILY_ID] == -1) ?  (GetFamilyDataInt(FP_Data[playerid][F_FAMILY_ID], "brend") ? "\n{B03131}[9]{FFFFFF} Komercijos skyrius\n{B03131}[10]{FFFFFF} Nekilnojamojo turto skyrius":""): "");
    
    return SPD(playerid, 966, DIALOG_STYLE_LIST, !"Meniu", global_str, !"Priimti", !"Atsaukti");
}

stock GetPhoneMaxTDByAPK(phone, apkId, bool:get_max_count = false, RETURN_ID = RETURN_SHOW_COUNT_TD)
{
    switch apkId do
    {
        case -1:
        {
            switch phone do {

                case 0: return (!get_max_count ? 50:85);
                case 1: return (!get_max_count ? 56:90);
                case 2: return (!get_max_count ? 51:82);
                case 3: return (!get_max_count ? 52:83);
                case 4: return (!get_max_count ? 50:84);
            }
        }

        case 0, 1:
        {
            switch phone do 
            {

                case 0: return 50;
                case 1: return 56;
                case 2: return 51;
                case 3: return 52;
                case 4: return 50;
                
            }
        }

        case 2:
        {
            switch phone do 
            {

                case 0: return 83;
                case 1: return 86;
                case 2: return 79;
                case 3: return 80;
                case 4: return 83;
            }
        }

        case 3:
        {
            switch phone do 
            {

                case 0: return 62;
                case 1: return 64;
                case 2,3: return 58;
                case 4: return 61;
            }
        }

        case 4: 
        {
            switch phone do
            {
                case 0: return 22;
                case 1: return 25;
                case 2: return 23;
                case 3: return (RETURN_ID == _:RETURN_SHOW_COUNT_TD ? 23:29);
                case 4: return (RETURN_ID == _:RETURN_SHOW_COUNT_TD ? 23:28);
            }
        }
    }

    return INVALID_DATA_ID;
}

stock CreatePhoneAPK(playerid, phone, apk = 0)
{
    if PhoneOpen[playerid] == -1 *then
        return false; // Jeigu telefonas ne atidarytas, tai eikite nahui!

    PhoneApp[playerid] = apk;
    PhoneInput[playerid] = "";
    
    for new i; i < GetPhoneMaxTDByAPK(phone, apk, false, RETURN_DELETE_COUNT_TD); i++ do
        DestroyPlayerTD(playerid, PhoneTD[playerid][i]);

    CreatePhoneTD(playerid, phone, apk, 0, GetPhoneMaxTDByAPK(phone, apk));

    return PhoneTime_update(playerid);
}

stock ShowPhoneTD(playerid, phone)
{
    if !PhoneData[phone][ph_status] *then
        return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Sis telefono numeris laikinai deaktivuotas serverio administracijos!");

    PhoneOpen[playerid] = phone;

    CreatePhoneTD(playerid, phone, -1, GetPhoneMaxTDByAPK(phone, -1), GetPhoneMaxTDByAPK(phone, -1, true));

    return CreatePhoneAPK(playerid, phone);
}

stock CreatePhoneTD(playerid, phoneId, apkId, min_td, max_td)
{
    new IntData[11], Float:floatData[10], color = PhoneColorById[PhoneColor[playerid]];

    for new i = max_td - 1; i > min_td - 1; i-- do
    {
        GetPhoneTextDrawSettings(phoneId, apkId, color, i, floatData[0], floatData[1], floatData[2], floatData[3], floatData[4], floatData[5], IntData[0], IntData[1], IntData[2], IntData[3], IntData[4], 
        IntData[5], IntData[6], IntData[7], IntData[8], IntData[9], IntData[10], floatData[6], floatData[7], floatData[8], floatData[9]);

        PhoneTD[playerid][i] = CreatePlayerTextDraw(playerid, floatData[0], floatData[1], get_TDName);
        PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][i], floatData[2], floatData[3]);
        PlayerTextDrawTextSize(playerid, PhoneTD[playerid][i], floatData[4], floatData[5]);
        PlayerTextDrawAlignment(playerid, PhoneTD[playerid][i], IntData[0]);
        PlayerTextDrawColor(playerid, PhoneTD[playerid][i], IntData[1]);
        PlayerTextDrawUseBox(playerid, PhoneTD[playerid][i], IntData[2]);
        PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][i], IntData[3]);
        PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][i], IntData[4]);
        PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][i], IntData[5]);
        PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][i], IntData[6]);
        PlayerTextDrawFont(playerid, PhoneTD[playerid][i], IntData[7]);
        PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][i], IntData[8]);
        PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][i], IntData[9]);
        
        if IntData[10] *then
            PlayerTextDrawSetPreviewModel(playerid, PhoneTD[playerid][i], IntData[10]),
            PlayerTextDrawSetPreviewRot(playerid, PhoneTD[playerid][i], floatData[6], floatData[7], floatData[8], floatData[9]);
    
        ShowPlayerTD(playerid, PhoneTD[playerid][i]);
    }
}

stock ClosePhoneTD(playerid)
{
    for new i; i < 92; i++ do
        DestroyPlayerTD(playerid, PhoneTD[playerid][i]);
    
    switch PhoneApp[playerid] do
    {
        case 2:
        {
            ShowPhoneTD(playerid, PhoneOpen[playerid]);
            return SelectTextDraw(playerid, 0x852a18aa);
        }

        case 3:
        {
            CreatePhoneAPK(playerid, PhoneOpen[playerid], 2);
            return SelectTextDraw(playerid, 0x852a18aa); 
        }
    }

    return PhoneOpen[playerid] = INVALID_DATA_ID;
}

public: @CallingPhone(playerid, phone[])
{
    if !cache_get_row_count() *then
        return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"{B03131}Tokio numerio nera!", !"x", !"");

    new targetid = Phone_FindByNumber(strval(phone));
    if targetid == INVALID_PLAYER_ID *then
        return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"{B03131}Jusu abonentas yra uz tinklo aprepties zonos ribu!\n{FFFFFF}Galite palikti jam zinute, ir kai tik jis prisijungs prie tinklo, gales ja perskaityti.", !"x", !"");

    ClosePhoneTD(playerid);
    return Phone_StartCall(playerid, targetid);
}

stock PhoneTime_update(playerid) 
{
	new phoneId = PhoneOpen[playerid], apk = PhoneApp[playerid], hour, minuite, time[16];
	
    gettime(hour, minuite, _);
	f(time,16, "%02d:%02d", hour, minuite);

    switch apk do
    {
        case 0:  // Main
        {
            PlayerTextDrawSetString(playerid, PhoneTD[playerid][PhoneData[phoneId][ph_PhoneTimeBoard]], time);
            PlayerTextDrawSetString(playerid, PhoneTD[playerid][PhoneData[phoneId][ph_PhoneTimeMain]], time);
        }

        case 1: // Calling
            PlayerTextDrawSetString(playerid, PhoneTD[playerid][PhoneData[phoneId][ph_PhoneTimeBoard]], time);
        case 2: // Mobile
            PlayerTextDrawSetString(playerid, PhoneTD[playerid][PhoneData[phoneId][ph_PhoneTimeARZMob]], time);
        case 3:
            PlayerTextDrawSetString(playerid, PhoneTD[playerid][PhoneData[phoneId][ph_PhoneTimeARZMob2Etap]], time);
    }

    return true;
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
        case 18865: Color = "oranzinis";
        case 18866: Color = "zydras";
        case 18867: Color = "raudonas";
        case 18868: Color = "juodas";
        case 18869: Color = "rozinis";
        case 18870: Color = "tams raudonas";
        case 18871: Color = "zalias";
        case 18872: Color = "melynas";
        case 18873: Color = "auksinis";
        case 18874: Color = "baltas";
        case 19513: Color = "sidabrinis";

        default: Color = "none";
    }

    return Color;
}

stock ShowPlayerBuyPhone(playerid, bool:update = true)
{
    if update *then {

        PhoneBuyData[playerid] = -1;
    }


    format(global_str, 300, "\
    {FFFFFF}Pavadinimas\t{FFFFFF}Rodymas\n\
    Modelis:\t%s\n\
    {FFFFFF}Spalva:\t%s\n\
    {FFFFFF}Nusipirkti:\t{73B461}${FFFFFF}%d", 
    !(PhoneBuyData[playerid] == -1) ? (str_f("%s", ItemsInfo[PhoneBuyData[playerid]][ItemNameLavka])):"Isrinkti", 
    !(PhoneBuyData[playerid] == -1) && !GetString(GetPhoneColorNameByModel(ItemsInfo[PhoneBuyData[playerid]][ItemModel]), "baltas") ? 
    GetPhoneColorNameByModel(ItemsInfo[PhoneBuyData[playerid]][ItemModel]):"Standartinis", 
    !(PhoneBuyData[playerid] == -1) ? (PhoneShop[gpdList(playerid, 0)][shop_phoneCost] + (!GetString(GetPhoneColorNameByModel(ItemsInfo[PhoneBuyData[playerid]][ItemModel]), "baltas") ? 2000:0)):0);


    return SPD(playerid, 2000, DIALOG_STYLE_TABLIST_HEADERS, !"{FFFFFF}Apibrezimas | {ae433d}Mobilusis irenginys", global_str, !"»", !"«");
}

//
#include ../library/phone/tdsettings2 // TEXTDRAWE NUSTATYMAI
