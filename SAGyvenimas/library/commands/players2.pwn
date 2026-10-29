cmd:resettune(playerid)
{
	if !IsPlayerInAnyVehicle(playerid) *then
		return SCM(playerid, COLOR_GREY, !"[Klaida] Butina buti transporte!");
	if(!GetString(CarInfo[GetVehicleID(GetPlayerVehicleID(playerid))][cOwner], PN(playerid)))
		return SCM(playerid, COLOR_GREY, !"Turite sedeti asmeniniame transporte");
	SPD(playerid, 6885, DIALOG_STYLE_MSGBOX, "Patvirtinimas", "{ffffff}Ar tikrai norite pasalinti visa custom automobilio tuninga?\n\nKaina: {33aa33}10.000.000${ffffff}", "Taip", "Ne");
	return 1;
}
CMD:quest(playerid)
{
	global_str = "";
	new num;
	for new i; i < MAX_QUESTS; i++ do
	{
		if AcceptQuest[playerid][i] != 0 && QuestProgress[playerid][i] != 100 *then
		{
		    if QuestProgress[playerid][i]<QI[i][LastProgress] *then
				f(global_str, sizeof(global_str),"%s\n{FFFFFF}%s | {DA9815}Progresas: %d/%d", global_str, QI[i][QuestName], QuestProgress[playerid][i],QI[i][LastProgress]);
		    else if(QuestProgress[playerid][i] == 100) f(global_str, sizeof(global_str), "%s\n{FFFFFF}%s | {E81818}[Atlikta]", global_str, QI[i][QuestName]);
		    else f(global_str, sizeof(global_str), "%s\n{FFFFFF}%s | {DA9815}Progresas: {DA9E30}[Galima baigti]", global_str, QI[i][QuestName]);
			QuestShow[playerid][num]=i;
			num++;
		}
	}
	if strlen(global_str) > 0 *then
		SPD(playerid, 7650, 2, !"", global_str, !"Isrinkti", !"Uzdaryti");
	else SPD(playerid, 0, 0, !"", !"{ffffff}Jus neturite priimtu uzduociu!", !"Priimti", !"");
	return 1;
}
cmd:givebiz(playerid, params[])
{
    new giveplayerid;
    if(sscanf(params, "ud", giveplayerid)) return SCM(playerid, COLOR_GREY, !"Naudokite: /givebiz [ID/Name]");
    if(PI[playerid][pRank] < 9) return SCM(playerid,COLOR_RED,!"Pasiekiama tik lyderiui ir pavaduotojui!");
    if(!IsAtMafia(playerid) || !IsAtMafia(giveplayerid))return SCM(playerid, COLOR_GREY, !"Arba jus, arba tas, kam norite perduoti versla, nepriklauso mafijai!");
    if(giveplayerid == playerid) return SCM(playerid, COLOR_GREY, !"Jus negalite perduoti sau paciam!");
    if(!ProxDetectorS(5.0, playerid, giveplayerid, 1)) return SCM(playerid,COLOR_RED,!"Jus esate toli nuo zaidejo!");
    if(BizWarState > 0)return SCM(playerid,COLOR_GREY, !"Dabar kazkas turi susitikima, kol ji vyksta, negalite perduoti verslo!");
    for(new i = 1;i<OWNABLEBIZES;i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid,10.0,BizData[i][bEnter_X],BizData[i][bEnter_Y],BizData[i][bEnter_Z])) continue;
	    if(BizData[i][bKrasher] != PI[playerid][pMember]) return SCM(playerid,COLOR_GREY, !"Jus nekontroliuojate sio verslo!");
	    BizData[i][bKrasher] = PI[giveplayerid][pMember];
     	SCM(giveplayerid,COLOR_VALIK, !"Dabar jus kontroliuojate si versla!");
     	SCM(playerid,COLOR_VALIK, !"Jus perdavete savo versla!");
     	UpdateBusinessText(i,1);
	}
	f(global_str, 128,"Zaidejas %s perdave jums savo verslo kontrole!",PN(playerid));
	SCM(giveplayerid,COLOR_RED,global_str);
	return 1;
}
CMD:top(playerid) return SPD(playerid, 17300, DIALOG_STYLE_TABLIST_HEADERS, !"{ae433d}Serverio statistika", !"{FFFFFF}Pavadinimas\t{FFFFFF}Parametras\nLabdaros teikejai\t[{85bb65}Pinigai{FFFFFF}]\nGyventoju reputacija\t[{85bb65}Lygis{FFFFFF}]\nForbes\t[{85bb65}Grynieji{FFFFFF}]\nForbes\t[{85bb65}Pinigai banke{FFFFFF}]\nForbes\t[{85bb65}Pinigai indelyje{FFFFFF}]\nForbes\t[{85bb65}SAG-Coins{FFFFFF}]\nForbes\t[{85bb65}SAG-EUR{FFFFFF}]\n", !"В»", !"x");
cmd:buyvieta(playerid)
{
	if FP_Data[playerid][F_FAMILY_ID] == -1 *then
		return SCM(playerid, COLOR_OLDRED, "[Klaida] {FFFFFF}Jus nesate vienos is seimu narys!");
	if !GetFamilyAcces(PN(playerid), FP_Data[playerid][F_FAMILY_ID]) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Sis skydelis pasiekiamas tik lyderiui ir pavaduotojui!");
	if GetFamilySlot(playerid) >= 20 *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Jusu seima pasieke maksimalu vietu skaiciu!");
	return SPD(playerid,8028,DIALOG_STYLE_MSGBOX,"Vietu pirkimas","{ffffff}Ar tikrai norite nusipirkti +1 vieta seimos automobiliu aiksteleje?\n{ffffff}Paslaugos kaina: {ffff00} 10000 SAG-Coins","Nusipirkti","Atgal");
}
CMD:piss(playerid)
{
    if(PI[playerid][pVIP] < 6) return SCM(playerid, COLOR_GOLD, !"["Mode_City"] {FFFFFF}Komanda pasiekiama nuo SAG VIP!");
    SetPlayerSpecialAction(playerid,68);
    piss[playerid] = 1;
    return true;
}
CMD:phone(playerid)
{
	if(JailTSR[playerid] != -1 && !IsPlayerInRangeOfPoint(playerid, 3.0, 329.1646,2474.7715,1500.9797)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate derybu kambaryje!");
	if(PI[playerid][pCalling] != -1 || PI[playerid][pONPhoneTalk] > 0) return SelectTextDraw(playerid, -16776961);
	if(donateopen{playerid}) CloseDonateMenu(playerid);
	global_str = "{FFFFFF}Mobilusis irenginys\t{FFFFFF}Spalvu gama";
	new count;
	for new i; i < PI[playerid][pInvCell]; i++ do
	{
	  	if IsPhoneModel(ItemsInfo[Inventory[playerid][0][i]][ItemModel]) *then
	  	{
			strcat(global_str, (str_f("\n{FFFFFF}%s\t%s", ItemsInfo[Inventory[playerid][0][i]][ItemNameLavka], GetPhoneColorNameByModel(ItemsInfo[Inventory[playerid][0][i]][ItemModel]))));
			spdList(playerid, count, Inventory[playerid][0][i]);
			count ++;
		}
	}
	if !count *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite telefono!");
	return SPD(playerid, 31510, DIALOG_STYLE_TABLIST_HEADERS, !"{FFFFFF}Telefonai | {ae433d}Telefonai", global_str , !"В»", !"x");
}
CMD:unbomb(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(IsACop(playerid))
	{
		if(BreakBomb[playerid] == -1)
		{
			for(new i; i < MAX_BOMBS; i ++)
			{
			    if(BombInfo[i][bbCreated] && !BombInfo[i][bbBreak])
			    {
			    	if(IsPlayerInRangeOfPoint(playerid, 1.0, BombInfo[i][bbPos][0], BombInfo[i][bbPos][1], BombInfo[i][bbPos][2]))
			    	{
			    	    BombInfo[i][bbBreak] = true;
			    	    BreakBomb[playerid] = i;
			    	    ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 1, 1, 0, 0, 0, 1);
						CallTimeOutFunction("UnBombPlayer", 5000, false, "ii", playerid, i);
						TogglePlayerControllable(playerid,false);
			    	    break;
			    	}
			    }
			}
		}
	}
	return 1;
}
CMD:bomb(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(PI[playerid][pBomb] > 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 100.0, 265.9013,78.3257,1001.0391) || IsPlayerInRangeOfPoint(playerid, 100.0, 1468.6514,-1741.8002,13.5469)|| IsPlayerInRangeOfPoint(playerid, 100.0, 2388.1479,-1926.6962,13.5500)|| IsPlayerInRangeOfPoint(playerid, 100.0, 2587.1738,-1236.9465,1212.7019) ||
		IsPlayerInRangeOfPoint(playerid, 100.0, 1914.9935,177.8372,37.2813) || IsPlayerInRangeOfPoint(playerid, 100.0, 2571.9922,-1303.6332,1044.1250) || IsPlayerInRangeOfPoint(playerid, 100.0, 2065.4238,-1374.4506,1001.2960)|| IsPlayerInRangeOfPoint(playerid, 100.0, 1497.3561,-1281.8790,14.5419 ) ||
		IsPlayerInRangeOfPoint(playerid, 100.0, 1789.8708,-1897.3647,13.3965) || IsPlayerInRangeOfPoint(playerid, 100.0, 191.0939,-108.1999,1.5488) || IsPlayerInRangeOfPoint(playerid, 100.0, 760.6195,-1418.3060,13.6124) || IsPlayerInRangeOfPoint(playerid, 100.0, 1976.8551,-1965.9889,13.5825) || IsPlayerInRangeOfPoint(playerid, 35.0, 200.8742,-239.7395,1.5744) ||
		IsPlayerInRangeOfPoint(playerid, 100.0, 1392.5906,-2267.2756,13.5469) || IsPlayerInRangeOfPoint(playerid, 100.0, 2804.7432,-1448.3627,20.1999) || IsPlayerInRangeOfPoint(playerid, 70.0, 2817.6655,1289.3645,10.9609)|| IsPlayerInRangeOfPoint(playerid, 50.0, 1595.0094,1825.6066,10.8203)|| IsPlayerInRangeOfPoint(playerid, 50.0, 2235.1648,1628.0640,1006.1799) ||
		IsPlayerInRangeOfPoint(playerid, 50.0, -72.6627,30.2661,3.1172)) return SCM(playerid,COLOR_GREY, !"Jus negalite cia uzstatyti bomba!");
		new time;
		if(sscanf(params,"d",time)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /bomb [laikmatis (sek)]");
		if(time >= 10 && time <= 900)
		{
		    new bombid = MAX_BOMBS;
		    for(new i; i < MAX_BOMBS;i ++)
		    {
		        if(!BombInfo[i][bbCreated])
		        {
	                bombid = i;
	                break;
		        }
		    }
		    if(bombid < MAX_BOMBS)
		    {
		        new Float:X, Float:Y, Float:Z;
		        GetPlayerPos(playerid, X, Y, Z);
		        ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 1, 0, 0, 0, 1);
		        f(global_str, 128 ,"Jus uzstatete bomba. Laikmatis %s", Convert(time));
		        SCM(playerid, COLOR_LIME, global_str);
		        CreteBomb[playerid]=0;
		        RemovePlayerAttachedObject(playerid, 7);
		        BombInfo[bombid][bbCreated] = true;
		        BombInfo[bombid][bbTime] = time;
		        f(global_str, 128,"{FFFFFF} Bomba \n{FF9900}%s", Convert(time));
		        BombInfo[bombid][bbText] = CreateDynamic3DTextLabel(global_str, COLOR_WHITE, X, Y, Z, 10.0);
		        BombInfo[bombid][bbObject] = CreateDynamicObject(1252, X, Y, Z, 0, 0, 0);
		        BombInfo[bombid][bbPos][0] = X;
		        BombInfo[bombid][bbPos][1] = Y;
		        BombInfo[bombid][bbPos][2] = Z;
		        PI[playerid][pBomb] --;
		    }
		}
		else SCM(playerid, COLOR_GREY, !"Ne daugiau kaip 900 ir ne maziau kaip 10");
	}
	else SCM(playerid, COLOR_GREY, !"Jus neturite bombos");
	return 1;
}
cmd:createbomb(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
    if(!IsAtGang(playerid) && !IsAtMafia(playerid)) return SCM(playerid,COLOR_RED,!"Jus nesate nei gaujoje, nei mafijoje.");
	if(GetCount(playerid, 553)<900)return SCM(playerid,COLOR_RED,!"Jums truksta soviniu gamybai! (( 900 ))");
	if(PI[playerid][pBomb]>=1)return SCM(playerid,COLOR_RED,!"Jus jau padarete bomba!");
	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 2, 0, 0, 0, 0, 0);
	DeleteItem(playerid, 553, 900);
	CreteBomb[playerid]=30;
	SCM(playerid,COLOR_GREY, !"Jus pradejote daryti bomba.");
	return 1;
}

cmd:minvite(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
    if(!IsAtMafia(playerid)){
        return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate mafijos narys!");
    }
    if(isnull(params))
    {
        SCM(playerid, -1, !"Naudokite: /minvite [zaidejo ID]");
        return 1;
    }

    new
        targetid = strval(params);

    if(!IsPlayerConnected(targetid) || playerid == targetid)
    {
        SCM(playerid, -1, !"Sis zaidejas yra neprisijunges");
        return 1;
    }
    if(PI[playerid][pLevel] > 4)
    {
        SCM(playerid, -1, !"Sis zaidejas yra neprisijunges");
        return 1;
    }
    GetPlayerName(targetid, global_str, 25);
    strcat(global_str, "dabar prasineja jusu globoje.");
    SCM(playerid, -1, global_str);

    GetPlayerName(playerid, global_str, 25);
    strcat(global_str, "paeme jus i mafijos globa.");
    return SCM(targetid, -1, global_str);
}
cmd:mbiz(playerid)
{
	global_str = "";
    if(!IsAtMafia(playerid)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate mafijos narys");
    for(new i = 1;i<OWNABLEBIZES;i++)
	{
 		if(BizData[i][bKrasher] != PI[playerid][pMember] || strcmp(BizData[i][bOwner],"The State",true) == 0 ) continue;
		f(global_str, 3000,"{FFFFFF}%s Verslas:{42B02C} %s{FFFFFF}\t\t\tSavininkas{42B02C} %s{FFFFFF}\n",global_str,BizData[i][bName],BizData[i][bOwner]);
	}
	if strlen(global_str) *then return SPD(playerid,0,0,"Verslai",global_str, !"Uzdaryti","");
	return SPD(playerid,0,0,"Informacija","{FFFFFF}Siuo metu jus nekontroliuojate jokiu verslu!", !"Uzdaryti","");
}
cmd:bizwar(playerid)
{
    if(!IsAtMafia(playerid)) return SCM(playerid,COLOR_RED,!"Jus nesate mafijos narys");
    if(PI[playerid][pLeader] == 0 && PI[playerid][pRank] < 9) return SCM(playerid,COLOR_RED,!"Pasiekiama tik lyderiui ir pavaduotojui!");
    if(BizWarState > 0) return SCM(playerid,COLOR_RED,!"Jus dabar negalite surengti sio susitikimo!");
	for(new i = 1;i<OWNABLEBIZES;i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid,10.0,BizData[i][bEnter_X],BizData[i][bEnter_Y],BizData[i][bEnter_Z])) continue;
	    if(GetString(BizData[i][bOwner],"The State")) return SCM(playerid,COLOR_GREY, !"Sis verslas niekam nepriklauso!");
	    if(BizData[i][bKrasher] == PI[playerid][pMember]) return SCM(playerid,COLOR_GREY, !"Jus jau kontroliuojate si versla!");
	    if(RecoveryTime[PI[playerid][pMember]] > 0) return SCM(playerid,COLOR_GREY, !"Jus dar neatgavote jegu po paskutinio uzemimo!");
	    if(BizData[i][bKrasher] == 0)
	    {
			BizData[i][bKrasher] = PI[playerid][pMember];
	        SCM(playerid,COLOR_VALIK, !"Dabar jus kontroliuojate si versla!");
	        UpdateBusinessText(i,1);
	        RecoveryTime[PI[playerid][pMember]] = 1800;
	    }
	    else
	    {
	        if(RecoveryTime[BizData[i][bKrasher]] > 0) return SCM(playerid,COLOR_GREY, !"Priesiska organizacija dar neatgavo jegu!");
	        ClickBiz[playerid] = i;
	        SPD(playerid,9612,2,"Susitikimo vieta:","- Medienos pjovykla\n- Apleistas aerodromas\n- Ukis Fort Carson\n- Apleistas kaimas", !"Priimti", !"Atsaukti");
	    }
	}
    return 1;
}
CMD:setspawn(playerid)
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(PI[playerid][pDCTime]==1 && PI[playerid][pHouseKey]==-1)PI[playerid][pDCTime]=0;
	switch(PI[playerid][pDCTime])
	{
	    case 0: global_str = "{633169}Stotis{FFFFFF}";
	    case 1: global_str = "{33AA33}Namas{FFFFFF}";
	    case 2: global_str = "{33AA33}Organizacija{FFFFFF}";
	    case 4: global_str = "{33AA33}Priekaba{FFFFFF}";
	    case 5: global_str = "{33AA33}Viesbutis{FFFFFF}";
		case 6: global_str = "{33AA33}Seimos butas{FFFFFF}";
		case 7: f(global_str, 100, "{faac58}%.02f,%.02f,%.02f", PI[playerid][pPremiumPos][0], PI[playerid][pPremiumPos][1], PI[playerid][pPremiumPos][2]);
	}
	f(global_str, 500,"\
	Dabartine spawno vieta: %s\n\
	Nustatyti viesbuti spawno vieta\n\
	Nustatyti nama spawno vieta.\n\
	Nustatyti organizacija spawno vieta.\n\
	Nustatyti seimos buta spawno vieta.\n\
	Nustatyti stoti spawno vieta.\n\
	Nustatyti priekaba spawno vieta.", global_str);
	if PI[playerid][pVIP] >= 6 *then strcat(global_str, "\n{faac58}Nustatyti spawno vieta sioje vietoje.");
	return SPD(playerid, 1781, 2 , !"Pasirinkite spawno vieta", global_str, !"Priimti", !"Uzdaryti");
}
CMD:sms(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
    if(!PI[playerid][pTelNum])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite SIM korteles!");
	static const fmt_str[] = "SELECT t.`Name`, t.`Namez`, t.`Text`, t.`read`, t.`time` FROM `phonemes` AS t JOIN (SELECT `Name`, `Text`, max(`time`) as `mtime` FROM `phonemes` WHERE `Namez` = '%s' GROUP BY `Name`) as t1 ON t.`Name` = t1.`Name` AND t.`time` = t1.`mtime` ORDER BY t.`time` DESC;";
	f(global_str, 512, fmt_str, PN(playerid));
	mysql_tquery(mysql, global_str, "ShowPlayerMessages", "d", playerid);
	return 1;
}
CMD:namestore(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(sscanf(params, "s[24]", params[0]))
		return SCM(playerid, -1, !"/namestore [ Nick/ID ]");
	new
		oldname[MAX_PLAYER_NAME],
		data[16];
	if(strlen(params[0]) <= 3 && IsNums(params[0])) {
		new
			player_id = strval(params[0]);
		if(!IsPlayerConnected(player_id))
			return SCM(playerid, -1, !"/namestore [ Nick/ID ]");
		f(global_str, 150, "SELECT * FROM `nickname_history` WHERE `nh_owner` = '%d'", PI[player_id][pID]);
		new
			Cache:result = mysql_query(mysql, global_str),
			rows,
			fields;
		cache_get_data(rows,fields);
		if(!cache_get_row_count(mysql))
		{
			f(global_str, 25, "%s", PN(player_id));
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, global_str, !"Sis zaidejas nekeite savo Nick", !"OK", !"");
			SCM(playerid, -1, !"Sis zaidejas nekeite savo Nick");
		    cache_delete(result, mysql);
		}
		else
		{
			global_str = "Nicku istorija:";
			for(new ns = 0 ; ns < rows ; ns ++ )
			{
				cache_get_row(ns, 1, oldname, mysql, MAX_PLAYER_NAME);
				cache_get_row(ns, 2, data, mysql, 16);
				if(strlen(oldname) || strlen(data))
					f(global_str, 500, "%s\n{FFFF00}%s\t{FFFFFF}%s",global_str, oldname, data);
			}
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, PN(playerid), global_str, !"OK", !"");
		    cache_delete(result, mysql);
		}
	}
	else
	{
	    f(global_str, 150, "SELECT `ID` FROM `accounts` WHERE `NickName` = '%s'", params[0]);
		new Cache:result = mysql_query(mysql, global_str);
		if(cache_get_row_count(mysql))
		{
			new
				id = cache_get_row_int(0, 0, mysql);
		    f(global_str, 150, "SELECT * FROM `nickname_history` WHERE `nh_owner` = '%d'", id);
			new
				Cache:r_get_nick = mysql_query(mysql, global_str),
				rows,
				fields;
			cache_get_data(rows,fields);
			if(!cache_get_row_count(mysql))
			{
				f(global_str, 25, params[0]);
				SPD(playerid, 1488, DIALOG_STYLE_MSGBOX, global_str, !"Sis zaidejas nekeite savo Nick", !"OK", !"");
				SCM(playerid, -1, !"Sis zaidejas nekeite savo Nick");
			    cache_delete(r_get_nick, mysql);
			}
			else
			{
				global_str = "Nicku istorija:";
				for(new ns = 0 ; ns < rows ; ns ++ )
				{
					cache_get_row(ns, 1, oldname, mysql, MAX_PLAYER_NAME);
					cache_get_row(ns, 2, data, mysql, 16);
					if(strlen(oldname) || strlen(data))
						f(global_str, 500, "%s\n{FFFF00}%s\t{FFFFFF}%s",global_str, oldname, data);
				}
				SPD(playerid, 1488, DIALOG_STYLE_MSGBOX, params[0], global_str, !"OK", !"");
			    cache_delete(r_get_nick, mysql);
			}
		}
		else SCM(playerid, COLOR_GREY, !"Neteisingas Nick");
		cache_delete(result, mysql);
	}
	return 1;
}
CMD:buybiz(playerid)
{
	if !IsValidPassport(playerid) *then
		return SCM(playerid, COLOR_GREY , !"[Klaida] {FFFFFF}Jus neturite paso, ji galite gauti savivaldybeje");
	new value;
	for new i = 1; i < OWNABLEBIZES; i++ do
    {
        if IsPlayerInRangeOfPoint(playerid,2.0,BizData[i][bEnter_X],BizData[i][bEnter_Y],BizData[i][bEnter_Z]) *then
    	{
    	    value++;
        	if GetPlayerBizes(playerid) *then
        	{
		        if GetString(BizData[i][bOwner], "The State") *then
	     	    {
	     	        new money;
			 		switch BizData[i][bCostType] do
			 		{
			 			case 1: money = PI[playerid][pVirMoney];
			 			case 2: money = PI[playerid][pRoubles];
			 			case 3: money = GetCount(playerid, 589);
			 			default: money = PI[playerid][pMoney];
			 		}
			 		if(PI[playerid][pLevel] < 6) return SCM(playerid, COLOR_GREY, "[Klaida] Norint isigyti versla, reikalingas 6 lygis!");
					if money >= BizData[i][bCost] *then InfoBiz[playerid] = i, CreateCaptcha_BOT(playerid, 2);
		     	    else SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
     	        	break;
     	        }
              	else SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Sis verslas jau kazkam priklauso");
 	        }
			else
			{
				SCM(playerid, COLOR_RED, !"[Klaida] {ffffff}Jus negalite isigyti daugiau verslu! Pirkite patobulinima \"Verslininkas\", kad turetumete iki 5 verslu!");
                SCM(playerid, COLOR_RED, !"[Klaida] {ffffff}Arba pirkite patobulinima \"Septyni verslai\", kad galetumete tureti iki 7 verslu!");
			}
 	    }
    }
    if(value == 0) return SCM(playerid, COLOR_GREY, "[Klaida] Salia jusu nera ne vieno verslo!");
	return 1;
}
CMD:satiety(playerid, param[])
{
    if(!IsPlayerLogged{playerid}) return 0;
    switch(Fullness[playerid])
	{
	    case 0..10: global_str = "{E12525}labai alkanas{A6A9A7}";
	    case 11..50: global_str = "{F99C32}alkanas{A6A9A7}";
	    case 51..70: global_str = "{6ED947}siek tiek isalkote{A6A9A7}";
	    case 71..150: global_str = "{54C977}sotus{A6A9A7}";
	}
	f(global_str,250,"{A6A9A7}Siuo metu esate %s.\nJusu sotumas: {FFFFFF}%d/100.{A6A9A7}\n\n\nPripildyti sotumo galite uzkandineje.",global_str,Fullness[playerid]);
	SPD(playerid,0,0,!"",global_str, !"Uzdaryti","");
	return 1;
}
CMD:ffarm(playerid, param[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	switch(PI[playerid][pCustomSkills][1])
	{
	    case 0..499: global_str = "pradedanciuoju ukininku\n\n{928C85}Norint dirbti traktorininku, reikia: 500 ukininko tasku\nNorint dirbti kombainininku, reikia: 3200 ukininko tasku\nNorint dirbti purskiancio laukus pilotu, reikia: 7000 ukininko tasku.";
        case 500..3199: global_str = "traktorininku\n\n{36972E}Norint dirbti traktorininku, reikia: 500 ukininko tasku - [ Atrakinta ]\n{928C85}Norint dirbti kombainininku, reikia: 3200 ukininko tasku\nNorint dirbti purskiancio laukus pilotu, reikia: 7000 ukininko tasku.";
		case 3200..6999: global_str = "kombainininku\n\n{36972E}Norint dirbti traktorininku, reikia: 500 ukininko tasku - [ Atrakinta ]\nNorint dirbti kombainininku, reikia: 3200 ukininko tasku - [ Atrakinta ]\n{928C85}Norint dirbti purskiancio laukus pilotu, reikia: 7000 ukininko tasku.";
		default: global_str = "purskiancio laukus pilotu\n\n{36972E}Norint dirbti traktorininku, reikia: 500 ukininko tasku - [ Atrakinta ]\nNorint dirbti kombainininku, reikia: 3200 ukininko tasku - [ Atrakinta ]\nNorint dirbti purskiancio laukus pilotu, reikia: 7000 ukininko tasku. - [ Atrakinta ]";
	}
	f(global_str,400,"{D38A37}Ukininko igudis: %d tasku{FFFFFF}\nSiuo metu galite dirbti:{D38A37} %s\n\n{D38A37}- Gero darbo.",PI[playerid][pCustomSkills][1],global_str);
	SPD(playerid,0,0,!"",global_str, !"Uzdaryti","");
	return 1;
}
CMD:carm(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(!IsAArmy(playerid)) return SCM(playerid,COLOR_GREY, !"Jus nesate kariuomeneje!");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_VALIK, !"Jus nesate budejime");
    if(GetVehicleModel(GetPlayerVehicleID(playerid))==433)
    {
    	f(global_str,500,"Pakrauti\nIskrauti i LSPD sandeli [%d/30k.] bank: {73B461}%d${FFFFFF}\nIskrauti i RCPD sandeli [%d/30k.] bank: {73B461}%d${FFFFFF}\nIskrauti i FBI [%d/30k.] bank: {73B461}%d${FFFFFF}\nIskrauti i SFPD sandeli [%d/30k.] bank: {73B461}%d$\nIskrauti i LVPD sandeli [%d/30k.] bank: {73B461}%d$",OrgInfo[TEAM_LSPD][oMats],OrgInfo[TEAM_LSPD][oBank],OrgInfo[TEAM_RCPD][oMats],OrgInfo[TEAM_RCPD][oBank],OrgInfo[TEAM_FBI][oMats],OrgInfo[TEAM_FBI][oBank],
		OrgInfo[TEAM_SFPD][oMats],OrgInfo[TEAM_SFPD][oBank],OrgInfo[TEAM_LVPD][oMats],OrgInfo[TEAM_LVPD][oBank]);
    	SPD(playerid,9653,2,"",global_str, !"Priimti", !"Uzdaryti");
	}
	else if(GetVehicleModel(GetPlayerVehicleID(playerid))==548) SPD(playerid,9663,2,"","Pakrauti sraigtasparni [ is gamyklos ]\nIskrauti i LS kariuomene\nIskrauti i LV kariuomene\nIskrauti i SF kariuomene", !"Priimti", !"Uzdaryti");
	return 1;
}
CMD:strafs(playerid, params[])
{
	if(!IsACop(playerid)) return  SCM(playerid,COLOR_RED,!"Jus nesate policininkas!");
    if(PI[playerid][pRank] < 4) return SCM(playerid,COLOR_RED,!"Si galimybe prieinama nuo 4 rango");
    if(GetPlayerState(playerid)!=2)return SCM(playerid,COLOR_RED,!"Jus turite buti uz vairo!");
   	if(GetVehicleModelEx(GetPlayerVehicleID(playerid)) != 525) return SCM(playerid,COLOR_RED,!"Jus turite buti vilkiko viduje!");
	SPD(playerid,193,1,"Iveskite suma","Iveskite uzstato suma\n\n{9ACD32}- Ne maziau kaip $800 ir ne daugiau kaip $10000","OK", !"Atsaukti");
	return 1;
}
CMD:beg(playerid)
{
    if PI[playerid][pLevel] > 4 *then
		return false;
    if !PI[playerid][pBeg][1] *then
    {
        if(IsPlayerInRangeOfPoint(playerid, 50.0, 1755.4108, -1893.7559, 13.5567)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Spawno teritorijoje negalima prasyti pinigu!");
        if(IsPlayerInAnyVehicle(playerid)) return 1;
        if(PI[playerid][pBeg][0] > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Prasyti pinigus galima karta per 10 sekundziu!");
        new
            Float:pos_x,
            Float:pos_y,
            Float:pos_z,
            Float:angle;
        GetPlayerPos(playerid, pos_x, pos_y, pos_z);
        GetXYInFrontOfPlayer(playerid, pos_x, pos_y, 1.0);
        GetPlayerFacingAngle(playerid, angle);
        PI[playerid][pBeg][2] = CreateDynamicObject(2599, pos_x, pos_y, pos_z - 0.6, 0.0, 0.0, angle, -1, -1, -1, 300.0, 300.0);
		SetDynamicObjectMaterial(PI[playerid][pBeg][2], 1, 1413, !"break_f_mesh", !"CJ_CORRIGATED", 0);
		SetDynamicObjectMaterialText(PI[playerid][pBeg][2], 0, !"Paaukokite\nbenamiui\ngydymui", 140, !"SAG", 75, 1, -1, 0, 1);
        Streamer_Update(playerid);
        SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Informacija!", !"\n\n{FFFFFF}Jus pradejote elgetauti pinigu. Kas 40 sekundziu jus gausite po 10$.\
		\nO jei busite mafijos kontroleje, galesite gauti iki 15$ per 40 sekundziu!\
		\nNorint prisijungti prie mafijos verslo, pakanka rasti viena is ju atstovu\
		\n \n{e8793e}Elgetauti galite net AFk, tai suteiks jums galimybe uzsidirbti pinigu,\
		\nkol uzsiimate reikalais realiame gyvenime. Elgetauti galima iki 24 valandu AFK!\n", !"Supratau", !"");
        PI[playerid][pBeg][0] = 10 + Global_Time;
        PI[playerid][pBeg][1] = 1;
        PI[playerid][pBeg][4] = 0;
        TogglePlayerControllable(playerid, 0);
        ApplyAnimationEx(playerid, !"BEACH", !"ParkSit_W_loop", 4.1, 0, 1, 1, 1, 1);
        GameTextForPlayer(playerid, !"successfull", 5000, 1);
        return SCM(playerid, -1, !">> {FAAC58}Naudokite {FFFFFF}/beg{FAAC58}, kad baigtumete elgetauti!");
    }
    TogglePlayerControllable(playerid, 1);
    DestroyDynamicObject(PI[playerid][pBeg][2]);
    PI[playerid][pBeg][1] = 0;
    ApplyAnimationEx(playerid, !"CARRY", !"crry_prtial", 4.0, 0, 0, 0, 0, 0);
    return SCM(playerid, -1, !">> {73B461}Jus paemete lentele ir nustojote {FFFFFF}elgetauti.");
}
CMD:passwd(playerid, params[])
{
	if sscanf(params, "s[50]s[50]s[50]", SQL_GET_ROW_STR[0], SQL_GET_ROW_STR[1], SQL_GET_ROW_STR[2]) *then
		return SCM(playerid, COLOR_LIGHTBLUE, "/passwd [oldpass] [newpass] [newpass2]");
	else if Int_GetPlayerData(playerid, "changepasswordR") > Global_Time *then
		return SCM(playerid, -1, "Slaptazodzius galima keisti kas 2 minutes!");
	Int_SetPlayerData(playerid, "changepasswordR", Global_Time + 120);
	f(global_str, 256, "SELECT `Password` FROM `accounts` WHERE `NickName` = '%s' LIMIT 1", PN(playerid));
	new Cache:result = mysql_query(mysql, global_str);
	cache_get_row(0, 0, SQL_GET_ROW_STR[3], mysql);
	cache_delete(result, mysql);
	if strcmp(MD5_Hash(SQL_GET_ROW_STR[0]), SQL_GET_ROW_STR[3], true) !=0 *then
		return SCM(playerid,COLOR_LIGHTBLUE,"Dabartinis slaptazodis nesutampa su ivestu!");
	else if strcmp(SQL_GET_ROW_STR[1], SQL_GET_ROW_STR[2], true) !=0 *then
		return SCM(playerid,COLOR_LIGHTBLUE,"Nauji slaptazodziai nesutampa tarpusavyje!");
	else if strcmp("No Mail Adress", PlayerMail[playerid], true) !=0 *then
    {
        if(Int_GetPlayerData(playerid, "remail") > Global_Time) return SCM(playerid, -1, !"Pakartotini laiska galima siusti kas 1 minute.");
        new code = 1000 + random(9000);
        SPD(playerid,203,1,"","\n\n{FFFFFF}I jusu {ffd450}el.pasta {FFFFFF}buvo issiustas\nlaiskas su {ffd450}kodu{FFFFFF}, kuri reikia\nivesti i laukeli zemiau.\n\n{ff5e50}Noredami sumazinti zaidima ir\npereiti i narsykle, naudokite sia\nklaviaturos kombinacija: ALT+TAB!\n\n","Issiusti", !"Uzdaryti");
        SetPVarInt(playerid,"remail",Global_Time+60);
        f(global_str,128,"Slaptazodzio keitimo kodas: %d",code);
        SendMail(PlayerMail[playerid], ""Mode_Mail"", Mode[CFG_Name],"San Andreas Gyvenimas", global_str);
        SetPVarInt(playerid, "authcode", code);
        SetPVarString(playerid, "rePassword", SQL_GET_ROW_STR[1]);//
        return 1;
    }
	SQL("UPDATE `accounts` SET `Password` = '%s' WHERE `ID` = '%d' LIMIT 1", MD5_Hash(SQL_GET_ROW_STR[1]), PI[playerid][pID]);
	SCM(playerid, COLOR_LIGHTBLUE, !"Slaptazodis pakeistas!");
	return amlf("<a href=../pages/user?name=%s>%s</a> pakeite slaptazodi", 4, PN(playerid), "", PN(playerid), PN(playerid) );
}
CMD:wedding(playerid, params[])
{
	if(Merrit[0] != 0) return SCM(playerid, COLOR_RED, !"Vestuves jau vyksta!");
    if(sscanf(params,"dd",params[0],params[1])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /wedding [Jaunikio ID] [Nuotakos ID]");
 	if(!IsAMeria(playerid))return SCM(playerid, COLOR_RED, !"Jus nesate savivaldybes darbuotojas");
	if(PI[playerid][pRank] < 8) return SCM(playerid, COLOR_RED, !"Suzadetuves gali atlikti tik darbuotojas, turintis 8 ar aukstesni ranga");
	if(!IsPlayerInRangeOfPoint(playerid, 10.0, 2363.9543,-1958.5900,1601.0859 )) return SCM(playerid, COLOR_RED, !"Jus nesate arti suzadetuviu vietos");
	if(!IsPlayerInRangeOfPoint(params[0], 10.0, 2363.9543,-1958.5900,1601.0859 )) return SCM(playerid, COLOR_RED, !"Jaunikis nera baznycioje!");
	if(!IsPlayerInRangeOfPoint(params[1], 10.0, 2363.9543,-1958.5900,1601.0859 )) return SCM(playerid, COLOR_RED, !"Nuotaka nera baznycioje!");
	if(params[0] == playerid) return SCM(playerid, COLOR_RED, !"Jus negalite priversti isteketi uz jusu!");
	if(params[1] == playerid) return SCM(playerid, COLOR_RED, !"Jus negalite priversti isteketi uz jusu!");
	if(PI[params[0]][pSex] != 1) return SCM(playerid, COLOR_RED, !"Pirmiausia nurodykite jauniki, tada nuotaka");
	if(PI[params[1]][pSex] != 2) return SCM(playerid, COLOR_RED, !"Pirmiausia nurodykite jauniki, tada nuotaka");
	if(strcmp(PI[params[0]][pMerrit], "None") || strcmp(PI[params[1]][pMerrit], "None")) return SCM(playerid, COLOR_RED, !"Opa, kazkas jau vedes arba istekejusi");
 	if(!Ring[params[0]]) return SCM(playerid, COLOR_RED, !"Panasu, kad kazkas nepirko ziedu!");
	Merrit[0] = 1;
	Merrit[1] = playerid;
	Merrit[2] = params[0];
	Merrit[3] = params[1];
	f(global_str, 128, "%s: Jaunikis %s , ar esate pasiruoses vesti %s?", PN(playerid), PN(params[0]), PN(params[1]));
	ProxDetector(25, playerid, global_str, COLOR_SCHAT, 1);
	SCM(params[0], COLOR_GREY, !"Noredami pasirinkti, parasykite zaidimo Chate taip/ne");
	return 1;
}
CMD:unwedding(playerid, params[])
{
	if(PI[playerid][pMoney] < 4000) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF} Jums truksta pinigu!");
    if(!IsPlayerInRangeOfPoint(playerid, 10.0, 2363.9543,-1958.5900,1601.0859)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Issiskirti galima tik baznycioje!");
	if(!strcmp(PI[playerid][pMerrit], "None")) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite sutuoktinio/sutuoktines");
	foreach(new i: Player)
    {
        if(!strcmp(PN(playerid), PI[i][pMerrit], true) && IsPlayerConnected(i))
		{
			SCM(i, COLOR_RED, !"Jusu sutuoktinis/sutuoktine jus paliko.");
			strmid(PI[i][pMerrit], "None", 0, MAX_PLAYER_NAME);
			strmid(PI[playerid][pMerrit], "None", 0, MAX_PLAYER_NAME);
			return 1;
		}
    }
	f(global_str, 256, "UPDATE `accounts` SET `Merrit` = 'None' WHERE `NickName` = '%s'", PI[playerid][pMerrit]);
	mysql_tquery(mysql, global_str);
	strmid(PI[playerid][pMerrit], "None", 0, MAX_PLAYER_NAME);
	return 1;
}
CMD:redice(playerid)
{
    if(KostiName[playerid] == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus niekam nepasiulete zaidimo!");
	Predlog[playerid] =
	Predlog[KostiName[playerid]] =
	KostiMoney[playerid] =
	KostiMoney[KostiName[playerid]] =
	ZapretDice[playerid] =
	ZapretDice[KostiName[playerid]] = 0;
	SCM(KostiName[playerid], COLOR_RED, !"[Informacija] {FFFFFF}Zaidejas atsisake statymo!");
	SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Jus atsisakete zaisti!");
	KostiName[KostiName[playerid]] =
	KostiName[playerid] = INVALID_PLAYER_ID;
	return 1;
}
cmd:dice(playerid, params[])
{
	if !IsPlayerInRangeOfPoint(playerid, 2.4, 2232.5732, -819.6976, 1407.1273) && !IsPlayerInRangeOfPoint(playerid, 2.4, 2258.4390, -853.8804, 1406.6176) && !IsPlayerInRangeOfPoint(playerid, 2.4, 2272.1606, -846.1528, 1406.6176)
	&& !IsPlayerInRangeOfPoint(playerid, 2.4, 2260.5095, -846.1528, 1406.6176)  && !IsPlayerInRangeOfPoint(playerid, 2.4, 2274.2310, -853.8804, 1406.6176) && !IsPlayerInRangeOfPoint(playerid, 2.4, 37.2464,2272.4465,1502.6428) && !IsPlayerInRangeOfPoint(playerid, 2.4, 37.2537,2278.4500,1502.6428) *then
		return SCM(playerid, COLOR_RED, !"Turite buti prie zaidimo stalo!");
    if(KostiMoney[playerid] != 0 || ZapretDice[playerid] != 0)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums jau pasiule zaidima!");
    if(sscanf(params, "dd", params[0], params[1]))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite /dice [zaidejo ID] [statymas (zetonais)]");
    if(params[1] < 1 || params[1] > 1000)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Minimalus statymas 1 zetonas, maksimalus - 1000 zetonu.");
 	if(GetCount(playerid, 316) < params[1])
		return SCM(playerid, COLOR_RED, !">>>>{FFFFFF} - Jums neuztenka zetonu. Zetonus galite isigyti casino keitykloje.");
    if(params[0] == 1001) {
        if(Int_GetPlayerData(playerid, !"timebot") > Global_Time)
            return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Su botu galima zaisti kas 5 sekundziu!");
	    global_str = "";
 	    new
		 	dice = 6,
	    	dice1 = random(5)+2;
	    f(global_str, 128, "[Informacija] {FFFFFF}Jus pasiulete Olivijai mesti kauliukus. Statymas: %i", params[1]);
	    SCM(playerid, COLOR_LIGHTBLUE, global_str);
	    f(global_str, 128, "Olivija ir %s mete kauliukus. Rezultatas: {CC9900}%i : %i", PN(playerid), dice, dice1);
	    ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
	    if(dice > dice1)
	    {
	        DeleteItem(playerid, 316, params[1]);
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Deja, jus pralaimejote!", !"Supratau", !"");
	        f(global_str, 20, "~r~-%d", params[1]);
	        GameTextForPlayer(playerid, global_str, 3000, 1);
	    }
	    else if(dice < dice1)
	    {
	        AddItem(playerid, 316, params[1]);
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Sveikiname, jus laimejote!", !"Supratau", !"");
	        f(global_str, 20, "~g~+%d", params[1]);
	        GameTextForPlayer(playerid, global_str, 3000, 1);
	    }
	    else if(dice == dice1) {
			SCM(playerid, COLOR_ORANGE, !"[Informacija] {FFFFFF}Zaidimas baigesi lygiosiomis!");
	    }
	    switch(dice1)
		{
		    case 1: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 90.0000, 0.0000);
		    case 2: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 180.0000, 0.0000);
		    case 3: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 90.0000);
		    case 4: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 270.0000);
		    case 5: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 0.0000);
		    case 6: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 270.0000, 0.0000);
		}
		f(global_str, 128, "Iskrito: {FFFFFF}%i", dice1);
		SetPlayerChatBubble(playerid, global_str, COLOR_ORANGE, 30.0, 10000);
		kostiKos[playerid] = 5;
		SetPVarInt(playerid, !"timebot", Global_Time+5);
		return 1;
    }
    if(params[0] == playerid)
		return 1;
	if(!ProxDetectorS(6.0, playerid, params[0]))
		return 1;
    if(!IsPlayerConnected(params[0]) || !IsPlayerLogged{params[0]})
		return 1;
    if(ZapretDice[params[0]] == 1)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Siuo metu zaidejas negali zaisti!");
	if(kostiKos[playerid] > 0)
		return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Siuo metu jus negalite pradeti zaidimo!");
    if(PlayerJob[playerid] == JOB_GUIDE && InJob[playerid] == 1)
		return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Krupje negali zaisti kauliukais!");
	SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Noredami atsisakyti savo statymo, iveskite [/redice]");
    global_str = "";
    f(global_str, 128, "[Informacija] {FFFFFF}Jus pasiulete %s mesti kauliukus. Statymas: %i", PN(params[0]), params[1]);
    SCM(playerid, COLOR_LIGHTBLUE, global_str);
    f(global_str, 128, "[Informacija] {FFFFFF}%s siulo mesti kauliukus. Statymas: %i", PN(playerid), params[1]);
    SCM(params[0], COLOR_LIGHTBLUE, global_str);
    SCM(params[0], COLOR_WHITE, !"Iveskite {48FC23}'/Yes'{FFFFFF}, kad sutiktumete, {FF0000}'/No' {FFFFFF}, kad atisakyti");
    ZapretDice[playerid] =
    ZapretDice[params[0]] = 1;
    KostiName[playerid] = params[0];
    KostiName[params[0]] = playerid;
    KostiMoney[params[0]] =
    KostiMoney[playerid] = params[1];
    Predlog[playerid] = 1;
    return 1;
}
cmd:no(playerid)
{
	if(KostiName[playerid] == INVALID_PLAYER_ID)
		return 1;
	Predlog[KostiName[playerid]] =
	KostiMoney[playerid] =
	KostiMoney[KostiName[playerid]] =
	ZapretDice[playerid] =
	ZapretDice[KostiName[playerid]] = 0;
	SCM(KostiName[playerid], COLOR_VALIK, !"[Informacija] {FFFFFF}Zaidejas atsisake statymo!");
	SCM(playerid, COLOR_ORANGE, !"[Informacija] {FFFFFF}Jus atsisakete zaisti!");
	KostiName[KostiName[playerid]] =
	KostiName[playerid] = INVALID_PLAYER_ID;
	return 1;
}
cmd:yes(playerid)
{
    if(KostiName[playerid] == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jums niekas nesiule mesti kauliukus");
    if(kostiKos[playerid] > 0)
		return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Siuo metu negalite priimti zaidimo!");
    if(PlayerJob[playerid] == JOB_GUIDE && InJob[playerid] == 1)
		return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Krupje negalite zaisti kauliukais!");
    new
		dice = random(5)+2,
    	dice1 = random(5)+2;
	global_str = "";
	if(!ProxDetectorS(6.0, playerid, KostiName[playerid]))
		return 1;
	if(Predlog[playerid] != 0)
		return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus negalite priimti zaidimo!");
	if(GetCount(playerid, 316) < KostiMoney[playerid] || GetCount(KostiName[playerid], 316) < KostiMoney[KostiName[playerid]])
	{
	    SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Vienam is jusu truksta BTC, kad galetumete zaisti kauliukais.");
	    SCM(KostiName[playerid], COLOR_RED, !"[Klaida] {FFFFFF}Vienam is jusu truksta BTC, kad galetumete zaisti kauliukais.");
	    callcmd::redice(playerid);
		callcmd::redice(KostiName[playerid]);
	    return 0;
	}
    f(global_str, 110, "%s ir %s mete kauliukus. Rezultatas: {CC9900}%i : %i", PN(KostiName[playerid]), PN(playerid), dice, dice1);
    ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
    if(dice > dice1)
    {
        AddItem(KostiName[playerid], 316, KostiMoney[playerid]);
        DeleteItem(playerid, 316, KostiMoney[playerid]);
		SPD(KostiName[playerid], 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Sveikiname, jus laimejote!", !"Supratau", !"");
		SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Deja, jus pralaimejote!", !"Supratau", !"");
        f(global_str, 20, "~g~+%d", KostiMoney[playerid]);
        GameTextForPlayer(KostiName[playerid], global_str, 3000, 1);
        f(global_str, 20, "~r~-%d", KostiMoney[playerid]);
        GameTextForPlayer(playerid, global_str, 3000, 1);
	    if AcceptQuest[KostiName[playerid]][21] && QuestProgress[KostiName[playerid]][21] < 10 *then
	    {
        	QuestProgress[KostiName[playerid]][21] ++;
			NextStapQI(KostiName[playerid], 21);
		}
    }
    else if(dice < dice1)
    {
        DeleteItem(KostiName[playerid], 316, KostiMoney[playerid]);
        AddItem(playerid, 316, KostiMoney[playerid]);
		SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Sveikiname, jus laimejote!", !"Supratau", !"");
		SPD(KostiName[playerid], 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Deja, jus pralaimejote!", !"Supratau", !"");
        f(global_str, 20, "~g~+%d", KostiMoney[playerid]);
        GameTextForPlayer(playerid, global_str, 3000, 1);
        f(global_str, 20, "~r~-%d", KostiMoney[playerid]);
        GameTextForPlayer(KostiName[playerid], global_str, 3000, 1);
	    if AcceptQuest[playerid][21] && QuestProgress[playerid][21] < 10 *then
	    {
        	QuestProgress[playerid][21] ++;
			NextStapQI(playerid, 21);
		}
    }
    else if(dice == dice1)
    {
		SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Zaidimas baigesi lygiosiomis!", !"Supratau", !"");
		SPD(KostiName[playerid], 0, DIALOG_STYLE_MSGBOX, !"{F1951B}Informacija", !"{FFFFFF}Zaidimas baigesi lygiosiomis!", !"Supratau", !"");
    }
    switch(dice1)
	{
	    case 1: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 90.0000, 0.0000);//+
	    case 2: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 180.0000, 0.0000);//+
	    case 3: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 90.0000);//+
	    case 4: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 270.0000);
	    case 5: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 0.0000); //+
	    case 6: SetPlayerAttachedObjectEx(playerid, 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 270.0000, 0.0000); //+
	}
	switch(dice)
	{
     	case 1: SetPlayerAttachedObjectEx(KostiName[playerid], 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 90.0000, 0.0000);//+
	    case 2: SetPlayerAttachedObjectEx(KostiName[playerid], 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 180.0000, 0.0000);//+
	    case 3: SetPlayerAttachedObjectEx(KostiName[playerid], 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 90.0000);//+
	    case 4: SetPlayerAttachedObjectEx(KostiName[playerid], 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 270.0000);
	    case 5: SetPlayerAttachedObjectEx(KostiName[playerid], 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 360.0000, 0.0000); //+
	    case 6: SetPlayerAttachedObjectEx(KostiName[playerid], 7, 1851, 1, 0.062400, 0.453750, 0.000000, 360.0000, 270.0000, 0.0000); //+
	}
	kostiKos[KostiName[playerid]] =
    kostiKos[playerid] = 5;
	f(global_str, 128, "Iskrito: %i", dice1);
	SetPlayerChatBubble(playerid,global_str,COLOR_ORANGE, 30.0, 10000);
	f(global_str, 128, "Iskrito: %i", dice);
	SetPlayerChatBubble(KostiName[playerid], global_str, COLOR_VALIK, 30.0, 10000);
	FirstGiveBizMoney(2010.3718,989.1686,10.8127,KostiMoney[playerid]*90/10);
 	ZapretDice[playerid] =
	ZapretDice[KostiName[playerid]] =
	KostiMoney[playerid] =
	KostiMoney[KostiName[playerid]] =
	Predlog[KostiName[playerid]] = 0;
	KostiName[KostiName[playerid]] =
	KostiName[playerid] = INVALID_PLAYER_ID;
    return 1;
}
CMD:armour(playerid)
{
	new
		string[24 - 4 + MAX_PLAYER_NAME + 5],
		Float:armour;
	GetPlayerArmour(playerid, armour);
	if (armour)
	{
		SCM(playerid, COLOR_LIGHTBLUE, !"Jus nusivilkote sarvus!");
		UpdatePlayerArmour(playerid, 0);
		f(string, sizeof(string), "%s[%d] nusivilko sarvus.", PN(playerid), playerid);
		ProxDetector(25.0, playerid, string, COLOR_PURPLE);
	}
	else
	{
		if (GetCount(playerid, 330) < 1)
			return SCM(playerid, COLOR_GREY, !"Jus neturite sarvu");
		if (Int_GetPlayerData(playerid, !"armourtime") > Global_Time)
			return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 60 sekundziu!");
		if(IsPlayerAttachedObjectSlotUsed(playerid, 5)) RemovePlayerAttachedObject(playerid, 5);
		SCM(playerid, COLOR_LIGHTBLUE, !"Jus apsivilkote sarvus. Naudokite /armour, kad ji nuimtumete arba vel uzsidetumete.");
		UpdatePlayerArmour(playerid, 100);
		f(string, 128, "%s[%d] apsivilko sarvus.", PN(playerid), playerid);
		ProxDetector(25.0, playerid, string, COLOR_PURPLE);
		SetPVarInt(playerid, !"armourtime", Global_Time + 60);
		DeleteItem(playerid, 330, 1);
	}
	return 1;
}
alias:house("home", "hmenu");
CMD:house(playerid)
{
    if PI[playerid][pDemorgan] *then
    	return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sios komandos sioje vietoje naudoti negalite!");
	new house = GetPlayerInHouseID(playerid), world = GetPlayerVirtualWorld(playerid);
	if !GetPlayerHouses(playerid, 1) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negyvenate ne viename is namu");
	if !IsPlayerHouse(playerid, house) && !IsPlayerTenant(playerid, house) *then
		return SCM(playerid, COLOR_RED, world ? "[Klaida] {FFFFFF}Jus nesate savo namuose!":"[Klaida] {FFFFFF}Jus neturite namo arba nesate prie jo!");
	if world && !IsPlayerInRangeOfPoint(playerid, 100.0, HouseInfo[house][hExit_X], HouseInfo[house][hExit_Y], HouseInfo[house][hExit_Z]) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate savo namuose!");
	if !world && !IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[house][hEnter_X], HouseInfo[house][hEnter_Y], HouseInfo[house][hEnter_Z]) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate salia savo namo!");
	PI[playerid][pHouseOpen] = house;
	if HouseEntered[playerid] == -1 *then
	{
        f(mysql_string, 16, "Namas в„–%d", house);
		f(global_str, 150, "{42B02C}- %s\n{42B02C}-{FFFFFF} Parduoti nama zaidejui", (HouseInfo[house][hLock] == 1) ? ("{A5EC67}Atrakinti {FFFFFF}nama") : "{EC6767}Uzrakinti {FFFFFF}nama");
		return SPD(playerid, 6698, DIALOG_STYLE_LIST, mysql_string, global_str, !"Isrinkti", !"Atsaukti");
	}
	if IsPlayerHouse(playerid, house) *then
		f(global_str, 500, "{42B02C}- %s\n{42B02C}-{FFFFFF} Namo meniu\n{42B02C}-{FFFFFF} Patobulinti nama\n{42B02C}-{FFFFFF} Parduoti nama\n{42B02C}-{FFFFFF} Parduoti nama zaidejui\n{42B02C}-{FFFFFF} %s\n{42B02C}-{FFFFFF} Mokesciai\n{42B02C}-{FFFFFF} Produktai\n{42B02C}-{FFFFFF} Apgyvendinti zaideja\n{42B02C}-{FFFFFF} Gyventoju sarasas",
	    (HouseInfo[house][hLock] == 1) ? ("{A5EC67}Atrakinti {FFFFFF}nama") : "{EC6767}Uzrakinti {FFFFFF}nama", HouseInfo[house][hAuction] ? "Nuimti nama nuo aukciono":"Isstatyti nama i aukciona"),
		f(mysql_string, 256, "Namas в„–%d | {42B02C}Naudotu objektu skaicius: %d is 10", HouseEntered[playerid], GetCountUsedObj(HouseEntered[playerid])),
		SPD(playerid, 174, DIALOG_STYLE_LIST, mysql_string, global_str, !"Isrinkti", !"Atsaukti");
	else
		f(global_str, 80, "{42B02C}- %s\n{42B02C}-{FFFFFF} Namo meniu", (HouseInfo[house][hLock] == 1) ? ("{A5EC67}Atrakinti {FFFFFF}nama") : "{EC6767}Uzrakinti {FFFFFF}nama"),
        SPD(playerid, 174, DIALOG_STYLE_LIST, !"", global_str, !"Isrinkti", !"Atsaukti");
	return 1;
}
CMD:usemed(playerid, params[])
{
	if(GetCount(playerid, 314) < 1) return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Neturite vaistineles!");
	if(GetPlayerVirtualWorld(playerid)==534) return 1;
	if(PI[playerid][pHeal] > 0) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus gydotes, cia vaistinele nepades!");
	if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 10 sekundziu!");
    SetPVarInt(playerid, !"itemtime", Global_Time+10);
	new Float: Health = PI[playerid][pHealth];
	DeleteItem(playerid, 314, 1);
	f(global_str, 48, "%s vartoja vaistus", PN(playerid));
	ProxDetector(25, playerid, global_str, COLOR_PURPLE);
	SCM(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus isgerete vaistus");
	if(Health <= 50) UpdatePlayerHealth(playerid, Health + 50);
	else UpdatePlayerHealth(playerid, 100);
	PI[playerid][pHospital] = 25;
 	ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}
CMD:exit(playerid)
{
	new i = HouseEntered[playerid];
	if i == INVALID_DATA_ID or !IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[i][hExit_X], HouseInfo[i][hExit_Y], HouseInfo[i][hExit_Z]) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate prie namo duru!");
	if HouseInfo[i][hType] == 2 *then
		return SPD(playerid, 9989, DIALOG_STYLE_LIST, !"", !"Iseiti i lauka", !"Priimti", !"Atsaukti");
	else if !HouseInfo[i][hGarage] *then
		return SPD(playerid, 9989, DIALOG_STYLE_LIST, !"", !"Iseiti i lauka\nIeiti i rusi\n{9FFF29}Ieiti i rusi su ventiliacija", !"Priimti", !"Atsaukti");
	return SPD(playerid, 9989, DIALOG_STYLE_LIST, !"", !"Iseiti i lauka\nIeiti i rusi\n{9FFF29}Ieiti i rusi su ventiliacija\n{ffc729}Ieiti i garaza", !"Priimti", !"Atsaukti");
}
CMD:blacklist(playerid, params[])
{
	if(IsAtFrakcia(playerid) && PI[playerid][pLeader]>0)
	{
	    if(sscanf(params,"us[72]",params[0],params[1])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /blacklist [id] [priezastis]");
     	if(!ProxDetectorS(4.0, playerid, params[0], 1)) return SCM(playerid,COLOR_RED,!"Jus esate toli nuo zaidejo!");
		if(PI[params[0]][pLeader] > 0 ) return SCM(playerid,COLOR_RED,!"Negalite prideti lyderio i juodaji sarasa");
		if(!IsPlayerConnected(params[0])) return SCM(playerid,COLOR_GREY, !"Zaidejas nerastas");
		if(!IsAtFrakcia(params[0]) && PI[params[0]][pMember]!=0) return SCM(playerid,COLOR_GREY, !"Zaidejas turi buti ne valstybineje organizacijoje!");
		if(PI[params[0]][pBL]) return SCM(playerid,COLOR_GREY, !"Zaidejas jau yra organizacijos juodajame sarase");
		if(params[0]==playerid)return 0;
		PI[params[0]][pBL] = 1;
		global_str = "";
		f(global_str,115,"Jus itraukete %s(%i) i juodaji sarasa. Priezastis: %s", PN(params[0]), params[0], params[1]);
		SCM(playerid,COLOR_LIGHTBLUE,global_str);
		f(global_str,144,"%s itrauke jus i juodaji sarasa. Priezastis: %s", PN(playerid), params[1]);
		SCM(params[0],COLOR_GREY,global_str);
		SCM(params[0],COLOR_GREY, !"Noredami is jo istrukti, turite surinkti 50 teises laikymosi tasku");
	}
	else SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite prieigos prie sios sistemos!");
    return 1;
}
CMD:unblacklist(playerid, params[])
{
	if(IsAtFrakcia(playerid) && PI[playerid][pLeader]>0)
	{
		if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unblacklist [id]");
		if(!IsPlayerConnected(params[0])) return SCM(playerid,COLOR_GREY, !"Zaidejas nerastas");
		if(!PI[params[0]][pBL]) return SCM(playerid,COLOR_GREY, !"Sio zaidejo juodajame sarase nera!");
		PI[params[0]][pBL] = 0;
		global_str = "";
		f(global_str,74,"Jus pasalinote %s(%i) is juodojo saraso",PN(params[0]),params[0]);
		SCM(playerid,COLOR_LIGHTBLUE,global_str);
		f(global_str,63,"%s pasalino jus is juodojo saraso",PN(playerid));
		SCM(params[0],COLOR_GREY,global_str);
    }
	else SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite prieigos prie sios sistemos!");
    return 1;
}
CMD:lights(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return 0;
	new carid = GetPlayerVehicleID(playerid);
	if(IsAVelik(carid) || IsAPlane(carid) || IsASkate(carid)) return 0;
	if(GetEngineStatus(carid)) SetLightsStatus(carid, !GetLightsStatus(carid), playerid);
	return 1;
}
CMD:rules(playerid) return ShowRules(playerid);
CMD:free(playerid, params[])
{
	if(PlayerJob[playerid]!=JOB_ADVOKAT) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus nesate advokatas.");
	new id;
    if(sscanf(params,"ud",id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /free [id]");
    if(id == playerid)return 1;
    if(!ProxDetectorS(2.5, playerid, id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate per toli nuo kalinio!");
    if(OldFreePlayer[playerid] == id) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus jau sumazinote sio zaidejo laika.");
	new time = PI[id][pJailTime],price = PI[id][pBailPrice];
    if(time == 0) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Sis zaidejas nera kalejime.");
    if(LawyerOffer[playerid] != INVALID_PLAYER_ID)
    {
        f(global_str, 150, "Advokatas %s atsauke savo pasiulyma del bausmes sutrumpinimo", PN(playerid));
        SCM(LawyerOffer[playerid], COLOR_GREY, global_str);
    }
 	f(global_str, 200,"{FFFFFF}Advokatas {E4AE25}%s{FFFFFF} siulo sutrumpinti jusu bausme.\nLaikas {E4AE25}%s{FFFFFF}\nKaina: {E4AE25}$%d{FFFFFF}", PN(playerid), Convert(time/2), price);
 	SPD(id, 259, 0, "Laiko sutrumpinimas", global_str, "Sutinku", !"Atsaukti");
    LawyerOffer[playerid] = id;
    LawyerOffer[id] = playerid;
    f(global_str, 128,"Siulote sutrumpinti bausme %s %s uz $%d", PN(id), Convert(time/2), price);
 	SCM(playerid,COLOR_LIGHTBLUE,global_str);
    return 1;
}
CMD:showlic(playerid, data[])
{
    extract data -> new player:id; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /showlic [id]");
	if Int_GetPlayerData(playerid,"reloader") > Global_Time *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
	else if !IsPlayerOnline(id) *then
		return false;
	else if !ProxDetectorS(5.0, playerid, id) *then
		return SCM(playerid, COLOR_RED, !"Jus esate toli nuo zaidejo!");
	else if PI[id][pShowDokument] *then
    	return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas isjunge galimybe jam ka nors parodyti!");
	if ShowLicenses(id, playerid) *then
	{
		f(global_str, 100, "%s parode savo licencijas %s", PN(playerid), PN(id));
		SetPlayerChatBubble(playerid, global_str, COLOR_PURPLE, 10.0, 5000);
		f(global_str, 100,"Jus sekmingai parodete savo licencijas {FFFFFF}%s",PN(id));
		SCM(playerid,COLOR_GREEN, global_str);
	}
	else SCM(playerid, COLOR_GREY, !"Siuo metu nepasiekiama");
	return SetPVarInt(playerid,"reloader", Global_Time+10);
}

CMD:showbadge(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid, COLOR_GREY, !"Jus neturite sio dokumento");
	if(Int_GetPlayerData(playerid,"reloader")>Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
	new id;
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /showbadge [id]");
	if(!ProxDetectorS(5.0, playerid, id)) return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
	new team = GetTeamID(playerid);
	new rank = PI[playerid][pRank];
	f(global_str, 150, "{FF9900}%s{FFFFFF}\n\nVardas: %s\nRangas: %s",OrgInfo[team][oName], PN(playerid), GetRankName(team, rank));
	SPD(id,0,0,"Asmens tapatybes kortele", global_str,"OK","");
	f(global_str, 128, "%s rodo asmens tapatybes kortele %s", PN(playerid), PN(id));
	ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
	SetPlayerChatBubble(playerid, global_str, COLOR_PURPLE, 10.0, 5000);
	SetPVarInt(playerid,"reloader",Global_Time+2);
	return 1;
}
CMD:showpass(playerid, params[])
{
	if(!IsValidPassport(playerid)) return SCM(playerid, COLOR_GREY, !"Jus neturite paso");
	if(Int_GetPlayerData(playerid, "reloader") > Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Komanda galima naudotis kas 5 sekundes!");
    new id; static str[128];
    if(sscanf(params, "u", id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /showpass [id]");
    if(!ProxDetectorS(5.0, playerid, id)) return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
    if(PI[id][pShowDokument]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas isjunge galimybe jam ka nors parodyti!");
	global_str = "";
    if(PI[playerid][pWanted] > 0)
    {
		f(str, sizeof(str), "{FFFFFF}Vardas: {FFD700}%s [ {FCAB48}Ieskomas {FFD700}]\n", PN(playerid));
		strcat(global_str, str);
	}
	else
	{
		f(str, sizeof(str), "{FFFFFF}Vardas: {FFD700}%s\n", PN(playerid));
		strcat(global_str, str);
	}
	f(str, sizeof(str), "{FFFFFF}Metu mieste: {FFD700}%d\n", PI[playerid][pLevel]);
	strcat(global_str, str);
	f(str, sizeof(str), "{FFFFFF}Serija: {FFD700}%d\n", PassInfo[playerid][psSeria]);
	strcat(global_str, str);
	f(str, sizeof(str), "{FFFFFF}Numeris: {FFD700}%d\n", PassInfo[playerid][psNumber]);
	strcat(global_str, str);
	f(str, sizeof(str), "{FFFFFF}Teisetvarka: {FFD700}%d/100\n", PI[playerid][pZKP]);
	strcat(global_str, str);
	if(!strcmp(PI[playerid][pMerrit], "None")) strcat(global_str,"{FFFFFF}Seimine padetis: {FFD700}[ Nevedes/Nesusituokusi ]\n");
	else
	{
        f(str, sizeof(str), "{FFFFFF}Seimine padetis: {FFD700}[ %s ]\n", PI[playerid][pMerrit]);
	    strcat(global_str, str);
	}
	if(PI[playerid][pMember] != 0)
	{
	    if(!IsAtGang(playerid) && !IsAtMafia(playerid))
	    {
			f(str, sizeof(str), "{FFFFFF}Organizacija: {FFD700}%s\n", OrgInfo[GetTeamID(playerid)][oName]);
			strcat(global_str, str);
			f(str, sizeof(str),"{FFFFFF}Pareigos: {FFD700}%s\n", GetRankName(GetTeamID(playerid), PI[playerid][pRank]));
			strcat(global_str, str);
		}
	}
	f(str, sizeof(str), "{FFFFFF}Darbas: {FFD700}%s\n", GetJobPN(PlayerJob[playerid]));
	strcat(global_str, str);
	if(VoenikTimer[playerid] < Global_Time) strcat(global_str,"{FFFFFF}Karinis bilietas: {FFD700}[ Nera ]\n\n");
	else strcat(global_str,"{FFFFFF}Karinis bilietas: {FFD700}[ Yra ]\n\n");
	strcat(global_str, "{FFFFFF}Gyvenamasis turtas:\n{FFD700}Nera\n\n");
	strcat(global_str, "{FFFFFF}Komercinis turtas:\n{FFD700}Nera\n\n");
    strcat(global_str, "{FFFFFF}Ukinis ukis:\n{FFD700}Nera");
	if(PI[playerid][pPcix] > 0)
	{
		f(str, sizeof(str), "\n\n{FF6200}Gydesi Psichiatrijos ligonineje: %d karta (Reikia atnaujinti med.kortele)", PI[playerid][pPcix]);
		strcat(global_str, str);
	}
	SPD(id, 0, 0, !"Pasas", global_str, !"OK", !"");
	f(global_str, 128, "%s rodo savo pasa %s", PN(playerid), PN(id));
	SetPlayerChatBubble(playerid, global_str, COLOR_PURPLE, 10.0, 5000);
	f(global_str, 128, "[Uzuomina] {FFFFFF}Jus sekmingai parodete savo pasa zaidejui {FF6347}%s", PN(id));
	SCM(playerid, COLOR_RED, global_str);
	SetPVarInt(playerid, "reloader", Global_Time + 5);
	return 1;
}
CMD:carpass(playerid, params[])
{
	if(Int_GetPlayerData(playerid, !"reloader") > Global_Time)
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
    extract params -> new player:target, car; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /carpass [zaidejo ID] [transporto ID]");
	if(target == INVALID_PLAYER_ID)
	    return 0;
    if(!ProxDetectorS(5.0, playerid, target))
		return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo!");
    if(!IsPlayerHaveCar(playerid, car))
		return SCM(playerid, COLOR_GREY, !"Tai nera jusu transportas");
    f(global_str, 128, "%s rodo tech. pasa %s", PN(playerid), PN(target));
	ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
    new
		number = GetVehicleID(car);
	if(!GetString(CarInfo[number][cNumber], ""Mode_City" ST"))
		f(global_str, 100, "{A63737}%s{FFFFFF}", CarInfo[number][cNumber]);
	else
		global_str = "{991717}Be numeriu [X2 mokestis]{FFFFFF}";
    if(IsAPlane(car))
    	f(global_str, 450, "{FFFFFF}Transportas: {73B461}%s%s{FFFFFF}\nSavininkas: {73B461}%s{FFFFFF}\nTarpininkas: {73B461}%s{FFFFFF}\nMokestis: {73B461}%d{FFFFFF} / 35 000\nBauda: {73B461}%d{FFFFFF} / 60 000\nAutomobilio numeris: %s\n\n{633169}Atkreipkite demesi, kad uz jusu automobili reikia moketi mokescius,\nkitaip ji atims valstybes tarnautojai!\nMokescius galite sumoketi banke.", GetVehicleName(car), VehicleInfo[car][vModification] == 578 ? ("{EAD064}[TT]") : (""), CarInfo[number][cOwner], CarInfo[number][cKeyer], CarInfo[number][cShtrafer], CarInfo[number][cShtraf], global_str);
    else
        f(global_str, 450, "{FFFFFF}Transportas: {73B461}%s%s{FFFFFF}\nSavininkas: {73B461}%s{FFFFFF}\nTarpininkas: {73B461}%s{FFFFFF}\nRida: {73B461}%.0f km.{FFFFFF}\nMokestis: {73B461}%d{FFFFFF} / 35 000\nBauda: {73B461}%d{FFFFFF} / 60 000\nAutomobilio numeris: %s\n\n{633169}Atkreipkite demesi, kad uz jusu automobili reikia moketi mokescius,\nkitaip ji atims valstybes tarnautojai!\nMokescius galite sumoketi banke.", GetVehicleName(car), VehicleInfo[car][vModification] == 578 ? ("{EAD064}[TT]") : (""), CarInfo[number][cOwner], CarInfo[number][cKeyer], CarInfo[number][cMilage], CarInfo[number][cShtrafer], CarInfo[number][cShtraf], global_str);
    SPD(target, 0, DIALOG_STYLE_MSGBOX, !"Informacija", global_str, !"Uzdaryti", !"");
    f(global_str, 128, "Jus sekmingai parodete transporto dokumentus zaidejui {FFFFFF}%s", PN(target));
	SCM(playerid, COLOR_GREEN, global_str);
	SetPVarInt(playerid, !"reloader", Global_Time + 2);
	return 1;
}
CMD:showskill(playerid, params[])
{
    new id;
	if(Int_GetPlayerData(playerid,"reloader")>Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
    if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /showskill [id]");
    if(!ProxDetectorS(5.0, playerid, id))  return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
	ShowSkills(id, playerid);
	SetPlayerChatBubble(playerid, "Kazka parode.", COLOR_PURPLE, 10.0, 5000);
	f(global_str,128,"Jus sekmingai parodete savo igudzius zaidejui %s",PN(id));
	SCM(playerid,COLOR_GREEN,global_str);
	SetPVarInt(playerid,"reloader",Global_Time+2);
	return 1;
}
CMD:showmc(playerid, params[])
{
	if(!IsValidPassport(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite sio dokumento");
	if(Int_GetPlayerData(playerid, "reloader") > Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
    new id;
    if(sscanf(params, "u", id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /showmc [id]");
    if(!ProxDetectorS(5.0, playerid, id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
    if(PI[id][pShowDokument]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas isjunge galimybe jam ka nors parodyti!");
	switch(MedCardInfo[playerid][mcState])
	{
	    case -1: return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite med.korteles!");
	   	case 0: global_str = "Nera apibreztas";
	   	case 1: global_str = "Psichiskai nesveikas(a)";
	   	case 2: global_str = "Pastebemi nukrypimai";
	   	case 3: global_str = "Visiskai sveikas(a)";
	}
	f(global_str, 300, "\
	{FFFFFF}Vardas: %s\n\n\
	Data: %s\n\
	Statusas: %s\n\
	{CEAD2A}Narkomanija: %d", PN(playerid), MedCardInfo[playerid][mcDate], global_str, PI[playerid][pAllRepl]);
	SPD(id, 0, DIALOG_STYLE_MSGBOX, "Med.kortele", global_str, "OK", "");
	f(global_str, 128, "%s rodo savo med.kortele %s", PN(playerid), PN(id));
	ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
	f(global_str, 128, "Jus sekmingai parodete savo med.kortele zaidejui {FFFFFF}%s", PN(id));
	SCM(playerid, COLOR_GREEN, global_str);
	SetPVarInt(playerid,"reloader",Global_Time + 10);
	return 1;
}
CMD:sellgangzone(playerid, params[])
{
    new zone = GetPlayerGangZone(playerid);
    new giveplayerid, count;
    if(sscanf(params, "ud", giveplayerid, count)) return SCM(playerid, COLOR_GREY, !"Naudokite: /sellgangzone [ID/Name] [Kaina]");
    if(!ProxDetectorS(2.0, playerid, giveplayerid, 1)) return SCM(playerid,COLOR_RED,!"Jus esate toli nuo zaidejo!");
	if(!IsAtGang(playerid) || !IsAtGang(giveplayerid))return SCM(playerid, COLOR_GREY, !"Arba jus, arba tas, kam norite parduoti zona, nepriklauso gaujai!");
	if(GZInfo[zone][gzFracID] != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"Tai ne jusu zona");
	if(giveplayerid == playerid) return SCM(playerid, COLOR_GREY, !"Jus negalite parduoti sau!");
	if(PI[playerid][pLeader]==0 || PI[giveplayerid][pLeader]==0) return SCM(playerid, COLOR_GREY, !"Tik lyderis lyderiui gali parduoti zonas!");
	if(CaptureZone == zone) return SCM(playerid, COLOR_GREY, !"Sia zona jau uzima");
	if(count<0)return SCM(playerid,COLOR_RED,!"Jus nurodote neigiama suma? Rimtai? Norite jam sumoketi?");
	if(PI[giveplayerid][pMoney]< count)return SCM(playerid,COLOR_RED,!"Sis banditas neturi pakankamai pinigu sumoketi!");
 	SellGzone[giveplayerid] = count;
	SellPGzone[giveplayerid] = playerid;
 	SCM(playerid,COLOR_GREY, !"Jus issiuntete pasiulyma del teritorijos pirkimo!");
	f(global_str, 100,"Zaidejas %s siulo nusipirkti teritorija uz %d$\nJus sutinkate?",PN(playerid),count);
	SPD(giveplayerid,377,0,"Informacija",global_str,"Sutinku","Atsaukti");
	return 1;
}
CMD:famcapture(playerid, params[])
{
	if !IsAOwner(playerid) *then return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Nezinoma komanda! Iveskite /help, kad pamatytumete prieinamas funkcijas.");
	new
		Atac = FP_Data[playerid][F_FAMILY_ID],	hour,minuite,second;
    gettime(hour, minuite, second);
    new zone = GetFamPlayerGangZone(playerid);
    if zone == -2 or zone > 156 *then
		return SCMF(playerid, -1, "err more %d", zone);
	if FamilyZone[zone][fZoneOwnerId] == -1 *then
	{
	    GangZoneHideForAll(FamilyZone_gang[zone]);
        GangZoneShowForAll(FamilyZone_gang[zone], FZColors[GetFamilyDataInt(Atac, "color")]);
        FamilyZone[zone][fZoneOwnerId] = Atac;
        SaveFamGangZone(zone);
	}
	else
	{
		f(global_str,128,"[A] Seima %s [%s(%d)] pradejo gaujos %s teritorijos uzemima",GetFamilyDataString(Atac, "name"), PN(playerid), playerid,GetFamilyDataString(FamilyZone[zone][fZoneOwnerId], "name"));
		SendAdminsMessage(COLOR_ORANGE,global_str);
		FamCaptureZone = zone;
		FamCaptureDef = FamilyZone[zone][fZoneOwnerId];
		FamCaptureAtac = Atac;
		FamCaptureAtacKill = 0;
		FamCaptureDefKill = 0;
		FamCaptureTime[0] = 0;
		FamCaptureTime[1] = 35; //10 minuciu
		GangZoneFlashForAll(FamilyZone_gang[FamCaptureZone], FZColors[GetFamilyDataInt(FamCaptureAtac, "color")]);
		SCM(playerid,COLOR_WHITE, !"Teritorija mirkses 2 minutes. Nugales ta gauja, kuri liks paskutine");
		SCM(playerid,COLOR_WHITE, !"Teritorija mirkses tol, kol joje liks viena gauja");
		FamilyZone[FamCaptureZone][famAttack] = true;
	}
	return true;
}
cmd:findfamzone(playerid, params[])
{
	extract params -> new idzone; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /findfamzone [id]");
	if idzone == -1 or idzone > 156 *then
	    return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Nurodytas netinkamas zonos kodas.");
	EnableGPSForPlayer(playerid, FamilyZone[idzone][fZone_Min_X], FamilyZone[idzone][fZone_Min_Y], FamilyZone[idzone][fZone_Max_X]);
	return SCMF(playerid,COLOR_VALIK, "[Informacija]{FFFFFF} Jus nustatete zyme ant seimos teritorijos в„–%i", idzone);
}
CMD:pobject(playerid)
{
    new Float:distance = 3.0, Float:player_dist = 5.0, object_id = -1;
    for new i; i < TOTALOBJECTS; i++ do
    {
        if !BH_Object[i][objHouseID] && !BH_Object[i][objBizID] *then continue;
        player_dist = GetPlayerDistanceFromPoint(playerid, BH_Object[i][objPosX], BH_Object[i][objPosY], BH_Object[i][objPosZ]);
        if distance > player_dist *then
            distance = player_dist, object_id = i;
    }
    if object_id == -1 *then return false;
    if BH_Object[object_id][objHouseID] *then { if !GetString(PN(playerid), HouseInfo[BH_Object[object_id][objHouseID]][hOwner]) *then return false; }
    else { if !GetString(PN(playerid), BizData[BH_Object[object_id][objBizID]][bOwner]) *then return false; }
	f(mysql_string, 256, "SELECT `Owner`, %s FROM bh_objects WHERE ID = '%d' LIMIT 1;", "DATE_FORMAT(`Date`, '%Y-%m-%d %H:%i:%S ')", BH_Object[object_id][objBaseID]);
	new Cache:result = mysql_query(mysql, mysql_string);
	if cache_get_row_count() *then
	{
		sql_get_row(0, {0,1});
		f(global_str, 550, "\
		{BFBBBA}Nekilnojamasis turtas:\t%s в„–%d\n\
		{BFBBBA}Nustate:\t\t%s\n\
		{BFBBBA}Data:\t\t\t%s\n{FFFFFF}\n\
		Perkelti\n\
		{FF0000}Paimti",
		BH_Object[object_id][objHouseID] ? "Namas":"Verslas",
		BH_Object[object_id][objHouseID] ? BH_Object[object_id][objHouseID]:BH_Object[object_id][objBizID],
		SQL_GET_ROW_STR[0], SQL_GET_ROW_STR[1]);
	}
	cache_delete(result, mysql);
    SetPVarInt(playerid, "object_edit_id", object_id);
	return SPD(playerid, 4450, DIALOG_STYLE_LIST, ItemsInfo[BH_Object[object_id][objItemID]][ItemName2], global_str, !"Isrinkti", !"Uzdaryti");
}
CMD:sprunk(playerid)
{
	if(!GetCount(playerid, 326))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite Sprunk!");
    if(PI[playerid][pHeal])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ligonineje draudziama!");
	if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Turite praeiti 3 sekundes tarp daiktu naudojimo!");
    new
		Float:Health;
    GetPlayerHealth(playerid, Health);
    if(Health <= 92.0)
		UpdatePlayerHealth(playerid, Health + 8);
    else
		UpdatePlayerHealth(playerid, 100);
    DeleteItem(playerid, 326, 1);
	new
		string[25 - 2 + MAX_PLAYER_NAME];
    f(string, 128, "%s isgere sprunk gerima", PN(playerid));
    ProxDetector(25.0, playerid, string, COLOR_PURPLE);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
    SetPVarInt(playerid, !"itemtime", Global_Time+3);
    return 1;
}
CMD:beer(playerid)
{
	if(!GetCount(playerid, 325))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite alaus!");
    if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Turite praeiti 3 sekundes tarp daiktu naudojimo!");
    SetPVarInt(playerid, !"itemtime", Global_Time+3);
    new
		Float:Health;
    GetPlayerHealth(playerid, Health);
    if(Health <= 90.0)
		UpdatePlayerHealth(playerid, Health + 10);
    else
		UpdatePlayerHealth(playerid, 100);
    DeleteItem(playerid, 325, 1);
    f(global_str, 80, "%s isgere alaus buteli", PN(playerid));
    ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
    return 1;
}
CMD:eat(playerid)
{
	f(global_str, 100, "Daiktas\tKiekis\n\
	{FFFFFF}Traskucius\t%d\n\
	{FFFFFF}Zuvi\t%d\n\
	{FFFFFF}Elniu mesa\t%d", GetCount(playerid, 315), GetCount(playerid, 549), GetCount(playerid, 407));
	SPD(playerid, 4332, DIALOG_STYLE_TABLIST_HEADERS, !"{FFD700}Valgyti", global_str, !"Priimti", !"Atsaukti");
	return 1;
}
CMD:drink(playerid)
{
	if(HouseEntered[playerid] == -1) return SCM(playerid, COLOR_GREY, !"Jus nesate ne viename is namu");
	if(!HouseInfo[HouseEntered[playerid]][hBar]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jusu namuose nera mini baro!");
    for(new A; A < 3; A++) TextDrawShowForPlayer(playerid, alcodraw[A]);
	TextDrawShowForPlayer(playerid, alcodraw1[0]);
	TextDrawShowForPlayer(playerid, alcodraw1[1]);
 	TextDrawShowForPlayer(playerid, alcodraw1[2]);
	TextDrawShowForPlayer(playerid, alcodraw1[5]);
	TextDrawShowForPlayer(playerid, alcodraw1[6]);
  	SelectTextDraw(playerid, 0xFF9933FF);
	return 1;
}
CMD:fwarn(playerid, params[])
{
	if(PI[playerid][pLeader] == 0 && PI[playerid][pRank] < 8) return SCM(playerid,COLOR_GREY, !"Jus negalite to padaryti!");
	new id;
	if(sscanf(params,"us[64]",id,params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /fwarn [id] [priezastis]");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_RED, !"Neteisingas zaidejo ID!");
    if(!IsGiveWarn(playerid, id)) return SCM(playerid, COLOR_RED, !"Jus negalite jam isduoti ispejimo!");
    if(PI[id][pLeader] > 0 ) return SCM(playerid,COLOR_RED,!"Jus negalite isduoti lyderiui ispejimo");
    if(PI[playerid][pRank]==PI[id][pRank])return SCM(playerid, COLOR_RED, !"Jus negalite jam isduoti ispejimo!");
    if(IsADomen(params[0])  && PI[playerid][pAdmin]<6)
    {
		SCM(playerid,COLOR_RED,!"Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid,COLOR_WHITE, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 0;
    }
    if(IsAIP(params[0]))return 1;
    PI[id][pFWarns] ++;
    f(global_str, 128,"Jus isdavete zaidejui %s ispejima. Priezastis %s",PN(id),params[0]);
    SCM(playerid,COLOR_LIGHTBLUE, global_str);
    f(global_str, 128,"%s jus isdavete ispejima. Priezastis %s",PN(playerid),params[0]);
    SCM(id,COLOR_RED, global_str);
	if(PI[id][pFWarns] >= 3)
	{
	    SCM(id,COLOR_GREY, !"Jus buvote automatiskai ismesti is organizacijos, nes turite daugiau nei 2 ispejimus");
	    f(global_str, 128,"%s palieka musu organizacija, nes turi daugiau nei 2 ispejimus",PN(id));
	    SendTeamMessage(PI[id][pMember],COLOR_GREY, global_str);
	    PI[id][pFWarns] =
        PI[id][pRank] =
        PlayerJob[id] =
	    PI[id][pMember] =
	    PI[id][pDCTime]=0;
	    SCM(id, COLOR_WHITE, !">> {FF6347} Spawno vieta automatiskai nustatyta Gelezinkelio stotyje. Pakeisti spawno vieta {FFFFFF}>> {FF6347}/setspawn!");
        SetBumSkin(id);
    	PlayerSpawn(id);
	}
	return 1;
}
CMD:unfwarn(playerid, params[])
{
	if(PI[playerid][pLeader] == 0 && PI[playerid][pRank] < 9) return SCM(playerid,COLOR_GREY, !"Jus negalite to padaryti!");
	new id;
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /unfwarn [id]");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_RED, !"Neteisingas zaidejo ID!");
    if(GetTeamID(id) != GetTeamID(playerid)) return SCM(playerid, COLOR_RED, !"Jus negalite pasalinti sio zmogaus ispejimo");
	if(PI[id][pFWarns] == 0) return SCM(playerid, COLOR_RED, !"Sis zaidejas neturi ispejimu!");
	if(id==playerid)return SCM(playerid, COLOR_RED, !"Jus negalite pasalinti ispejimo sau!");
    PI[id][pFWarns] --;
    f(global_str, 100,"Jus pasalinote ispejima %s",PN(id));
    SCM(playerid,COLOR_LIGHTBLUE,global_str);
    f(global_str, 100,"%s pasalino jusu ispejima",PN(playerid));
    SCM(id,COLOR_RED, global_str);
	return 1;
}
CMD:Newsredak(playerid, params[])
{
   	if(!IsANews(playerid)) return SCM(playerid,COLOR_GREY, !"Tik CNN darbuotojams!");
	if(PI[playerid][pRank]<2)return SCM(playerid,COLOR_RED,!"Prieiga uzdrausta! (Pasiekiama nuo 2 rango!)");
	global_str = "";
	foreach(new id: Player)
	{
		if(AddTimeMessages[id] > 0)
		{
			if(vipob[id] > 0) f(global_str, 1024,"{fcaa4d}[VIP] {ffffff}%s Siuntejas: %s			%dc\n",global_str,PN(id),Global_Time - AddTimeMessages[id]);
            else f(global_str,1024,"%s Siuntejas: %s			%dc\n",global_str,PN(id),Global_Time - AddTimeMessages[id]);
		}
	}
	if(strlen(global_str) > 0) SPD(playerid,556,2,"Redagavimas",global_str, !"Isrinkti", !"Uzdaryti"); else SPD(playerid,0,0,"Redagavimas","Siuo metu pranesimu nera", !"Uzdaryti","");
	return 1;
}
CMD:ad(playerid, data[])
{
    if(PI[playerid][pLevel] < 2)
		return SCM(playerid, COLOR_GREY, !"Reklama galima teikti tik nuo 2-ojo lygio");
    if AddTimeMessages[playerid] > 0 *then
		return SCM(playerid, COLOR_RED, !"Jus jau pateikete skelbima radakcijai!");
    if(TimeMessage[playerid] > Global_Time)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite taip daznai pateikti skelbimu!");
	if !ImprovementsData[playerid][idTablet]  && !IsPlayerInRangeOfPoint(playerid, 50.0, 1538.2813,1951.8353,1020.9574) *then
			return SCM(playerid, COLOR_GREY, !"Jus negalite cia pateikti skelbimo! Vykite i LS/SF/LV-Radijo stotis");
	new type;
	if sscanf(data, "ds[128]", type, data[0]) *then
    {
        SCM(playerid, -1, !"Naudokite: /ad [Tipas: 1 - Standart, 2 - VIP] [Tekstas]");
		SCM(playerid, COLOR_ORANGE, !">>>>{FFFFFF} - Standart skelbimo kaina - 1 000$");
        return SCM(playerid, COLOR_ORANGE, !">>>>{FFFFFF} - VIP skelbimo kaina - 3 000$");
    }
	if(!(1 <= strlen(data[0]) <= 100))
	   return SCM(playerid, COLOR_GREY, !"Skelbimo simboliu skaicius negali buti mazesnis nei 1 arba didesnis nei 100.");
	if !(1 <= type <= 2) *then
		return SCM(playerid, COLOR_ORANGE, !">>>>{FFFFFF} - Naudokite 1 - Standart skelbimas, 2 - VIP skelbimas!");
	else if type == 1 && PI[playerid][pMoney] < 1000 *then
		return SCM(playerid, COLOR_RED, !">>>>{FFFFFF} - Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
	else if type == 2 && PI[playerid][pMoney] < 3000 *then
		return SCM(playerid, COLOR_RED, !">>>>{FFFFFF} - Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
    SCM(playerid, COLOR_YELLOW, !"Jusu zinute uzregistruota sistemoje ir bus paskelbta po redagavimo!");
    f(global_str, 145, "Gavome pranesima apie skelbimu apdorojima nuo: %s", PN(playerid));
    SendTeamMessage(TEAM_RADIO, COLOR_WHITE, global_str);
    SendTeamMessage(TEAM_RADIOLV, COLOR_WHITE, global_str);
	SendTeamMessage(TEAM_RADIOSF, COLOR_WHITE, global_str);
    AddTimeMessages[playerid] = Global_Time;
    TimeMessage[playerid] = Global_Time + ( type > 1 ? 5:20);
	vipob[playerid] = type - 1;
    f(AddMessages[playerid], 128, "%s", data[0]);
	return GiveMoney(playerid, type > 1 ? -3000:-1000, "Ziniasklaidos pranesimas");
}
CMD:cure(playerid, params[])
{
	if(!IsAMedic(playerid)) return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nesate gydytojas!");
	if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /cure [id]");
	if(playerid == params[0]) return 0;
	if(!(Int_GetPlayerData(params[0], "DeathReturn") > 0)) return SCM(playerid, COLOR_OLDRED, !"Nereikia");
	KillTimer(DeathTimer[params[0]]);
	if(DeathText[params[0]]) DestroyDynamic3DTextLabel(DeathText[params[0]]);
	SetPVarInt(params[0], "DeathReturn", 0);
	UpdatePlayerHealth(params[0], 100);
	ClearAnimations(params[0]);
	TogglePlayerControllable(params[0], true);
	GiveMoney(playerid, 40000);
	return 1;
}
CMD:heal(playerid, params[])
{
	if(!IsAMedic(playerid))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate gydytojas!");
	if(!TeamDuty{playerid})
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Noredami gydyti pacientus, turite buti budejime!");
    extract params -> new player:target; else
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /heal [id]");
	if(target == INVALID_PLAYER_ID)
	    return 0;
	if(!ProxDetectorS(4.0, playerid, target))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo");
   	new carid = GetPlayerVehicleID(playerid);
	if VehicleInfo[carid][vTeam] == TEAM_M4C || VehicleInfo[carid][vTeam] == TEAM_MEDICSF || VehicleInfo[carid][vTeam] == TEAM_MEDICLV ||
	IsPlayerInRangeOfPoint(playerid, 70, 1143.8265,-1310.5242,1019.4139) *then
	{
	    SCM(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus pateikete gydymo pasiulyma.");
		f(global_str, 150, "\n\nGydytojas {dad540}%s {FFFFFF}nori jus isgydyti uz {dad540}$400\n\n", PN(playerid));
		SPD(target, 131, DIALOG_STYLE_MSGBOX, !"Gydymas", global_str, !"OK", !"Atsaukti");
		HealOffer[target] = playerid;
	}
	else SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Jus turite buti ligonineje arba automobilyje!");
	return true;
}
CMD:number(playerid, params[])
{
	if(GetCount(playerid, 327) < 1)
		return SCM(playerid, COLOR_GREY, !"Jus neturite telefonu knyga");
	new targetid;
    if(sscanf(params, "u", targetid))
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /number [id], kad suzinotumete zaidejo numeri!");
    if(targetid == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas yra neprisijunges!");
	if(PI[targetid][pAdmin])
	    return 0;
    if(!PI[targetid][pTelNum])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas neturi SIM korteles!");
    SetPlayerChatBubble(playerid, !"Ziuri telefonu knyga", COLOR_PURPLE, 10.0, 5000);
    new string[29 - 6 + MAX_PLAYER_NAME + 5 + 8];
	f(string, sizeof(string), "{FFFFFF}%s[%d]:    {33CCFF}%d", PN(targetid), targetid, PI[targetid][pTelNum]);
    SCM(playerid, -1, string);
	return 1;
}
CMD:fishes(playerid, params[])
{
	global_str = "";
	for(new i;i < 5;i ++) f(global_str, 200, "%s\n",global_str,FishName[PlayerFish[playerid][i]]);
	if(!SPD(playerid,0,0,"Zuvu sarasas",global_str,"OK",""))SCM(playerid, COLOR_GREY, !"Siuo metu neprieinama.");
	return 1;
}
CMD:go_fished(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(!InJob[playerid])
		{
			if(GetCount(playerid, 522) > 0)
			{
				if(GetCount(playerid, 523) > 0)
				{
					if(!Fishing{playerid})
					{
						for(new i;i < sizeof(FishZone);i ++)
						{
							if(IsPlayerInRangeOfPoint(playerid,2.0,FishZone[i][0],FishZone[i][1],FishZone[i][2]))
							{
								SetPlayerArmedWeapon(playerid, 0);
								if(!IsPlayerAttachedObjectSlotUsed(playerid, 7))SetPlayerAttachedObjectEx(playerid, 7,18632,6,0.079376,0.037070,0.007706,181.482910,0.000000,0.000000,1.000000,1.000000,1.000000);
								TogglePlayerControllable(playerid, false);
								ApplyAnimationEx(playerid,!"SWORD",!"SWORD_3",4.1, 0, 1, 1, 1, 0, 1);
								f(global_str, 128,"* %s meta kabli ir pagauna zuvi",PN(playerid));
								ProxDetector(25,playerid,global_str,COLOR_PURPLE);
								SetPlayerTimer(playerid,"PlayerFishing",15000 + random(10000),false);
								Fishing{playerid} = true;
							}
						}
					}
					else SCM(playerid,COLOR_GREY, !"Jus jau gaudote zuvi");
				}
				else SCM(playerid,COLOR_GREY, !"Jus neturite masalo");
			}
			else SCM(playerid,COLOR_GREY, !"Jus neturite meskeres");
		}
		else SCM(playerid,COLOR_GREY, !"Negalima zvejoti darbo metu");
	}
	return 1;
}
CMD:mask(playerid, params[])
{
    if(Cuffed[playerid]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate suristas ir negalite judeti");
	if(IsANotControllable(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite judeti");
    if(PI[playerid][pMaskON] ==0)
    {
		if(!GetCount(playerid, 319)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite kaukes!");
		if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 60 sekundziu!");
    	SetPVarInt(playerid, !"itemtime", Global_Time+60);
		DeleteItem(playerid, 319, 1);
		SetPlayerColor(playerid,0x665E5E01);
	    PI[playerid][pMaskON] = 600;
	    ApplyAnimationEx( playerid, "SHOP", "ROB_shifty", 4.1, 0, 1, 1, 0, 0 );
	    SCM(playerid,COLOR_GREEN, !"[Informacija] {FFFFFF}Jus sekmingai uzsidejote kauke.");
	    SCM(playerid,COLOR_BLUE, !"[Informacija] {FFFFFF}Kaukes veikimo laikas yra 10 minuciu, po kurio ja reikes ismesti.");
    }
    else
	{
	    PI[playerid][pMaskON]=0;
		if(TeamDuty{playerid}) SetPlayerColor(playerid,TeamColors[GetTeamID(playerid)]);
		else SetPlayerColor(playerid,0xFFFFFF80);
        SCM(playerid,COLOR_GREEN, !"[Informacija] {FFFFFF}Jus sekmingai ismetete kauke.");
	}
	return 1;
}
CMD:keys(playerid)
{
	global_str = "";
	new cars, carid; static Package[120];
	foreach(Vehicle, i)
	{
		if i == INVALID_VEHICLE_ID *then continue;
		carid = GetVehicleID(i);
		if IsAOwnableCar(i) && GetString(CarInfo[carid][cKeyer], PN(playerid)) *then
		{
		    ShowCar[playerid][cars] = i;
            if VehicleInfo[i][vModification] == 333 *then Package = "{FFD848}[Supreme]{FFFFFF}";
			else if VehicleInfo[i][vModification] == 578 *then Package = "{FFD848}[Twin Turbo]{FFFFFF}";
			else if VehicleInfo[i][vModification] == 548 *then Package = "{FFD848}[Launch]{FFFFFF}";
			else if VehicleInfo[i][vModification] == 587 *then Package ="{FFD848}[Halloween]{FFFFFF}";
			else if VehicleInfo[i][vModification] == 951 *then Package = "{FFD848}[PREMIUM]{FFFFFF}";
			else Package = "";
			if CarInfo[carid][cShtraf] *then f(global_str, 1024, "%s{FF6347}[X]{FFFFFF} %s(%d)\n", global_str, GetVehicleName(i), i);
			else f(global_str, 1024, "%s%s%s %s(%d)\n", global_str, CarInfo[carid][cParkedInPark] ? "{FF6347}[Nepastatyta]{FFFFFF}":"", Package, GetVehicleName(i), i);
		    cars ++;
		}
	}
	if !cars *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus neturite transporto raktu!");
	SPD(playerid, 162, DIALOG_STYLE_LIST, !"{FFFFFF}Raktai | {ae433d}Svetimas transportas", global_str, !"В»", !"x");
	return 1;
}
cmd:cars(playerid)
{
	format(global_str, 128, "SELECT * FROM ownable WHERE BINARY Owner = '%s'", PN(playerid));
	new Cache:result = mysql_query(mysql, global_str), count, carid, sqlid;
	count = cache_get_row_count(mysql);
	global_str = "";
	for new idx; idx < count; idx++ do
	{
		ShowCar[playerid][idx] = cache_get_row_int(idx, 0, mysql);
		carid = OnPlayerCarLoad( ShowCar[playerid][idx] ), sqlid = GetVehicleID( carid );
		if !carid *then
			format(global_str, 1024, "%s{FF5E5E}[Neikelta]{FFFFFF} %s%s", global_str, GetVehicleName(cache_get_row_int(idx, 1, mysql), true), cache_get_row_int(idx, 40, mysql) ? "\t{cccccc}- ikeliama prisijungimo metu\n" : "\n");
		else if CarInfo[sqlid][cShtraf] *then
			format(global_str, 1024, "%s{FF6347}[X]{FFFFFF} %s(%d)\n", global_str, GetVehicleName(carid), carid);
		else
		{
			switch VehicleInfo[carid][vModification] do
			{
				case 548: mysql_string = "{EAD064}[Launch]{FFFFFF}";
				case 578: mysql_string = "{EAD064}[Twin Turbo]{FFFFFF}";
				case 587: mysql_string = "{EAD064}[Halloween]{FFFFFF}";
				case 951: mysql_string = "{EAD064}[PREMIUM]{FFFFFF}";
				default: mysql_string = "";
			}
			format(global_str, 1024, "%s%s%s %s(%d)%s", global_str, CarInfo[sqlid][cParkedInPark] ? "{FF6347}[Nepastatyta]{FFFFFF}":"", mysql_string, GetVehicleName(carid), carid, CarInfo[sqlid][ConnectLoad] ? "\t{cccccc}- ikeliama prisijungimo metu\n" : "\n");
		}
	}
	cache_delete(result, mysql);
	if !count *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus neturite asmeninio transporto!");
	return SPD(playerid, 162, DIALOG_STYLE_LIST, !"Mano transportas", global_str, !"Isrinkti", !"Atsaukti");
}
CMD:showbinfo(playerid, params[])
{
	if sscanf(params, "du", params[0], params[1]) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /showbinfo [bizid] [name/id]");
	if params[1] == INVALID_PLAYER_ID *then return false;
	if params[0] < 0 || params[0] > OWNABLEBIZES *then return false;
	if !GetString(PN(playerid), BizData[params[0]][bOwner]) *then return false;
	ShowWeekBiz(params[1], params[0]);
	return false;
}
CMD:bizinfo(playerid)
{
	if(PI[playerid][pDemorgan])
    	return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sios komandos negalite naudoti sioje vietoje!");
	return ShowBusinessDialog(playerid, 0);
}
CMD:dejail(playerid, params[])
{
    if(GetTeamID(playerid) != TEAM_TSR) return 1;
    if(!TeamDuty{playerid}) return SCM(playerid, COLOR_RED, !"Jus nesate budejime!");
	if(PI[playerid][pRank] < 2) return SCM(playerid, COLOR_RED, !"Jus nesate priziuretojas!");
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /dejail [id]");
    SCM(playerid, COLOR_YELLOW, "Istraukete zaideja is GRK");
    SCM(params[0], COLOR_YELLOW, "Jus istraukete is GRK!");
	JailTSR[params[0]] = -1;
	PI[params[0]][pJailTime] = 0;
	PlayerSpawn(params[0]);
	SaveAccount(params[0]);
	return 0;
}
CMD:take(playerid, params[])
{
	if(!IsACop(playerid) ) return SCM(playerid,COLOR_GREY, !"Jus negalite atimti licenciju");
    new id;
    if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /take [id]");
    if(PI[playerid][pRank] < 6) return SCM(playerid,COLOR_GREY, !"Jus negalite atimti licenciju");
    if(!ProxDetectorS(2.0,playerid,id)) return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo!");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    TakeOffer[playerid] = id;
    SPD(playerid,88,2,"Ka atimti","Narkotikus\nSovinius\nGinkla\nLicencija","Atimti", !"Atsaukti");
	return 1;
}
CMD:incar(playerid, params[])
{
    new id,mesto;
    if (sscanf(params, "ud", id, mesto) || mesto < 1 || mesto > 3) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /incar [id] [vietos ID(1-3)]");
    if(!ProxDetectorS(4,playerid,id)) return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    new imcop = IsACop(playerid);
    new cuffed = (imcop && Cuffed[id]);
    if( !cuffed ) return SCM(playerid, COLOR_GREY, !"Sis zaidejas nera paralyziuotas");
    for(new i = 1;i < CountVehicles();i ++)
    {
        if(!IsACar(i)) continue;
        if(GetDoorsStatus(i)) continue;
        if(GetVehicleSeat(i, mesto) != INVALID_PLAYER_ID) continue;
        if( mesto > GetVehicleMaxSeat(i) ) continue;
        if( !( IsACopCar(i) && imcop )) continue;
        new Float:X,Float:Y,Float:Z;
        GetVehiclePos(i,X,Y,Z);
        if(!IsPlayerInRangeOfPoint(playerid,2.5,X,Y,Z)) continue;
        // nutraukiam /gotome tempima, kitaip laikmatis traukia zaideja is masinos (desync)
        new escort = GotoInfo[id][gtGoID];
        if(escort != INVALID_PLAYER_ID && IsPlayerConnected(escort)) GotoInfo[escort][gtID] = INVALID_PLAYER_ID;
        CheckPlayerGoCuff(id);
        TogglePlayerControllable(id, true);
        ClearAnimations(id, 1);
        SetPlayerSpecialAction(id, SPECIAL_ACTION_NONE);
        SetPlayerVirtualWorld(id, GetVehicleVirtualWorld(i));
        SetPlayerInterior(id, GetPlayerInterior(playerid));
        PutPlayerInVehicle(id, i, mesto);
        SetTimerEx("Incar_Freeze", 1500, false, "ii", id, i);
        f(global_str,128," %s itrauke %s i automobili.",PN(playerid),PN(id));
        ProxDetector(25,playerid,global_str,COLOR_PURPLE);
        break;
    }
    return 1;
}
CMD:outcar(playerid, params[])
{
	if(!IsPlayerLogged{playerid}) return 0;
	if(!IsACop(playerid)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Si komanda skirta tik policijai ir FBI!");
	if(!TeamDuty{playerid}) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate budejime!");
	new id;
	if(sscanf(params, "u", id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /outcar [id] (arba /isvesti [id])");
	if(id == INVALID_PLAYER_ID || !IsPlayerConnected(id) || !IsPlayerLogged{id}) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Zaidejas nerastas!");
	if(id == playerid) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Negalite isvesti saves!");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Pirmiausia islipkite is transporto priemones!");
	new veh = GetPlayerVehicleID(id);
	if(!veh) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Sis zaidejas nesedi transporto priemoneje!");
	if(GetPlayerState(id) == PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Negalite isvesti vairuotojo! Naudokite /cuff arba /eject.");
	new Float:vx, Float:vy, Float:vz;
	GetVehiclePos(veh, vx, vy, vz);
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, vx, vy, vz)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus esate per toli nuo transporto priemones!");
	if(!Cuffed[id] && !CuffedTime[id]) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Sis zaidejas nera surakintas ar paralyziuotas!");

	new Float:px, Float:py, Float:pz, Float:pa;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, pa);
	px += 1.0 * floatsin(-pa, degrees);
	py += 1.0 * floatcos(-pa, degrees);
	TogglePlayerControllable(id, true);
	RemovePlayerFromVehicle(id);
	SetPlayerInterior(id, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));
	SetPlayerPos(id, px, py, pz);
	SetPlayerFacingAngle(id, pa + 180.0);
	SetCameraBehindPlayer(id);
	if(Cuffed[id]) SetPlayerSpecialAction(id, SPECIAL_ACTION_CUFFED);

	f(global_str, 128, " %s isvede %s is transporto priemones.", PN(playerid), PN(id));
	ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);

	// jei surakintas ir pareigunas nieko neveda - automatiskai pradeda vesti (/gotome)
	if(Cuffed[id] && GotoInfo[playerid][gtID] == INVALID_PLAYER_ID && GotoInfo[id][gtGoID] == INVALID_PLAYER_ID)
	{
		CheckPlayerGoCuff(playerid);
		CheckPlayerGoCuff(id);
		GotoInfo[playerid][gtID] = id;
		GotoInfo[id][gtGoID] = playerid;
		GotoInfo[id][gtState] = GetPlayerState(playerid);
		GetPlayerPos(id, GotoInfo[id][gtX], GotoInfo[id][gtY], GotoInfo[id][gtZ]);
		SCM(playerid, COLOR_WHITE, !"[Informacija] {FFFFFF}Zaidejas eina paskui jus. Kad nustotumete vesti, iveskite {33AA33}/ungotome");
	}
	return 1;
}
CMD:isvesti(playerid, params[]) return callcmd::outcar(playerid, params);
CMD:arrest(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_GREY, !"Jus nesate policininkas!");
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    new Float:Distance[sizeof(PrisonPos)];
    Distance[0] = GetPlayerDistanceFromPoint(playerid,PrisonPos[0][0],PrisonPos[0][1],PrisonPos[0][2]);
    Distance[1] = GetPlayerDistanceFromPoint(playerid,PrisonPos[1][0],PrisonPos[1][1],PrisonPos[1][2]);
    Distance[2] = GetPlayerDistanceFromPoint(playerid,PrisonPos[2][0],PrisonPos[2][1],PrisonPos[2][2]);
    Distance[3] = GetPlayerDistanceFromPoint(playerid,PrisonPos[3][0],PrisonPos[3][1],PrisonPos[3][2]);
    Distance[4] = GetPlayerDistanceFromPoint(playerid,PrisonPos[4][0],PrisonPos[4][1],PrisonPos[4][2]);
    SCM(playerid,COLOR_LIGHTBLUE,"Vaziuokite i vieta, pazymeta raudonu zymekliu zemelapyje");
	for(new i;i<5;i++) TogglePlayerDynamicCP(playerid,JailCP[i],false);
    if(Distance[0] < Distance[1] && Distance[0] < Distance[2] && Distance[0] < Distance[3] && Distance[0] < Distance[4])
    {
        PlayerJailCP[playerid] = 0;
        TogglePlayerDynamicCP(playerid,JailCP[0],true);
    }
    else if(Distance[1] < Distance[0] && Distance[1] < Distance[2] && Distance[1] < Distance[3] && Distance[1] < Distance[4])
    {
        PlayerJailCP[playerid] = 1;
        TogglePlayerDynamicCP(playerid,JailCP[1],true);
    }
    else if(Distance[2] < Distance[0] && Distance[2] < Distance[1] && Distance[2] < Distance[3] && Distance[2] < Distance[4])
    {
        PlayerJailCP[playerid] = 2;
        TogglePlayerDynamicCP(playerid,JailCP[2],true);
    }
    else if(Distance[3] < Distance[0] && Distance[3] < Distance[1] && Distance[3] < Distance[2] && Distance[3] < Distance[4])
    {
        PlayerJailCP[playerid] = 3;
        TogglePlayerDynamicCP(playerid,JailCP[3],true);
    }
    else if(Distance[4] < Distance[0] && Distance[4] < Distance[1] && Distance[4] < Distance[2] && Distance[1] < Distance[3])
    {
        PlayerJailCP[playerid] = 4;
        TogglePlayerDynamicCP(playerid,JailCP[4],true);
    }
	return 1;
}
CMD:en(playerid, params[])
{
	if !(GetPlayerState(playerid) == 2) *then return false;

	else if engines[playerid] > Global_Time *then return SCM(playerid,COLOR_GREY, !"Negalima taip daznai uzvesti variklio");

	new carid = GetPlayerVehicleID(playerid);
	if IsAVelik(carid) || IsARC(carid) || IsASkate(carid) *then return false;
	else if(GetEngineStatus(carid) < 1)
	{
	    if(GetPlayerVirtualWorld(playerid)!=1228)
	    {
		    if(IsACar(carid) && !GetPlayerLicense(playerid, 0) && CarTest[playerid] == -1) return 0;
		    if(IsABike(carid) && !GetPlayerLicense(playerid, 1) && MotoTest[playerid] == -1) return 0;
		    if(IsABoat(carid) && !GetPlayerLicense(playerid, 3)) return 0;
	    }
	    if Fuel[carid] > 0.0 or Fuel[carid] <= 0.0 && IsAPlane(carid) *then
	    {
	        if(IsASellCar(carid)) return 1;
			else if !IsAOwnableCar(carid) && GetArendCarID(carid) != -1 && ArendInfo[GetArendCarID(carid)][aRentID] != playerid *then return RemovePlayerFromVehicle(playerid);
   			else if(!IsAOwnableCar(carid) || CarInfo[GetVehicleID(carid)][cKeyIN])
		    {
			    new Float:Health, string[50];
			    GetVehicleHealth(carid, Health);
			    if(Health > 1000) Health = 1000.0;
			    else if(Health < 400) return SCM(playerid, COLOR_GREY, !"Negalite uzvesti variklio. Kreipkites i mechanika, kad ji pataisytu");
			    new UNEngine = floatround(2000.0 - Health);
			    if(UNEngine < 0) UNEngine = 0;
			    else if(UNEngine > 2000) UNEngine = 2000;
			    CallTimeOutFunction("EngineVehicle", UNEngine, false, "ii", playerid, carid);
			    f(string, 128, "%s bando uzvesti varikli", PN(playerid));
			    ProxDetector(25.0, playerid, string, COLOR_PURPLE);
			    engines[playerid]=Global_Time+4;
			    if(pTemp[playerid][pSellCar] != -1 && autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarplayerid] == playerid) {
				    SCM(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Transportas buvo pasalinta is pardavimo, nes jus arba transportas paliko vieta!");
				    autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarCarID] = INVALID_VEHICLE_ID;
				    autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarplayerid] = INVALID_PLAYER_ID;
					DestroyDynamic3DTextLabel(autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarText]);
					for new z; z < 4; z++ do DestroyDynamicObject(autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarObject][z]);
				    DestroyDynamicArea(autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarArea]);
			    	if(autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarType] == 1) {
			    		UpdateDynamic3DTextLabelText(autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarLabel], -1, !"Pardavimo vieta {33aa33}[Laisva]\n{d1ca61}Tipas: dvir/auto/moto\n{FFFFFF}Noredami uzimti, paspauskite 'ALT'");
			    	}
			    	else {
			    		UpdateDynamic3DTextLabelText(autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarLabel], -1, !"Pardavimo vieta {33aa33}[Laisva]\n{d1ca61}Tipas: sraigtasparniai\n{FFFFFF}Noredami uzimti, paspauskite 'ALT'");
			    	}
					pTemp[playerid][pSellCar] = -1;
				}
		    }
		    else return SCM(playerid, COLOR_GREY, !"Reikia ideti raktus i uzdegima. Naudokite: /key");
	    }
		else return SCM(playerid, COLOR_GREY, !"Butina papildyti si transporto priemones degalus"),	PlayerNotification(playerid, "error","Pranesimas","Butina papildyti si transporto priemones degalus",1500);
	}
	else
	{
		SetEngineStatus(carid,false, playerid);
		f(global_str, 70," %s uzgesino varikli",PN(playerid));
		ProxDetector(25.0,playerid,global_str,COLOR_PURPLE);
	}
	return 1;
}
CMD:live(playerid, params[])
{
	if(!IsANews(playerid)) return SCM(playerid,COLOR_RED, !"Jus nesate reporteris!");
	if(PI[playerid][pRank]<6)return SCM(playerid,COLOR_RED,!"Prieiga uzdrausta! (Pasiekiama nuo 6 rango!)");
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    new carid = GetPlayerVehicleID(playerid);
	if(IsANewsCar(carid) || IsPlayerInRangeOfPoint(playerid,50,-161.72, 1340.78, 1500.99))
	{
	    if(LiveOffer[playerid] != INVALID_PLAYER_ID) return 0;
	   	new id;
	    if(sscanf(params,"u",id)) return SCM(playerid,COLOR_OLDRED, !"Naudokite: /live [id/name]");
	    if(!IsPlayerConnected(id) || id == playerid) return 0;
        if(!IsPlayerInVehicle(id,GetPlayerVehicleID(playerid))) return 0;
	    f(global_str, 150 ,"Reporteris %s siulo jums pasikalbeti su juo tiesioginiame eteryje",PN(playerid));
	    SPD(id,146,0,"Pokalbis",global_str,"Sutinku","Nereikia");
		LiveOfferID[id] = playerid;
	}
	else SCM(playerid, COLOR_GREY, !"Jus turite buti radijo stoties automobilyje arba naujienu agenturos pastate!");
	return 1;
}
CMD:endlive(playerid, params[])
{
	if(!IsANews(playerid)) return SCM(playerid,COLOR_RED, !"Jus nesate reporteris!");
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    if(LiveOffer[playerid] == INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, !"Siuo metu nepasiekiama");
    new id = LiveOffer[playerid];
    static getradio[40];
    switch(PI[playerid][pMember])
    {
        case TEAM_RADIO: getradio = "LS";
        case TEAM_RADIOSF: getradio = "SF";
        case TEAM_RADIOLV: getradio = "LV";
        default: getradio = "";
    }
    if(!IsPlayerConnected(id) || id == playerid) return SCM(playerid, COLOR_GREY, !"Neteisingas ID");
    TogglePlayerControllable(LiveOfferID[id], true);
    f(global_str, 128,"[Radio %s] Reporteris %s baige pokalbi su %s.",getradio,PN(playerid), PN(id));
	SCMALL(COLOR_LIME, global_str);
    f(global_str, 128,"Reporteris %s %s baige pokalbi su jumis.",getradio,PN(playerid));
	SCM(id, COLOR_GREY, global_str);
	f(global_str, 100,"Jus baigete pokalbi su %s.",PN(playerid));
	SCM(playerid, COLOR_GREY, global_str);
	LiveOfferID[playerid] = INVALID_PLAYER_ID;
	LiveOfferID[id] = INVALID_PLAYER_ID;
	return 1;
}
CMD:advokats(playerid)
{
	SCM(playerid, COLOR_ORANGE, !"Prisijunge advokatai:");
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerJob[i] == 6 && PI[i][pTelNum] != 0)
			{
			    f(global_str, 68, "Advokatas %s(%d) | Telefono numeris: %d", PN(i), i, PI[i][pTelNum]);
				SCM(playerid, COLOR_LIGHTBLUE, global_str);
			}
		}
	}
	return 1;
}
CMD:zeks(playerid, params[])
{
	if(PlayerJob[playerid]!=JOB_ADVOKAT) return SCM(playerid, COLOR_GREY, !"Jus nesate advokatas.");
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
			if(PI[i][pJailTime] > 0)
			{
				switch(GetPlayerVirtualWorld(i))
				{
				    case 11: global_str ="Red Country PD";
				    case 12: global_str ="Las-Venturas PD";
				    case 13: global_str ="San Fierro PD";
				}
				f(global_str,145,"%s(%d) | Laikas: %d min | Uzstatas: $%d | Vieta: %s.",PN(i),i,PI[i][pJailTime]/60,PI[i][pBailPrice],global_str);
				SCM(playerid,COLOR_GREY,global_str);
			}
		}
	}
	return 1;
}
CMD:z(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_RED, !"Jus nesate policininkas!");
	if(PI[playerid][pRank] < 2) return SCM(playerid,COLOR_RED,!"Zaidejo zymejimas galimas nuo 2 rango!");
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime");
	new id;
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /z [id]");
 	if(IsACop(id))return SCM(playerid,COLOR_GREY, !"Negalima pazymeti policininka!");
	if(!ProxDetectorS(200,playerid,id)) return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo. Reikia privaziuoti prie zaidejo mazdaug per 200 metru");
    if(zap[id]) return SCM(playerid, COLOR_GREY, !"Zaideja jau pazymejo");
    SCM(playerid, COLOR_YELLOW, "Jus pazymejote zaideja, jums reikia ji surakinti per 10 minuciu.");
	zap[id] = 600;
    SPD(id, 0, 0, "Informacija", "{FFFFFF}Jus pazymejo policija, turite 10 minuciu, kad jusu nesuimtu.\nPo pasibaigusio laiko, zyme bus nuimta!\n{FF0000}Jei iseisite is serverio, busite\nautomatiskai ikalintas!", "Supratau", "");
	return 1;
}
CMD:cuff(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_RED, !"Jus nesate policininkas!");
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime");
	new id;
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /cuff [id/name]");
 	if(IsACop(id))return SCM(playerid,COLOR_GREY, !"Negalima uzdeti antrankiu policininkui");
	if(!ProxDetectorS(1.5,playerid,id)) return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
	if(CuffedTime[id] <= 0 || PlayerSpeed(id)) return SCM(playerid, COLOR_GREY, !"Pirmiausia reikia apsvaiginti zaideja");
    if(Cuffed[id]) return SCM(playerid, COLOR_GREY, !"Zaidejas jau surakintas");
    if(PlayerOfCuff[playerid] != INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, !"Jus jau kazka surakinate");
    if(PlayerOfCuff[id] != INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, !"Zaideja jau surakina");
    PlayerOfCuff[playerid] = id;
    PlayerOfCuff[id] = playerid;
    TimeOfCuff[playerid] = 4;
    Recuffer[id]=playerid;
	CuffedTime[id] = 30;
    f(global_str, 128 ,"%s pradeda surakinti %s",PN(playerid),PN(id));
    ProxDetector(25,playerid, global_str,COLOR_PURPLE);
    ApplyAnimationEx(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.1, 0, 1, 1, 1, 0, 1);
	return 1;
}
CMD:uncuff(playerid, params[])
{
	if(!IsACop(playerid) && PI[playerid][pAdmin] < 1) return SCM(playerid,COLOR_RED, !"Jus nesate policininkas!");
	new id;
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /uncuff [id/name]");
	if(!ProxDetectorS(2.5,playerid,id)) return SCM(playerid, -1, !"Jus esate toli nuo zaidejo!");
	if(!Cuffed[id]) return SCM(playerid, -1, !"Zaidejas nesurakintas");
	f(global_str, 128," %s nueme antrankius nuo %s",PN(playerid),PN(id));
	ProxDetector(25,playerid,global_str,COLOR_PURPLE);
	Cuffed[id] = false;
	CuffedTime[id] = 0;
	Recuffer[id]=INVALID_PLAYER_ID;
	TogglePlayerControllable(id,true);
	SetPlayerSpecialAction(id, 0);
	if(GotoInfo[playerid][gtID] == id)
	{
	    CheckPlayerGoCuff(id);
		CheckPlayerGoCuff(playerid);
	}
	return 1;
}
CMD:bot(playerid, params[])
{
    if(!IsACop(playerid) && PI[playerid][pAdmin] < 1) return SCM(playerid,COLOR_RED, !"Jus nesate policininkas!");
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /bot [id/name]");
    if(!ProxDetectorS(1.5,playerid,params[0])) return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
	if(pTemp[params[0]][BreakCount]==0) return SCM(playerid,COLOR_RED,!"Sis zaidejas nesistengia sulauzyti antrankiu!");
    CheckBreakCuff(params[0]);
    CheckTheftCar(params[0]);
	DeleteItem(playerid, 328, GetCount(playerid, 328));
    SCM(params[0],COLOR_GREY, !"[Klaida] {FFFFFF}Is jusu ateme savarzeles!");
	SCM(playerid,COLOR_VALIK, !"Jus sekmingai atemete savarzeles.");
	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 1, 0, 0, 0, 1);
	return 1;
}
CMD:break(playerid, params[])
{
	if(GotoInfo[playerid][gtGoID]!=INVALID_PLAYER_ID)return SCM(playerid, COLOR_GREY, !"Konvojaus metu negalite naudoti savarzeliu!");
	if(GetCount(playerid, 328) < 1) return SCM(playerid, COLOR_GREY, !"Jus neturite savarzeliu");
	if(!Cuffed[playerid]) return SCM(playerid, COLOR_GREY, !"Jus nesate surakintas");
    if(CuffedTime[playerid]) return SCM(playerid, COLOR_RED, !"Jus nesate paralyziuotas!");
    CheckMiner(playerid);
    CheckBreakCuff(playerid);
    CheckTheftCar(playerid);
    SetPlayerRandomKey(playerid, pTemp[playerid][BreakKey], true);
    ShowPlayerActionBand(playerid, 0, 20);
    f(global_str, 100," %s istrauke savarzeles, kad sulauzytu antrankius",PN(playerid));
    SetPlayerChatBubble(playerid, global_str, COLOR_PURPLE, 10.0, 5000);
	return 1;
}
CMD:breakcar(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid)) return 1;
    if(IsANotControllable(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite judeti");
    if(!GetCount(playerid, 713)) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Neturite lauztuvelio, nusipirkite ji automobiliu daliu parduotuveje");
	if(TheftCarID[playerid] != 0) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus jau lauziate transporto priemone");
    new Float:X, Float:Y, Float:Z;
    foreach(Vehicle, i)
    {
        if(OwnableCar[i] == INVALID_VEHICLE_ID) continue;
        new carid = OwnableCar[i];
        if(!IsAOwnableCar(carid)) continue;
        GetVehiclePos(carid, X, Y, Z);
        if(CarInfo[i][cLock] != 1) continue;
        if(IsABike(carid) || IsAVelik(carid) || IsAMoped(carid) || IsASkate(carid)) continue;
        if(!IsPlayerInRangeOfPoint(playerid, 2.0, X, Y, Z)) continue;
        if(!IsPlayerAimingAt(playerid, X, Y, Z, 2.0)) continue;
        CheckTheftCar(playerid);
        CheckMiner(playerid);
        CheckBreakCuff(playerid);
        TheftCarID[playerid] = carid;
        TheftCount[playerid] = 0;
        TogglePlayerControllable(playerid, false);
        ApplyAnimationEx(playerid, !"ROB_BANK", !"CAT_Safe_Rob", 4.1, 0, 1, 1, 1, 0, 1);
        SetPlayerRandomKey(playerid, TheftKey[playerid], true);
        ShowPlayerActionBand(playerid, 0, 10);
		DeleteItem(playerid, 713, 1);
        return 1;
    }
    SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Salia jusu nera tinkamo transporto!");
    return 1;
}
CMD:clear(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_GREY, !"Jus nesate policininkas!");
    if(PI[playerid][pRank] < 5) return SCM(playerid,COLOR_GREY, !"Jusu rangas yra per mazas siai operacijai. Reikalingas 5 rangas.");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    new id;
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /clear [id/name]");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_RED, !"Neteisingas zaidejo ID!");
    PI[id][pWanted] = 0;
    SetPlayerWantedLevel(id, 0);
    f(global_str, 100,"Policininkas %s nuvale paieska %s[%d]",PN(playerid), PN(id), id);
    SendCopsMessage(COLOR_LIGHTBLUE,global_str);
    f(global_str, 100,"Policininkas %s nuvale jusu paieska",PN(playerid));
    SCM(id,COLOR_LIGHTBLUE,global_str);
    f(global_str, 100,"Jus isvalete paieska %s[%d]",PN(id), id);
    SCM(playerid,COLOR_LIGHTBLUE,global_str);
	return 1;
}
CMD:id(playerid, params[])
{
    new targetid;
	if sscanf(params, "u", targetid) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /id [id/name]");
    new insert_pos, i;
    static const LauncherName[2][13] = {"be Launcher", "Launcher"};
	if !IsNums(params) && strlen(params) < 3 *then return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Iveskite bent 3 simbolius paieskai!");
	if !IsNums(params) *then
	{
		foreach(Player, id)
		{
			if IsPlayerNPC(id) *then continue;

			GetPlayerName(id, global_str, 25);

			insert_pos = strfind(global_str, params, true);
			if !(insert_pos == -1) *then
			{
				strins(global_str, "{FFFFFF}", strlen(params) + insert_pos);
				strins(global_str, "{FF8888}", insert_pos);
				f(global_str, 128, "[%d] %s | Lygis: %d | UID: %d | packetloss: %0.2f (%s)", id, global_str, PI[id][pLevel], PI[id][pID], NetStats_PacketLossPercent(id), LauncherName[GetPlayerLauncher(id)]);
				SCM(playerid, -1, global_str);
				i++;
			}
		}
	}
	else if !(targetid == INVALID_PLAYER_ID) && !IsPlayerNPC(targetid) *then
		return SCMF(playerid, -1, "[%d] %s | Lygis: %d | UID: %d | packetloss: %0.2f (%s)", targetid, PN(targetid), PI[targetid][pLevel], PI[targetid][pID], NetStats_PacketLossPercent(targetid), LauncherName[GetPlayerLauncher(targetid)]);
	if !i *then SCMF(playerid, COLOR_OLDRED, "[Klaida] {FFFFFF}Zaidejas \'%s\' nerastas!", params);
    return true;
}
CMD:boom(playerid)
{
	if !(AksSlot[playerid][0][5] == 348) && !(AksSlot[playerid][0][5] == 334) *then
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite boombox/koloneles!");
	else if IsPlayerInAnyVehicle(playerid) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite pastatyti boombox automobilyje!");
	if bumboxobject[playerid] *then
	{
		if !IsPlayerInRangeOfPoint(playerid, 3.0, BumBoxPos[playerid][0], BumBoxPos[playerid][1], BumBoxPos[playerid][2]) *then
			return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus esate per toli nuo boombox/koloneles!");
		DestroyDynamic3DTextLabel(bumbox3D[playerid]);
		DestroyDynamicObject(bumboxobject[playerid]);
		boombox[playerid] = RadioID[playerid] = bumboxobject[playerid] = 0;
		foreach(Player,i)
		{
			if IsPlayerInRangeOfPoint(playerid,30.0, BumBoxPos[playerid][0], BumBoxPos[playerid][1], BumBoxPos[playerid][2]) *then
				StopAudioStreamForPlayerFix(i);
		}
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 1, 0, 0, 0, 1);
		SetPlayerAccessory(playerid, AksSlot[playerid][0][5], 5);
		return SCM(playerid, COLOR_RED, !"[Informacija] {ffffff}Jus pasiemete savo boombox/kolonele!");
	}
	else
	{
		foreach(new i: Player)
		{
			if !bumboxobject[i] *then continue;
			if IsPlayerInRangeOfPoint(playerid, 30.0, BumBoxPos[i][0], BumBoxPos[i][1], BumBoxPos[i][2]) *then
			    return SCM(playerid, COLOR_RED, !"[Klaida] {ffffff}Kazkas netoliese jau pastate boombox/kolonele!");
   		}
		GetPlayerPos(playerid, BumBoxPos[playerid][0], BumBoxPos[playerid][1], BumBoxPos[playerid][2]);
		ApplyAnimationEx(playerid, !"BOMBER", !"BOM_Plant", 4.0, 0, 1, 0, 0, 0, 1);
		SCM(playerid, COLOR_GREEN, !"Sekmingai pastatete boombox ant grindu.");
		SCM(playerid, COLOR_GREEN, !"Noredami atidaryti grojarasti, paspauskite ALT prie boombox.");
		SetPlayerChatBubble(playerid, (AksSlot[playerid][0][5] == 348) ? ("Padejo boombox ant zemes") : ("Padejo kolonele ant zemes"), COLOR_PURPLE, 10.0, 5000);
		BumBoxPos[playerid][0] += 1.0;
	 	BumBoxPos[playerid][1] += 1.0;
	  	BumBoxPos[playerid][2] -= 1.0;
		bumboxobject[playerid] = CreateDynamicObject(ItemsInfo[ AksSlot[playerid][0][5] ][ItemModel], BumBoxPos[playerid][0], BumBoxPos[playerid][1], BumBoxPos[playerid][2], 0.0, 0.0, 0.0);
		area_boombox[playerid] = CreateDynamicCircle(BumBoxPos[playerid][0], BumBoxPos[playerid][1], 30.0, 0, 0, -1);
        f(global_str, 60, "Pastate: {FFFFFF}%s", PN(playerid));
        bumbox3D[playerid] = CreateDynamic3DTextLabel(global_str, 0x3c7d4cFF, BumBoxPos[playerid][0], BumBoxPos[playerid][1], BumBoxPos[playerid][2], 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 5.0);
	    RemovePlayerAttachedObject(playerid, 5);
	    boombox[playerid] = 1;
	}
	return true;
}
CMD:leaders(playerid)
{
	SCM(playerid, COLOR_OLDRED, !"Prisijunge lyderiai:");
	foreach(new i: Player)
	{
		if(!PI[i][pLeader])
			continue;
		switch(PI[i][pLeader])
		{
			case TEAM_LSPD: global_str = "{FFBF00}Policija LS";
			case TEAM_RCPD: global_str = "{FFCC00}RCPD";
			case TEAM_FBI: global_str = "{FFBF00}FBI";
			case TEAM_SFPD: global_str = "{FFBF00}Policija SF";
			case TEAM_M4C: global_str = "{F7819F}Ligonine LS";
			case TEAM_MEDICLV: global_str = "{F7819F}Ligonine LV";
			case TEAM_MERIALS: global_str = "{FF0000}Savivaldybe";
			case TEAM_ARMYLV: global_str = "{996633}Kariuomene LV";
			case TEAM_MEDICSF: global_str = "{F7819F}Ligonine SF";
			case TEAM_LICENSERS: global_str = "{2E9AFE}Licenciju isdavejai";
			case TEAM_RADIO: global_str = "{FF8000}Radio LS";
			case TEAM_GROOVE: global_str = "{04B404}Grove";
			case TEAM_VAGOS: global_str = "{DBA901}Vagos";
			case TEAM_BALLAS: global_str = "{DF01D7}Ballas";
			case TEAM_CORONOS: global_str = "{00FFFF}Aztecas";
			case TEAM_RIFA: global_str = "{0489B1}Rifa";
			case TEAM_RM: global_str = "{08298A}Russian Mafia";
			case TEAM_YAKUZA: global_str = "{DF0101}Yakuza";
			case TEAM_LCN: global_str = "{DBA901}La Cosa Nostra";
			case TEAM_BIKERS: global_str = "{585858}Warlock MC";
			case TEAM_ARMY: global_str = "{996633}Kariuomene LS";
			case TEAM_BANK: global_str = "{2E9AFE}Centrinis bankas";
			case TEAM_LVPD: global_str = "{FFBF00}Policija LV";
			case TEAM_RADIOLV: global_str = "{FF8000}Radio LV";
			case TEAM_WOLFS: global_str = "{7F6464}Night Wolfs";
			case TEAM_RADIOSF: global_str = "{FF8000}Radio SF";//color
			case TEAM_ARMYSF: global_str = "{996633}Kariuomene SF";//color
			case TEAM_TSR: global_str = "{996633}Griezto Rezimo Kalejimas";//color
			case TEAM_STRAH: global_str = "{336699}Draudimo kompanija";
			case TEAM_JEFFERSON: global_str = "{F7819F}Ligonine Jefferson";
		}
		new
			dirit[12];
		if(!PI[i][pTelNum])
			dirit = "Neturima";
		else
			valstr(dirit, PI[i][pTelNum]);
		if(!PlayerAFKTime[i])
			f(global_str, 145, "{FFFFFF}%s[%d] - %s {FFFFFF}| Numeris: %s", PN(i), i, global_str, dirit);
		else
			f(global_str, 145, "{FFFFFF}%s[%d] - %s {FFFFFF}| Numeris: %s{FFFFFF} | AFK: %d sekundziu", PN(i), i, global_str, dirit, PlayerAFKTime[i]);
		SCM(playerid, COLOR_VALIK, global_str);
	}
	SCM(playerid, COLOR_VALIK, !"[Uzuomina]{FFFFFF}Noredami rasti organizacijos narius, naudokite /phone - menu.");
	return 1;
}
CMD:help(playerid)
{
    return ShowPlayerDialogEx(playerid, 64, DIALOG_STYLE_LIST, !"Pagalba del serverio",
		!"{633169}Daznai uzduodami klausimai\n\
		{AFAFAF}[CMD] Telefonas\n\
		{AFAFAF}[CMD] Darbas\n\
		{AFAFAF}[CMD] Organizacija\n\
		{AFAFAF}[CMD] Namas\n\
		{AFAFAF}[CMD] Verslas\n\
		{AFAFAF}[CMD] Asmeninis transportas\n\
		{AFAFAF}[CMD] Transportas\n\
		{AFAFAF}[CMD] Animacijos\n\
		{AFAFAF}[CMD] Chatai\n\
		{AFAFAF}[CMD] Admin\n\
		{AFAFAF}[CMD] Pagrobimas\n\
		{AFAFAF}[CMD] Kita\n\
		{AFAFAF}[FAQ] Ginklu igudziai\n\
		{AFAFAF}[FAQ] Darbas\n\
		{633169}[FAQ] Serverio taisykles\n\
		{633169}[FAQ] Privilegijos VIP/GOLD\n\
		{AFAFAF}[FAQ] Losimo automatas\n\
		{633169}[INFO] Site/Forumas/DC\n\
		{AFAFAF}[INFO] Atsakymai i testus\n\
  		{AFAFAF}[FAQ] Medziagu vagyste\n\
		{AFAFAF}[FAQ] Ukio pletra\n\
		{AFAFAF}[FAQ] Banko kortele\n\
		{AFAFAF}[FAQ] Zvejyba\n\
		{AFAFAF}[FAQ] Medziagu sunkvezimiu apiplesimas\n\
		{AFAFAF}[FAQ] Bagazine\n\
		{AFAFAF}[FAQ] Narkotiku prieglobsciai ir Gaujos\n\
		{AFAFAF}[FAQ] Sveikata\n\
		{AFAFAF}[CMD] Seima\n\
		{AFAFAF}[FAQ] Padeka administracijai",
		!"Isrinkti", !"Atsaukti");
}
CMD:settings(playerid)
	return ShowUpdateSettings(playerid);
CMD:stats(playerid)
	return ShowStats(playerid, playerid);
CMD:buydrugs(playerid, params[])
{
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /buydrugs [kiekis]");
    if(!IsPlayerInRangeOfPoint(playerid,10,331.9075,1119.5465,1083.8903)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    if(params[0]<1)return 1;
    switch(GetPlayerVirtualWorld(playerid))
    {
        case 1:
        {
            if(GLS[45]<params[0])return SendBotMessage(playerid,"Seni, atsiprasau, bet as jau neturiu prekiu!");
            if(PI[playerid][pMoney]<(GLS[50]*params[0]))return SendBotMessage(playerid,"Seni, tu juk neturi pinigu man sumoketi!");
            GiveMoney(playerid,-(GLS[50]*params[0]));
            GLS[45]-=params[0];
            GLS[60]+=GLS[50]*params[0];
            SaveInformation();
            AddItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo zole!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[45],GLS[60],GLS[55],GLS[50] );
            UpdateDynamic3DTextLabelText(NarkoText[0], COLOR_WHITE, global_str);
        }
        case 2:
        {
            if(GLS[46]<params[0])return SendBotMessage(playerid,"Seni, atsiprasau, bet as jau neturiu prekiu!");
            if(PI[playerid][pMoney]<(GLS[51]*params[0]))return SendBotMessage(playerid,"Seni, tu juk neturi pinigu man sumoketi!");
            GiveMoney(playerid,-(GLS[51]*params[0]));
            GLS[46]-=params[0];
            GLS[61]+=GLS[51]*params[0];
            SaveInformation();
            AddItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo zole!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[46],GLS[61],GLS[56],GLS[51]  );
            UpdateDynamic3DTextLabelText(NarkoText[1], COLOR_WHITE, global_str);
        }
        case 3:
        {
            if(GLS[47]<params[0])return SendBotMessage(playerid,"Seni, atsiprasau, bet as jau neturiu prekiu!");
            if(PI[playerid][pMoney]<(GLS[52]*params[0]))return SendBotMessage(playerid,"Seni, tu juk neturi pinigu man sumoketi!");
            GiveMoney(playerid,-(GLS[52]*params[0]));
            GLS[47]-=params[0];
            GLS[62]+=GLS[52]*params[0];
            SaveInformation();
            AddItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo zole!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[47],GLS[62],GLS[57],GLS[52]  );
            UpdateDynamic3DTextLabelText(NarkoText[2], COLOR_WHITE, global_str);
        }
        case 4:
        {
            if(GLS[48]<params[0])return SendBotMessage(playerid,"Seni, atsiprasau, bet as jau neturiu prekiu!");
            if(PI[playerid][pMoney]<(GLS[53]*params[0]))return SendBotMessage(playerid,"Seni, tu juk neturi pinigu man sumoketi!");
            GiveMoney(playerid,-(GLS[53]*params[0]));
            GLS[48]-=params[0];
            GLS[63]+=GLS[53]*params[0];
            SaveInformation();
            AddItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo zole!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[48],GLS[63],GLS[58],GLS[53]  );
            UpdateDynamic3DTextLabelText(NarkoText[3], COLOR_WHITE, global_str);
        }
        case 5:
        {
            if(GLS[49]<params[0])return SendBotMessage(playerid,"Seni, atsiprasau, bet as jau neturiu prekiu!");
            if(PI[playerid][pMoney]<(GLS[54]*params[0]))return SendBotMessage(playerid,"Seni, tu juk neturi pinigu man sumoketi!");
            GiveMoney(playerid,-(GLS[54]*params[0]));
            GLS[49]-=params[0];
            GLS[64]+=GLS[54]*params[0];
            SaveInformation();
            AddItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo zole!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[49],GLS[64],GLS[59],GLS[54]  );
            UpdateDynamic3DTextLabelText(NarkoText[4], COLOR_WHITE, global_str);
        }
        default: return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    }
	return 1;
}
CMD:selldrugs(playerid, params[])
{
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /selldrugs [kiekis]");
    if(GetCount(playerid, 525)<params[0]) return SendBotMessage(playerid,"Seni, tu juk neturi tiek prekiu pardavimui!");
    if(!IsPlayerInRangeOfPoint(playerid,10,331.9075,1119.5465,1083.8903)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    if(params[0]<1)return 1;
    switch(GetPlayerVirtualWorld(playerid))
    {
        case 1:
        {
            if(GLS[60]<(params[0]*GLS[55])) return SendBotMessage(playerid,"Seni, atsiprasau, bet as neturiu pinigu tau sumoketi!");
            GiveMoney(playerid,(GLS[55]*params[0]));
            GLS[60]-=(GLS[55]*params[0]);
            GLS[45]+=params[0];
            SaveInformation();
            DeleteItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo pinigus!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[45],GLS[60],GLS[55],GLS[50] );
            UpdateDynamic3DTextLabelText(NarkoText[0], COLOR_WHITE, global_str);
        }
        case 2:
        {
            if(GLS[61]<(params[0]*GLS[56])) return SendBotMessage(playerid,"Seni, atsiprasau, bet as neturiu pinigu tau sumoketi!");
            GiveMoney(playerid,(GLS[56]*params[0]));
            GLS[61]-=(GLS[56]*params[0]);
            GLS[46]+=params[0];
            SaveInformation();
            DeleteItem(playerid, 525, params[0]);
           	SendBotMessage(playerid,"Va, laikyk savo pinigus!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[46],GLS[61],GLS[56],GLS[51]  );
            UpdateDynamic3DTextLabelText(NarkoText[1], COLOR_WHITE, global_str);
        }
        case 3:
        {
            if(GLS[62]<(params[0]*GLS[57])) return SendBotMessage(playerid,"Seni, atsiprasau, bet as neturiu pinigu tau sumoketi!");
            GiveMoney(playerid,(GLS[57]*params[0]));
            GLS[62]-=(GLS[57]*params[0]);
            GLS[47]+=params[0];
            SaveInformation();
            DeleteItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo pinigus!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[47],GLS[62],GLS[57],GLS[52]  );
            UpdateDynamic3DTextLabelText(NarkoText[2], COLOR_WHITE, global_str);
        }
        case 4:
        {
            if(GLS[63]<(params[0]*GLS[58])) return SendBotMessage(playerid,"Seni, atsiprasau, bet as neturiu pinigu tau sumoketi!");
            GiveMoney(playerid,(GLS[58]*params[0]));
            GLS[63]-=(GLS[58]*params[0]);
            GLS[48]+=params[0];
            SaveInformation();
            DeleteItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo pinigus!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[48],GLS[63],GLS[58],GLS[53]  );
            UpdateDynamic3DTextLabelText(NarkoText[3], COLOR_WHITE, global_str);
        }
        case 5:
        {
            if(GLS[64]<(params[0]*GLS[59])) return SendBotMessage(playerid,"Seni, atsiprasau, bet as neturiu pinigu tau sumoketi!");
            GiveMoney(playerid,(GLS[59]*params[0]));
            GLS[64]-=(GLS[59]*params[0]);
            GLS[49]+=params[0];
			SaveInformation();
            DeleteItem(playerid, 525, params[0]);
            SendBotMessage(playerid,"Va, laikyk savo pinigus!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[49],GLS[64],GLS[59],GLS[54]  );
            UpdateDynamic3DTextLabelText(NarkoText[4], COLOR_WHITE, global_str);
        }
        default: return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    }
	return 1;
}
CMD:putmoney(playerid, params[])
{
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /putmoney [kiekis]");
    if(!IsPlayerInRangeOfPoint(playerid,10,331.9075,1119.5465,1083.8903)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    if(CanUse[playerid]==0)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite galimybes valdyti sio narkotiku prieglobsciu!");
    if(PI[playerid][pMoney]<params[0]) return SendBotMessage(playerid,"Seni, kaip tu gali man duoti tiek pinigu, jei ju neturi");
    if(params[0]<1)return 1;
	if(params[0]>5000000) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus negalite is karto paimti tiek pinigu!");
    if(PI[playerid][pRank]<9)return 1;
    switch(GetPlayerVirtualWorld(playerid))
    {
        case 1:
        {
			GiveMoney(playerid,-params[0]);
			SendBotMessage(playerid,"Opa, dabar mes galesim supirkti zole!");
			GLS[60]+=params[0];
			SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[45],GLS[60],GLS[55],GLS[50] );
            UpdateDynamic3DTextLabelText(NarkoText[0], COLOR_WHITE, global_str);
        }
        case 2:
        {
            GiveMoney(playerid,-params[0]);
            SendBotMessage(playerid,"Opa, dabar mes galesim supirkti zole!");
            GLS[61]+=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[46],GLS[61],GLS[56],GLS[51]  );
            UpdateDynamic3DTextLabelText(NarkoText[1], COLOR_WHITE, global_str);
        }
        case 3:
        {
            GiveMoney(playerid,-params[0]);
            SendBotMessage(playerid,"Opa, dabar mes galesim supirkti zole!");
            GLS[62]+=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[47],GLS[62],GLS[57],GLS[52]  );
            UpdateDynamic3DTextLabelText(NarkoText[2], COLOR_WHITE, global_str);
        }
        case 4:
        {
            GiveMoney(playerid,-params[0]);
            SendBotMessage(playerid,"Opa, dabar mes galesim supirkti zole!");
            GLS[63]+=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[48],GLS[63],GLS[58],GLS[53]  );
            UpdateDynamic3DTextLabelText(NarkoText[3], COLOR_WHITE, global_str);
        }
        case 5:
        {
            GiveMoney(playerid,-params[0]);
            SendBotMessage(playerid,"Opa, dabar mes galesim supirkti zole!");
            GLS[64]+=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[49],GLS[64],GLS[59],GLS[54]  );
            UpdateDynamic3DTextLabelText(NarkoText[4], COLOR_WHITE, global_str);
        }
        default: return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    }
	return 1;
}
CMD:setdbuy(playerid, params[])
{
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setdbuy [Narkotiku pardavimo kaina]");
    if(!IsPlayerInRangeOfPoint(playerid,10,331.9075,1119.5465,1083.8903)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    if(CanUse[playerid]==0)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite galimybes valdyti sio narkotiku prieglobsciu!");
    if(params[0]<1)return 1;
    if(params[0]>5000)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus negalite nustatyti tokia kaina!");
    if(PI[playerid][pRank]<9)return 1;
    switch(GetPlayerVirtualWorld(playerid))
    {
        case 1:
        {
			SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis pirks zole uz tokia kaina!");
			GLS[50]=params[0];
			SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[45],GLS[60],GLS[55],GLS[50] );
            UpdateDynamic3DTextLabelText(NarkoText[0], COLOR_WHITE, global_str);
        }
        case 2:
        {
            SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis pirks zole uz tokia kaina!");
            GLS[51]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[46],GLS[61],GLS[56],GLS[51]  );
            UpdateDynamic3DTextLabelText(NarkoText[1], COLOR_WHITE, global_str);
        }
        case 3:
        {
            SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis pirks zole uz tokia kaina!");
            GLS[52]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[47],GLS[62],GLS[57],GLS[52]  );
            UpdateDynamic3DTextLabelText(NarkoText[2], COLOR_WHITE, global_str);
        }
        case 4:
        {
            SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis pirks zole uz tokia kaina!");
            GLS[53]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[48],GLS[63],GLS[58],GLS[53]  );
            UpdateDynamic3DTextLabelText(NarkoText[3], COLOR_WHITE, global_str);
        }
        case 5:
        {
           	SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis pirks zole uz tokia kaina!");
            GLS[54]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[49],GLS[64],GLS[59],GLS[54]  );
            UpdateDynamic3DTextLabelText(NarkoText[4], COLOR_WHITE, global_str);
        }
        default: return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    }
	return 1;
}
CMD:setdsell(playerid, params[])
{
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /setdsell [Narkotiku supirkimo kaina]");
    if(!IsPlayerInRangeOfPoint(playerid,10,331.9075,1119.5465,1083.8903)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    if(CanUse[playerid]==0)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite galimybes valdyti sio narkotiku prieglobsciu!");
    if(params[0]<1)return 1;
    if(params[0]>5000)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus negalite nustatyti tokia kaina!");
    if(PI[playerid][pRank]<9)return 1;
    switch(GetPlayerVirtualWorld(playerid))
    {
        case 1:
        {
			SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis parduos zole uz tokia kaina!");
			GLS[55]=params[0];
			SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[45],GLS[60],GLS[55],GLS[50] );
            UpdateDynamic3DTextLabelText(NarkoText[0], COLOR_WHITE, global_str);
        }
        case 2:
        {
            SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis parduos zole uz tokia kaina!");
            GLS[56]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[46],GLS[61],GLS[56],GLS[51]  );
            UpdateDynamic3DTextLabelText(NarkoText[1], COLOR_WHITE, global_str);
        }
        case 3:
        {
            SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis parduos zole uz tokia kaina!");
            GLS[57]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[47],GLS[62],GLS[57],GLS[52]  );
            UpdateDynamic3DTextLabelText(NarkoText[2], COLOR_WHITE, global_str);
        }
        case 4:
        {
            SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis parduos zole uz tokia kaina!");
            GLS[58]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[48],GLS[63],GLS[58],GLS[53]  );
            UpdateDynamic3DTextLabelText(NarkoText[3], COLOR_WHITE, global_str);
        }
        case 5:
        {
           	SendBotMessage(playerid,"Gerai, dabar narkotiku prieglobstis parduos zole uz tokia kaina!");
            GLS[59]=params[0];
            SaveInformation();
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[49],GLS[64],GLS[59],GLS[54]  );
            UpdateDynamic3DTextLabelText(NarkoText[4], COLOR_WHITE, global_str);
        }
        default: return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    }
	return 1;
}
CMD:dropgun(playerid, param[])
{
    if(IsPlayerInAnyVehicle(playerid)) return 0;
	new weapon = GetPlayerWeapon(playerid);
	new ammo = GetPlayerAmmo(playerid);
	new slot = GetWeaponSlot(weapon);
	if(ammo < 1 ) return 0;
	if(weapon < 1) return SCM(playerid, COLOR_GREY, !"[Uzuomina] {FFFFFF}Jus neturite ginklo rankose");
	if(PI[playerid][pGuns][GetWeaponSlot(weapon)] != weapon)return 0;
	if(PI[playerid][pAmmos][slot] != GetPlayerAmmo(playerid))return 0;
    new Float:x, Float:y, Float:z,Float:eagle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid,eagle);
	new idgun;
	switch(weapon)
    {
        case 17:idgun=343;
		case 22:idgun=346;
		case 23:idgun=347;
		case 24:idgun=348;
		case 25:idgun=349;
		case 28:idgun=352;
		case 29:idgun=353;
		case 30:idgun=355;
		case 31:idgun=356;
		case 32:idgun=372;
		case 33:idgun=357;
		case 34:idgun=358;
		case 42:idgun=366;
		case 43:idgun=367;
		default: return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Sio ginklo negalima ismesti!");
    }
	new idobject=-1;
    for(new i;i<MAX_DGUNS;i++)
    {
        if(dguns[i]==-1)
		{
 			idobject=i;
	 		break;
		}
    }
    if(idobject==-1)
    {
        new min1=Global_Time;
        for(new i;i<MAX_DGUNS;i++)
        {
            if(dguntime[i]<min1)
            {
                min1=dguntime[i];
                idobject=i;
            }
        }
        DestroyDynamicObject(dguns[idobject]);
    }
    dguntime[idobject]=Global_Time;
    dpatrons[idobject]=ammo;
    dgunn[idobject]=weapon;
    dguns[idobject] = CreateDynamicObject(idgun, x, y, z-0.97, 96, 110, eagle, GetPlayerVirtualWorld(playerid));
	_GiveGun(playerid,weapon,-ammo);
	PI[playerid][pGuns][slot] = 0;
	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 2, 0, 0, 0, 0, 0);
	SCM(playerid,COLOR_GREY, !"[Informacija] {FFFFFF}Jus padejote ginkla ant zemes.");
	PI[playerid][pLastGun]=0;
	PI[playerid][pLastAmmo]=0;
    return 1;
}
CMD:firewood(playerid)
{
    if(Cuffed[playerid])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus surakintas ir negalite judeti");
	if(IsANotControllable(playerid))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite judeti!");
	if(GetCount(playerid, 552) < 1)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite malku! Ju galite nusipirkti degalines parduotuveje!");
    if(GetCount(playerid, 320) < 1)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite ziebtuvelio! Galite nusipirkti parduotuveje 24/7!");
	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudoti pastate draudziama!");
    if(IsPlayerInAnyVehicle(playerid))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Transporte negalima");
	if(IsPlayerToKvadrat(playerid, 850, 590, 2914, 2902) || IsPlayerToKvadrat(playerid, -2918, -1010, -1210, 1378) || IsPlayerToKvadrat(playerid, 82, -1882, 2906, -870) || IsPlayerToKvadrat(playerid, 1358, -2742, 2910, -1882))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Mieste draudziama kurti lauzus!");
	new
		Float:x,
		Float:y,
		Float:z,
		Float:a;
	for(new i; i < MAX_WOODS; i++)
	{
	    if(wwoods[i] != -1)
	    {
	        GetDynamicObjectPos(wwoods[i], x, y, z);
			if(IsPlayerInRangeOfPoint(playerid, 2, x, y, z))
				return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite cia kurti lauzo, nes salia jau yra vienas!");
		}
	}
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
	new
		idobject = -1;
    for(new i; i < MAX_WOODS; i++)
    {
        if(wwoods[i] == -1)
		{
 			idobject = i;
	 		break;
		}
    }
    if(idobject == -1)
    {
        new min1 = Global_Time;
        for(new i; i < MAX_WOODS; i++)
        {
            if(wwoodtime[i] < min1)
            {
                min1 = wwoodtime[i];
                idobject = i;
            }
        }
        DestroyDynamicObject(wwoods[idobject]);
    }
    wwoodtime[idobject] = Global_Time;
   	wwTimer[idobject] = 1800;
    wwoods[idobject] = CreateDynamicObject(19632, x, y, z - 1.0, 0, 0, a);
	wOwner[idobject] = PN(playerid);
    f(global_str, 125, "Lauzas\nUzkure ugni: %s\n{FFFFFF}Dega. Liko: {FAAC58}%d {FFFFFF}minuciu.\n\nIskepti zuvi: /cook", wOwner[idobject],floatround(float(wwTimer[idobject]) / 60.0));
	wwText[idobject] = CreateDynamic3DTextLabel(global_str, -1, x, y, z, 4.0);
	DeleteItem(playerid, 552, 1);
 	ApplyAnimationEx(playerid, !"CHAINSAW", !"CSAW_G", 4.0, 0, 0, 0, 0, 0, 1);
 	GameTextForPlayer(playerid, !"SUCCESSFUL", 0, 1);
	return 1;
}
CMD:cook(playerid, params[])
{
    new
		Float:x[MAX_WOODS],
		Float:y[MAX_WOODS],
		Float:z[MAX_WOODS],
		count;
    for(new i; i < MAX_WOODS; i++)
    {
		GetDynamicObjectPos(wwoods[i], x[i], y[i], z[i]);
        if(IsPlayerInRangeOfPoint(playerid, 2.0, x[i], y[i], z[i])) {
			count ++;
		}
    }
    if(!count)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Salia jusu nera lauzo!");
    for(new i; i < 5; i ++)
    {
        if(!PlayerFish[playerid][i])
			return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite zuvies!");
        PlayerFish[playerid][i] --;
        break;
    }
    AddItem(playerid, 549, 1);
    GameTextForPlayer(playerid, !"fried fish + 1", 0, 1);
    SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"{FFFFFF}Jus sekmingai iskepete {9ACD32}1{ffffff} kepta zuvi!\nNoredami pavalgyti, naudokite {9ACD32}/eat{FFFFFF}!", !"Supratau", !"");
    return 1;
}
CMD:drug(playerid, params[])
{
	if(GetPlayerWeapon(playerid)!=6)return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums reikalingas kastuvas, kad pasodintumete kanapes, ji galima nusipirkti mechanikos parduotuveje!");
    if(!IsAtGang(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Kanapes gali sodinti tik gaujos nariai!");
    if(!IsPlayerToKvadrat(playerid,2163.3979,-1697.2588,  2166.3228,-1687.7272) && !IsPlayerToKvadrat(playerid,2165.2397,-1510.9233,  2171.0142,-1504.9988) &&
    !IsPlayerToKvadrat(playerid,1790.4725,-2014.1749,  1799.6927,-2004.0822) && !IsPlayerToKvadrat(playerid,1790.5725,-1989.2954,  1799.8381,-1978.8665) &&
    !IsPlayerToKvadrat(playerid,2306.3516,-2008.3705,  2320.1846,-2005.4993) && !IsPlayerToKvadrat(playerid,2351.5613,-1926.0016,  2360.9636,-1915.7379) &&
    !IsPlayerToKvadrat(playerid,2351.4980,-1904.1448,  2360.9351,-1893.7114)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Seklas galima pasodinti tik sode salia narkotiku prieglobscio!");
	if(IsPlayerInAnyVehicle(playerid)) return 0;
	if(PI[playerid][pD_Packets]<1)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Norint pasodinti kanapes, reikia tureti sekla, kuria galima rasti miske uz miesto");
	new zone = GetPlayerGangZone(playerid),num=0;
	if(GZInfo[zone][gzFracID] != PI[playerid][pMember]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Kanapes galima pasodinti tik savo narkotiku prieglobstyje!");
	new Float:x, Float:y, Float:z,Float:eagle;
	for(new i;i<MAX_NARKO;i++)
	{
	    if(ddrugs[i]!=-1)
	    {
	        GetDynamicObjectPos(ddrugs[i],x,y,z);
			if(IsPlayerInRangeOfPoint(playerid,2,x,y,z)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus negalite cia pasodinti kanapiu, nes salia jau yra sodinukas/kanape.");
			if(IsPlayerInRangeOfPoint(playerid,20,x,y,z)) num++;
		}
	}
	if(num>4)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Siame sode auga daugiau nei 5 sodinukai! Surinkite derliu arba sodinkite kitame sode!");
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid,eagle);
	new idgun = 859;
	new idobject=-1;
    for(new i;i<MAX_NARKO;i++)
    {
        if(ddrugs[i]==-1)
		{
 			idobject=i;
	 		break;
		}
    }
    if(idobject==-1)
    {
        new min1=Global_Time;
        for(new i;i<MAX_NARKO;i++)
        {
            if(ddrugtime[i]<min1)
            {
                min1=ddrugtime[i];
                idobject=i;
            }
        }
        DestroyDynamicObject(ddrugs[idobject]);
    }
    ddrugtime[idobject]=Global_Time;
   	ddTimer[idobject] = 5000;//Pakeisti
    ddrugs[idobject] = CreateDynamicObject(idgun, x,y,z-1.0,0, 0, eagle);
    f(global_str, 256, "Kanapiu sodinukas\nBrendimo procese. Liko: {FAAC58}%d{FFFFFF} minuciu.",floatround(float(ddTimer[idobject])/60.0));
	ddText[idobject] = CreateDynamic3DTextLabel(global_str,-1,x, y, z,4.0);
	PI[playerid][pD_Packets]--;
 	ApplyAnimationEx(playerid,"CHAINSAW","CSAW_G",4.0,0,0,0,0,0,1);
 	GameTextForPlayer(playerid, "planted", 0, 1);
	return 1;
}
CMD:getmoney(playerid, params[])
{
    if sscanf(params,"d",params[0]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /getmoney [kiekis]");
    if !IsPlayerInRangeOfPoint(playerid,10,331.9075,1119.5465,1083.8903) *then
		return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    if CanUse[playerid] == 0 *then
		return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite galimybes valdyti sio narkotiku prieglobsciu!");
	if params[0] < 1 *then
		return 1;
	if PI[playerid][pRank]<9 *then
		return 1;
    switch GetPlayerVirtualWorld(playerid) do
    {
        case 1:
        {
            if GLS[60] < params[0] *then
				return SendBotMessage(playerid, "Seni, as neturiu tiek pinigu!");
			GiveMoney(playerid,params[0]);
			GLS[60] -= params[0];
			SaveInformation();
			SendBotMessage(playerid, "Va, laikyk savo pelna!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[45],GLS[60],GLS[55],GLS[50] );
            UpdateDynamic3DTextLabelText(NarkoText[0], COLOR_WHITE, global_str);
        }
        case 2:
        {
            if GLS[61] < params[0] *then
				return SendBotMessage(playerid, "Seni, as neturiu tiek pinigu!");
            GiveMoney(playerid, params[0]);
            GLS[61] -= params[0];
            SaveInformation();
            SendBotMessage(playerid, "Va, laikyk savo pelna!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[46],GLS[61],GLS[56],GLS[51]  );
            UpdateDynamic3DTextLabelText(NarkoText[1], COLOR_WHITE, global_str);
        }
        case 3:
        {
        	if GLS[62] < params[0] *then
				return SendBotMessage(playerid, "Seni, as neturiu tiek pinigu!");
            GiveMoney(playerid, params[0]);
            GLS[62] -= params[0];
            SaveInformation();
            SendBotMessage(playerid, "Va, laikyk savo pelna!");
            f(global_str,450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[47],GLS[62],GLS[57],GLS[52]  );
            UpdateDynamic3DTextLabelText(NarkoText[2], COLOR_WHITE, global_str);
        }
        case 4:
        {
            if GLS[63] < params[0] *then
				return SendBotMessage(playerid, "Seni, as neturiu tiek pinigu!");
            GiveMoney(playerid, params[0]);
            GLS[63] -= params[0];
            SaveInformation();
            SendBotMessage(playerid, "Va, laikyk savo pelna!");
            f(global_str,450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[48],GLS[63],GLS[58],GLS[53]  );
            UpdateDynamic3DTextLabelText(NarkoText[3], COLOR_WHITE, global_str);
        }
        case 5:
        {
            if GLS[64] < params[0] *then
				return SendBotMessage(playerid, "Seni, as neturiu tiek pinigu!");
            GiveMoney(playerid, params[0]);
            GLS[64] -= params[0];
            SaveInformation();
            SendBotMessage(playerid, "Va, laikyk savo pelna!");
            f(global_str, 450, "Narkotiku prieglobstis\nYra: {D38A37}%d{FFFFFF} prekiu\nSaskaitoje: {D38A37}%d{FFFFFF}$\n\nNarkotiku supirkimo kaina: {D38A37}%d{FFFFFF}\nNarkotiku kaina: {D38A37}%d{FFFFFF}\n\nNusipirkti narkotikus - {10F441}/buydrugs{FFFFFF}\nParduoti narkotikus - {10F441}/selldrugs{FFFFFF}",GLS[49],GLS[64],GLS[59],GLS[54]  );
            UpdateDynamic3DTextLabelText(NarkoText[4], COLOR_WHITE, global_str);
        }
        default:
			return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo narkotiku prieglobstyje!");
    }
	return 1;
}
CMD:wanted(playerid, params[])
{
	if !IsACop(playerid) *then
		return SCM(playerid, COLOR_RED, !"Jus nesate policininkas!");
	if sscanf(params, "d", params[0]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /wanted [paieskos lygis 1-6]");
	if params[0] > 6 *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /wanted [paieskos lygis 1-6]");
	new num = 0;
	global_str = "";
	foreach(new i: Player)
	{
		if PI[i][pWanted] == params[0] *then
	    {
	        if num == 25 *then
				break;
	        f(global_str, sizeof global_str, "%s{FFFFFF}%s(%d) - %d paieskos lygis\n", global_str, PN(i), i, PI[i][pWanted]);
	        num++;
		}
	}
	SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", global_str, !"Uzdaryti", !"");
	return 1;
}
CMD:orderlist(playerid, params[])
{
	if !(PlayerJob[playerid] == 3) *then
		return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate produktu pristatymo darbuotojas!");
	new num;
	global_str = "";
	for new i = 1; i < OWNABLEBIZES; i++ do
	{
	    if !GetString(BizData[i][bOwner],"The State") *then
    	{
		    if num < 21 *then
	      	{
				if BizData[i][bBuyCost] && BizData[i][bNeedItem] *then
				{
				    f(global_str, sizeof global_str, "{FFFFFF}%s - %s.{FFFFFF} Perka: %d p. Kaina: %d$\n", global_str, BizData[i][bName], BizData[i][bNeedItem], BizData[i][bBuyCost]);
				    DBizitem[playerid][num] = i;
				    num++;
				}
			}
			else break;
		}
	}
	if num *then
		return SPD(playerid, 8761, 2, !"Paieska imonininko", global_str, !"Priimti", !"Atsaukti");
	return SPD(playerid, 0, 0, !"Paieska imonininko", !"{FFFFFF}Deja, siuo metu uzsakymu nera!", !"Priimti", !"");
}
CMD:lzal(playerid, params[])
{
    if !GetString(BuildsInfo[0][blArenderID], PN(playerid)) *then
		return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nenuomojate koncertu sale!");
	if BuildsInfo[0][blTime]<1 *then
		return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Niekas nenuomoja koncertu sale");
	if !IsPlayerInRangeOfPoint(playerid,30,649.3248,-1353.8834,13.5470) && !IsPlayerInRangeOfPoint(playerid,30,-575.709, 2594.2, 1705.09) *then
	{
	    SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus turite buti prie iejimo ar isejimo is koncertu sales!");
	    return 1;
	}
	if BuildsInfo[0][blClosed]==0 *then
		return false;
	global_str = "";
	switch BuildsInfo[0][blCanEnter] do
	{
	    case 0: global_str = "{49A430}Laisvas{FFFFFF}";
	    case 1: f(global_str, 80,"{E37A45}Mokamas: %d${FFFFFF}",BuildsInfo[0][blCanEnter]);
	    case 2: global_str = "{A48330}Pagal kvietima{FFFFFF}";
	    default: f(global_str,80,"{E37A45}Mokamas: %d${FFFFFF}",BuildsInfo[0][blCanEnter]);
	}
	f(global_str, 950, "\
	Iejimas: %s [Pakeisti]\nPaskelbti apie renginio pradzia\nPajamu {46AB2A}ataskaitos{FFFFFF}\n\
	Atsiimti pelna: {46AB2A}%d${FFFFFF}\nIsduoti leidima %s", global_str, ZallFunction[1], BuildsInfo[0][blCanEnter] == 2 ? "[ {46AB2A}Pasiekiama{FFFFFF} ]":"[ {AB2A2A}Nepasiekiama{FFFFFF} ]");
	SPD(playerid, 798, 2, !"",global_str, !"Priimti", !"Atsaukti");
    return 1;
}
CMD:scutes(playerid, params[])
{
	if(PI[playerid][pMember]!=TEAM_FBI)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate FBI narys!");
	if(!TeamDuty{playerid})return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate darbines bukles!");
	new id;
	if(PI[playerid][pMScutes]!=-1)
	{
	 	f(global_str, 300,"{4D7D22}-{FFFFFF} Nesiotojas: {4D7D22}%s{FFFFFF}\n\n{FFFFFF}Jus gausite pranesimus, kai asmuo, kurio stebejimas ijungtas,\npaskambins kam nors arba parasys SMS.",PN(PI[playerid][pMScutes]));
		SPD(playerid,1081,0,"",global_str,"{DE3737}Isjungti{FFFFFF}", !"Atsaukti");
		return 0;
	}
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /scutes [id]");
	if(PI[id][pTelNum]<=0) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas neturi telefono!");
	if(id==playerid)return 0;
	if(!IsPlayerConnected(id)) return 0;
	if(!ProxDetectorS(2.0, playerid, id, 1)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
	if(PI[id][pScutes]==-1)
	{
		PI[id][pScutes]=playerid,f(global_str,200,"Jus sekmingai pritvirtinote klausymo prietaisa prie zaidejo mobiliojo telefono %s.",PN(id));
		PI[playerid][pMScutes]=id;
	}
	else SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Siam zaidejui jau yra pritvirtintas klausymo prietaisas!");
	ApplyAnimationEx(playerid,"CRIB","CRIB_Use_Switch",4.0,0,0,0,0,0);
	SetPlayerChatBubble(playerid, "Padare kazka keisto", COLOR_PURPLE, 10.0, 5000);
	SCM(playerid,COLOR_GREEN,global_str);
	return 1;
}
CMD:bankmenu(playerid, params[])
{
	if(GetTeamID(playerid) != TEAM_BANK)
		return SCM(playerid, COLOR_RED, !"Prieiga uzdrausta");
	extract params -> new player:target; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /bankmenu [id]");
    if(target == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, !"Zaidejas nera prisijunges!");
	if(!IsPlayerInRangeOfPoint(playerid, 8.0, -2683.8354, 807.3682, 1500.9688))
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Sia komanda galite naudoti tik Banke!");
    if(!TeamDuty{playerid})
		return SCM(playerid, COLOR_RED, !"Jus nesate budejime!");
	PanelPlayerID[playerid] = target;
	new rank = PI[playerid][pRank];
	if(rank < 5)
		return SCM(playerid, COLOR_RED, !"Prieiga uzdrausta");
    ShowPlayerDialogEx(playerid, 713, DIALOG_STYLE_LIST, !"Pasirinkite veiksma",
		!"{633169}[1]{73B461} Isduoti kredita [6]\n\
		{633169}[2]{73B461} Suzinoti skola bankui [1]\n\
		{633169}[3]{73B461} Suzinoti pinigu kieki banke [1]\n\
		{633169}[4]{73B461} Isduoti banko kortele [1]\n\
		{633169}[5]{73B461} Atkurti banko kortele [5]\n\
		{633169}[6]{73B461} Priimti pinigus i indeli [4]\n\
		{633169}[7]{73B461} Nusiimti pinigus is indelio [4]",
		!"Isrinkti", !"Atsaukti");
	return 1;
}
CMD:news(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return SCM(playerid,COLOR_GREY, !"Pirmiausia reikia prisijungti");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    if(!IsANews(playerid)) return SCM(playerid,COLOR_GREY, !"Si komanda jums nepasiekiama!");
    if(PI[playerid][pRank]<5)return SCM(playerid,COLOR_GREY, !"Si komanda jums nepasiekiama! (Reikalingas 5 rangas!)");
	if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(sscanf(params,"s[100]",params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /news [tekstas]");
    if(IsAIP(params[0]))return 1;
    if(Int_GetPlayerData(playerid,"newser")>Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
	new carid = GetPlayerVehicleID(playerid);
	new getradio[40];
    switch(PI[playerid][pMember])
    {
        case TEAM_RADIO: getradio = "LS";
        case TEAM_RADIOSF: getradio = "SF";
        case TEAM_RADIOLV: getradio = "LV";
        default: getradio = "";
    }
	if(IsANewsCar(carid) || IsPlayerInRangeOfPoint(playerid,50,1716.1687,-1663.5651,20.2279)|| IsPlayerInRangeOfPoint(playerid,50,1654.9037,-1640.4658,57.1529))
	{
	 	f(global_str, 145,"[ News %s ] %s %s[%d]:{FFFFFF} %s",getradio,GetRankName(TEAM_RADIO,PI[playerid][pRank]),PN(playerid),playerid,params[0]);
		SCMALL(0x73B461FF,global_str);
		SetPVarInt(playerid,"newser",Global_Time+4);
	}
	else SCM(playerid,COLOR_BLUENEW,"Jus nesate radijo studijos transporte");
	return 1;
}
CMD:gov(playerid, params[])
{
    if(!IsAtFrakcia(playerid)) return 0;
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    static result[150]; result[0] = EOS;
	if(sscanf(params,"s[100]",result)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /gov [tekstas]");
    if(GLS[36] >= 3) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Visos organizacijos turi teise tik i 3 valstybes eilutes per 10 minuciu!");
    if(!IsPlayerLogged{playerid}) return SCM(playerid,COLOR_GREY, !"Pirmiausia reikia prisijungti");
	if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(PI[playerid][pRank] >= 9 && IsAtFrakcia(playerid)) SendGovMessage(playerid,result);
	GLS[36]++;
	return 1;
}
CMD:m(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return SCM(playerid,COLOR_GREY, !"Pirmiausia reikia prisijungti");
	if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
	if(sscanf(params,"s[100]",params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /m [tekstas]");
	if( IsAIP(params[0]) ) return 0;
	new carid = GetPlayerVehicleID(playerid);
	if(!IsACop(playerid)) return SCM(playerid,COLOR_GREY, !"Jus nesate policininkas!");
	if(!IsPlayerInAnyVehicle(playerid) && !IsACopCar(carid)) return SCM(playerid,COLOR_GREY, !"Ne galiu!");
	f(global_str, 145,"[G] %s %s(%d): %s",GetRankName(GetTeamID(playerid),PI[playerid][pRank]),PN(playerid),playerid,params[0]);
	ProxDetector(30,playerid, global_str,COLOR_YELLOW);
	SetPlayerChatBubble(playerid,  global_str, COLOR_YELLOW, 10.0, 5000);
	return 1;
}
CMD:garsiakalbis(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return SCM(playerid,COLOR_GREY, !"Pirmiausia reikia prisijungti");
	if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
	if(sscanf(params,"s[100]",params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /megafon [tekstas]");
	if( IsAIP(params[0]) ) return 0;
	if(!IsACop(playerid)) return SCM(playerid,COLOR_GREY, !"Jus nesate policininkas!");
	f(global_str, 145,"[Garsiakalbis] %s %s(%d): %s",GetRankName(GetTeamID(playerid),PI[playerid][pRank]),PN(playerid),playerid,params[0]);
	ProxDetector(30,playerid,global_str,COLOR_YELLOW);
	SetPlayerChatBubble(playerid, global_str, COLOR_YELLOW, 10.0, 5000);
	return 1;
}
CMD:s(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return SCM(playerid,COLOR_GREY, !"Pirmiausia reikia prisijungti");
	if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(sscanf(params,"s[100]",params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /s [tekstas]");
	if( IsAIP(params[0]) ) return 0;
	if(Int_GetPlayerData(playerid,"payer")>Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
	SetPVarInt(playerid,"payer",Global_Time+3);
	SetPlayerChatBubble(playerid, params[0], COLOR_SCHAT, 25.0, 5000);
	f(global_str, 145,"%s[%d] saukia: %s!!",PN(playerid),playerid,params[0]);
	ProxDetector(25,playerid, global_str,COLOR_SCHAT,1);
	if(!IsPlayerInAnyVehicle(playerid) && !PlayerLie{playerid})	ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_01",1000.0,0,0,0,0,0,1);
	return 1;
}
alias:b("n");
CMD:b(playerid, params[])
{
	if PI[playerid][pMuteTime] *then return SendMuteMessage(playerid);
	if sscanf(params, "s[100]", global_str) *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /b [tekstas]");
	if IsAIP(global_str) *then return false;
	f(global_str, 145, "(( %s%s[%d]: {AFAFAF}%s{FFFFFF} ))", PI[playerid][pAdmin] ? "Administratorius ":"", PN(playerid), playerid, global_str);
	ProxDetector(10,playerid,global_str,COLOR_WHITE,1);
	return 1;
}
CMD:c(playerid, params[])
{
	if PI[playerid][pMuteTime] *then return SendMuteMessage(playerid);
	if sscanf(params,"s[100]",global_str) *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /c [tekstas]");
	if IsAIP(global_str) *then return 0;
	f(global_str,145,"%s[%d] kalba pasnibzdomis: {FFFFFF}%s",PN(playerid),playerid,global_str);
	ProxDetector(2,playerid,global_str,COLOR_BLUE);
	return 1;
}
CMD:todo(playerid, params[])
{
	if PI[playerid][pMuteTime] *then return SendMuteMessage(playerid);
	new text[64], me[64];
    if sscanf(params, "p<*>s[64]s[64]", text, me) *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}/todo Fraze*Veiksmas");
    if IsAIP(params[0]) || IsAIP(params[1]) *then return 0;
    f(global_str, 128, "\"%s\", - pasake %s,{FF99FF} %s.",text,PN(playerid),me);
    ProxDetector(30.0, playerid, global_str, -1);
    return 1;
}
CMD:me(playerid, params[])
{
	if PI[playerid][pMuteTime] *then return SendMuteMessage(playerid);
	if sscanf(params,"s[100]",params[0]) *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /me [veiksmas]");
	if IsAIP(params[0]) *then return 0;
	f(global_str, 145,"%s[%d] %s",PN(playerid),playerid,params[0]);
	ProxDetector(25,playerid,global_str,COLOR_ME);
	SetPlayerChatBubble(playerid, params[0], COLOR_PURPLE, 10.0, 5000);
	return 1;
}
CMD:do(playerid, params[])
{
	if PI[playerid][pMuteTime] *then return SendMuteMessage(playerid);
	if sscanf(params,"s[100]", params[0]) *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /do [veiksmas]");
	if IsAIP(params[0]) *then return 0;
	f(global_str, 128," %s  - |  %s[%d] ",params[0], PN(playerid),playerid);
	ProxDetector(25,playerid,global_str,COLOR_DOCHAT);
	SetPlayerChatBubble(playerid, params[0], COLOR_PURPLE, 10.0, 5000);
	return 1;
}
CMD:try(playerid, params[])
{
	if PI[playerid][pMuteTime] *then return SendMuteMessage(playerid);
	if sscanf(params,"s[100]",params[0]) *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /try [veiksmas]");
	if IsAIP(params[0]) *then return 0;
	switch random(10) do
	{
		case 0..4: f(global_str, 150," %s[%d] %s -{9ACD32} Sekmingai ", PN(playerid),playerid, params[0]);
		case 5..9: f(global_str, 150," %s[%d] %s - {FF0000} Nesekmingai ", PN(playerid),playerid, params[0]);
	}
	ProxDetector(25,playerid,global_str,COLOR_ME);
	f(global_str, 145 ,"%s",params[0]);
	SetPlayerChatBubble(playerid, global_str, COLOR_PURPLE, 10.0, 5000);
	return 1;
}
CMD:lmenu(playerid,params[])
{
	new org = PI[playerid][pMember];
	if !org *then return false;
	else if !PI[playerid][pLeader] && PI[playerid][pRank] < OrgInfo[org][Max_Rang]-1 *then return false;
	else if !IsAtMafia(playerid)&& !IsAtGang(playerid) *then
	{
		f (global_str, 100, "{FFFFFF}Bankas: {E1E948}%d$", OrgInfo[org][oBank]);
		return SPD(playerid, 1214, DIALOG_STYLE_LIST, global_str, PI[playerid][pMember] == TEAM_FBI ? "\
		{AFAFAF}Pakviesti i organizacija\n\
		{AFAFAF}Organizacijos nariu valdymas\n\
		{AFAFAF}Perkelimas\n\
		{F2D253}Atranka\n\
		{FFFFFF}Pakeisti atlyginimus\n\
		Rangu valdymas\n\
		Auto-Invite valdymas\n\
		{ffff00}Nusiimti{ffffff} lesas nuo organizacijos saskaitos\n\
		{ffff00}Papildyti{ffffff} organizacijos saskaita\n":!"\
		{AFAFAF}Pakviesti i organizacija\n\
		{AFAFAF}Organizacijos nariu valdymas\n\
		{F2D253}Atranka\n\
		{FFFFFF}Pakeisti atlyginimus\n\
		Rangu valdymas\n\
		{ffff00}Nusiimti{ffffff} lesas nuo organizacijos saskaitos\n\
		{ffff00}Papildyti{ffffff} organizacijos saskaita\n", !"Toliau", !"Atsaukti");
	}
	else
		f(mysql_string, 50, "{FFFFFF}Bankas: {009327}%d$",OrgInfo[org][oBank]),
		f(global_str, 350,"{AFAFAF}Pakviesti i organizacija\n{AFAFAF}Prisijunge zaidejai\n{AFAFAF}Sandelis [%s]\n{AFAFAF}Transporto spawnas [{009327}25 000${AFAFAF}]\n{AFAFAF}Transporto degalu papildymas [{009327}35 000${AFAFAF}]", !OrgInfo[org][oOb4ak] ? ("{407930}Atidarytas") : ("{D24449}Uzdarytas")),
		SPD(playerid,1214,2,mysql_string,global_str,"Toliau", !"Atsaukti");
	return false;
}
CMD:invite(playerid, params[])
{
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /invite [id]");
	if(CuffedTime[params[0]] > 0) return SCM(playerid, COLOR_RED, !"Zaidejas yra soko busenoje!");
 	if(PI[playerid][pLeader] == 0 && PI[playerid][pRank] < 9) return SCM(playerid, COLOR_RED, !"Prieiga uzdrausta!");
	if(PI[params[0]][pMember] > 0) return SCM(playerid, COLOR_GREY, !"Zaidejas yra kitoje organizacijoje!");
	if(!IsPlayerConnected(params[0]) || !IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Zaidejas nerastas");
	if(IsAtFrakcia(playerid) && PI[params[0]][pBL] != 0)
    {
        SCM(playerid, COLOR_GREY, !"Jus negalite priimti sio zaidejo. Galimos priezastys:");
		SCM(playerid, COLOR_GREY, !"- Sis zaidejas jau yra itrauktas i juodaji sarasa");
		return 1;
	}
	if(Clother[params[0]] != -1) return 0;
	if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return 0;
	if(!ProxDetectorS(5.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Turite buti salia zaidejo");
	if(InviteOffer[params[0]] != INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, !"Siam zaidejui jau buvo issiustas kvietimas prisijungti prie organizacijos");
	new Leader[15];
	global_str = "";
	if(PI[params[0]][pWarns] > 0) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejo su WARN negalima priimti i organizacija!");
	if(IsAtFrakcia(playerid, 1) && PI[params[0]][pZKP] < 35)
	{
	    SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sio piliecio teisetvarka neleidzia jam istoti i organizacija! (Reikia 35 teisetvarkos tasku!)");
	    SCM(params[0], COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite buti priimtas i organizacija, nes turite per mazai teisetvarkos tasku! (Reikia 35 teisetvarkos tasku!)");
	    return 0;
	}
	if(PI[playerid][pLeader] > 0) Leader = "Lyderis";
	else Leader = "Lyderio pav.";
	InviteOffer[params[0]] = playerid;
	f(global_str, 100, "Jus kvieciate %s i savo organizacija", PN(params[0]));
	SCM(playerid, COLOR_LIGHTBLUE, global_str);
	f(global_str, 100, "%s %s kviecia jus i savo organizacija %s", Leader, PN(playerid), OrgInfo[GetTeamID(playerid)][oName]);
	SPD(params[0], 8, DIALOG_STYLE_MSGBOX, !"Invite", global_str, !"Priimti", !"Atsaukti");
	return 1;
}
CMD:frisk(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_RED,!"Jus nesate policininkas");
	new id,Drugs[20],Mats[20],Gun[20];
    if(sscanf(params,"u",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /frisk [id]");
    if(!ProxDetectorS(1.0,playerid,id)) return SCM(playerid,COLOR_RED,!"Jus esate toli nuo zaidejo!");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    global_str = "{FFFFFF}";
    if(GetCount(id, 553) > 0) Mats = "{33AA33}[Yra]\n";
    else Mats = "{FF0000}[Nera]";
    if(GetCount(id, 525) > 0) Drugs = "{33AA33}[Yra]\n";
    else Drugs = "{FF0000}[Nera]";
    new gunid, ammo;
    Gun = "{FF0000}[Nera]";
    for(new i;i < 13;i ++)
    {
        GetPlayerWeaponData(id, i, gunid, ammo);
        if(!gunid || !ammo) continue;
        Gun = "{33AA33}[Yra]\n";
        break;
    }
    f(global_str, 128, "Soviniai: \t%s\n", Mats);
    f(global_str, 128, "%sNarkotikai: \t%s\n", global_str, Drugs);
    f(global_str, 128, "%sGinklas: \t%s\n", global_str, Gun);
    SPD(playerid,0,0,PN(id),global_str,"OK","");
    f(global_str,128," %s apiesko %s",PN(playerid),PN(id));
	ProxDetector(25,playerid,global_str,COLOR_PURPLE);
    return 1;
}
CMD:ticket(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_RED,!"Jus nesate policininkas!");
	new id,ticket,reason[50];
    if(sscanf(params,"uds[50]",id,ticket,reason)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /ticket [id] [suma] [priezastis]");
    if(!ProxDetectorS(5.0,playerid,id)) return SCM(playerid, COLOR_WHITE, !"Jus esate toli nuo zaidejo");
    if(PI[id][pLevel] < 2) return SCM(playerid, COLOR_RED, !"Negalima skirti baudos pirmo lygio zaidejams");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    if(ticket < 1 || ticket > 10000) return SCM(playerid, COLOR_RED, !"Bauda ne mazesne kaip $1 ir ne didesne kaip $10000");
	f(global_str, 150 ,"Policininkas %s jums skyre bauda.\n\n{FF9900}Suma: $%d\nPriezastis: %s",PN(playerid),ticket,reason);
	SPD(id,87,0,"Bauda",global_str,"Sumoketi", !"Atsaukti");
	f(global_str,128,"Jus skyrete bauda zaidejui %s. Suma: $%d | Priezastis: %s",PN(id),ticket,reason);
	SCM(playerid,COLOR_LIGHTBLUE,global_str);
	TicketOffer[id] = playerid;
	TicketPrice[id] = ticket;
	return 1;
}
CMD:throwfish(playerid, params[])
{
	new massa;
	static string[100], Fish[20];
	string[0] = EOS, Fish[0] = EOS;
	for(new i; i < 5; i ++)
 	{
 		new fish = PlayerFish[playerid][i];
 		if(fish == 0) strcat(string, "{AFAFAF}None\n");
 		else
 		{
 			f(Fish, sizeof(Fish), "{33CCFF}%s %d Kg\n", FishName[fish], FishMassa[playerid][fish]);
 			strcat(string, Fish);
 			massa += FishMassa[playerid][fish];
 		}
 	}
	if(massa > 0)
	{
		f(Fish, sizeof(Fish), "{33CCFF}Visa zuvi %d Kg\n", massa);
		strcat(string, Fish);
	}
 	SPD(playerid,263,2,"Ka ismesti?",string,"Ismesti", !"Atsaukti");
 	return 1;
}
CMD:credit(playerid, params[])
{
	if(PI[playerid][pMember]!=TEAM_BANK) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate Banko darbuotojas!");
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
	if(PI[playerid][pLeader]==0 && PI[playerid][pRank]<9) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Si funkcija prieinama tik banko lyderiui ir pavaduotojui!");
	SPD(playerid,329,2,"Banko meniu","{633169}[1]{FFFFFF} Procentas\n{633169}[2]{FFFFFF} Procentas\n{633169}[3]{FFFFFF} Procentas\n{633169}[4]{FFFFFF} Procentas\n{633169}[5]{FFFFFF} Procentu\n{633169}[6]{FFFFFF} Procentu", !"Priimti", !"Atsaukti");
	return 1;
}
CMD:pay(playerid, params[])
{
    if PI[playerid][pDemorgan] *then
    	return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite keistis/perduoti pinigu sioje vietoje!");
	new id,money;
	if(Int_GetPlayerData(playerid,"payer")>Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
    if(sscanf(params,"ud",id,money)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /pay [id] [suma]");
    if(!ProxDetectorS(3.0,playerid,id)) return SCM(playerid,COLOR_GREY, !"Jus esate toli nuo zaidejo");
	if(playerid == id) return SCM(playerid,COLOR_GREY, !"Negalima perduoti pinigu sau paciam");
	if(money < 1 || PI[playerid][pMoney] < money) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
	if(PI[playerid][pLevel]==1 && money > 200)return SCM(playerid,COLOR_RED,!"Zaidejai, kurie yra zemiau 2 lygio, gali perduoti iki 200$");
	if money > 50000 or GetPlayerADDVIP(playerid) && money > 1000000 *then
		return SCM(playerid, COLOR_VALIK, !"Negalima perduoti daugiau nei $50000");
	if PI[id][pMoney] + money < 0 *then
		return SendErrorMessage(playerid);
	GiveMoney(playerid,-money);
	GiveMoney(id,money);
	SetPVarInt(playerid,"payer",Global_Time+2);
	ApplyAnimationEx(playerid,"DEALER","shop_pay",4.1, 0, 1, 1, 0, 0, 1);
	f(global_str, 128,"%s perduoda voka su pinigais %s",PN(playerid),PN(id));
	SetPlayerChatBubble(playerid, global_str, COLOR_PURPLE, 10.0, 5000);
	f(global_str, 128,"%s perdave jums $%d",PN(playerid),money);
	SCM(id,COLOR_GREY, global_str);
	f(global_str, 128,"Jus perdavete $%d %s",money,PN(id));
	SCM(playerid,COLOR_GREY, global_str);
	return 1;
}
CMD:putobject(playerid, params[])
{
	if(!IsACop(playerid) && !PI[playerid][pAdmin]) return SCM(playerid, COLOR_RED, !"Jus nesate darbuotojas PD/FBI!");
	if(PI[playerid][pRank] < 5 && !PI[playerid][pAdmin]) return SCM(playerid,COLOR_RED,!"Si galimybe pasiekiama nuo 5 rango.");
	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid)!=0) return SCM(playerid, COLOR_RED, !"Naudoti pastate draudziama!");
	f(global_str, 200,"{FFFFFF}Liko: {94B0C1}%d{FFFFFF} objektu.",PI[playerid][pObjikt]);
	SPD(playerid,399,2,global_str,"-{633169} Aptverimas [1]\n-{633169} Apsauginis atmusejas\n-{633169} Kugis\n-{633169} Aptverimas [2]\n-{633169} Lentele\n-{633169} Greicio mazinimo kalneliai\nGelezine tvorele\nGelezine tvorele [2]\n[ZENKLAS] Greicio apribojimas\n[ZENKLAS] Draudziama vaziuoti tiesiai\n[ZENKLAS] Uzdaryta\n[ZENKLAS] Stop\n[ZENKLAS] Duokite kelia\n[ZENKLAS] Kelio remontas\n[ZENKLAS] Vaziuokite tiesiai!\n[ZENKLAS] Posukis i kaire\n[ZENKLAS] Posukis i desine\n- Radaras\nPasalinti objekta", !"Priimti", !"Atsaukti");
	return 1;
}
CMD:demoute(playerid, params[])
{
	if(PI[playerid][pMember]!= TEAM_FBI && PI[playerid][pMember]!= TEAM_MERIALS)return SCM(playerid,COLOR_RED,!"Pasiekiama tik savivaldybei ir FBI!");
    if(!PI[playerid][pLeader] && PI[playerid][pRank] != 9) return SCM(playerid,COLOR_RED,!"Prieiga uzdrausta! (Pasiekiama tik Lyderiui/Pavaduotojui)");
    if(!IsPlayerConnected(playerid) || !IsPlayerLogged{playerid}) return 0;
    new id;
    if(sscanf(params,"us[100]",id, params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /demoute [id] [priezastis]");
    if(!ProxDetectorS(5.0, playerid, id, 1)) return SCM(playerid,COLOR_RED,!"Jus esate toli nuo zaidejo!");
	if(!IsAtFrakcia(id)) return SCM(playerid,COLOR_RED,!"Jus galite atleisti tik valstybes tarnautojus!");
	if(id == playerid) return SCM(playerid,COLOR_GREY, !"Jus negalite atleisti saves!");
	if(PI[id][pLeader] > 0 ) return SCM(playerid,COLOR_RED,!"Jus negalite atleisti lyderio");
	if(IsACop(id)) if(UsingShield[id]) RemovePlayerAttachedObject(id, 7);
	PI[id][pMember] =
	PI[id][pDCTime]=
	PI[id][pRank] =
	pSportZal[id]=0;
	SCM(id, COLOR_WHITE, !">> {FF6347} Spawno vieta automatiskai nustatyta Gelezinkelio stotyje. Pakeisti spawno vieta {FFFFFF}>> {FF6347}/setspawn!");
	TeamDuty{id} = false;
	f(global_str, 145,"{FFFFFF}%s ismete jus is organizacijos.\nPriezastis: %s",PN(playerid), params[0]);
	SCM(id,COLOR_LIGHTBLUE,global_str);
	f(global_str, 145,"Jus ismetete %s. Priezastis: %s",PN(id), params[0]);
	SCM(playerid,COLOR_LIGHTBLUE,global_str);
	f(global_str, 145,"[D]%s[%d] Atleido %s, Priezastis: %s",PN(playerid),playerid,PN(id), params[0]);
	SendGosMessage(COLOR_DEPAR,global_str);
	SetPlayerColor(id,0xFDFCFC15);
	_ResetGun(id);
	UpdatePlayerArmour(id,0);
	ResetSpawnInfo(id, 0);
	SetBumSkin(id);
	return 1;
}
CMD:uninvite(playerid, params[])
{
	if PI[playerid][pMember] && PI[playerid][pRank] < OrgInfo[PI[playerid][pMember]][Max_Rang]-1 && !PI[playerid][pLeader] *then
		return SCM(playerid,COLOR_RED,!"Prieiga uzdrausta!");
	new id;
	if sscanf(params,"us[100]", id, params[0]) *then
		return SCM(playerid,COLOR_OLDRED,!"Naudokite: /uninvite [id] [priezastis]");
	else if IsADomen(params[0]) || IsAMg(params[0]) || IsAIP(params[0]) *then
    {
		SCM(playerid,COLOR_RED,!"Tokiuose pranesimuose draudziama naudoti angliskus simbolius");
    	SCM(playerid,COLOR_WHITE, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 0;
    }
	if PI[playerid][pRank] == PI[id][pRank] *then
		return false;
	else if !IsGiveWarn(playerid, id) *then
		return SCM(playerid,COLOR_GREY, !"Sis zaidejas priklauso kitai organizacijai");
	else if id == playerid *then
		return SCM(playerid,COLOR_GREY, !"Saves negalima");
	else if PI[id][pLeader] *then
		return SCM(playerid,COLOR_RED,!"Jus negalite atleisti lyderio");
	UnInvite(id);
	SCMF(id, COLOR_LIGHTBLUE, "{FFFFFF}%s jus ismete is organizacijos.\nPriezastis: %s", PN(playerid), params[0]);
	f(global_str, 145,"{FFFFFF}%s ismete %s is organizacijos.\nPriezastis: %s",PN(playerid),PN(id), params[0]);
	SendTeamMessage(PI[playerid][pMember],COLOR_LIGHTBLUE, global_str);
	return SCMF(playerid ,COLOR_LIGHTBLUE, "Jus ismetete %s. Priezastis: %s",PN(id), params[0]);
}
CMD:giverank(playerid, params[])
{
	if(PI[playerid][pMember]<=0)return 0;
    if(PI[playerid][pRank] < 9 && PI[playerid][pLeader] == 0) return SCM(playerid,COLOR_RED,!"Prieiga uzdrausta!");
	if(sscanf(params,"ud",params[0],params[1])) return SCM(playerid,COLOR_VALIK, !"Naudokite: /giverank [id] [rank]");
	if(!ProxDetectorS(8.0, playerid, params[0])) return SCM(playerid,COLOR_GREY, !"Jus turite buti salia zaidejo!");
    if(PI[params[0]][pLeader] > 0 ) return SCM(playerid,COLOR_RED,!"Jus negalite keisti ranga lyderiui");
    if(params[1] < 1) return SCM(playerid,COLOR_GREY, !"Negalima pakelti iki sio rango");
    if(Clother[params[0]]!=-1)return 0;
	if(GetPlayerVirtualWorld(playerid)!=GetPlayerVirtualWorld(params[0]))return 0;
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Zaidejas nerastas");
	if(PI[playerid][pRank] <= PI[params[0]][pRank]) return SCM(playerid, COLOR_GREY, !"Jus negalite paaukstinti/pazeminti sio zaidejo");
	if(PI[playerid][pRank] == 9 && params[1] > 8) return SCM(playerid,COLOR_RED,!"Negalima suteikti rango daugiau nei 8");
 	if(params[1] > 9) return SCM(playerid,COLOR_GREY, !"Negalima pakelti iki sio rango");
	if(PI[params[0]][pMember] != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"Zaidejas priklauso kitai organizacijai!");
	global_str = "";
	f(global_str,100,"Lyderis %s %s iki %d rango",PN(playerid),PI[params[0]][pRank] > params[1] ? ("pazemino"):("paaukstino"),params[1]);
	SCM(params[0],COLOR_LIGHTBLUE,global_str);
	f(global_str,100,"Jus %ste zaideja %s iki %d rango",PI[params[0]][pRank] > params[1] ? ("paauksino"):("pazemino"),PN(params[0]),params[1]);
	SCM(playerid,COLOR_LIGHTBLUE,global_str);
	PI[params[0]][pRank] = params[1];
	if(PI[params[0]][pSex] == 2)
	{
	    if(TeamDuty{params[0]})
		{
			SetPlayerSkinEx(params[0],GOrgSkins[GetTeamID(params[0])][params[1]]);
			TogglePlayerControllable(params[0],true);
		}
	}
	else
	{
	    if(TeamDuty{params[0]})
		{
			SetPlayerSkinEx(params[0],MOrgSkins[GetTeamID(params[0])][params[1]]);
			TogglePlayerControllable(params[0],true);
		}
	}
	return 1;
}
CMD:carskill(playerid)
{
    f(global_str, 80," Esamas automobilio vairavimo igudis: {FFFFFF}%d/100.", PI[playerid][pCarSkill]),
	SCM(playerid, COLOR_LIGHTBLUE, global_str);
	SCM(playerid, -1, !"Norint pagerinti vairavimo igudzius, butina atsakingai vairuoti savo automobili,");
	SCM(playerid, -1, !"priziureti ji ir nesmugiuoti pesciuju.");
	SCM(playerid, COLOR_GREY, !"Noredami parodyti savo igudzius kitam zaidejui, naudokite /showcarskill.");
	return 1;
}
CMD:showcarskill(playerid, params[])
{
	new targetid;
	if(sscanf(params, "d", targetid))
	    return SCM(playerid, COLOR_OLDRED, !"Naudokite: /showcarskill [id]");
	if(targetid == INVALID_PLAYER_ID)
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas nera prisijunges!");
    if(!ProxDetectorS(5.0, playerid, targetid))
		return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo!");
	f(global_str, 145, "Zaidejas %s[%d] parode savo vairavimo igudziu ataskaita. Vairavimo igudis: {FFFFFF}[%d/100]", PN(playerid), playerid, PI[playerid][pCarSkill]);
	SCM(targetid, COLOR_LIGHTBLUE, global_str);
	f(global_str, 128, "Jus sekmingai parodete vairavimo ataskaita zaidejui {FFFFFF}%s[%d]", PN(targetid), targetid);
	SCM(targetid, COLOR_GREY, global_str);
	return 1;
}
CMD:gotp(playerid)
{
    if(!Teleport) return SCM(playerid, -1, !"[Klaida] Renginys dar neprasidejo arba teleportacijos laikas jau praejo.");
    return SPD(playerid, 4697, DIALOG_STYLE_MSGBOX, !"Ispejimas", !"{FFFFFF}Pagal renginio taisykles jusu ginklas bus konfiskuotas.\n\nJus sutinkate?", !"Taip", !"Ne");
}
CMD:taxi(playerid, params[])
{
	new carid = GetPlayerVehicleID(playerid);
	if( PlayerJob[playerid] != JOB_TAXI)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate taksistas!");
	if(!IsATaxi(carid))return 0;
	if(TaxiTarif[playerid] > 0) SCM(playerid, COLOR_GREY, !"[Informacija] {FFFFFF}Tarifas jau nustatytas - galite ji pakeisti.");
	SPD(playerid,56,1,"Tarifas","{FFFFFF}Iveskite jusu tarifa ir suki per kableli\n\n{9ACD32}- Tarifas ne mazesnis kaip 1 ir ne didesnis kaip $70\nSukis neturetu virsyti 30 simboliu","OK", !"Atsaukti");
	return 1;
}
CMD:kiss(playerid, params[])
{
	extract params -> new player:target; else
		return SCM(playerid, COLOR_GREY, !"Naudokite: /kiss [id]");
	if(IsPlayerInAnyVehicle(playerid) || IsPlayerInAnyVehicle(target))
		return 1;
	if(AnimPlayed{playerid} || AnimPlayed{target})
		 return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus jau naudojate animacija!");
 	if(PI[playerid][pHeal] > 0 || PI[target][pHeal] > 0)
	 	return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ligonineje negalima!");
    if(Cuffed[playerid] || Cuffed[target])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus surakintas ir negalite judeti");
    if(CuffedTime[playerid] || CuffedTime[target])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate paralyziuotas!");
	else if GetPlayerVirtualWorld(playerid) == 534 or GetPlayerVirtualWorld(target) == 534 *then
		return false;
	if !IsPlayerOnline(target) *then
		return false;
	else if playerid == target *then
		return SCM(playerid, COLOR_GREEN, !"Jus negalite pabuciuoti saves!");
	else if !ProxDetectorS(3.0, playerid, target) *then
		return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
	if(IsPlayerInRangeOfPoint(playerid, 100.0, 36.26, 2242.85, 1501.65) || IsPlayerInRangeOfPoint(target, 100.0, 36.26, 2242.85, 1501.65))
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Cia negalima buciuotis!");
    if Int_GetPlayerData(playerid, !"payer") > Global_Time *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
    SetPVarInt(playerid, !"payer", Global_Time + 5);
    new
        string[15 - 2 + MAX_PLAYER_NAME];
	f(string, sizeof(string), "Pabuciavo %s", PN(target));
    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 5000);
    f(string, sizeof(string), "Pabuciavo %s", PN(playerid));
    SetPlayerChatBubble(target, string, COLOR_PURPLE, 30.0, 5000);
	new
		Float:angle;
	GetPlayerFacingAngle(playerid, angle);
	SetPlayerFacingAngle(target, angle + 180);
	ApplyAnimationEx(playerid, !"BD_FIRE", !"GRLFRD_KISS_03", 4.0, 0, 0, 0, 0, 0);
	return ApplyAnimationEx(target, !"BD_FIRE", !"PLAYA_KISS_03", 4.0, 0, 0, 0, 0, 0);
}
CMD:anims(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(GetPlayerVirtualWorld(playerid) == 534)
		return 0;
	if(IsPlayerInAnyVehicle(playerid))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Automobilyje negalima naudoti animacijas!");
    if(AnimPlayed{playerid})
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus jau naudojate animacija!");
	if(PI[playerid][pHeal])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ligonineje negalima!");
    if(Cuffed[playerid])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus surakintas ir negalite judeti");
    if(CuffedTime[playerid])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus paralyziuotas!");
    extract params -> new animid; else
		SCM(playerid, COLOR_OLDRED, !"Naudokite: {FFFFFF}( /anims id ), kad greiciau persijungineti.");
	switch animid do
	{
        case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
        case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
        case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
        case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
        case 5: ApplyAnimationEx(playerid, !"DANCING", !"DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 0);
        case 6: ApplyAnimationEx(playerid, !"DANCING", !"dnce_M_a", 4.1, 1,0, 0, 0, 0, 0);
        case 7: ApplyAnimationEx(playerid, !"ON_LOOKERS", !"wave_loop", 4.1, 1, 1, 1, 0, 0);
        case 8: ApplyAnimationEx(playerid, !"BEACH", !"bather", 4.0, 1, 0, 0, 0, 0);
        case 9: ApplyAnimationEx(playerid, !"ped", !"endchat_03", 4.1, 1, 0, 0, 0, 0, 0);
        case 10: ApplyAnimationEx(playerid, !"benchpress", !"gym_bp_celebrate", 4.0, 0, 0, 0, 0, 0);
		case 11: ApplyAnimationEx(playerid, !"PED", !"COWER", 4.1, 0, 0, 0, 0, 0, 1);
		case 12: ApplyAnimationEx(playerid, !"SHOP", !"ROB_SHIFTY", 4.1, 0, 0, 0, 0, 0, 1);
		case 13: ApplyAnimationEx(playerid, !"SHOP", !"ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0, 1);
		case 14: ApplyAnimationEx(playerid, !"COP_AMBIENT", !"Coplook_loop", 4.0, 0, 1, 1, 1, -1);
		case 15: ApplyAnimationEx(playerid, !"FOOD", !"EAT_VOMIT_P", 4.1, 0, 0, 0, 0, 0, 1);
		case 16: ApplyAnimationEx(playerid, !"FOOD", !"EAT_BURGER", 4.1, 0, 0, 0, 0, 0, 1);
		case 17: ApplyAnimationEx(playerid, !"DEALER", !"DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
		case 18: ApplyAnimationEx(playerid, !"CRACK", !"CRCKDETH2", 4.1, 0, 0, 0, 0, 0, 1);
		case 19: ApplyAnimationEx(playerid, !"LOWRIDER", !"M_SMKLEAN_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 20: ApplyAnimationEx(playerid, !"LOWRIDER", !"F_SMKLEAN_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 21: ApplyAnimationEx(playerid, !"BEACH", !"ParkSit_M_loop", 4.0, 0, 0, 0, 1, 1, 1);
		case 22: ApplyAnimationEx(playerid, !"PARK", !"Tai_Chi_Loop",4.0,1,0,0,0,0,1);
		case 23: ApplyAnimationEx(playerid, !"BAR", !"dnk_stndF_loop", 4.1, 0, 0, 0, 0, 0, 1);
		case 24: ApplyAnimationEx(playerid, !"DANCING", !"DAN_RIGHT_A", 4.1, 0, 0, 0, 0, 0, 1);
		case 25: ApplyAnimationEx(playerid, !"BSKTBALL", !"BBALL_DEF_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 26: ApplyAnimationEx(playerid, !"MISC", !"PLYR_SHKHEAD", 4.1, 0, 0, 0, 0, 0, 1);
		case 27: ApplyAnimationEx(playerid, !"BSKTBALL", !"BBALL_IDLE", 4.1, 0, 0, 0, 0, 0, 1);
		case 28: ApplyAnimationEx(playerid, !"CAMERA", !"camstnd_cmon", 4.0, 0, 0, 0, 0, 0);
		case 29: ApplyAnimationEx(playerid, !"SHOP", !"SHP_ROB_HANDSUP", 4.1, 0, 0, 0, 0, 0, 1);
		case 30: ApplyAnimationEx(playerid, !"CRACK", !"CRCKIDLE2", 4.1, 0, 0, 0, 0, 0, 1);
		case 31: ApplyAnimationEx(playerid, !"CRACK", !"CRCKIDLE4", 4.1, 0, 0, 0, 0, 0, 1);
		case 32: ApplyAnimationEx(playerid, !"DEALER", !"DEALER_IDLE", 4.1, 0, 0, 0, 0, 0, 1);
		case 33: ApplyAnimationEx(playerid, !"GANGS", !"LEANIDLE", 4.1, 0, 0, 0, 0, 0, 1);
		case 34: ApplyAnimationEx(playerid, !"GANGS", !"SHAKE_CARSH", 4.1, 0, 0, 0, 0, 0, 1);
		case 35: ApplyAnimationEx(playerid, !"GANGS", !"SMKCIG_PRTL", 4.1, 0, 0, 0, 0, 0, 1);
		case 36: ApplyAnimationEx(playerid, !"BEACH", !"ParkSit_W_loop", 3.0, 0, 1, 1, 1, 0);
		case 37: ApplyAnimationEx(playerid, !"INT_HOUSE", !"LOU_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 38: ApplyAnimationEx(playerid, !"INT_OFFICE", !"OFF_SIT_BORED_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 39: ApplyAnimationEx(playerid, !"INT_OFFICE", !"OFF_SIT_IDLE_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 40: ApplyAnimationEx(playerid, !"INT_OFFICE", !"OFF_SIT_TYPE_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 41: ApplyAnimationEx(playerid, !"INT_SHOP", !"SHOP_SHELF", 4.1, 0, 0, 0, 0, 0, 1);
		case 42: ApplyAnimationEx(playerid, !"JST_BUISNESS", !"girl_02", 4.1, 0, 0, 0, 1, 1, 1);
		case 43: ApplyAnimationEx(playerid, !"KISSING", !"GF_STREETARGUE_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 44: ApplyAnimationEx(playerid, !"KISSING", !"Grlfrd_Kiss_01", 4.0, 0, 0, 0, 0, 0, 1);
		case 45: ApplyAnimationEx(playerid, !"KISSING", !"Grlfrd_Kiss_01", 4.0, 0, 0, 0, 0, 0, 1);
		case 46: ApplyAnimationEx(playerid, !"KISSING", !"Grlfrd_Kiss_02", 4.0, 0, 0, 0, 0, 0, 1);
		case 47: ApplyAnimationEx(playerid, !"LOWRIDER", !"RAP_B_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 48: ApplyAnimationEx(playerid, !"MEDIC", !"CPR", 4.0, 0, 0, 0, 0, 0);
		case 49: ApplyAnimationEx(playerid, !"MISC", !"BITCHSLAP", 4.1, 0, 0, 0, 0, 0, 1);
		case 50: ApplyAnimationEx(playerid, !"MISC", !"BNG_WNDW", 4.1, 0, 0, 0, 0, 0, 1);
		case 51: ApplyAnimationEx(playerid, !"MISC", !"KAT_THROW_K", 4.1, 0, 0, 0, 0, 0, 1);
		case 52: ApplyAnimationEx(playerid, !"MISC", !"SEAT_LR", 4.1, 0, 0, 0, 0, 0, 1);
		case 53: ApplyAnimationEx(playerid, !"PED", !"SEAT_IDLE", 4.1, 0, 0, 0, 0, 0, 1);
		case 54: ApplyAnimationEx(playerid, !"ON_LOOKERS", !"LKUP_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 55: ApplyAnimationEx(playerid, !"ON_LOOKERS", !"POINTUP_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 56: ApplyAnimationEx(playerid, !"ON_LOOKERS", !"PANIC_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 57: ApplyAnimationEx(playerid, !"ON_LOOKERS", !"SHOUT_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 58: ApplyAnimationEx(playerid, !"GHANDS", !"gsign1LH", 4.0, 0, 0, 0, 0, 1, 1);
		case 59: ApplyAnimationEx(playerid, !"PED", !"IDLE_taxi", 4.0, 0, 0, 0, 0, 0);
		case 60: ApplyAnimationEx(playerid, !"POLICE", !"DOOR_KICK", 4.1, 0, 0, 0, 0, 0, 1);
		case 61: ApplyAnimationEx(playerid, !"POLICE", !"COPTRAF_STOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 62: ApplyAnimationEx(playerid, !"RIOT", !"RIOT_ANGRY_B", 4.1, 0, 0, 0, 0, 0, 1);
		case 63: ApplyAnimationEx(playerid, !"LOWRIDER", !"RAP_C_Loop", 4.0, 1, 0, 0, 0, 0);
		case 64: ApplyAnimationEx(playerid, !"SWAT", !"GNSTWALL_INJURD", 4.1, 0, 0, 0, 0, 0, 1);
		case 65: ApplyAnimationEx(playerid, !"SWEET", !"SWEET_INJUREDLOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 66: ApplyAnimationEx(playerid, !"RIOT", !"RIOT_ANGRY", 4.0, 0, 0, 0, 0, 0);
		case 67: ApplyAnimationEx(playerid, !"GHANDS", !"GSIGN2", 4.1, 0, 0, 0, 0, 0, 1);
		case 68: ApplyAnimationEx(playerid, !"GHANDS", !"GSIGN4", 4.1, 0, 0, 0, 0, 0, 1);
		case 69: ApplyAnimationEx(playerid, !"GHANDS", !"GSIGN5", 4.1, 0, 0, 0, 0, 0, 1);
		case 70: ApplyAnimationEx(playerid, !"CRACK", !"CRCKIDLE1", 4.1, 0, 0, 0, 0, 0, 1);
		case 71: ApplyAnimationEx(playerid, !"SPRAYCAN", !"spraycan_full", 4.0, 0, 0, 0, 0, 0);
		case 72: ApplyAnimationEx(playerid, !"GRAFFITI", !"SPRAYCAN_FIRE", 4.1, 0, 0, 0, 0, 0, 1);
		case 73: ApplyAnimationEx(playerid, !"SMOKING", !"M_SMKSTND_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 74: ApplyAnimationEx(playerid, !"RIOT", !"RIOT_CHANT", 4.1, 0, 0, 0, 0, 0, 1);
		case 75: ApplyAnimationEx(playerid, !"RIOT", !"RIOT_PUNCHES", 4.1, 0, 0, 0, 0, 0, 1);
		case 76: ApplyAnimationEx(playerid, !"PED", !"fucku", 4.0, 0, 0, 0, 0, 0, 1);
		case 77: ApplyAnimationEx(playerid, !"LOWRIDER", !"RAP_A_Loop", 4.0, 1, 0, 0, 0, 0);
		case 78: ApplyAnimationEx(playerid, !"CAR", !"FIXN_CAR_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 79: ApplyAnimationEx(playerid, !"CAR_CHAT", !"CAR_TALKM_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
		case 80: ApplyAnimationEx(playerid, !"CRACK", !"BBALBAT_IDLE_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 81: ApplyAnimationEx(playerid, !"CRACK", !"BBALBAT_IDLE_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 82: ApplyAnimationEx(playerid, !"GHANDS", !"GSIGN1", 4.0, 0, 0, 0, 0, 1, 1);
		case 83: ApplyAnimationEx(playerid, !"GHANDS", !"GSIGN3", 4.0, 0, 0, 0, 0, 1, 1);
		case 84: ApplyAnimationEx(playerid, !"GRAVEYARD", !"mrnF_loop", 4.1, 0, 1, 1, 0, 0);
		case 85: ApplyAnimationEx(playerid, !"MISC", !"scratchballs_01", 4.0, 0, 0, 0, 0, 0);
		case 86: ApplyAnimationEx(playerid, !"INT_HOUSE", !"LOU_In", 4.1, 0, 0, 0, 1, 1, 1);
		case 87: ApplyAnimationEx(playerid, !"SUNBATHE", !"Lay_Bac_in", 3.0, 0, 1, 1, 1, 0);
		case 88: ApplyAnimationEx(playerid, !"BEACH", !"SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0);
		case 89: ApplyAnimationEx(playerid, !"PED", !"DLE_armed", 4.1, 0, 1, 1, 1, 1, 1);
		case 90: ApplyAnimationEx(playerid, !"PED", !"Gun_stand", 4.1, 0, 1, 1, 1, 1, 1);
		case 91: ApplyAnimationEx(playerid, !"KISSING", !"gfwave2", 4.1, 0, 1, 1, 0, 0);
		case 92: ApplyAnimationEx(playerid, !"PED", !"BIKE_fall_off", 4.1, 0, 1, 1, 1, 1, 1);
		case 93: ApplyAnimationEx(playerid, !"PED", !"BIKE_pickupL", 4.1, 0, 0, 0, 0, 0, 1);
		case 94: ApplyAnimationEx(playerid, !"GANGS", !"hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
		case 95: ApplyAnimationEx(playerid, !"GANGS", !"hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
		case 96: ApplyAnimationEx(playerid, !"GANGS", !"hndshkfa_swt", 4.0, 0, 0, 0, 0, 0, 1);
		case 97: ApplyAnimationEx(playerid, !"GANGS", !"shake_carK", 4.0, 0, 0, 0, 0, 0);
		case 98: ApplyAnimationEx(playerid, !"GANGS", !"shake_cara", 4.0, 0, 0, 0, 0, 0);
		case 99: ApplyAnimationEx(playerid, !"PED", !"KO_shot_stom", 4.0, 0, 1, 1, 1, 0);
		case 100: ApplyAnimationEx(playerid, !"PED", !"EV_DIVE", 4.0, 0, 1, 1, 1, 0);
		case 101: ApplyAnimationEx(playerid, !"PED", !"BIKE_fallR", 4.0, 0, 1, 1, 1, 0);
		case 102: ApplyAnimationEx(playerid, !"GYMNASIUM", !"GYMshadowbox", 4.0, 1, 1, 1, 1, 0);
		case 103: ApplyAnimationEx(playerid, !"PED", !"gang_gunstand", 3.0, 0, 1, 1, 1, 0);
		default:
		{
			if IsPlayerCefInit(playerid) *then
			{
				ExecuteEvent(playerid, 0, "window.executeEvent('event.setActiveView', '[\"AnimationsMenu\"]');");
				ExecuteEvent(playerid, 0, "window.executeEvent('event.animationsMenu.ClearAnimations', '[null]');");
				ExecuteEvent(playerid, 0, "window.executeEvent('event.animationsMenu.initializeAnimations', '[]');");
				OnFocusBrowser(playerid, 0, true);
			}
			else
			{
			    return ShowPlayerDialogEx(playerid, 133, DIALOG_STYLE_LIST, !"Animacijos",
			        !"[1] Sokti (1)\n\
			        [2] Sokti (2)\n\
			        [3] Sokti (3)\n\
			        [4] Sokti (4)\n\
			        [5] Sokti (5)\n\
			        [6] Sokti (6)\n\
			        [7] Mojuoti ranka\n\
			        [8] Atsigulti ant zemes\n\
			        [9] Atsisveikinti\n\
			        [10] Skaityti repa\n\
			        [11] Atsisesti, uzdengus galva rankomis\n\
			        [12] Uzsideti kauke\n\
			        [13] Istiesti ranka priesais save\n\
			        [14] Sukryziuoti rankas\n\
			        [15] Vemti\n\
			        [16] Uzkasti\n\
			        [17] Pasiulyti narkotikus\n\
			        [18] Guleti ant zemes (trukciojant)\n\
			        [19] Rukyti kaip vyras\n\
			        [20] Rukyti kaip moteris\n\
			        [21] Atsisesti ant zemes\n\
			        [22] Rytu kovos menai\n\
			        [23] Isgerti gerima\n\
			        [24] Sokti ant vienos kojos\n\
			        [25] Stoveti vartininko pozoje\n\
			        [26] Facepalm\n\
			        [27] Rytu sokio elementas\n\
			        [28] Pakviesti ka nors\n\
			        [29] Pakelti rankas i virsu\n\
			        [30] Guleti ant sono ant zemes\n\
			        [31] Guleti ant nugaros ant zemes\n\
			        [32] Stoveti kaip dilleris (atsigreziant)\n\
			        [33] Atsiremti nugara\n\
			        [34] Stumti sonu\n\
			        [35] Suvalgyti kazka (desine ranka)\n\
			        [36] Guleti, remiantis delnu\n\
			        [37] Atsisesti ant kedes\n\
			        [38] Sedeti pavargusiam prie PC\n\
			        [39] Sedeti prie stalo\n\
			        [40] Sedeti ir rasyti\n\
			        [41] Paimti ka nors ir apziureti\n\
			        [42] Atsisesti sukryziavus kojas\n\
			        [43] Atsisakyti ko nors\n\
			        [44] Bucinys 1\n\
			        [45] Bucinys 2\n\
			        [46] Bucinys 3\n\
			        [47] Mojuoti rankomis vietoje\n\
			        [48] Dirbtinis kvepavimas\n\
			        [49] Pliaukstelejimai gulint\n\
			        [50] Ziureti pro ka nors\n\
			        [51] Rytu kovos menu elementas\n\
			        [52] Sesti ant kedes (2)\n\
			        [53] Sesti ant kedes (3)\n\
			        [54] Ziureti i dangu\n\
			        [55] Nurodyti ranka i virsu\n\
			        [56] Bijoti ko nors\n\
			        [57] Raginti kazka (streikas)\n\
			        [58] Gangsterio gestas\n\
			        [59] Gaudyti transporta\n\
			        [60] Kojos smugis\n\
			        [61] Belsti i duris\n\
			        [62] Kelti sukilima\n\
			        [63] Sokcioti\n\
			        [64] Guleti ant zemes (nepadoriai)\n\
			        [65] Prasta savijauta\n\
			        [66] Gangsterio pasisveikinimas\n\
			        [67] Pasisveikinimas\n\
			        [68] Gestikuliuoti (1)\n\
			        [69] Gestikuliuoti (2)\n\
			        [70] Sedeti suzeistu\n\
			        [71] Piesti graffiti (1)\n\
			        [72] Piesti graffiti (2)\n\
			        [73] Rukyti\n\
			        [74] Sirgalius (2)\n\
			        [75] Sirgalius (3)\n\
			        [76] Rodyti Fuck\n\
			        [77] Skaityti repa\n\
			        [78] Taisyti masina\n\
			        [79] Atsiremti i automobili\n\
			        [80] Laikyti lazda (1)\n\
			        [81] Laikyti lazda (2)\n\
			        [82] Gestikuliuoti (3)\n\
			        [83] Gestikuliuoti (4)\n\
			        [84] Verkti\n\
			        [85] Kasyti kiausus\n\
			        [86] Sesti [3]\n\
			        [87] Atsigulti [2]\n\
			        [88] Atsigulti [4]\n\
			        [89] Atsistoti i stovesena su AK-47\n\
			        [90] Atsistoti i stovesena su Deagle\n\
			        [91] Mojuoti ranka\n\
			        [92] Nukristi\n\
			        [93] Atsikelti\n\
			        [94] Pasisveikinti [1]\n\
			        [95] Pasisveikinti [2]\n\
			        [96] Pasisveikinti [3]\n\
			        [97] Spirti koja\n\
			        [98] Pastumti\n\
			        [99] Mirti\n\
			        [100] Sokti\n\
			        [101] Persiversti\n\
			        [102] Box\n\
			        [103] Nutaikyti ginkla\n\
					[104] {FFFF00}'Unikalus sokis Fortnite\n\
	                [105] {FFFF00}'Unikalus sokis Gangnam Style\n\
	                [106] {FFFF00}'Unikalus sokis Cowboy",
			        !"Isrinkti", !"Atsaukti");
			}
		}
	}
	if !(animid == 0) *then
	    SPD(playerid, 0, DIALOG_STYLE_MSGBOX, "Помощь", "{ffffff}Для того чтобы остановить анимацию, введите: {ffff00}/stanim{ffffff} или нажмите {ffff00}ENTER", "Хорошо", ""),
			AnimPlayed{playerid} = true,
				TextDrawShowForPlayer(playerid, StopAnimation);
	return 1;
}
alias:anims("anim", "animlist");
CMD:park(playerid)
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(GetPlayerState(playerid) != 2) return SCM(playerid, COLOR_OLDRED, !"Jus turite buti uz savo automobilio vairo!");
	if(!IsPlayerInHisVehicle(playerid) && !PI[playerid][pAdmin]) return SCM(playerid, COLOR_RED, !"Tai ne jusu automobilis!");
	for(new i; i < MAX_ZONE; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, nzone[i][zDistance], nzone[i][zEnter_x], nzone[i][zEnter_y], nzone[i][zEnter_z]))
	    {
	        SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"{B8F64D}Uzuomina", !"{FFFFFF}Sioje vietoje {B8F64D}negalima {FFFFFF}statyti asmeninio automobilio!", !"Supratau", !"");
	        return 1;
	    }
	}
	new Float: vhealth;
	new carid = GetPlayerVehicleID(playerid);
	new panels, doors_, lights_, tires;
	GetVehicleDamageStatus(carid, panels, doors_, lights_, tires);
	new number = GetVehicleID(carid);
	new Float: car_x, Float: car_y, Float: car_z;
	GetVehiclePos(carid, car_x, car_y, car_z);
	CarInfo[number][cPos_X] = car_x;
	CarInfo[number][cPos_Y] = car_y;
	CarInfo[number][cPos_Z] = car_z + 0.8;
	CarInfo[number][cParkedInPark] = 0;
	GetVehicleZAngle(carid, CarInfo[number][cPos_A]);
	f(global_str, 2000, "UPDATE `ownable` SET `Pos_X` = '%.4f', `Pos_Y` = '%.4f', `Pos_Z` = '%.4f', `Pos_A` = '%.4f' WHERE ID = %d", CarInfo[number][cPos_X], CarInfo[number][cPos_Y], CarInfo[number][cPos_Z], CarInfo[number][cPos_A], CarInfo[number][cID]);
    mysql_tquery(mysql, global_str);
	GetVehicleHealth(carid, vhealth);
	CarInfo[number][cVirtualWorld] = GetPlayerVirtualWorld(playerid);
	CarInfo[number][cInterior] = GetPlayerInterior(playerid);
	RestartCar(carid);
	f(global_str, 64, "{000000}%s", CarInfo[number][cNumber]);
	SetVehicleNumberPlate(carid, global_str);
	J_SetVehicleHealth(carid, vhealth);
	UpdateVehicleDamageStatus(carid, panels, doors_, lights_, tires);
	if(!IsAVelik(carid) || !IsASkate(carid)) SetEngineStatus(carid, false, playerid);
	else SetEngineStatus(carid, true, playerid);
	CallTimeOutFunction("ModCar", 1000, false, "d", carid);
	if(GarageEntered[playerid] != -1) {
		if(GetPlayerVirtualWorld(playerid) != 0) {
			CarInfo[number][cParkedInGarage] = 1;
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"\n\n{FFFFFF}Jus sekmingai pastatete savo automobili garaze!\nDabar jusu automobilis bus {ECE146}uzspawnintas{FFFFFF} sioje vietoje.\nDabar jums nereikia moketi {ECE146}mokescio{FFFFFF} uz automobili, kuris stovi garaze!\n\n", !"Supratau", !"");
		}
	}
	else if(ParkingEntered[playerid] != -1) {
		if(GetPlayerVirtualWorld(playerid) != 0) {
			CarInfo[number][cParkedInParking] = 1;
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"\n\n{FFFFFF}Jus sekmingai pastatete savo automobili pozemineje stovejimo aiksteleje!\nDabar jusu automobilis bus {ECE146}uzspawnintas{FFFFFF} sioje vietoje.\nDabar jums nereikia moketi {ECE146}mokescio{FFFFFF} uz automobili, kuris stovi garaze!\n\n", !"Supratau", !"");
		}
	}
	else
	{
		if(CarInfo[number][cParkedInGarage]) CarInfo[number][cParkedInGarage] = 0;
	}
	SaveOwnableCar(number);
	return 1;
}
CMD:sellcar(playerid)
{
    if(!IsPlayerLogged{playerid}) return 0;
    new
		carid = GetPlayerVehicleID(playerid);
	if(!IsAOwnableCar(carid))
		return 0;
	if(!GetString(CarInfo[GetVehicleID(carid)][cOwner], PN(playerid)))
		return SCM(playerid, COLOR_GREY, !"Jus turetumete sedeti savo asmeniniame automobilyje");
	if((pTemp[playerid][pSellCar] != -1 && autoBazarInfo[pTemp[playerid][pSellCar]][autoBazarCarID] == carid))
	    return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite parduoti transporto priemones, kol prekiaujate automobiliu turguje");
	return SPD(playerid, 803, DIALOG_STYLE_MSGBOX, !"Ispejimas", !"{FFFFFF}Jus tikrai norite parduoti savo automobili?\nParduodant automobili jums bus pasiulyta tik\nnedidele dalis jo valstybines vertes", !"Toliau", !"Atsaukti");
}
CMD:tradecar(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
    new id,dop;
    new carid = GetPlayerVehicleID(playerid);
    if(!GetString(CarInfo[GetVehicleID(carid)][cOwner], PN(playerid)))
		return SCM(playerid, COLOR_GREY, !"Jus turetumete sedeti savo asmeniniame automobilyje");
    if(!IsABoat(carid))
    {
	    if(IsPlayerInRangeOfPoint(playerid, 250, -2123.6548,-854.3079,32.0939))
		{
		    if(sellcarto[playerid]>Global_Time)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Pasiulyma pirkti/mainyti galima daryti kas minute!");
		    if(sscanf(params,"ud",id,dop)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /tradecar [id] [Priemoka (Jei be priemokos, irasykite 0)]");
            if(!IsPlayerConnected(id)) return SCM(playerid,COLOR_RED,!"Neteisingas zaidejo ID!");
			if !SettingData[id][sdActionTrade] *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas isjunge galimybe siulyti jam parduoti/mainyti automobili!");
			if(dop>12000000)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Priemoka neturi virsyti 12 000 000$");
		    if(IsPlayerInHisVehicle(playerid)) return SCM(playerid,COLOR_RED,!"Jus nesate savo automobilyje!");
		    if(IsPlayerInHisVehicle(id)) return SCM(playerid,COLOR_RED,!"Zaidejas, su kuriuo norite apsikeisti automobiliais, nera savo transporte.");
		    if(id == playerid) return 0;
		    if(dop<0 || dop > 100000000)return 0;
		    new pcaridd = GetPlayerVehicleID(id);
		    if(!ProxDetectorS(10.0, playerid, id)) return SCM(playerid,COLOR_GREY, !"Zaidejas turi buti salia jusu.");
			f(global_str,400,"{FFFFFF}Jus siulote %s apsikeisti transportu\n\n_____________________\nJusu modelis: %s\nKomplektacija: %s\n{FFFFFF}Numeriai: %d\n\n{C16060}Modelis %s: %s\nKomplektacija: %s\n{FFFFFF}Numeriai: %d\nPriemoka: %d\n\n{FFFFFF}_____________________",PN(id), GetVehicleName(carid),VehicleInfo[carid][vModification] == 578 ? ("{e54c4c}TT") : ("{96e54c}Standart"),carid,PN(id), GetVehicleName(pcaridd), VehicleInfo[pcaridd][vModification] == 578 ? ("{dd565f}TT") : ("{9ACD32}Standart"),pcaridd,dop);
			SPD(playerid,0,0,"Transporto mainai",global_str,"OK","");
			f(global_str,400,"{FFFFFF}%s siulo jums apsikeisti transportu\n\n_____________________\nJusu modelis: %s\nKomplektacija: %s\n{FFFFFF}Numeriai: %d\n\n{C16060}Modelis %s: %s\nKomplektacija: %s\n{FFFFFF}Numeriai: %d\nPriemoka: %d\n\n{FFFFFF}_____________________",
			PN(playerid), GetVehicleName(GetPlayerVehicleID(id)), VehicleInfo[GetPlayerVehicleID(playerid)][vModification] == 578 ? ("{e54c4c}TT") : ("{96e54c}Standart"),GetPlayerVehicleID(id),PN(playerid), GetVehicleName(GetPlayerVehicleID(playerid)),VehicleInfo[carid][vModification] == 578 ? ("{e54c4c}TT") : ("{96e54c}Standart"),GetPlayerVehicleID(playerid),dop);
			SPD(id,2999,0,"Transporto mainai",global_str, !"Priimti","Atsaukti");
		 	caoffer[id]=playerid;
		 	caoffer[playerid]=id;
		 	cardop[playerid] = dop;
		 	cartrade[playerid]= GetPlayerVehicleID(playerid);
            cartrade[id] = GetPlayerVehicleID(id);
		 	sellcarto[playerid]=Global_Time+60;
		}
		else
		{
		    SCM(playerid,COLOR_RED,!"Parduoti ar keistis transporto priemonemis galima tik automobiliu turguje! /GPS -> Kita -> Automobiliu Turgus!");
		    EnableGPSForPlayer(playerid,-2154.3662,-970.6815,32.0234);
		}
	}
	return 1;
}
CMD:sellcarto(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	if(!GetString(CarInfo[GetVehicleID(GetPlayerVehicleID(playerid))][cOwner], PN(playerid))) return SCM(playerid,COLOR_RED,!"Jus nesate savo automobilyje!");
	new carid = GetPlayerVehicleID(playerid);
    {
		if(IsPlayerInRangeOfPoint(playerid, 250, -2123.6548,-854.3079,32.0939))
		{
			if(sellcarto[playerid]>Global_Time)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Pasiulyma pirkti/mainyti galima daryti kas minute!");
		    new number = GetVehicleID(carid);
		    if(!IsPlayerRegCar(playerid, carid)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate savo automobilyje!");
		    new id, cost;
		    if(sscanf(params,"ud",id,cost)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /sellcarto [id] [suma]");
			if !SettingData[id][sdActionTrade] *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas isjunge galimybe siulyti jam parduoti/mainyti automobili!");
			if(cost<10000)return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Per maza kaina! [ Minimaliai 10000$ ]");
			if(!IsPlayerConnected(id)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Neteisingas zaidejo ID!");
			if(id == playerid) return 0;
			if(!ProxDetectorS(7.0, playerid, id)) return SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Zaidejas turi buti salia transporto priemones");
			if(IsACar(carid) && cost > (CarInfo[number][cCost]*8)) return SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Kaina negali virsyti 8 kartus nuo valstybines vertes.");
			sellcarto[playerid]=Global_Time+60;
			f(global_str,150,"{FFFFFF}Jus siulote %s nusipirkti transporta\n\nModelis: %s\nNumeriai: %d\nKaina: %d$\nKomplektacija: %s",
			PN(id), GetVehicleName(carid), carid,cost, VehicleInfo[carid][vModification] == 578 ? ("{e54c4c}TT") : ("{96e54c}Standart") );
			SPD(playerid,0,0,"Transporto pardavimas",global_str,"OK","");
			f(global_str,150,"{FFFFFF}%s siulo jums nusipirkti jo transporta\n\nModelis: %s\nNumeriai: %d\nKaina: %d$\nKomplektacija: %s",
			PN(id), GetVehicleName(carid), carid,cost, VehicleInfo[carid][vModification] == 578 ? ("{e54c4c}TT") : ("{96e54c}Standart") );
			SPD(id,3000,0,"Transporto pirkimas",global_str,"Nusipirkti", !"Atsaukti");
			CarOffer[id] = playerid;
			CarOffer[playerid] = id;
			CarPrice[id] = cost;
		}
		else
		{
		    SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Parduoti ar keistis transporto priemonemis galima tik automobiliu turguje! /GPS -> Kita -> Automobiliu Turgus!");
		    EnableGPSForPlayer(playerid,-2154.3662,-970.6815,32.0234);
		}
	}
	return 1;
}
CMD:key(playerid)
{
    if(!IsPlayerLogged{playerid}) return 0;
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate savo automobilyje!");
	if(!IsPlayerInHisVehicle(playerid) && !PI[playerid][pAdmin])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate savo automobilyje!");
	if(IsANotControllable(playerid))
		return SCM(playerid, COLOR_GREY, !"Siuo metu jus negalite judeti.");
	new
		carid = GetPlayerVehicleID(playerid),
		number = GetVehicleID(carid);
	if(IsAVelik(carid) || IsASkate(carid))
		return 1;
	if(CarInfo[number][cShtraf])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis transportas stovi baudos aiksteleje!");
	if(CarInfo[number][cKeyIN])
	{
		CarInfo[number][cKeyIN] = 0;
	    f(global_str, 128, " %s istrauke raktus is uzdegimo spynos", PN(playerid));
	    ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
	    SetEngineStatus(carid, false, playerid);
 	}
	else
	{
	    CarInfo[number][cKeyIN] = 1;
	    f(global_str, 128, " %s ikiso raktus i uzdegimo spyna", PN(playerid));
	    ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
	}
	return 1;
}
CMD:alarm(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
	extract params -> new car; else
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /alarm [id]");
	if(!IsPlayerHaveCar(playerid,car))
		return 0;
    new
		number = GetVehicleID(car);
	if(!CarInfo[number][cAlarmON])
	{
		CarInfo[number][cAlarmON] = 1;
		SCM(playerid, COLOR_YELLOW, !"Signalizacija ijungta");
	}
	else
	{
		CarInfo[number][cAlarmON] = 0;
		SCM(playerid, COLOR_RED, !"Signalizacija isjungta");
		SetAlarmStatus(car, false);
	}
	return 1;
}
CMD:jlock(playerid, params[])
{
    if(!IsPlayerLogged{playerid}) return 0;
    new Float: x, Float: y, Float: z, tyk = jlock[playerid];
    if(tyk != 0) GetVehiclePos(tyk, x, y, z);
    if(VehicleInfo[tyk][vLock] && IsPlayerInRangeOfPoint(playerid, 5, x, y, z))
	{
	    if(VehicleInfo[tyk][vJob] == 0 && !IsAArendCar(tyk) ) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Uzdaryti/Atidaryti galima tik darbini ir isnuomota transporta!");
	    VehicleInfo[tyk][vLock] = 0;
	    SetDoorsStatus(tyk, 0, playerid);
		GameTextForPlayer(playerid, "~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~CAR~g~ UNLOCK~n~/jlock", 3000, 3);
		SetPlayerChatBubble(playerid, "* Atidaro darbini transporta", COLOR_PURPLE, 10.0, 5000);
		tyk = 0;
		jlock[playerid] = tyk;
	}
	else
	{
	    if(GetPlayerState(playerid) != 2) return SCM(playerid, COLOR_RED, !"Pasiekiama tik vairuotojo vietoje!");
	    if(VehicleInfo[GetPlayerVehicleID(playerid)][vJob] == 0 && !IsAArendCar(GetPlayerVehicleID(playerid))) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Uzdaryti/Atidaryti galima tik darbini ir isnuomota transporta!");
	    VehicleInfo[GetPlayerVehicleID(playerid)][vLock] = 1;
		SetDoorsStatus(GetPlayerVehicleID(playerid), 1, playerid);
		GameTextForPlayer(playerid, "~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~CAR~r~ LOCK~n~/jlock", 3000, 3);
		SetPlayerChatBubble(playerid, "* Uzdaro darbini transporta", COLOR_PURPLE, 10.0, 5000);
		tyk = GetPlayerVehicleID(playerid);
		jlock[playerid] = tyk;
	}
	return 1;
}
cmd:style(playerid)
{
    if !IsPlayerLogged{playerid} *then
		return 0;
    if GetPlayerState(playerid) != 2 *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus turite buti vairuotojo vietoje!");
    new vehid = GetPlayerVehicleID(playerid);
    if !VehicleInfo[vehid][vModification] *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Vaziavimo stiliu galite keisti tik jei turite techniniu modifikaciju arba policijos automobiliuose!");
    VehicleInfo[vehid][vStyle] = !VehicleInfo[vehid][vStyle];
    if IsAOwnableCar(vehid) *then CarInfo[GetVehicleID(vehid)][cStyle] = !CarInfo[GetVehicleID(vehid)][cStyle];
    GameTextForPlayer(playerid, VehicleInfo[vehid][vStyle] ? ("~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~STYLE:~r~ SPORT!") : ("~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~STYLE:~g~ COMFORT!"), 3000, 3);
    PlayerPlaySound(playerid, 32000, 0.0, 0.0, 0.0);
    return 1;
}
CMD:remkey(playerid)
{
	if !(AksSlot[playerid][0][5] == 614) *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus neturite unikalaus aksesuaro 'Plaktukas'.");
	if(Int_GetPlayerData(playerid, "remkey") > Global_Time) return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Si aksesuara galima naudoti karta per valanda!");
	new Float:pX, Float:pY, Float:pZ, Float:vX, Float:vY, Float:vZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	new Float:minS = 1.50, Float:dist, car = INVALID_VEHICLE_ID;
	foreach(Vehicle, i)
	{
		GetVehiclePos(i, vX, vY, vZ);
		dist = PointToPoint(pX, pY, pZ, vX, vY, vZ);
		if(dist < minS)
		{
			car = i;
			minS = dist;
		}
	}
	if(car == INVALID_VEHICLE_ID) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate per toli nuo transporto priemones, kuria reikia taisyti!");
	J_RepairVehicle(car);
	SetPVarInt(playerid, "remkey", Global_Time+3600);
	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1);
    f(global_str, 100, " %s suremontavo savo automobili.", PN(playerid));
	ProxDetector(25, playerid, global_str, COLOR_ME);
    GameTextForPlayer(playerid, !"~w~CAR IS ~g~REPAIRED", 5000, 6);
	return 1;
}
CMD:lock(playerid)
{
	new
		Float:pX, Float:pY, Float:pZ,
		Float:minS = 9.50, Float:CurrentDistance,
	    car = INVALID_VEHICLE_ID;
	GetPlayerPos(playerid, pX, pY, pZ);
	foreach(Vehicle, i)
	{
		if !IsAOwnableCar(i) *then continue;
		else if IsPlayerHaveCar(playerid, i) or PI[playerid][pAdmin] *then
		{
			CurrentDistance = GetVehicleDistanceFromPoint(i, pX, pY, pZ);
			if CurrentDistance < minS *then
				car = i, minS = CurrentDistance;
		}
	}
	if car == INVALID_VEHICLE_ID *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Salia jusu nera transporto!");
	new
	    number = GetVehicleID(car);
	SetDoorsStatus(car, CarInfo[number][cLock] = !CarInfo[number][cLock], playerid);
	return GameTextForPlayer(playerid, CarInfo[number][cLock] ? "~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~CAR~r~ LOCK~n~/lock":"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~CAR~g~ UNLOCK~n~/lock", 3000, 3);
}
CMD:findibiz(playerid, params[])
{
	if(PI[playerid][pMoney] < 15000) return SCM(playerid, COLOR_RED, !">>>>{FFFFFF} - Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
	new id;
	if(sscanf(params,"d",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /findibiz [id]");
	if(id > OWNABLEBIZES) return 0;
	EnableGPSForPlayer(playerid,BizData[id][bEnter_X],BizData[id][bEnter_Y],BizData[id][bEnter_Z]);
	GiveMoney(playerid,-15000);
	SCM(playerid,COLOR_LIGHTBLUE,"[Informacija] {FFFFFF}Zemelapyje pazymeta vieta, kur bus verslas.");
	FirstGiveBizMoney(-2240.6787,577.6776,35.1719,15000);
	return true;
}
CMD:findihouse(playerid, params[])
{
	if(PI[playerid][pMoney] < 15000) return SCM(playerid, COLOR_RED, !">>>>{FFFFFF} - Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
	new id;
	if(sscanf(params,"d",id)) return SCM(playerid,COLOR_OLDRED, !"Naudokite: /findihouse [id]");
	if(id > OWNABLEHOUSES) return 0;
	EnableGPSForPlayer(playerid,HouseInfo[id][hEnter_X],HouseInfo[id][hEnter_Y],HouseInfo[id][hEnter_Z]);
	GiveMoney(playerid,-15000);
	SCM(playerid,COLOR_LIGHTBLUE,"[Informacija] {FFFFFF}Zemelapyje pazymeta vieta, kur bus namas.");
	FirstGiveBizMoney(-2240.6787,577.6776,35.1719,15000);
	return true;
}
CMD:out(playerid)
{
	if PI[playerid][pVIP] < 5 *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Komanda pasiekiama nuo 5 VIP lygio!");
    else if PI[playerid][pLeader] *then
		return SCM(playerid, COLOR_RED, !"Jus negalite atsistatydinti is lyderio pareigu!");
    else if !PI[playerid][pMember] *then
		return SCM(playerid, COLOR_RED, !"Jus nesate nei vienoje organizacijoje!");
	f(global_str, 100, "[Svarbu] {FFFFFF}%s[%d] savo noru paliko organizacija!", PN(playerid), playerid);
	SendTeamMessage(PI[playerid][pMember], COLOR_RED, global_str);
	UnInvite(playerid);
 	return SCM(playerid, COLOR_LIGHTBLUE, !"Jus palikote organizacija");
}
CMD:su(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_GREY, !"Jus nesate policininkas!");
	if(PI[playerid][pRank] < 3) return SCM(playerid,COLOR_RED,!"Pateikti i paieska galima nuo 3 rango!");
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
	new id, wanted, reason[100];
    if(sscanf(params, "uds[100]", id, wanted, reason)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /su [id] [paieskos lygis] [priezastis]");
	if(id == INVALID_PLAYER_ID) return 0;
    if(IsAIP(reason))return 1;
    if(PI[id][pWanted]>=6)return SCM(playerid,COLOR_GREY, !"Sis zaidejas jau turi 6-o lygio paieska!");
    if(PI[id][pWanted]==wanted) return SCM(playerid,COLOR_GREY, !"Sis zaidejas jau turi toki paieskos lygi.");
    if(!IsPlayerConnected(id)) return SCM(playerid,COLOR_GREY, !"Neteisingas zaidejo ID!");
    if(IsACop(id))return SCM(playerid,COLOR_GREY, !"Negalima skelbti policininko paieska");
    if(PI[id][pJailTime]) return SCM(playerid,COLOR_GREY, !"Negalima paskelbti ieskomo kalinio");
    if(wanted < 1 || wanted > 6) return SCM(playerid,COLOR_GREY, !"Negalima duoti maziau nei 1 ir daugiau nei 6 zvaigzdziu");
	SetPlayerCriminal(playerid,id,PI[id][pWanted]+wanted,reason);
    return 1;
}
cmd:f(playerid, params[])
{
    if(!IsAtGang(playerid) && !IsAtMafia(playerid))return 1;
	if(GetTeamID(playerid) == 0) return 0;
    if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
    if(PI[playerid][pFMuteTime] > 0) return SCM(playerid, COLOR_GREY, !"Lyderis nutilde jus ir jus negalite rasyti i /f Chat");
    if(sscanf(params,"s[100]",params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /f [text]");
    if(IsADomen(params[0])  && PI[playerid][pAdmin]<6)
    {
		SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid,-1, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 1;
    }
    if(IsAIP(params[0]))return 1;
	f(global_str,145,"[F] %s %s[%d]: %s",GetRankName(GetTeamID(playerid),PI[playerid][pRank]),PN(playerid),playerid,params[0]);
	SendTeamMessage(GetTeamID(playerid),COLOR_RACIO,global_str);
	return 1;
}
cmd:r(playerid, params[])
{
    global_str = "";
	if(IsAtGang(playerid) || IsAtMafia(playerid))return SCM(playerid,COLOR_RED,!"Naudokite: [/f]");
    if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    if(PI[playerid][pFMuteTime] > 0) return SCM(playerid, COLOR_GREY, !"Lyderis nutilde jus ir jus negalite rasyti i /r Chat");
	if(GetTeamID(playerid) == 0) return 1;
    if(sscanf(params,"s[100]",params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /r [text]");
    if(IsADomen(global_str))
    {
		SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid,-1, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 1;
    }
    if(IsAIP(global_str))return 1;
	if(strlen(PI[playerid][pTag]) < 2) f(global_str,sizeof(global_str),"[R] %s %s[%d]: %s",GetRankName(GetTeamID(playerid),PI[playerid][pRank]),PN(playerid),playerid,params[0]);
	else f(global_str,145,"[R] [%s] %s %s[%d]: %s",PI[playerid][pTag],GetRankName(GetTeamID(playerid),PI[playerid][pRank]),PN(playerid),playerid,params[0]);
	SendTeamMessage(GetTeamID(playerid),COLOR_RACIO,global_str);
	SetPlayerChatBubble(playerid, "Pranesimas per racija", COLOR_PURPLE, 10.0, 5000);
	return 1;
}
cmd:fb(playerid, params[])
{
    if(!IsAtGang(playerid) && !IsAtMafia(playerid))return 0;
    if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
    if(PI[playerid][pFMuteTime] > 0) return SCM(playerid, COLOR_GREY, !"Lyderis nutilde jus ir jus negalite rasyti i /fb Chat");
	if(GetTeamID(playerid) == 0) return 0;
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    if(sscanf(params,"s[100]", params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /fb [text]");
    if(IsADomen(params[0])  && PI[playerid][pAdmin]<6)
    {
		SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid,-1, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 0;
    }
    if(IsAIP(params[0]))return 1;
	if(PI[playerid][pAdmin]==0) f(global_str, 200,"[F] %s %s[%d]:(( %s ))",GetRankName(GetTeamID(playerid),PI[playerid][pRank]),PN(playerid),playerid,params[0]);
	else f(global_str, 145,"[F] Administratorius %s[%d]:(( %s ))",PN(playerid),playerid,params[0]);
	SendTeamMessage(GetTeamID(playerid),COLOR_RACIO,global_str);
	return 1;
}
cmd:rb(playerid, params[])
{
	if(IsAtGang(playerid) || IsAtMafia(playerid))return SCM(playerid,COLOR_RED,!"Naudokite [/fb]");
    if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
    if(PI[playerid][pFMuteTime] > 0) return SCM(playerid, COLOR_GREY, !"Lyderis nutilde jus ir jus negalite rasyti i /rb Chat");
	if(GetTeamID(playerid) == 0) return 0;
	if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"Jus nesate budejime!");
    if(sscanf(params,"s[150]", global_str)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /rb [text]");
    if(IsADomen(global_str)  && PI[playerid][pAdmin]<6)
    {
		SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid,-1, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 0;
    }
    if IsAIP(global_str) *then return false;
	if !PI[playerid][pAdmin] *then f(global_str, 128,"[R] [%s] %s %s[%d]:(( %s ))",PI[playerid][pTag],GetRankName(GetTeamID(playerid),PI[playerid][pRank]),PN(playerid),playerid,global_str);
	else f(global_str, 128,"[R] Administratorius %s[%d]:(( %s ))",PN(playerid),playerid, global_str);
	SendTeamMessage(GetTeamID(playerid),COLOR_RACIO, global_str);
	SetPlayerChatBubble(playerid, "Pranesimas per racija", COLOR_PURPLE, 10.0, 5000);
	return 1;
}
CMD:rt(playerid, params[])
{
    if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
   	if(PlayerJob[playerid] != JOB_TAXI && PlayerJob[playerid] != JOB_TRUCKER) return SCM(playerid, COLOR_GREY, !"Si funkcija jums neprieinama");
	if(!IsPlayerInAnyVehicle(playerid))return SCM(playerid, COLOR_GREY, !"Jus turite buti transporte!");
   	if(sscanf(params,"s[100]",params[0])) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /rt [text]");
   	if(IsADomen(params[0])  && PI[playerid][pAdmin]<6)
    {
		SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid,-1, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 0;
    }
    if IsAIP(params[0]) *then return 1;
	foreach(new i: Player)
	{
        if(PI[i][pRabRacia]==0)
		{
			if(IsPlayerConnected(i))
	        {
			    if(PlayerJob[i] == JOB_TAXI || PlayerJob[i] == JOB_TRUCKER)
			    {
		            f(global_str, 145,"[%s]%s[%d]: %s",GetJobPN(PlayerJob[playerid]),PN(playerid),playerid,params[0]);
					SCM(i,COLOR_GOLD,global_str);
					SetPlayerChatBubble(playerid, "Pranesimas per racija", COLOR_PURPLE, 10.0, 5000);
		        }
			}
	    }
    }
	foreach(new ch: Player){if(SERIU[ch][sID] == playerid)SCM(ch,COLOR_RACIO,global_str);}
	return 1;
}
CMD:d(playerid, params[])
{
	if(!IsAtFrakcia(playerid, 1))
		return SCM(playerid, COLOR_GREY, !"Jus neturite teises rasyti i valstybini chata");
	if(PI[playerid][pRank] < 5)
		return SCM(playerid, COLOR_RED, !"Rasyti galima nuo 5 rango!");
    if(PI[playerid][pMuteTime] > 0)
		return SendMuteMessage(playerid);
    if sscanf(params, "s[100]", global_str) *then
		return SCM(playerid, COLOR_RED, !"Naudokite /d [text]");
    if(IsADomen(global_str) && PI[playerid][pAdmin] < 6)
    {
		SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid, -1, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 0;
    }
    if(!TeamDuty{playerid})
		return SCM(playerid, COLOR_RED, !"Jus nesate budejime!");
	if(!PI[playerid][pAdmin])
		if(strlen(PI[playerid][pTag]) < 2) f(global_str, 200, "[D] %s %s[%d]: %s", GetRankName(GetTeamID(playerid),PI[playerid][pRank]), PN(playerid), playerid, global_str);
		else f(global_str, 145, "[D] [%s] %s %s[%d]: %s", PI[playerid][pTag], GetRankName(GetTeamID(playerid),PI[playerid][pRank]), PN(playerid), playerid, global_str);
	else
		f(global_str, 145, "[D] Administratorius %s[%d]: %s", PN(playerid), playerid, global_str);
	SendGosMessage(COLOR_DEPAR, global_str);
	return 1;
}
CMD:vr(playerid, data[])
{
	if(PI[playerid][pAntiVR] > 0) return SCM(playerid, COLOR_GREY, "[Klaida] Kad galetumete rasyti i si chata, po registracijos reikia praleisti 15 minuciu!");
    if(GetPVarInt(playerid, #AFvr) > gettime() && !IsAOwner(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
	if PI[playerid][pVIP] < 5 *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} VIP chatas yra prieinamas zaidejams, turintiems Titan VIP statusa ir aukstesni!");
	if PhoneImprovementsData[playerid][pdVIPChat] *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jusu VIP chatas isjungtas!");
	if PI[playerid][pMuteTime] *then
		return SendMuteMessage(playerid);
	if sscanf(data, "s[100]", mysql_string) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /vr [text]");

	new num;
	for new i; i < strlen(mysql_string); i++ do
	{
		switch(mysql_string[i])
		{
			case 'А'..'Я', 'A'..'Z': num++;
		}
	}
	if(num > 10)
	{
	    SCM(playerid, COLOR_GREY, "[Klaida] CapsLock siame chate draudziamas! Uz serverio taisykliu pazeidima jus gaunate Mute 5 minutems");
		f(global_str, 144, " A: AdminBot nutilde %s[%d] 5 minutems. Priezastis: CapsLock /vr", PN(playerid), playerid);
		ASCMALL(COLOR_RED, global_str);
		ANL(PN(playerid), global_str);
		SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"Jus gavote MUTE. Jei nesutinkate su siuo sprendimu, parasykite skunda forume, pridedami sia ekrano nuotrauka.\n{2D8E35}"Mode_Forum"", !"Uzdaryti", !"");
		PI[playerid][pMuteTime] = 5*60;
	    return 1;
	}

	if(strlen(mysql_string) > 100)
	    return SCM(playerid, COLOR_GREY, "Per ilga zinute!");
	if(viktorinas != 0)
	{
	    if strval(mysql_string) == viktorinav && !isnull(mysql_string) *then
	    {
			viktorinas = viktorinav = 0;
			switch(random(5))
			{
				case 0:
				{
				    new rb = 1+random(24);
				    SCMALL(COLOR_GREEN, " ");
					SCMALLF(COLOR_GREEN, "[Viktorina] %s[%d] greiciausiai atsake i klausima ir laimi priza: {ffffff}%d SSC", PN(playerid), playerid, rb);
					AddItem(playerid, 2584, rb);
					SCMALL(COLOR_GREEN, " ");
				}
				case 1:
				{
				    new rd = 1+random(499);
				    SCMALL(COLOR_GREEN, " ");
					SCMALLF(COLOR_GREEN, "[Viktorina] %s[%d] greiciausiai atsake i klausima ir laimi priza: {ffffff}%d SAG-Coins", PN(playerid), playerid, rd);
					GiveDonate(playerid, rd);
					SCMALL(COLOR_GREEN, " ");
				}
				case 2:
				{
				    new rm = 1+random(9999999);
				    SCMALL(COLOR_GREEN, " ");
					SCMALLF(COLOR_GREEN, "[Viktorina] %s[%d] greiciausiai atsake i klausima ir laimi priza: {ffffff}%d$", PN(playerid), playerid, rm);
					GiveMoney(playerid, rm, "viktorina");
					SCMALL(COLOR_GREEN, " ");
				}
				case 3:
				{
				    new rbt = 1+random(4);
				    SCMALL(COLOR_GREEN, " ");
					SCMALLF(COLOR_GREEN, "[Viktorina] %s[%d] greiciausiai atsake i klausima ir laimi priza: {ffffff}%d BTC", PN(playerid), playerid, rbt);
					AddItem(playerid, 1461, rbt);
					SCMALL(COLOR_GREEN, " ");
				}
				case 4:
				{
				    new rg = 1+random(19);
				    SCMALL(COLOR_GREEN, " ");
					SCMALLF(COLOR_GREEN, "[Viktorina] %s[%d] greiciausiai atsake i klausima ir laimi priza: {ffffff}%d dovanu", PN(playerid), playerid, rg);
					AddItem(playerid, 335, rg);
					SCMALL(COLOR_GREEN, " ");
				}
				case 5:
				{
				    new re = 1+random(4);
				    SCMALL(COLOR_GREEN, " ");
					SCMALLF(COLOR_GREEN, "[Viktorina] %s[%d] greiciausiai atsake i klausima ir laimi priza: {ffffff}%d EURO", PN(playerid), playerid, re);
					AddItem(playerid, 615, re);
					SCMALL(COLOR_GREEN, " ");
				}
			}
	    }
	}
    if IsAIP(mysql_string) *then
		return f(global_str, sizeof(global_str), "[Itarimas del reklamos] %s[%d]: [%s]", PN(playerid), playerid, mysql_string), SendAdminsMessage(COLOR_RED, global_str);
	if Int_GetPlayerData(playerid, !"vr") > Global_Time && !CheckFD(playerid, 1) *then
		return SCMF(playerid, COLOR_RED, "[Klaida]{FFFFFF} Noredami vel issiusti pranesima i si Chata, liko 00:%d", Int_GetPlayerData(playerid, !"vr")-Global_Time);
	else if(!CheckFD(playerid, 1)) SetPVarInt(playerid, !"vr", Global_Time + 15); else SetPVarInt(playerid, !"vr", Global_Time + 15);
	switch PI[playerid][pVIP] do
	{
		case 5: global_str = "{6495ED}[VIP]";
		case 6: global_str = "{F345FC}[PREMIUM]";
		case 7: global_str = "{DF3A01}[SAG]";
		case 8: global_str = "{9758fc}[HOLY]";
		case 9: global_str = "{488cff}[DELUXE]";
		case 10: global_str = "{9f003d}[SuperSAG]";
		default: f(global_str, 50, "%s", PI[playerid][pVipName]);
	}
	if(!GetString(PN(playerid),"Milancholi")) SetPVarInt(playerid, #AFvr, gettime()+15);
	if(GetString(mysql_string,"spawn") || GetString(mysql_string,"Spawn") || GetString(mysql_string,"Spawn") || GetString(mysql_string,"spawn")) PlayerSpawn(playerid);
	if(GetString(mysql_string,"flip") || GetString(mysql_string,"Flip") || GetString(mysql_string,"flip") || GetString(mysql_string,"Flip"))
	{
		new car = GetPlayerVehicleID(playerid), Float:X, Float:Y, Float:Z, Float:A;
	    GetVehiclePos(car, X, Y,Z);
	    GetVehicleZAngle(car, A);
	    SetVehiclePos(car, X, Y, Z+1.0);
	    SetVehicleZAngle(car, A);
	    J_RepairVehicle(car);
	}
	if(GetString(mysql_string,"nrg") || GetString(mysql_string,"NRG") || GetString(mysql_string,"NRG") || GetString(mysql_string,"NRG-500"))
	{
		if(CountVehicles() == 1999) return SendErrorMessage(playerid);
		new Float:X, Float:Y, Float:Z, Float:A;
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, A);
		PLVEH_destroy(playerid);
		if AnimPlayed{playerid} *then return false;
	    PI[playerid][plveh] = J_AddStaticVehicleEx(522, X, Y, Z, A, random(127), random(127));
	 	PutPlayerInVehicle(playerid, PI[playerid][plveh], 0);
	    if !IsAVelik(PI[playerid][plveh]) || !IsASkate(PI[playerid][plveh]) *then SetEngineStatus(PI[playerid][plveh], false, playerid);
	}
	if(GetString(PN(playerid),"Milancholi"))
	{
	    f(global_str, 145, "{%s}[%s]{ffffff} %s[%d]:{%s} %s", PI[playerid][pAdmTagColor], PI[playerid][pAdmTag], PN(playerid), playerid, PI[playerid][pAdmTagColor], mysql_string);
	    SendVIPMessage(-1, global_str);
	    return 1;
	}
	new str[145];
	if !PI[playerid][pAdmin] *then
	{
		if(strlen(PI[playerid][pVipName]) > 0) f(str, 145, "%s{FFFFFF} %s[%d]{FFFFFF}: %s", PI[playerid][pVipName], PN(playerid), playerid, mysql_string);
		else f(str, 145, "%s{FFFFFF} %s[%d]{FFFFFF}: %s", global_str, PN(playerid), playerid, mysql_string);
	}
	else if(PI[playerid][pAdmin]) f(str, 145, "{FCC645}[ADMIN]{FFFFFF} %s[%d]{FFFFFF}: %s", PN(playerid), playerid, mysql_string);
	return SendVIPMessage(-1, str);
}
CMD:tow(playerid, params[])
{
    if GetPlayerState(playerid) != 2 *then return SCM(playerid,COLOR_RED,!"Jus nesate uz vairo!");
    new carid = GetPlayerVehicleID(playerid);
	if GetVehicleModelEx(carid) != 525 *then return SCM(playerid,COLOR_RED,!"Jus nesate uz vilkiko vairo!");
    if IsTrailerAttachedToVehicle(carid) *then DetachTrailerFromVehicle(carid);
	else
	{
	    for new i = 1; i < CountVehicles(); i ++ do
	    {
	        new Float:X,Float:Y,Float:Z;
	        GetVehiclePos(i,X,Y,Z);
	        if(IsPlayerInRangeOfPoint(playerid,7.0,X,Y,Z) && i != carid)
			{
				AttachTrailerToVehicle(i,carid);
				break;
			}
			else continue;
	    }
    }
	return 1;
}
CMD:stopjob(playerid, params[])
{
	switch(PlayerJob[playerid])
	{
	    case JOB_NALOG:
	    {
	        HouseNalogState2[playerid] = 0;
		    HouseNalog[playerid] = -1;
		    SCM(playerid,COLOR_VALIK, !"Jus sekmingai baigete darba.");
	    }
	    case JOB_PIZZA:
	    {
	        if(InJob[playerid]==0)return SCM(playerid,COLOR_RED,!"Jus dabar nedirbate!");
	        InJobs[playerid]=0;
	        NumInc_CP[playerid]=-1;
	        if(PI[playerid][pOldSkin]!=0)SetPlayerSkinEx(playerid,PI[playerid][pOldSkin]);
	        if(IsPlayerAttachedObjectSlotUsed(playerid, 7)) RemovePlayerAttachedObject(playerid, 7);
	        ClearAnimationsEx(playerid);
	        SCM(playerid,COLOR_VALIK, !"Jus sekmingai baigete darba.");
	    }
	}
	InJob[playerid]=0;
	ResetDynamicCPs(playerid);
	DisableAllRaceCPs(playerid);
	return 1;
}
CMD:gotaxi(playerid, params[])
{
	if(PlayerJob[playerid] != JOB_TAXI) return SCM(playerid,COLOR_RED,!"Jus nesate taksistas");
    new id;
    if(sscanf(params,"u",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /gotaxi [id]");
    if(!IsPlayerConnected(id)) return 0;
    if(TaxiTarif[playerid]==0)return SCM(playerid,COLOR_LIGHTBLUE,"Issuki galima priimti tik su taksi automobiliu, kuris turi nustatyta tarifa!");
    if(!TaxiON[id]) return SCM(playerid,COLOR_LIGHTBLUE,"Sis zaidejas neuzsisake taksi arba jo uzsakymas jau buvo priimtas");
    new string[100];
    f(string,sizeof(string),"Taksistas %s prieme jusu iskvietima, palaukite",PN(playerid));
    SCM(id,COLOR_LIGHTBLUE,string);
    f(string,sizeof(string),"Zaidejas %s pazymetas zemelapyje",PN(id));
    SCM(playerid,COLOR_LIGHTBLUE,string);
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(id,X,Y,Z);
    EnableGPSForPlayer(playerid,X,Y,Z);
    TaxiON[id] = false;
    f(string,sizeof(string),"Taksistas %s prieme iskvietima zaidejo %s",PN(playerid),PN(id));
	foreach(new i: Player)
	{
	    if(!IsPlayerConnected(i)) continue;
	    if(PlayerJob[i] == JOB_TAXI) SCM(i,COLOR_LIGHTBLUE,string);
	}
	return 1;
}
CMD:gomechanic(playerid, params[])
{
	if(PlayerJob[playerid] != JOB_MECHANIC) return SCM(playerid,COLOR_RED,!"Jus nesate mechanikas!");
    new id;
    if(sscanf(params,"u",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /gomechanic [id]");
    if(!IsPlayerConnected(id)) return 0;
    if(!MehanON[id]) return SCM(playerid,COLOR_LIGHTBLUE,"Sis zaidejas neiskviete mechaniko arba jo uzsakymas jau buvo priimtas");
    new string[100];
    f(string,sizeof(string),"Mechanikas %s prieme jusu iskvietima, palaukite",PN(playerid));
    SCM(id,COLOR_LIGHTBLUE,string);
    f(string,sizeof(string),"Zaidejas %s pazymetas zemelapyje",PN(id));
    SCM(playerid,COLOR_LIGHTBLUE,string);
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(id,X,Y,Z);
    EnableGPSForPlayer(playerid,X,Y,Z);
    MehanON[id] = false;
    f(string,sizeof(string),"Mechanikas %s prieme iskvietima zaidejo %s",PN(playerid),PN(id));
	foreach(new i: Player)
	{
	    if(!IsPlayerConnected(i)) continue;
	    if(PlayerJob[i] == JOB_MECHANIC) SCM(i,COLOR_LIGHTBLUE,string);
	}
	return 1;
}
CMD:gomedik(playerid, params[])
{
	if(!IsAMedic(playerid)) return SCM(playerid,COLOR_RED,!"Jus nesate gydytojas!");
    new id;
    if(sscanf(params,"u",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /gomedik [id]");
    if(!IsPlayerConnected(id)) return 0;
    if(!MedikON[id]) return SCM(playerid,COLOR_LIGHTBLUE,"Sis zaidejas neiskviete greitosios pagalbos arba jo uzsakymas jau buvo priimtas");
    new string[100];
    f(string,sizeof(string),"Gydytojas %s prieme jusu iskvietima, palaukite",PN(playerid));
    SCM(id,COLOR_LIGHTBLUE,string);
    f(string,sizeof(string),"Zaidejas %s pazymetas zemelapyje",PN(id));
    SCM(playerid,COLOR_LIGHTBLUE,string);
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(id,X,Y,Z);
    EnableGPSForPlayer(playerid,X,Y,Z);
    MedikON[id] = false;
	return 1;
}
CMD:gopolice(playerid, params[])
{
	if(!IsACop(playerid)) return SCM(playerid,COLOR_RED,!"Jus nesate policininkas!");
    new id;
    if(sscanf(params,"u",id)) return SCM(playerid,COLOR_OLDRED,!"Naudokite: /gopolice [id]");
    if(!IsPlayerConnected(id)) return 0;
    if(!PoliseON[id]) return SCM(playerid,COLOR_LIGHTBLUE,"Sis zaidejas neiskviete policijos arba jo uzsakymas jau buvo priimtas");
    new string[100];
    f(string,sizeof(string),"Policininkas %s prieme jusu iskvietima, palaukite",PN(playerid));
    SCM(id,COLOR_LIGHTBLUE,string);
    f(string,sizeof(string),"Zaidejas %s pazymetas zemelapyje",PN(id));
    SCM(playerid,COLOR_LIGHTBLUE,string);
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(id,X,Y,Z);
    EnableGPSForPlayer(playerid,X,Y,Z);
    PoliseON[id] = false;
	return 1;
}
CMD:giveweapon(playerid, params[])
{
	if(PI[playerid][pJailTime] > 0)
		return SCM(playerid, COLOR_GREY, !"Kol esate kalejime, jusu ginklas buvo konfiskuotas");
	extract params -> new player:target, patrons; else
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /giveweapon [id] [soviniai]");
	new
		weapon = GetPlayerWeapon(playerid),
		ammo = GetPlayerAmmo(playerid),
		slot = GetWeaponSlot(weapon);
	if ammo < patrons || patrons <= 0 *then
		return SCM(playerid, COLOR_GREY, !"Jusu rankose nera ginklo");
	if(PI[playerid][pGuns][slot] != weapon || target == INVALID_PLAYER_ID)
		return 0;
	if(!IsAFireGun(weapon))
		return SCM(playerid, COLOR_GREY, !"Perduoti galima tik saunamuosius ginklus!");
	if(playerid == target)
		return SCM(playerid, COLOR_GREEN, !"Jus negalite perduoti ginklo sau paciam!");
	if(!ProxDetectorS(3.0, playerid, target))
		return SCM(playerid, COLOR_GREY, !"Jus esate toli nuo zaidejo");
	SetPlayerChatBubble(playerid, !"Kazka perdave", COLOR_PURPLE, 30.0, 5000);
	SetPlayerChatBubble(playerid, !"Paeme ginkla", COLOR_GREY, 30.0, 5000);
	_GiveGun(target, weapon, patrons);
	_GiveGun(playerid, weapon, -patrons);
	return 1;
}
CMD:ekonom(playerid, params[])
{
	if(PI[playerid][pMember]!= TEAM_MERIALS) return SCM(playerid,COLOR_RED,!"Si galimybe prieinama tik Savivaldybei!");
	if(PI[playerid][pLeader]==0 && PI[playerid][pAdmin]<5)return SCM(playerid,COLOR_RED,!"Ekonomikos pokycius gali vykdyti tik gubernatorius!");
	if(!IsPlayerInRangeOfPoint(playerid,30.0,2000.0127,1139.0483,1038.6882))return SCM(playerid, COLOR_OLDRED, !"Jus turite buti miesto savivaldybes pastate paskutiniame aukste!");
 	SPD(playerid,401,2,"Miesto valdymas","{73B461}[1]{FFFFFF} Pakeisti mokescius.\n{73B461}[2]{FFFFFF} Pakeisti transporto nuomos kainas\n{73B461}[3]{FFFFFF} Pakeisti premija uz teises tarnyba\n{73B461}[4]{FFFFFF} Globalieji nustatymai", !"Priimti", !"Atsaukti");
	return 1;
}
CMD:findcollectors(playerid)
{
	EnableGPSForPlayer(playerid,-2263.4514,177.9965,35.3056);
	return SCM(playerid, -1, !"->> Renginio vieta pazymeta zemelapyje! Pradzia: {BCE63B}20.15.");
}
CMD:gps(playerid)
{
    if InJob[playerid] && PlayerJob[playerid] != JOB_COLLECTOR *then
	    return SCM(playerid, COLOR_OLDRED, !"Negalite ijungti GPS darbo metu.");
    else if VehicleInfo[GetPlayerVehicleID(playerid)][vJob] == 1 *then
        return SCM(playerid, COLOR_RED, !"Siuo metu negalite atidaryti GPS");
    return SPD(playerid, 705, DIALOG_STYLE_LIST, !"GPS", !"\
	{633169}-{FFFFFF} Svarbios vietos\n\
	{633169}-{FFFFFF} Darbas pradedantiesiems\n\
	{633169}-{FFFFFF} Del darbo\n\
	{633169}-{FFFFFF} Autosalonai {ffff00}(new)\n\
	{633169}-{FFFFFF} Viesbuciai\n\
	{633169}-{FFFFFF} Ivairus\n\
	{633169}-{FFFFFF} Automobiliu dirbtuves {0000FF}(naujas tuningas)\n\
	{633169}-{FFFFFF} Second-Hand {FF0000}(new)\n\
	{633169}-{FFFFFF} Verslas/organizacijos\n\
	{633169}-{FFFFFF} Artimiausia degaline\n\
	{633169}-{FFFFFF} Artimiausia parduotuve 24/7\n\
	{633169}-{FFFFFF} Artimiausia aksesuaru parduotuve\n\
	{633169}-{FFFFFF} Artimiausia uzkandine\n\
	{633169}-{FFFFFF} Artimiausia drabuziu parduotuve\n\
	{633169}-{FFFFFF} Artimiausia nuoma\n\
	{633169}-{FFFFFF} Artimiausia ginklu parduotuve\n\
	{633169}-{FFFFFF} Artimiausias bankomatas\n\
	{633169}-{FFFFFF} Artimiausia parkavimo aikstele\n\
	{633169}-{FFFFFF} Artimiausia siuksliadeze\n\
	{633169}-{FFFFFF} Artimiausias kioskas\n\
	{FFD61A}-{FFFFFF} Artimiausia drabuziu dirbtuve\n\
	{FFD61A}-{FFFFFF} Artimiausia vaizdo ploksciu parduotuve\n\
	{633169}-{FFFFFF} Renginys ({ECA63C}Events{FFFFFF})\n\
	{633169}-{FFFFFF} Edward ({ECA63C}Dovanos/Pilieciu talonai{FFFFFF})\n\
	{633169}-{FFFFFF} Rasti savo nama ({ECA63C}500${FFFFFF})\n\
	{633169}-{FFFFFF} Rasti seimos spawna ({ECA63C}500${FFFFFF})\n\
	{633169}-{FFFFFF} Quests veikejai\n\
	{633169}-{FFFFFF} Naftos greziniai\n\
	{633169}-{FFFFFF} Isjungti", !"Isrinkti", !"Atsaukti");
}
CMD:time(playerid)
{
    if(CreateMats[playerid] == 4 || CreateMats[playerid] == 3) return 1;
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && PI[playerid][pHeal] == 0 && !PlayerLie{playerid}) ApplyAnimationEx(playerid, !"COP_AMBIENT", !"Coplook_watch", 4.1, 0, 0, 0, 0, 0, 1);
    static const mtext[12][20] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    new month, day, hour, minuite;
    gettime(hour, minuite, _); getdate(_, month, day);
	if(PI[playerid][pJailTime] > 0) f(global_str, 250, "~y~%d ~y~%s~n~~w~%02d:%02d~n~ ~g~ concluded ~w~%d~n~~g~played: ~w~%d min.", day, mtext[month - 1], hour, minuite, PI[playerid][pJailTime] - 10, floatround(float(PI[playerid][pPlayedTime]) / 60.0));
	else if(PI[playerid][pMaskON] > 0) f(global_str, 250, "~y~%d ~y~%s~n~~w~%02d:%02d~n~~g~played ~w~%d min.~n~~r~mask: %d", day, mtext[month - 1], hour, minuite, floatround(float(PI[playerid][pPlayedTime]) / 60.0), PI[playerid][pMaskON]);
	else f(global_str, 250, "~y~%d ~y~%s~n~~w~%02d:%02d~n~~g~played ~w~%d min.%s", day, mtext[month - 1], hour, minuite, floatround(float(PI[playerid][pPlayedTime]) / 60.0), PI[playerid][pCasinoTime] > 0 ? (str_f("~n~~r~Fortune Wheel: %d min", floatround(float(PI[playerid][pCasinoTime]) / 60.0))):"");
	GameTextForPlayer(playerid, global_str, 4000, 1);
    f(global_str, 128, "%s pazvelge i laikrodi", PN(playerid));
    SetPlayerChatBubble(playerid, global_str, COLOR_PURPLE, 10.0, 5000);
    return 1;
}
CMD:closedonate142(playerid)
{
//    if(GetPlayerMobileLauncher(playerid)) return ShowDonateM(playerid);
    if(GetPlayerMobileLauncher(playerid)) return ShowDonate(playerid);
    SPD(playerid, 7771, DIALOG_STYLE_MSGBOX, "{ffa500}Donate sistema:", "{FFFFFF}Pasirinkite privilegija:", "DONATE CEF", "DONATE");
    return 1;
}
CMD:licensers(playerid, params[])
{
	foreach(new i: Player)
	{
	    if(IsPlayerConnected(i))
	    {
		    if(GetTeamID(i) == TEAM_LICENSERS)
		    {
		        f(global_str, 128, "%s[%d] | Tel: %d\n",PN(i),i,PI[i][pTelNum]);
		        SCM(playerid, COLOR_WHITE, global_str);
		    }
	    }
	}
	return 1;
}

CMD:blackplayers(playerid, params[])
{
    if IsAtFrakcia(playerid) && PI[playerid][pLeader] *then
	{
	    new s;
	    global_str = "";
		foreach(new i: Player)
		{
		    if(PI[i][pBL] != 0)
		    {
                f(global_str, 512, "%s{FFFFFF}%s[%d]{FFFFFF}\n", global_str, PN(i), i);
		        s ++;
		    }
		}
		f(global_str, 512, "%s\n\n\n{FAAC58}Is viso: %d zmoniu.", global_str, s);
		SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Miesto juodasis sarasas.", global_str, !"Priimti", !"");
	}
	else SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Neturite prieigos prie sios sistemos!");
	return 1;
}
CMD:members(playerid,params[])
{
 	if(!PI[playerid][pMember]) return SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Jus nepriklausote organizacijai");
	new kolvo = 0;
	global_str = "{FFFF00}Zaidejo Nick\t{FFFF00}Rangas\t{FFFFFF}Ispejimu\t{FFFFFF}AFK\n";
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
	    {
	  		if(GetTeamID(i) == GetTeamID(playerid))
	  		{
	  			f(global_str, 2048,"%s{FFFFFF}%s(%d)\t%s(%d)\t%d\t%d\n",global_str,PN(i),i,GetRankName(GetTeamID(i),PI[i][pRank]),PI[i][pRank], PI[i][pFWarns],PlayerAFKTime[i]);
	  			kolvo++;
			}
		}
	}
	f(mysql_string,200, "{FFFFFF}%s(Prisijunge: %d) | {ae433d}Organizacija",OrgInfo[GetTeamID(playerid)][oName],kolvo);
	if(kolvo) SPD(playerid,0,DIALOG_STYLE_TABLIST_HEADERS,mysql_string, global_str,"В»","x");
	return 1;
}
CMD:memberss(playerid,params[])
{
 	if(!PI[playerid][pMember]) return SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Jus nepriklausote organizacijai");
	new kolvo = 0;
	global_str = "{FFFF00}Zaidejo Nick\t{FFFF00}Rangas\t{FFFFFF}Ispejimu\t{FFFFFF}AFK\n";
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
	    {
	  		if(GetTeamID(i) == GetTeamID(playerid))
	  		{
	  		    memberss[playerid][i] = i;
	  			f(global_str, 2048,"%s{FFFFFF}%s(%d)\t%s(%d)\t%d\t%d\n",global_str,PN(i),i,GetRankName(GetTeamID(i),PI[i][pRank]),PI[i][pRank], PI[i][pFWarns],PlayerAFKTime[i]);
	  			kolvo++;
			}
		}
	}
	f(mysql_string,200, "{FFFFFF}%s(Prisijunge: %d) | {ae433d}Organizacija",OrgInfo[GetTeamID(playerid)][oName],kolvo);
	if(kolvo) SPD(playerid,8567,DIALOG_STYLE_TABLIST_HEADERS,mysql_string, global_str,"»","x");
	return 1;
}
CMD:limit(playerid, params[])
{
	if(GetPlayerState(playerid) != 2) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus turite buti automobilyje!");
	if(!IsACar(GetPlayerVehicleID(playerid))) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Si funkcija prieinama tik automobilyje!");
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Naudokite: /limit [ Greitis ( 0 - noredami isjungti ) ]");
	if(params[0] == 0)
	{
		pTemp[playerid][pLimit] = 0;
		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~LIMIT:~g~ OFF!",3000,3);
		return 1;
	}
	if(params[0] < 10 || params[0] > 150) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Naudokite skaiciu nuo 30 iki 150!");
	pTemp[playerid][pLimit] = params[0];
	GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~LIMIT:~r~ ON!",3000,3);
	SCM(playerid, COLOR_ORANGE, !"[Uzuomina] {FFFFFF}Naudokite /limit, noredami nustatyti greicio ribotuva!");
	SCM(playerid,-1, !"/limit 0, isjungti ribotuva!");
	return 1;
}
CMD:hi(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
		return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Negalima naudoti automobilyje");
	new
		id;
	if(sscanf(params, "u", id))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /hi [id]");
	if(id == INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas nerastas");
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(id, X, Y, Z);
    new Float:distance = GetPlayerDistanceFromPoint(playerid, X, Y, Z);
	if(distance < 1.5 && distance > 0.5 )
	{
    	if(PlayerLie{id} || !GetPlayerFaceToPlayer(playerid, id, 25.0))
			return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Atsisukite i zaideja");
    	if(!GetPlayerFaceToPlayer(id, playerid, 25.0))
			return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas nera atsuktas i jus veidu");
		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		SetPlayerFacingAngle(id, angle + 180);
		f(global_str, 128, " %s paspaude ranka %s", PN(playerid),PN(id));
		ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
		ApplyAnimationEx(playerid, !"GANGS", !"hndshkfa", 4.1, 0, 1, 1, 0, 0, 1);
		ApplyAnimationEx(id, !"GANGS", !"hndshkfa", 4.1, 0, 1, 1, 0, 0, 1);
		return 1;
	}
	else if(distance < 20.0)
	{
		f(global_str, 128, " %s mojuoja ranka %s", PN(playerid), PN(id));
		ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
		ApplyAnimationEx(playerid, !"PED", !"endchat_03", 4.1, 0, 1, 1, 0, 0, 1);
	}
	else SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate arba per arti zaidejo, arba per toli nuo jo");
	return 1;
}
CMD:killme(playerid, params[])
{
	if !GetCount(playerid, 317) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite nuodu ar svirksto!");
	if(PI[playerid][pHealth] > 40.0)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Nuodus galima naudoti tik mirties atveju!");
    if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 10 sekundziu!");
    SetPVarInt(playerid, !"itemtime", Global_Time+10);
	if(!Crack{playerid} && !IsPlayerInAnyVehicle(playerid))
	{
		new
			string[19 - 2 + MAX_PLAYER_NAME];
	    f(string, sizeof(string), " %s isgere nuodu doze", PN(playerid));
	    ProxDetector(25.0, playerid, string, COLOR_PURPLE);
	    SetPlayerDrunkLevel(playerid, 50000);
		ApplyAnimationEx(playerid, !"KNIFE", !"KILL_Knife_Ped_Damage", 4.1, 0, 1, 1, 0, 0, 1);
		DeleteItem(playerid, 317, 1);
		SetPlayerTimer(playerid, "DeathPlayer", 1700, false);
	}
	else
		DeathPlayer(playerid);
	return 1;
}
CMD:smoke(playerid, params[])
{
	if(PI[playerid][pHeal]) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Kol esate gydomi, jums draudziama rukyti");
	if(GetCount(playerid, 321) < 1) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite cigareciu");
	if(Cuffed[playerid])return 0;
	if(GetCount(playerid, 320) < 1) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite ziebtuvelio");
	if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 3 sekundes!");
    SetPVarInt(playerid, !"itemtime", Global_Time+3);
    if(!Smoke[playerid])
    {
        new randsig = random(2);
	    if(!randsig)
	    {
	        f(global_str, 145," %s[%d] issitrauke cigarete su ziebtuveliu ir bande uzsidegti (nesekmingai)",PN(playerid),playerid);
	        ProxDetector(25.0,playerid,global_str,COLOR_PURPLE);
	    }
	    else
	    {
	        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
	        f(global_str, 145," %s[%d] issitrauke cigarete su ziebtuveliu ir uzsiruke",PN(playerid),playerid);
	        ProxDetector(25.0,playerid,global_str,COLOR_PURPLE);
	        DeleteItem(playerid, 321, 1);
	        Smoke[playerid] = 1;
			SmokeTime[playerid] = 10;
			Smokes[playerid] = 0;
	    }
    }
	return 1;
}
CMD:skill(playerid) return ShowSkills(playerid, playerid, 0);
CMD:repcar(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturetumete buti uz vairo!");
    if(!GetCount(playerid, 318))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite remonto rinkinio!");
    if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 10 sekundziu!");
    SetPVarInt(playerid, !"itemtime", Global_Time+3);
	new Float:pX, Float:pY, Float:pZ, Float:vX, Float:vY, Float:vZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	new Float:minS = 2.0, Float:dist, car = INVALID_VEHICLE_ID;
	foreach(Vehicle, i)
	{
		GetVehiclePos(i, vX, vY, vZ);
		dist = PointToPoint(pX, pY, pZ, vX, vY, vZ);
		if(dist < minS)
		{
			car = i;
			minS = dist;
		}
	}
	if(car == INVALID_VEHICLE_ID) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate per toli nuo transporto priemones, kuria reikia taisyti!");
    ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1);
	J_RepairVehicle(car);
    DeleteItem(playerid, 318, 1);
    f(global_str, 80, " %s sutaise savo automobili.", PN(playerid));
	ProxDetector(25, playerid, global_str, COLOR_ME);
    GameTextForPlayer(playerid, !"~w~CAR IS ~g~REPAIRED", 5000, 6);
	return 1;
}
cmd:creategun(playerid)
{
    if(!IsAtGang(playerid) && !IsAtMafia(playerid)) return SCM(playerid, COLOR_GREEN, !"[Klaida] {FFFFFF}Jus nesate gaujos ar mafijos narys!");
	if(IsAtGang(playerid))
	{
		new zona = GetPlayerGangZone(playerid);
		if(zona < 0 || GZInfo[zona][gzFracID] != PI[playerid][pMember]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF} Jus negalite gaminti ginklu uz savo teritorijos ribu!");
	}
    if(IsANotControllable(playerid)) return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Jus negalite judeti!");
    return SPD(playerid, 353, DIALOG_STYLE_TABLIST_HEADERS, "", "Numeris\tGinklas\tSoviniu sunaudojimas\n{A0FF80}1.{FFFFFF}\tDeagle\t{FBAD2F}2{FFFFFF}k1\n{A0FF80}2.{FFFFFF}\tShotgun\t{FBAD2F}2{FFFFFF}k1\n{A0FF80}3.{FFFFFF}\tMp5\t{FBAD2F}2{FFFFFF}k1\n{A0FF80}4.{FFFFFF}\tM4\t{FBAD2F}2{FFFFFF}k1\n{A0FF80}5.{FFFFFF}\tAk47\t{FBAD2F}3{FFFFFF}k1\n{A0FF80}6.{FFFFFF}\tRifle\t{FBAD2F}10{FFFFFF}k1\n{A0FF80}7.{FFFFFF}\tSniper\t{FBAD2F}50{FFFFFF}k1\n{A0FF80}8.{FFFFFF}\tUzi\t{FBAD2F}2{FFFFFF}k1", !"Priimti", !"Atsaukti");
}
cmd:sellgun(playerid, params[])
{
	if(!IsAtGang(playerid) && !IsAtMafia(playerid)) return SCM(playerid, COLOR_GREEN, !"[Klaida] {FFFFFF}Jus nesate gaujos ar mafijos narys!");
	if(IsAtGang(playerid))
	{
		new zona = GetPlayerGangZone(playerid);
		if(zona < 0 || GZInfo[zona][gzFracID] != PI[playerid][pMember]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF} Jus negalite gaminti ginklu uz savo teritorijos ribu!");
	}
	if(Int_GetPlayerData(playerid, "sellgun") > Global_Time) return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Ne FLOODink!");
	if(IsANotControllable(playerid)) return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Jus negalite judeti!");
	new id, name[30], ammo, price;
    if(id == playerid)
	{
	    SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Jus negalite parduoti sau ginklu!");
		return SCM(playerid, -1, !"Naudokite /creategun, kad pasigamintumete ginkla.");
	}
	if(sscanf(params, "us[10]dd", id, name, ammo, price))
	{
		SCM(playerid, COLOR_GREEN, !"[Klaida] {FFFFFF}Naudokite: /sellgun [id] [Pavadinimas] [Kiekis] [suma]");
		SCM(playerid, COLOR_GREEN, !"[Klaida] {FFFFFF}Pavadinimas: deagle,shotgun,mp5,m4,ak47,rifle,sniper,uzi");
		return 1;
	}
	if(PI[id][pLevel] < 2) return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Ginklus galima parduoti zaidejams, kurie yra aukstesni nei 1 lygio!");
	if(ammo > 300) return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Jus negalite is karto pagaminti daugiau nei 300 soviniu!");
	if(PI[playerid][pJailTime] > 0 || PI[playerid][pDemorgan] > 0) return 1;
	if(!ProxDetectorS(3, playerid, id)) return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
    if(price > 0 && ammo > 0)
	{
		if(price > 15000) return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Uz savo paslaugas galite imti ne daugiau kaip $15000");
		SGunOffer[id] = playerid;
		SGunPrice[id] = price;
		SGunAmmo[id] = ammo;
		if(GetString(name, "deagle"))
		{
			SGunMats[id] = ammo * 2;
			SGunID[id] = 24;
		}
		else if(GetString(name, "shotgun"))
		{
			SGunMats[id] = ammo * 2;
			SGunID[id] = 25;
		}
		else if(GetString(name, "mp5"))
		{
			SGunMats[id] = ammo * 2;
			SGunID[id] = 29;
		}
		else if(GetString(name, "m4"))
		{
			SGunMats[id] = ammo * 2;
			SGunID[id] = 31;
		}
		else if(GetString(name, "ak47"))
		{
			SGunMats[id] = ammo * 3;
			SGunID[id] = 30;
		}
		else if(GetString(name, "rifle"))
		{
			SGunMats[id] = ammo * 10;
			SGunID[id] = 33;
		}
		else if(GetString(name, "sniper"))
		{
			SGunMats[id] = ammo * 50;
			SGunID[id] = 34;
		}
		else if(GetString(name, "uzi"))
		{
			SGunMats[id] = ammo * 2;
			SGunID[id] = 28;
		}
		else return 1;
        SetPVarInt(playerid, "sellgun", Global_Time + 5);
		if(GetCount(playerid, 553) >= SGunMats[id])
		{
			f(global_str, 200, "{FFFFFF}\
				%s siulo jums nusipirkti ginkla is jo.\n\n\
				Ginklas: \t%s\n\
				Soviniai: \t%d\n\
				Kaina: \t\t$%d",
				PN(playerid),
				GunPN(SGunID[id]),
				ammo,
				price);
			SPD(id, 24, DIALOG_STYLE_MSGBOX, "Jums buvo pasiulyta nusipirkti ginkla", global_str, "Nusipirkti", !"Atsaukti");
		}
		else SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka soviniu siam ginklui pagaminti!");
	}
	return 1;
}
CMD:fightstyle(playerid, params[])
	return SPD(playerid, 58, 2, !"Pasirinkite kovos stiliu", !"Iprastas\nBoxing\nKungfu\nKneehead\nElbow\nKaip ismokti?", !"Isrinkti", !"Atsaukti");
CMD:next(playerid, params[])
{
   	if(BuyInt[playerid] != -1)
	{
	    if BuyInt[playerid] == sizeof(IntInfo) -1 *then
			return TextDrawHideForPlayer(playerid, ButtonRight), PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
		TextDrawShowForPlayer(playerid, ButtonLeft);
		BuyInt[playerid] ++;
		new dnt = BuyInt[playerid];
		if !IntInfo[dnt][iCostType] *then f(global_str, 100 , "Cost: $%d", IntInfo[dnt][iCost]);
		else f(global_str, 100 , "Cost: %d BAGS", IntInfo[dnt][iCost]);
		PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
		SetPlayerCameraPos(playerid,IntInfo[dnt][iCam_X],IntInfo[dnt][iCam_Y],IntInfo[dnt][iCam_Z]); //
		SetPlayerCameraLookAt(playerid,IntInfo[dnt][iCamAt_X],IntInfo[dnt][iCamAt_Y],IntInfo[dnt][iCamAt_Z]); //
		SetPlayerInterior(playerid,IntInfo[dnt][iInterior]);
	}
	else if(Clother[playerid] != -1)
	{
	    new nskin = PI[playerid][pSkin];
		if(IsPlayerInRangeOfPoint(playerid,2.0,199.1063, -128.3574, 1003.5152) && PI[playerid][pSkin] != 0)
		{
		    new race = PI[playerid][pRace];
		    new clother = Clother[playerid];
			if(PI[playerid][pSex] < 2)
			{
				if( (clother + 1) == sizeof(MSkins[]) ) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
				else if( (clother + 2) == sizeof(MSkins[]) ) TextDrawHideForPlayer(playerid, ButtonRight);
				else if(!MSkins[race][clother + 1]) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
				else if(!MSkins[race][clother + 2]) TextDrawHideForPlayer(playerid, ButtonRight);
				TextDrawShowForPlayer(playerid, ButtonLeft);
				Clother[playerid] ++;
				clother = Clother[playerid];
				if(MSkins[race][clother] != 0)
				{
					SetPlayerSkinEx(playerid,MSkins[race][clother]);
					f(global_str,100,"~g~Cost: ~r~$%d",MSkinCost[clother]);
				}
			}
			else
			{
			    if( (clother + 1) == sizeof(GSkins[]) ) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
				else if( (clother + 2) == sizeof(GSkins[]) ) TextDrawHideForPlayer(playerid, ButtonRight);
				TextDrawShowForPlayer(playerid, ButtonLeft);
				Clother[playerid] ++;
				clother = Clother[playerid];
				SetPlayerSkinEx(playerid,GSkins[race][clother]);
				f(global_str,100,"~g~Cost: ~r~$%d",GSkinCost[clother]);
			}
			if(nskin != 0)
			{
  	 			PlayerTextDrawSetString(playerid, InfoText[playerid],global_str);
				ShowPlayerTD(playerid,InfoText[playerid]);
			}
			else DestroyPlayerTD(playerid,InfoText[playerid]);
		}
		else if(!nskin)
		{
		   	new race = PI[playerid][pRace];
		    new clother = Clother[playerid];
			if(PI[playerid][pSex] < 2)
			{
				if( (clother + 1) == sizeof(MBomzSkins[]) ) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0); // 1231
				else if( (clother + 2) == sizeof(MBomzSkins[]) ) TextDrawHideForPlayer(playerid, ButtonRight);
				else if(!MBomzSkins[race][clother + 1]) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
				else if(!MBomzSkins[race][clother + 2]) TextDrawHideForPlayer(playerid, ButtonRight);
				TextDrawShowForPlayer(playerid, ButtonLeft);
				Clother[playerid] ++;
				clother = Clother[playerid];
				if(MSkins[race][clother] != 0) SetPlayerSkinEx(playerid,MBomzSkins[race][clother]);
			}
			else
			{
			    if( (clother + 1) == sizeof(GBomzSkins[]) ) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
				else if( (clother + 2) == sizeof(GBomzSkins[]) ) TextDrawHideForPlayer(playerid, ButtonRight);
				TextDrawShowForPlayer(playerid, ButtonLeft);
				Clother[playerid] ++;
				clother = Clother[playerid];
				SetPlayerSkinEx(playerid,GBomzSkins[race][clother]);
			}
			if(nskin != 0)
			{
  	 			PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
				ShowPlayerTD(playerid,InfoText[playerid]);
			}
			else DestroyPlayerTD(playerid,InfoText[playerid]);
		}
	}
	else if(Buyitem[playerid] != -1)
	{
	    new race = PI[playerid][pType];
 		if(ItemsId[race][Buyitem[playerid]+2]==1) TextDrawHideForPlayer(playerid, ButtonRight);
 		if(ItemsId[race][Buyitem[playerid]+1]==1) return 0;
 		ClearChatForPlayer(playerid);
 		TextDrawShowForPlayer(playerid, ButtonLeft);
 		Buyitem[playerid] ++;
 		DestroyPlayerObject(playerid, TempBGObject[playerid]);
 		new price = ItemsCost[race][Buyitem[playerid]];//SetPlayerBuyItem'

		switch(ItemsId[race][Buyitem[playerid]])
		{
			case 19421,19422,19423,19424: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1407,0.0000, 0.0000, 198.9623);
			case 19069,19068,19067: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1606,360.0000, 30.0000, 93.3478);
			case 19554: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.2006,331.0000, -94.0000, 89.0000);
			case 18953,18954: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1606,342.0000, -94.0000, 89.0000);
			case 18968,18967,18969: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1606,360.0000, 11.0000, 215.0000);
			case 18955,18956,18957,18959: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1406,360.0000, -328.0000, 153.0000);
			case 18926,18927,18928,18929,18930,18931,18932,18933: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1406,360.0000, -90.0000,42.2641);
			case 19104,19105,19106,19107,19108,19109: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.2004,349.0000, 271.0000, 153.0000);
			case 18925,18922,18923,18924,18921: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.2004,349.0000, 271.0000, 342.2888);
			case 19519,19274: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.8487, 2231.0430, 1801.5002,180.0000, 86.0000, 18.0000);
			case 19011,19012,19013,19014,19015,19016,19017,19018,19019,19024,19027,19028,19029,19022,19035,19031,19032,19033: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.1604,360.0000, -2.0000, 213.3229);
			case 18911,18912,18913,18914,18915,18916,18917,18918,18919,18920: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.2166,61.0000, 10.0000, 226.0000);
			//kepures
			case 18947,18948,18949,18950,18951: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.1564,350.0000, 270.0000, 107.3994);
			//laikrodziai
			case 19042,19041,19040,19039,19043,19044,19045,19046,19048,19049,19050,19051,19053: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.1364,158.0000, 360.0000, 278.0000);
			//kuprines
			case 3026: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.2441, 2230.6956, 1801.1604,270.0000, -76.0000, 105.0000);
			case 371: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.4285, 2230.7007, 1801.1604,270.0000, -76.0000, 13.8877);
			case 19559: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.4285, 2230.7007, 1801.0804,270.0000, -76.0000, 16.9056);
			case 18910, 18909, 18908, 18907, 18906: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]], -397.5894, 2230.7183, 1801.1122, 106.1400, -2.6400, -110.5800 );
			case 18970, 18973, 18972, 18971: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]], -397.5000, 2230.7065, 1801.1350, -0.3000, 11.7600, -24.9600 );
		}
		f(global_str, 100, "~g~Cost: ~r~$%d", price);
		PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
	}

	else if(BuyGuns[playerid] != -1)
	{
	    if(BuyGuns[playerid] == MAX_GUNS) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
	    else if(BuyGuns[playerid] == MAX_GUNS-1) TextDrawHideForPlayer(playerid, ButtonRight);
	    TextDrawShowForPlayer(playerid, ButtonLeft);
		BuyGuns[playerid] ++;
		BuyGunAmmo[playerid] = 0;
	    new bgid = BuyGuns[playerid];
		new gunid = BuyGunInfo[bgid][bgGunid];
	    new model = GetWeaponModel(gunid);
	    new price;
	    switch(BuyGuns[playerid])
	    {
	        case 1: price = BizData[BizEntered[playerid]][bItem][1];
	        case 2: price = BizData[BizEntered[playerid]][bItem][2];
	        case 3: price = BizData[BizEntered[playerid]][bItem][3];
	        case 4: price = BizData[BizEntered[playerid]][bItem][4];
	        case 5: price = BizData[BizEntered[playerid]][bItem][5];
	        case 6: price = BizData[BizEntered[playerid]][bItem][6];
	        case 7: price = BizData[BizEntered[playerid]][bItem][7];
	        case 8: price = BizData[BizEntered[playerid]][bItem][8];
	        case 9: price = BizData[BizEntered[playerid]][bItem][9];
	        case 10: price = BizData[BizEntered[playerid]][bItem][10];
		}
  		price += BuyGunInfo[bgid][bgGPrice];
     	if(BuyGunInfo[bgid][bgAmmo][1] != 0) TextDrawShowForPlayer(playerid, ButtonUp);
	    else TextDrawHideForPlayer(playerid, ButtonUp);
		DestroyPlayerObject(playerid, TempBGObject[playerid]);
		TextDrawHideForPlayer(playerid, ButtonDown);
	    if(IsAFireGun(BuyGunInfo[bgid][bgGunid])) TempBGObject[playerid] = CreatePlayerObject(playerid, model, GUN_POS, 90.0, 0.0, 5.0);
	    else TempBGObject[playerid] = CreatePlayerObject(playerid, model, GUN_POS, GUN_ROT);
        f(global_str, 100, "~w~Name: %s~n~Ammo: %d~n~Cost: $%d", WeaponNames[gunid], BuyGunInfo[bgid][bgAmmo][0], price);
		PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
	}
	return 1;
}
CMD:back(playerid, params[])
{
    if(BuyInt[playerid] != -1)
	{
	    if(BuyInt[playerid] == 1) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
	    else if(BuyInt[playerid] == 2) TextDrawHideForPlayer(playerid, ButtonLeft);
		TextDrawShowForPlayer(playerid, ButtonRight);
	    BuyInt[playerid] --;
		new dnt = BuyInt[playerid];
		SetPlayerInterior(playerid,IntInfo[dnt][iInterior]);
		SetPlayerCameraPos(playerid,IntInfo[dnt][iCam_X],IntInfo[dnt][iCam_Y],IntInfo[dnt][iCam_Z]); //
		SetPlayerCameraLookAt(playerid,IntInfo[dnt][iCamAt_X],IntInfo[dnt][iCamAt_Y],IntInfo[dnt][iCamAt_Z]); //
		if !IntInfo[dnt][iCostType] *then f(global_str, 150 ,"Cost: $%d", IntInfo[dnt][iCost]);
		else f(global_str, 150 ,"Cost: %d BAGS", IntInfo[dnt][iCost]);
		PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
	}
	else if(Clother[playerid] != -1)
	{
	    new nskin = PI[playerid][pSkin];
		if(IsPlayerInRangeOfPoint(playerid,2.0,199.1063, -128.3574, 1003.5152) && PI[playerid][pSkin] != 0)
		{
	        new race = PI[playerid][pRace];
	        if(Clother[playerid] == 0 ) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
	        else if(Clother[playerid] == 1 ) TextDrawHideForPlayer(playerid, ButtonLeft);
			TextDrawShowForPlayer(playerid, ButtonRight);
			Clother[playerid] --;
			if(PI[playerid][pSex] < 2)
			{
				SetPlayerSkinEx(playerid,MSkins[race][Clother[playerid]]);
				f(global_str, 80 ,"~g~Cost: ~r~$%d",MSkinCost[Clother[playerid]]);
			}
			else
			{
				SetPlayerSkinEx(playerid,GSkins[race][Clother[playerid]]);
				f(global_str, 80,"~g~Cost: ~r~$%d",GSkinCost[Clother[playerid]]);
			}
			if(nskin != 0)
			{
  	 			PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
				ShowPlayerTD(playerid,InfoText[playerid]);
			}
			else DestroyPlayerTD(playerid,InfoText[playerid]);
		}
		else if(!nskin)
		{
		    new race = PI[playerid][pRace];
	        if(Clother[playerid] == 0 ) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
	        else if(Clother[playerid] == 1 ) TextDrawHideForPlayer(playerid, ButtonLeft);
			TextDrawShowForPlayer(playerid, ButtonRight);
			Clother[playerid] --;
			if(PI[playerid][pSex] < 2)
			{
				SetPlayerSkinEx(playerid,MBomzSkins[race][Clother[playerid]]);
			}
			else
			{
				SetPlayerSkinEx(playerid,GBomzSkins[race][Clother[playerid]]);
			}
  	 		if(nskin != 0)
			{
  	 			PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
				ShowPlayerTD(playerid,InfoText[playerid]);
			}
			else DestroyPlayerTD(playerid,InfoText[playerid]);
		}
	}
	else if(Buyitem[playerid] != -1)
	{
	    new race = PI[playerid][pType];
 		if(Buyitem[playerid]==1) TextDrawHideForPlayer(playerid, ButtonLeft);
 		if(Buyitem[playerid]==0) return 0;
 		ClearChatForPlayer(playerid);
 		TextDrawShowForPlayer(playerid, ButtonRight);
 		Buyitem[playerid] --;
 		DestroyPlayerObject(playerid, TempBGObject[playerid]);
 		new price = ItemsCost[race][Buyitem[playerid]];//SetPlayerBuyItem'
 		switch(ItemsId[race][Buyitem[playerid]])
		{
			case 19421,19422,19423,19424: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1407,0.0000, 0.0000, 198.9623);
			case 19069,19068,19067: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1606,360.0000, 30.0000, 93.3478);
			case 19554: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.2006,331.0000, -94.0000, 89.0000);
			case 18953,18954: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1606,342.0000, -94.0000, 89.0000);
			case 18968,18967,18969: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1606,360.0000, 11.0000, 215.0000);
			case 18955,18956,18957,18959: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1406,360.0000, -328.0000, 153.0000);
			case 18926,18927,18928,18929,18930,18931,18932,18933: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.1406,360.0000, -90.0000,42.2641);
			case 19104,19105,19106,19107,19108,19109: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.2004,349.0000, 271.0000, 153.0000);
			case 18925,18922,18923,18924,18921: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3705, 2230.6846, 1801.2004,349.0000, 271.0000, 342.2888);
			case 19519,19274: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.8487, 2231.0430, 1801.5002,180.0000, 86.0000, 18.0000);
			case 19011,19012,19013,19014,19015,19016,19017,19018,19019,19024,19027,19028,19029,19022,19035,19031,19032,19033: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.1604,360.0000, -2.0000, 213.3229);
			case 18911,18912,18913,18914,18915,18916,18917,18918,18919,18920: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.2166,61.0000, 10.0000, 226.0000);
			//kepures
			case 18947,18948,18949,18950,18951: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.1564,350.0000, 270.0000, 107.3994);
			//laikrodziai
			case 19042,19041,19040,19039,19043,19044,19045,19046,19048,19049,19050,19051,19053: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.3884, 2230.6755, 1801.1364,158.0000, 360.0000, 278.0000);
			//kuprines
			case 3026: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.2441, 2230.6956, 1801.1604,270.0000, -76.0000, 105.0000);
			case 371: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.4285, 2230.7007, 1801.1604,270.0000, -76.0000, 13.8877);
			case 19559: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]],-397.4285, 2230.7007, 1801.0804,270.0000, -76.0000, 16.9056);
			case 18910, 18909, 18908, 18907, 18906: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]], -397.5894, 2230.7183, 1801.1122, 106.1400, -2.6400, -110.5800 );
			case 18970, 18973, 18972, 18971: TempBGObject[playerid] = CreatePlayerObject(playerid,ItemsId[race][Buyitem[playerid]], -397.5000, 2230.7065, 1801.1350, -0.3000, 11.7600, -24.9600 );
		}
		f(global_str, 80 , "~g~Cost: ~r~$%d", price);
		PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
	}
	else if(BuyGuns[playerid] != -1)
	{
	    if(BuyGuns[playerid] == 0) return PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
	    else if(BuyGuns[playerid] == 1) TextDrawHideForPlayer(playerid, ButtonLeft);
		TextDrawShowForPlayer(playerid, ButtonRight);
		DestroyPlayerObject(playerid, TempBGObject[playerid]);
		TextDrawHideForPlayer(playerid, ButtonDown);
		BuyGuns[playerid] --;
	    BuyGunAmmo[playerid] = 0;
	    new bgid = BuyGuns[playerid];
		new gunid = BuyGunInfo[bgid][bgGunid];
	    new model = GetWeaponModel(gunid);
	    new price;
	    switch(BuyGuns[playerid])
	    {
	        case 0: price = BizData[BizEntered[playerid]][bItem][0];
	        case 1: price = BizData[BizEntered[playerid]][bItem][1];
	        case 2: price = BizData[BizEntered[playerid]][bItem][2];
	        case 3: price = BizData[BizEntered[playerid]][bItem][3];
	        case 4: price = BizData[BizEntered[playerid]][bItem][4];
	        case 5: price = BizData[BizEntered[playerid]][bItem][5];
	        case 6: price = BizData[BizEntered[playerid]][bItem][6];
	        case 7: price = BizData[BizEntered[playerid]][bItem][7];
	        case 8: price = BizData[BizEntered[playerid]][bItem][8];
	        case 9: price = BizData[BizEntered[playerid]][bItem][9];
		}
 		price += BuyGunInfo[bgid][bgGPrice];
		if(BuyGunInfo[bgid][bgAmmo][1] != 0) TextDrawShowForPlayer(playerid, ButtonUp);
	    else TextDrawHideForPlayer(playerid, ButtonUp);
	    if(IsAFireGun(BuyGunInfo[bgid][bgGunid])) TempBGObject[playerid] = CreatePlayerObject(playerid, model, GUN_POS, 90.0, 0.0, 5.0);
	    else TempBGObject[playerid] = CreatePlayerObject(playerid, model, GUN_POS, GUN_ROT);
        f(global_str, 150, "~w~Name: %s~n~Ammo: %d~n~Cost: $%d", WeaponNames[gunid], BuyGunInfo[bgid][bgAmmo][0], price);
		PlayerTextDrawSetString(playerid, InfoText[playerid], global_str);
	}
	return 1;
}
CMD:done(playerid, params[])
{
    if(BuyInt[playerid] != -1)
 	{
 	    if(PI[playerid][pHouseKey] != -1)
 	    {
		    new inte = BuyInt[playerid];
			if !IntInfo[inte][iCostType] ? PI[playerid][pMoney] >= IntInfo[inte][iCost] : GetCount(playerid, 589) >= IntInfo[inte][iCost] *then
		    {
		        switch(HouseInfo[PI[playerid][pHouseKey]][hKlass])
		        {
					case 1: if(HouseRooms[inte]>1)return SPD(playerid,0,0,!"","Deja, jusu namuose toks remontas netilps!", !"Priimti","");
				    case 2: if(HouseRooms[inte]>2)return SPD(playerid,0,0,!"","Deja, jusu namuose toks remontas netilps!", !"Priimti","");
				    case 3: if(HouseRooms[inte]>3)return SPD(playerid,0,0,!"","Deja, jusu namuose toks remontas netilps!", !"Priimti","");
					case 4: if(HouseRooms[inte]>4)return SPD(playerid,0,0,!"","Deja, jusu namuose toks remontas netilps!", !"Priimti","");
		        }
		        if(PI[playerid][pDCTime]!=1) PI[playerid][pDCTime]=1;
		        TogglePlayerControllable(playerid, true);
				SCM(playerid,COLOR_GREEN, !"Sveikinu jus su naujo interjero pirkimu!");
				if !IntInfo[inte][iCostType] *then GiveMoney(playerid,-IntInfo[inte][iCost]);
				else DeleteItem(playerid, 589, IntInfo[inte][iCost]);
				SetHouseInt( PI[playerid][pHouseKey], inte);
				BuyInt[playerid] = -1;
     			SettingSpawn(playerid);
				if(pTemp[playerid][SPECTPLAYER]==true) SpecPl(playerid, false);
				DestroyPlayerTD(playerid,InfoText[playerid]);
				SaveHouse(PI[playerid][pHouseKey]);
				PlayerPlaySound(playerid, 30800, 0.0, 0.0, 0.0);
			}
			else
			{
			    PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
				SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
				return 1;
			}
		}
	}
	else if(Clother[playerid] != -1)
	{
	    new nskin = PI[playerid][pSkin];
	    new skin = Clother[playerid];
	    if(nskin != 0)
	    {
		    new cost;
		    new race = PI[playerid][pRace];
		    new clother = Clother[playerid];//tika
		    if(PI[playerid][pSex]==1)
			{
				if(MSkins[race][clother]!=GetPlayerSkin(playerid))return 0;
			}
			if(PI[playerid][pSex]==2)
			{
			    if(GSkins[race][clother]!=GetPlayerSkin(playerid))return 0;
			}
            new bizid = BizEntered[playerid];
		    if(PI[playerid][pSex] == 2) cost = GSkinCost[skin];
		    else cost = MSkinCost[skin];
		    if(cost <= 0) cost = 140;
		    if(PI[playerid][pMoney] < cost) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
		    if(BizData[bizid][bProducts]<(cost/100))return SCM(playerid,-1, !"{FFFFFF}Atsiprasome, bet pas mus baigesi prekes!");
			Clother[playerid] = -1;
			TogglePlayerControllable(playerid, true);
			UpdatePlayerPos(playerid, 199.0545,-131.5248,1003.5152);
			TogglePlayerDynamicCP(playerid, Binko_CP, true);
			AddItem(playerid, GetPlayerSkin(playerid), 1);
			GiveMoney(playerid,-cost);
   			GiveBizMoney(bizid,cost);
			BizData[bizid][bProducts]-=(cost/100);
			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld(playerid,OldWorld[playerid]);
			SendPedBot(playerid);
			SetPlayerSkinEx(playerid, PI[playerid][pOldSkin]);
			if(QuestProgress[playerid][8]==0 && AcceptQuest[playerid][8]!=0)
		    {
		        QuestProgress[playerid][8]=1;
		        SPD(playerid,0,0,!"","{FFFFFF}Jus sekmingai nusipirkote naujus drabuzius, kaip prase Michael.\nGrizkite atgal, kad gautumete atlygi uz atlikta uzduoti.\n\n{82A3DF}Dabar galite isigyti drabuziu bet kurioje parduotuveje.", !"Priimti","");
		        NextStapQI(playerid,8);
		    }
		}
		else
		{
		    TutState[playerid] = -1;
			SetFullness(playerid, 100);
			SetPlayerWeather(playerid, Weather);
			Clother[playerid] = -1;
			PI[playerid][pSkin] = GetPlayerSkin(playerid);
		    if(pTemp[playerid][SPECTPLAYER]==true)SpecPl(playerid, false);
		    SetPlayerVirtualWorld(playerid, 0);
 			SetPlayerInterior(playerid, 0);
			if(PI[playerid][pRace]==0)
		    {
				switch(random(4))
				{
      				case 0:UpdatePlayerPos(playerid,1765.5046,-1892.7008,13.5611);
		  			case 1:UpdatePlayerPos(playerid,1765.3536,-1902.9863,13.5661);
		  			case 2:UpdatePlayerPos(playerid,1758.8562,-1903.0684,13.5646);
		  			case 3:UpdatePlayerPos(playerid,1758.8551,-1892.5815,13.5559);
				}
				SetPlayerFacingAngle(playerid, 199.2585);
			}
			else
			{
				UpdatePlayerPos(playerid, 2229.4236,-1156.9237,25.8201);
				SetPlayerFacingAngle(playerid,39.4635);
			}
			StopAudioStreamForPlayer(playerid);
			ClearChatForPlayer(playerid);
			SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Informacija", !"\
			{ffffff}Aciu, kad uzsiregistravote {8000ff}San Andreas Gyvenimas!\n\n\
			{FAAC58}Jus gavote 3000$\n\
			{FAAC58}Noredami pirmi zinoti naujas musu serverio naujienas, uzeikite i Musu telegrama: {ffffff}t.me/SAGyvenimas", "Aciu", "");
	 		SCM(playerid,COLOR_WHITE, !"{DFCFCF}[Uzuomina] {DC2441}Serveryje yra inventorius, naudokite 'Y' klavisa darbui su juo.");
		 	SCM(playerid,COLOR_WHITE, !"{DFCFCF}[Uzuomina] {DC2441}Galite uzduoti klausima musu techninei pagalbai naudodami /report");
		 	SCM(playerid,COLOR_WHITE, !"{DFCFCF}[Uzuomina] {DC2441}Rekomenduojame gauti pasa, o tada vykti i uki ar gamykla, kad uzdirbtumete pinigu vairuotojo pazymejimui.");
		 	SCM(playerid,COLOR_WHITE, !"{c92e2e}[Informacija] Serveris San Andreas Gyvenimas. Visus klausimus siuskite i /report!");
		 	SCM(playerid,COLOR_WHITE, !"{0ba3fe}[Informacija] Launcher galesite atsisiusti musu oficialioje svetaineje: None");
		 	SCM(playerid,COLOR_WHITE, !"{0ba3fe}[Informacija] Parasyti skunda, gauti pagalba musu forume: None");
		 	SCM(playerid,COLOR_WHITE, !"{0ba3fe}[Informacija] Butinai prisijunkite prie musu Discord: discord.gg/bWfENuNM");
		 	SCM(playerid,COLOR_WHITE, !"{ff356a}[Informacija] Linkime jums malonaus zaidimo ir geros nuotaikos San Andreas Gyvenimas projekte!");
		 	SCM(playerid,COLOR_WHITE, !"{feb151}[Donate] Projekte galite isigyti unikaliu prekiu uz tikrus eurus: /donate");
		 	SCM(playerid,COLOR_WHITE, !"{dc1a24}[Bonus] Musu serveryje veikia premiju programa uz praleista laika: /bonus");
		 	SCM(playerid,COLOR_WHITE, !"{C2A2DA}[Bilietai] Uz kiekviena praleista valanda gausite po viena unikalu bilieta: /bilet");
		 	SCM(playerid,COLOR_WHITE, !"{FF69B4}[Dovana] Raskite dovanas ir atidarykite skrynias. Pagrindinis prizas {ffffff}BMW X5!");
		 	SCM(playerid,COLOR_WHITE, !" ");
		 	SetString(PI[playerid][pVipName], "{ffa500}[Naujokas]");
		 	UpdatePlayerDataStr(playerid, "VipName", PI[playerid][pVipName]);
		 	SCM(playerid,COLOR_WHITE, !"{FAAC58}Jus gavote 3000$");
		 	SCM(playerid,COLOR_WHITE, !"{FAAC58}Noredami pirmi zinoti naujas musu serverio naujienas, uzeikite i Musu telegrama: {ffffff}t.me/SAGyvenimas");
			if(GetPlayerMobileLauncher(playerid))
			{
			    PI[playerid][LauncherData][1] = 4;
			    Hunger(playerid, 1);
			    HideLogo(playerid);
				new BitStream:bs = BS_New();
				BS_WriteValue(bs, PR_UINT8, 220, PR_UINT8, 8, PR_UINT8, 3);
				PR_SendPacket(bs, playerid), BS_Delete(bs);
				UpdateBrowser(playerid, 8, 3);
			}
            PlayerSpawn(playerid);
			TogglePlayerControllable(playerid,true);
			PI[playerid][pAntiVR] = 300;
			UpdatePlayerDataInt(playerid, "pAntiVR", PI[playerid][pAntiVR]);
		   	PI[playerid][pHungryShow] = 0;
		   	SetFullness(playerid, 100);
		   	Hunger(playerid, 0);
		   	SettingData[playerid][sdActionTrade] = 1;
			PI[playerid][pRabRacia] = 1;
            PI[playerid][pZKP] = 20;
	   		PI[playerid][pHospital] = 25;
			UpdatePlayerHealth(playerid, 100);
		    SetCameraBehindPlayer(playerid);
		    if(!PI[playerid][pRace]) CheckPointForPlayer(playerid,1773.6903,-1891.7493,13.5504);
			else CheckPointForPlayer(playerid,1163.6832, -1754.9606, 13.6180);
		}
	}
	else if(Buyitem[playerid] != -1)
	{
	    new race = PI[playerid][pType],
	    	price = ItemsCost[race][Buyitem[playerid]],
	    		biz = BizEntered[playerid],
	    			item = ItemsIdInv[race][Buyitem[playerid]]+1;
        if(PI[playerid][pMoney]<price)return SendBotMessage(playerid,"Atsiprasome, bet jus neturite pakankamai pinigu pirkimui!");
        if(BizData[biz][bProducts]<(price/100))return SendBotMessage(playerid,"Atsiprasome, bet pas mus baigesi prekes!");
	    SendBotMessage(playerid,"Aciu uz pirkima, laukiam jusu sugriztant!");
		GiveMoney(playerid,-price);
		GiveBizMoney(biz,price);
		BizData[biz][bProducts] -= (price/100);
		AddItem(playerid, item, 1);
        TogglePlayerControllable(playerid, true);
        PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
		SetCameraBehindPlayer(playerid);
		Buyitem[playerid] = PI[playerid][pType] = -1;
		DeletePVar(playerid, "timetobuy2");
		DestroyPlayerObject(playerid, TempBGObject[playerid]);
	}
    else if(BuyGuns[playerid] != -1)
	{
	    new bgid = BuyGuns[playerid];
	    new ammo = BuyGunAmmo[playerid];
	    new weaponid = BuyGunInfo[bgid][bgGunid];
		new ammos = BuyGunInfo[bgid][bgAmmo][ammo];
		new money;
	    switch(BuyGuns[playerid])
	    {
	        case 0: money = BizData[BizEntered[playerid]][bItem][0];
	        case 1: money = BizData[BizEntered[playerid]][bItem][1];
	        case 2: money = BizData[BizEntered[playerid]][bItem][2];
	        case 3: money = BizData[BizEntered[playerid]][bItem][3];
	        case 4: money = BizData[BizEntered[playerid]][bItem][4];
	        case 5: money = BizData[BizEntered[playerid]][bItem][5];
	        case 6: money = BizData[BizEntered[playerid]][bItem][6];
	        case 7: money = BizData[BizEntered[playerid]][bItem][7];
	        case 8: money = BizData[BizEntered[playerid]][bItem][8];
	        case 9: money = BizData[BizEntered[playerid]][bItem][9];
	        case 10: money = BizData[BizEntered[playerid]][bItem][10];
		}
	    money += BuyGunInfo[bgid][bgGPrice];
     	new biz = BizEntered[playerid];
	    if(biz != -1)
		{
			if(BizData[biz][bProducts] < (money/10) ) return SendBotMessage(playerid,"Atsiprasome, nes mums baigesi produktai.");
			if(PI[playerid][pMoney]<money)return SendBotMessage(playerid,"Atsiprasome, bet jus neturite pakankamai pinigu!");
		    BizData[biz][bProducts] -= (money/10);
			GiveBizMoney(biz,money);
		}
	    if(weaponid)
	    {
	        if(PI[playerid][pMoney]<money) return SendBotMessage(playerid,"Atsiprasome, bet jus neturite pakankamai pinigu!");
		    GiveMoney(playerid, -money);
		    f(global_str,100, "[Informacija] {FFFFFF}Jus nusipirkote %s su %d soviniu uz $%d", WeaponNames[weaponid], ammos, money);
		    SCM(playerid, COLOR_VALIK, global_str);
		    SendAmmoBot(playerid);
			switch weaponid do
			{
			    case 1: AddItem(playerid, 526, ammos);
			    case 5: AddItem(playerid, 527, ammos);
			    case 8: AddItem(playerid, 528, ammos);
			    case 46: AddItem(playerid, 529, ammos);
			    case 17: AddItem(playerid, 530, ammos);
			    case 24: AddItem(playerid, 531, ammos);
			    case 25: AddItem(playerid, 532, ammos);
			    case 29: AddItem(playerid, 533, ammos);
			    case 30: AddItem(playerid, 534, ammos);
			    case 31: AddItem(playerid, 535, ammos);
			    case 33: AddItem(playerid, 536, ammos);
			    case 44: AddItem(playerid, 537, ammos);
			}
		    PlayerPlaySound(playerid, 30800, 0.0, 0.0, 0.0);
			return 0;
		}
	}
	DestroyPlayerTD(playerid,InfoText[playerid]);
	TextDrawHideForPlayer(playerid,Boxmenu0);
	TextDrawHideForPlayer(playerid,Boxmenu1);
	TextDrawHideForPlayer(playerid,Boxmenu2);
	TextDrawHideForPlayer(playerid,ButtonLeft);
	TextDrawHideForPlayer(playerid,ButtonRight);
	TextDrawHideForPlayer(playerid,ButtonUp);
	TextDrawHideForPlayer(playerid,ButtonDown);
	TextDrawHideForPlayer(playerid,ButtonCancel);
	TextDrawHideForPlayer(playerid,ButtonSelect);
	TextDrawHideForPlayer(playerid,boxaccept);
	TextDrawHideForPlayer(playerid,boxcancel);
	TextDrawHideForPlayer(playerid,Boxmenu3);
	CancelSelectTextDraw(playerid);
	return 0;
}
CMD:cancel(playerid, params[])
{
    if(BuyInt[playerid] != -1)
 	{
 	    if(PI[playerid][pDCTime]!=1) PI[playerid][pDCTime]=1;
        TogglePlayerControllable(playerid, true);
		BuyInt[playerid] = -1;
		SettingSpawn(playerid);
		SpecPl(playerid, false);
		DestroyPlayerTD(playerid,InfoText[playerid]);
		PlayerPlaySound(playerid, 30800, 0.0, 0.0, 0.0);
	}
	else if(Clother[playerid] != -1)
	{
	    new nskin = PI[playerid][pSkin];
	    if(nskin != 0)
	    {
	        UpdatePlayerPos(playerid, 199.0545, -131.5248, 1003.5152);
			TogglePlayerControllable(playerid, true);
			SetCameraBehindPlayer(playerid);
	  		SetPlayerVirtualWorld(playerid,OldWorld[playerid]);
			TogglePlayerDynamicCP(playerid, Binko_CP, true);
			PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
			Clother[playerid] = -1;
			SetPlayerSkinEx(playerid,PI[playerid][pSkin]);
	    }
		else return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Turite pasirinkti skina!");
	}
	else if(Buyitem[playerid] != -1)
	{
        TogglePlayerControllable(playerid, true);
		SetCameraBehindPlayer(playerid);
		PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
		Buyitem[playerid] = -1;
		DestroyPlayerObject(playerid, TempBGObject[playerid]);
		PI[playerid][pType]=-1;
		SetPVarInt(playerid,"timetobuy2",0);
	}
	else if(BuyGuns[playerid] != -1)
	{
	    BuyGuns[playerid] = -1;
	    DestroyPlayerTD(playerid, InfoText[playerid]);
	    SCM(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus atsisakete pirkti ginkla");
	    PlayerPlaySound(playerid, 30802, 0.0, 0.0, 0.0);
		SetCameraBehindPlayer(playerid);
		DestroyPlayerObject(playerid, TempBGObject[playerid]);
	}
	DestroyPlayerTD(playerid,InfoText[playerid]);
	TextDrawHideForPlayer(playerid,Boxmenu0);
	TextDrawHideForPlayer(playerid,Boxmenu1);
	TextDrawHideForPlayer(playerid,Boxmenu2);
	TextDrawHideForPlayer(playerid,ButtonLeft);
	TextDrawHideForPlayer(playerid,ButtonRight);
	TextDrawHideForPlayer(playerid,ButtonUp);
	TextDrawHideForPlayer(playerid,ButtonDown);
	TextDrawHideForPlayer(playerid,ButtonCancel);
	TextDrawHideForPlayer(playerid,ButtonSelect);
	TextDrawHideForPlayer(playerid,boxaccept);
	TextDrawHideForPlayer(playerid,boxcancel);
	TextDrawHideForPlayer(playerid,Boxmenu3);
	CancelSelectTextDraw(playerid);
	return 1;
}
CMD:eject(playerid, params[])
{
	new id;
	if(sscanf(params,"u",id)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Naudokite: /eject [ID/Name]");
	if(playerid == id) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Negalite ismesti saves.");
	if(GetPlayerState(playerid) != 2) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Tik vairuotojas gali tai padaryti");
	if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(id)) return 0;
	new power = random(10);
	if(power > 5)
	{
		f(global_str, 100, " %s nepavyko ismesti is transporto zaidejo %s", PN(playerid), PN(id));
		ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
	}
	else
	{
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(id,true);
		f(global_str, 100, " %s ismete is transporto %s", PN(playerid), PN(id));
		ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
		RemovePlayerFromVehicle(id);
	}
	return 1;
}
CMD:medcard(playerid, params[])
{
	if(!IsAMedic(playerid)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate ligonines narys!");
    if(PI[playerid][pRank] < 3) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jusu rangas nera pakankamai aukstas tam padaryti.");
    new id, status;
    if(sscanf(params, "ui", id, status))
	{
		SCM(playerid, COLOR_OLDRED, !"Naudokite: /medcard [id] [statusas]");
		SCM(playerid, COLOR_WHITE, !"__________ Statusai __________");
		SCM(playerid, COLOR_GREY, !" 0. Neapibreztas");
		SCM(playerid, COLOR_WHITE, !" 1. Psichiskai nesveikas");
		SCM(playerid, COLOR_WHITE, !" 2. Pastebimi nukrypimai");
		SCM(playerid, COLOR_WHITE, !" 3. Visiskai sveikas");
		return 1;
	}
	if(status == -1) return 1;
	if(!ProxDetectorS(3.0, playerid, id, 1)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo");
    if(!IsValidPassport(id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zaidejas neturi paso.");
    if(!TeamDuty{playerid}) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate budejime!");
    new Med[30];
    MedCardInfo[id][mcState] = status;
	switch(MedCardInfo[id][mcState])
	{
	    case 0: Med = "Neapibreztas";
	    case 1: Med = "Psichiskai nesveikas";
	    case 2: Med = "Pastebimi nukrypimai";
	    case 3: Med = "Visiskai sveikas";
	}
    new year, month, day;
    getdate(year, month, day);
    f(global_str, 100, "%d/%d/%d", day, month, year);
    SetString(MedCardInfo[id][mcDate], global_str);
    if(status == 3) f(global_str, 200, "{FFFFFF}Gydytojas %s jums isdave medicinine kortele: %s\nParodyti kortele: '/showmc'\n{D84343}Psichiatrines ligonines lankymo sarasas isvalytas!", PN(playerid), Med);
    else f(global_str, 200, "{FFFFFF}Gydytojas %s jums isdave medicinine kortele: %s\nParodyti kortele: '/showmc'", PN(playerid), Med);
    SPD(id, 0, DIALOG_STYLE_MSGBOX, "", global_str, "Supratau", "");
    f(global_str, 145, "[Informacija] {FFFFFF}Jus isdavete medicinine kortele %s: %s", PN(id), Med);
    SCM(playerid, COLOR_LIGHTBLUE, global_str);
    if(status == 3) PI[id][pPcix] = 0;
    f(global_str, 200, "UPDATE `passports` SET `McDate` = '%s', `McState` = '%d' WHERE `Name` = '%s'",
	    MedCardInfo[id][mcDate],
	    MedCardInfo[id][mcState],
		PN(id));
    mysql_tquery(mysql, global_str);
	return 1;
}
CMD:fmute(playerid, params[])
{
	if(!PI[playerid][pLeader] && PI[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jums si komanda nepasiekiama!");
    new id, time;
    if(sscanf(params,"dds[100]", id, time, params[0])) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /fmute [id] [time] [reason]");
    if(IsADomen(params[0])  && PI[playerid][pAdmin]<6)
    {
		SCM(playerid,COLOR_RED,!"Tokiose zinutese draudziama naudoti angliskus simbolius");
    	SCM(playerid,COLOR_WHITE, !"Nekartokite sio veiksmo, kad isvengtumete bausmes.");
		return 0;
    }
    if(IsAIP(params[0]))return 1;
    if(PI[playerid][pMuteTime]>0)return 0;
    if(time>180)return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Nutildymo laika galima nustatyti ne ilgiau kaip 60 minuciu!");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate budejime!");
    if(GetTeamID(id) != GetTeamID(playerid)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Sis zaidejas nepriklauso jusu organizacijai!");
    if(time == 0) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Nustatyti 0 minuciu neleidziama!");
    if(PI[id][pLeader] > 0 ) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus negalite duoti nutildyma lyderiui");
    f(global_str, 145 ,"Darbuotojas %s nutilde zaideja %s %d minuciu. Priezastis: %s",PN(playerid),PN(id),time,params[0]);
    SendTeamMessage(GetTeamID(playerid), COLOR_RED, global_str);
    PI[id][pFMuteTime] = time*60;
	return 1;
}
CMD:funmute(playerid, params[])
{
	if(!PI[playerid][pLeader] && PI[playerid][pRank] < 8) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jums si komanda nepasiekiama!");
    new id;
    if(sscanf(params,"d", id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /funmute [id]");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate budejime!");
    if(GetTeamID(id) != GetTeamID(playerid)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Sis zaidejas nepriklauso jusu organizacijai!");
    f(global_str, 145 ,"Darbuotojas %s nueme nutildyma nuo %s",PN(playerid),PN(id));
	SendTeamMessage(GetTeamID(playerid), COLOR_RED, global_str);
	PI[id][pFMuteTime] = 0;
	return 1;
}
alias:referals("ref");
CMD:referals(playerid)
	return OpenReferalMenu(playerid);
CMD:unrentcar(playerid, params[])
{
	if(ArendKey[playerid] == INVALID_VEHICLE_ID) return 0;
    new car = ArendKey[playerid];
	new vehid = ArendCar[0] + car;
	if(ArendInfo[car][aRentID] == playerid)
	{
		ArendInfo[car][aRentID] = INVALID_PLAYER_ID;
		SetVehicleToRespawn(vehid);
	}
	ArendKey[playerid] = INVALID_VEHICLE_ID;
	SCM(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus atsisakete nuomoti transporto priemone");
	return 1;
}
CMD:houseskin(playerid, params[])
{
	if(!IsPlayerLogged{playerid}) return 0;
	if(Clother[playerid] == -1) return 0;
	new skin = Clother[playerid];
	new cost;
    if(PI[playerid][pSex] == 2) cost = GSkinCost[skin];
    else cost = MSkinCost[skin];
    if(PI[playerid][pMoney]< cost) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
	if(PI[playerid][pHouseKey] == -1) return SCM(playerid,COLOR_GREY, !"Jus nesate registruotas ne vienuose namuose");
	new house = PI[playerid][pHouseKey];
	if(!GetString(HouseInfo[house][hOwner],PN(playerid))) return SCM(playerid,COLOR_GREY, !"Jus nesate namo savininkas");
	new bizid = BizEntered[playerid];
	if(BizData[bizid][bProducts]<(cost/100))return SCM(playerid,-1, !"{FFFFFF}Atsiprasome, bet pas mus baigesi prekes!");
    new bool:buyskin;
    for(new i;i < 5;i ++)
    {
        if(HouseInfo[house][hSkin][i] == 0)
        {
            HouseInfo[house][hSkin][i] = GetPlayerSkin(playerid);
            GiveMoney(playerid, -cost);
			GiveBizMoney(bizid,cost);
            SCM(playerid, COLOR_LIGHTBLUE, "Jus nusipirkote persirengimo kostiuma namuose");
            SendPedBot(playerid);
            buyskin = true;
            break;
        }
    }
    if(!buyskin) SCM(playerid,COLOR_GREY, !"Jusu namuose nera laisvu kabliu");
	return 1;
}
CMD:fillcar(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus turite buti islipe is transporto priemones!");
    if(!GetCount(playerid, 332))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite kanistros!");
    if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 10 sekundziu!");
    SetPVarInt(playerid, !"itemtime", Global_Time+10);
	new Float:pX, Float:pY, Float:pZ, Float:vX, Float:vY, Float:vZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	new Float:minS = 2.0, Float:dist, car = INVALID_VEHICLE_ID;
	foreach(Vehicle, i)
	{
		GetVehiclePos(i, vX, vY, vZ);
		dist = PointToPoint(pX, pY, pZ, vX, vY, vZ);
		if(dist < minS)
		{
			car = i;
			minS = dist;
		}
	}
	if(car == INVALID_VEHICLE_ID) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate per toli nuo transporto, kuria reikia uzpildyti degalais!");
    Fuel[car] += 15;
    if(Fuel[car] >= 100)
		Fuel[car] = 100;
	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 6.1, 0, 0, 0, 0, 0,1);
    DeleteItem(playerid, 332, 1);
    new
		string[25 - 2 + MAX_PLAYER_NAME];
    f(string, sizeof(string), " %s uzpilde savo automobili degalais.", PN(playerid));
	ProxDetector(25, playerid, string, COLOR_ME);
    GameTextForPlayer(playerid, !"~w~CAR IS ~g~REFUELED", 5000, 6);
    DeleteItem(playerid, 332, 1);
	return 1;
}
CMD:fixmycar(playerid, params[])
{
	if(PI[playerid][pVIP] < STATUS_PLATIN)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Si funkcija prieinama tik zaidejams, turintiems 3 arba aukstesnio lygio VIP statusa!");
	extract params -> new car; else
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /fixmycar [id]");
	if(!IsPlayerHaveCar(playerid, car))
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tai ne jusu transportas!");
	if(PI[playerid][pMoney] < 1000)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu! Reikia 1000$");
	if GetPlayerState(playerid) == 2 *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Reikia buti islipus is transporto priemones.");
	GiveMoney(playerid, -1000);
	SetVehicleToRespawn(car);
	if(!IsAOwnableCar(car)) return 0;
	new debil = GetVehicleID(car);
	SetVehiclePos(car, CarInfo[debil][cPos_X], CarInfo[debil][cPos_Y], CarInfo[debil][cPos_Z]);
	GameTextForPlayer(playerid, !"Car is returned", 0, 1);
	return 1;
}
CMD:deltun(playerid, params[])
{
	extract params -> new car; else
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /deltun [transporto ID]");
	new
		number = GetVehicleID(car);
	if(!GetString(CarInfo[number][cOwner], PN(playerid)))
		return 0;
	if(PI[playerid][pMoney] < 10000)
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu! Reikia 10 000$");
	GiveMoney(playerid, -10000);
	if(!IsAVelik(car) || !IsASkate(car))
		SetEngineStatus(car, false, -1);
	else
		SetEngineStatus(car, true, -1);
	SetVehicleToRespawn(car);
	SaveOwnableCar(number);
	SCM(playerid, COLOR_LIGHTBLUE, !"[Informacija] {FFFFFF}Jus pasalinote tuninga nuo savo transporto");
	return 1;
}
CMD:fill(playerid)
{
	new carid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == 2)
	{
	    if(GetVehicleKindFuel(GetPlayerVehicleID(playerid)) != -1)
	    {
			if(IsAtGasStation(playerid))
			{
				new
					fuelid = GetGasStation(playerid),
					bizid = FuelInfo[fuelid][fBizzID];
//					Float:cost = BizData[bizid][bEnterPrice];
                if !GetPlayerLauncher(playerid) *then
                {
					if(IsACar(carid))
					{
						if(GetVehicleKindFuel(GetPlayerVehicleID(playerid)) != -1)
						{
							if(BizData[bizid][bProducts] >= 100)
							{
								if(Fuel[GetPlayerVehicleID(playerid)] < 100.0)
								{
									if(KindFuel[playerid] == -1)
									{
										if(GetVehicleKindFuel(GetPlayerVehicleID(playerid)) != 0)
										{
											GameTextForPlayer(playerid,"~w~This type of fuel ~r~is not suitable~w~~n~for your vehicles!",10000,4);
										}
										PlayerFuel[playerid] = fuelid;
										CountFuel[playerid] = 0.0;
										KindFuel[playerid] = 0;
										SCM(playerid, COLOR_GREEN, !"[Informacija] {FFFFFF}Naudokite zymekli, kad pasirinktumete degalu tipa ir kieki");
										SCM(playerid, COLOR_GREEN, !"[Informacija] {FFFFFF}Jus galite uzpildyti pilna baka - paspaude degalu kaina");
										CreateFillTD(playerid);
										for(new i; i < 34; i++) ShowPlayerTD(playerid, FillUp[playerid][i]);
										SelectTextDraw(playerid, 0xAFAFAFFF);
									}
								}
								else SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Jusu transportas visiskai uzpildytas degalais");
							}
							else SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Sioje degalineje nebera degalu");
						}
						else SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Mes neturime kuro jusu transporto priemonei");
					}
					else SCM(playerid,COLOR_RED, !"[Klaida]{FFFFFF} Jus turite elektromobili...");
				}
				else
				{
					if(BizData[bizid][bProducts] >= 100)
					{
                        if(KindFuel[playerid] == -1)
                        {
							if(Fuel[carid] < 100.0)
							{
/*								ExecuteEvent(playerid, 0, "window.executeEvent('event.setActiveView', '[\"GasStation\"]');");
								ExecuteEvent(playerid, 0, (str_f("window.executeEvent('event.gasstation.initializeFuelTypes', '[[{\"id\":0,\"title\":\"Dizelis\",\"price\":%.1f,\"available\": 0},{\"id\":1,\"title\":\"92\",\"price\":%.1f,\"available\": 1},{\"id\":2,\"title\":\"95\",\"price\":%.1f,\"available\": 0},{\"id\":3,\"title\":\"98\",\"price\":%.1f,\"available\": 0}]]');", cost, cost, cost, cost)));
							    ExecuteEvent(playerid, 0, (str_f("window.executeEvent('event.gasstation.initializeProducts', '[[{\"id\":0,\"title\":\"Rem.komplektas\",\"image\":520,\"price\":%i},{\"id\":1,\"title\":\"Kanistra\",\"image\":516,\"price\":%i},{\"id\":2,\"title\":\"Powerbank automobilio ikrovimui\",\"image\":700054,\"price\":%i}]]');", BizData[bizid][bItem][1], BizData[bizid][bItem][2], BizData[bizid][bItem][3])));
								ExecuteEvent(playerid, 0, "window.executeEvent('event.gasstation.initializeMaxLiters', '[100]');");
								ExecuteEvent(playerid, 0, (str_f("window.executeEvent('event.gasstation.initializeCurrentLiters', '[%i]');", floatround(Fuel[carid]))));
								OnFocusBrowser(playerid, 0, true);*/
								PlayerFuel[playerid] = fuelid;
								CountFuel[playerid] = 0.0;
								KindFuel[playerid] = 0;
								SCM(playerid, COLOR_GREEN, !"[Informacija] {FFFFFF}Naudokite zymekli, kad pasirinktumete degalu tipa ir kieki");
								SCM(playerid, COLOR_GREEN, !"[Informacija] {FFFFFF}Jus galite uzpildyti pilna baka - paspaude degalu kaina");
								CreateFillTD(playerid);
								for(new i; i < 34; i++) ShowPlayerTD(playerid, FillUp[playerid][i]);
								SelectTextDraw(playerid, 0xAFAFAFFF);
							}
							else SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Jusu transportas visiskai uzpildytas degalais");
						}
					}
					else SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Sioje degalineje nebera degalu");
				}
			}
		}
		else SCM(playerid, COLOR_RED , !"[Klaida] {FFFFFF}Jus turite elektromobili...");
	}
	return 1;
}
CMD:find(playerid, params[])
{
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /find [id]");
	if(!IsACop(playerid)) return SCM(playerid,COLOR_RED, !"Jus nesate policininkas!");
    if(IsANotControllable(playerid)) return SCM(playerid, COLOR_RED, !"Jus negalite judeti!");
	if(playerid == params[0]) return 0;
	if(PI[params[0]][pMaskON]>0) return SCM(playerid, COLOR_VALIK, !"[Klaida] {FFFFFF}Neimanoma rasti sio zmogaus vietos!");
	if(GetPlayerInterior(params[0]) != GetPlayerInterior(playerid)) return SCM(playerid, COLOR_VALIK, !"[Klaida] {FFFFFF}Zaidejas yra kazkokiame pastate");
	if(PI[params[0]][pWanted]==0) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite ieskoti zaidejo, kuris nera nusikaltelis!");
	if(!IsPlayerConnected(params[0])) return 0;
	new Float:POS[3];
	GetPlayerPos(params[0], POS[0], POS[1], POS[2]);
	EnableGPSForPlayer(playerid, POS[0], POS[1], POS[2]);
	return 1;
}
CMD:usebad(playerid, params[])
{
    if(GetCount(playerid, 524) == 0) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite vaistu nuo narkomanijos!");
	if(medlomka[playerid]>0)return SCM(playerid,COLOR_RED, !"[Klaida] {FFFFFF}Jus jau isgerete vaistus!");
	if(PI[playerid][pAllRepl]==0)return SCM(playerid,COLOR_GREY, !"[Informacija] {FFFFFF}Jus nesergate narkomanija!");
	if(startlomka[playerid]==1) return SCM(playerid,COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite vartoti vaistu abstinencijos metu!");
	if(CuffedTime[playerid]!=0 || Cuffed[playerid])return SCM(playerid,COLOR_RED, !"[Klaida] {FFFFFF}Siuo metu negalite vartoti vaistu!");
	if(!IsPlayerInRangeOfPoint(playerid, 100.0,2065.5859,-1374.3174,1001.2960))return SCM(playerid,COLOR_RED, !"Vaistus galima vartoti tik ligonineje!");
	SCM(playerid,COLOR_RED, !"[Informacija] {FFFFFF}Jus isgerete vaistus nuo narkomanijos!");
	SCM(playerid,COLOR_GREY, !"[Informacija] {FFFFFF}Netrukus gali prasideti salutinis poveikis!");
	ApplyAnimationEx(playerid,"FOOD","EAT_Burger",4.1,0,1,1,1,1);
	medlomka[playerid]=240;
	DeleteItem(playerid, 524, 1);
	return 1;
}
CMD:recept(playerid, params[])
{
	new id;
	if(CuffedTime[playerid]!=0 || Cuffed[playerid])return 0;
	if(!IsAMedic(playerid))return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Recepta gali israsyti tik gydytojas!");
	if(PI[playerid][pRank]<4)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Recepta gali israsyti tik 4 rango gydytojas!");
	if(sscanf(params,"u",id)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /recept [id]");
    if(!ProxDetectorS(3.0, playerid, id, 1)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
    if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate budejime!");
    f(global_str, 100 ,"%s israse %s recepta vaistams isigyti.",PN(playerid),PN(id));
    ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
    SCM(playerid,COLOR_GREY, !"[Informacija] {FFFFFF}Jus sekmingai israsete recepta.");
    SCM(id,COLOR_GREY, !"[Informacija] {FFFFFF}Jums buvo israsytas receptas, kurio deka galite isigyti vaistinele arba vaistus nuo narkomanijos.");
 	PlayerDrunkLevel[id]=1;
	return 1;
}
CMD:delldrugs(playerid, params[])
{
    if(GetCount(playerid, 525) < 1) return SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Jus neturite narkotiku");
    DeleteItem(playerid, 525, GetCount(playerid, 525));
    SetPlayerChatBubble(playerid, "Ismete narkotikus", COLOR_GREEN, 10.0, 5000);
    SCM(playerid,COLOR_GREEN, !"[Informacija] {FFFFFF}Jus sekmingai ismetete narkotikus.");
	return 1;
}
CMD:usedrugs(playerid, params[])
{
    if(GetPlayerVirtualWorld(playerid)==534)return 0;
	if(GetCount(playerid, 525) < 1) return SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Jus neturite narkotiku");
    if(Cuffed[playerid]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate surakintas ir negalite judeti");
	if(PI[playerid][pHeal] > 0) return SCM(playerid,COLOR_GREY, !"[Informacija] {FFFFFF}Kol esate ligonineje, negalite vartoti narkotiku!");
    if(UseDrugsTime[playerid] > 120) return 0;
    if(Int_GetPlayerData(playerid,"narko")>Global_Time)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Palaukite pora sekundziu!");
    new Float:Health;
    GetPlayerHealth(playerid,Health);
	Health += 30;
	if(Health > 100) Health = 100;
    UpdatePlayerHealth(playerid,Health);
    if(IsPlayerInAnyVehicle(playerid)) ApplyAnimationEx(playerid,"FOOD","EAT_Burger",4.1,0,0,0,0,0,1);
	DeleteItem(playerid, 525, 1);
	UseDrugsTime[playerid] += 60;
	PI[playerid][pAllRepl]++;
	if(startlomka[playerid]==1)PI[playerid][pOldRepl]=0;
	startlomka[playerid]=0;
	SetPlayerDrunkLevel (playerid, 3900);
	f(global_str, 100," %s vartoja narkotiku doze",PN(playerid));
	ProxDetector(30,playerid,global_str,COLOR_PURPLE);
	if(!IsPlayerInAnyVehicle(playerid))ApplyAnimationEx(playerid,"SMOKING","M_smk_drag",4.1,0,0,0,0,0,1);
	SetPVarInt(playerid,"narko",Global_Time+6);
	return 1;
}
CMD:gotome(playerid, params[])
{
	if(IsACop(playerid))
	{
	    new id;
		if(sscanf(params,"u",id)) return SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Naudokite: /gotome [id]");
		if(!TeamDuty{playerid}) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate budejime");
		if(ProxDetectorS(2.0, playerid, id))
		{
		    if(GotoInfo[playerid][gtID] == INVALID_PLAYER_ID)
		    {
		        if(GotoInfo[id][gtGoID] == INVALID_PLAYER_ID)
		        {
					if(Cuffed[id])
					{
                        CheckPlayerGoCuff(playerid);
                        CheckPlayerGoCuff(id);
					    GotoInfo[id][gtID] = INVALID_PLAYER_ID;
					    GotoInfo[playerid][gtGoID] = INVALID_PLAYER_ID;
					    GotoInfo[playerid][gtID] = id;
					    GotoInfo[id][gtGoID] = playerid;
					    GotoInfo[id][gtState] = GetPlayerState(playerid);
					    GetPlayerPos(id, GotoInfo[id][gtX], GotoInfo[id][gtY], GotoInfo[id][gtZ]);
					    SCM(playerid, COLOR_WHITE, !"[Informacija] {FFFFFF}Kad nustotumete tempti zaideja, iveskite {33AA33}/ungotome");
					    f(global_str, 128, "* %s tempe zaideja %s paskui save", PN(playerid), PN(id));
					    ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
					    TogglePlayerControllable(id, true);
					}
					else SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Zaidejas nera surakintas");
		        }
		        else SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Si zaideja jau kazkas veda su savimi");
		    }
		    else SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus jau vedate kazka su savimi");
		}
		else SCM(playerid, COLOR_GREY, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo");
	}
	return 1;
}
CMD:ungotome(playerid, params[])
{
	if(IsACop(playerid))
	{
		new id;
		if(sscanf(params,"u",id)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /ungotome [id/name]");
		if(ProxDetectorS(1.5,playerid,id))
		{
			if(Cuffed[id] && GotoInfo[playerid][gtID] == id)
			{
				f(global_str, 128 ,"* %s nustojo tempti zaideja %s paskui save",PN(playerid),PN(id));
				ProxDetector(25,playerid,global_str,COLOR_PURPLE);
				TogglePlayerControllable(id, Cuffed[id]);
				CheckPlayerGoCuff(id);
				CheckPlayerGoCuff(playerid);
			}
			else SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas nera surakintas arba jus jo netempiate");
		}
	}
	return 1;
}
CMD:accept(playerid,param[])
{
	new id=PanelPlayerID[playerid],Float: money = CenaRaboti[playerid] ;
    if(id == INVALID_PLAYER_ID)return 0;
    if(PI[id][pTelNum]<=0)return 0;
    new price = floatround( money, floatround_floor );
    if(PI[playerid][pMoney]<price)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite pakankamai pinigu, kad sumoketumete pardavejui!");
    if(!ProxDetectorS(9.0, playerid, id, 1)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
    if(price<1)return 0;
    switch(Ingatre[playerid])
    {
        case 1:
        {
            f(global_str,145,"[Informacija]{FFFFFF} %s sekmingai pardave jums SIM kortele su numeriu {52A32A}%d{FFFFFF} uz {52A32A}%d$.",PN(id),PI[id][pTelNum],price);
			SCM(playerid,COLOR_VALIK,global_str);
			f(global_str,145,"[Informacija] {FFFFFF}%s prieme jusu pasiulyma pirkti SIM kortele. Jus gavote {52A32A}%d$.",PN(playerid),price);
		    SCM(id,COLOR_VALIK,global_str);
		    if(price > 10000)
		    {
			    f(global_str,145,"Zaidejas %s[%d] [IP: %s] pardave SIM kortele zaidejui %s[%d] [IP: %s] uz $%d [$%d]",PN(id),id,PlayerIP(id),PN(playerid),playerid,PlayerIP(playerid),price);
			 	SendAdminsMessage(COLOR_RED, global_str);
			}
			PI[playerid][pTelNum] = PI[id][pTelNum];
			PI[id][pTelNum] = 0;
		    GiveMoney(playerid,-price);
			GiveMoney(id,price);
        }
    }
    CenaRaboti[playerid]=0;
	Ingatre[playerid]=0;
	PanelPlayerID[playerid]=-1;
	return 1;
}
CMD:nope(playerid,param[])
{
	if(CenaRaboti[playerid]==0)return SCM(param[0],COLOR_WHITE, !"[Klaida] {FFFFFF}Jums niekas nepasiule pirkti SIM korteles!");
	if(PanelPlayerID[playerid]==-1)return SCM(param[0],COLOR_WHITE, !"[Klaida] {FFFFFF}Jums niekas nepasiule pirkti SIM korteles!");
	SCM(playerid,COLOR_RED,!"[Informacija] {FFFFFF}Jus sekmingai atsisakete pasiulymo pirkti SIM kortele.");
	f(global_str,145,"[Informacija] {FFFFFF} %s atsisake jusu pasiulymo!",PN(playerid));
	SCM(PanelPlayerID[playerid],COLOR_RED,global_str);
	CenaRaboti[playerid]=0;
	Ingatre[playerid]=0;
	PanelPlayerID[playerid]=-1;
	return 1;
}
CMD:sellcard(playerid,param[])
{
    if(Getemer[playerid]>Global_Time)return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
    if(sscanf(param,"ud",param[0],param[1])) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Naudokite: /sellcard [id] [kaina]");
    if(param[1]<1)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Naudokite kaina didesne nei 1$!");
    if(PI[param[0]][pMoney]<param[1])return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Sis zmogus neturi tiek pinigu, kad jums sumoketu!");
    if(!ProxDetectorS(9.0, playerid, param[0], 1)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
    if(param[0]==playerid)return 0;
    if(!PI[playerid][pTelNum])return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus neturite SIM korteles!");
	if(!IsPlayerLogged{param[0]})return 0;
	PanelPlayerID[param[0]] = playerid;
	CenaRaboti[param[0]] = param[1];
	f(global_str,145,"[Informacija] {52A32A}%s{FFFFFF} siulo parduoti SIM kortele {52A32A}%d{FFFFFF} uz {52A32A}%d${FFFFFF}.",PN(playerid),PI[playerid][pTelNum],param[1]);
	SCM(param[0],COLOR_GREEN,global_str);
	SCM(param[0],COLOR_WHITE, !"[Informacija] {FFFFFF}/accept - kad priimtumete pasiulyma /nope - kad atmestumete.");
    f(global_str,145,"Jus pasiulete {52A32A}%s{FFFFFF} parduoti savo SIM kortele uz {52A32A}%d${FFFFFF}.",PN(param[0]),param[1]);
	SCM(playerid,COLOR_WHITE,global_str);
	Ingatre[param[0]] = 1;
	Getemer[playerid]= Global_Time + 5;
	return 1;
}
CMD:repare(playerid, params[])
{
	if(PlayerJob[playerid] != JOB_MECHANIC) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate mechanikas!");
	new carid = GetPlayerVehicleID(playerid);
	if(VehicleInfo[carid][vJob] != JOB_MECHANIC) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus turite buti mechaniko automobilyje!");
	if(sscanf(params, "ud", params[0], params[1])) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /repare [id] [kaina]");
	if(params[1] < 1 || params[1] > 1000) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Kaina negali buti mazesne nei 1$ ir didesne nei 1000$!");
	if(PI[params[0]][pMoney] < params[1]) return SCM(playerid, COLOR_RED,!"[Klaida] {FFFFFF}Sis zmogus neturi tiek pinigu, kad jums sumoketu!");
	if(GetPlayerState(params[0]) != 2) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas, kuriam norite padeti, turi buti uz vairo!");
 	if(!ProxDetectorS(9.0, playerid, params[0], 1)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
	if(params[0] == playerid) return 0;
	if(!IsPlayerLogged{params[0]}) return 0;
	PanelPlayerID[params[0]] = playerid;
	CenaRaboti[params[0]] = params[1];
	f(global_str, 145, "Mechanikas {52A32A}%s{FFFFFF} siulo sutvarkyti jusu transporta uz {52A32A}%d${FFFFFF}.", PN(playerid), params[1]);
	SPD(params[0], 1898, DIALOG_STYLE_MSGBOX, !"Sutinkate?", global_str, !"Priimti", !"Atsaukti");
    f(global_str, 145, "Jus pasiulete {52A32A}%s{FFFFFF} sutvarkyti transporta uz {52A32A}%d${FFFFFF}.", PN(params[0]), params[1]);
	SCM(playerid, COLOR_WHITE, global_str);
	Ingatre[params[0]] = 1;
    return 1;
}
CMD:filscar(playerid, params[])
{
	if(PlayerJob[playerid] != JOB_MECHANIC) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nesate mechanikas!");
	new carid = GetPlayerVehicleID(playerid);
	if(VehicleInfo[carid][vJob] != JOB_MECHANIC) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus turite buti mechaniko automobilyje!");
	if(sscanf(params, "ud", params[0], params[1])) return SCM(playerid ,COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /filscar [id] [kiekis litrais]");
	if(params[1] < 1 || params[1] > 100) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus negalite parduoti maziau nei 1 litra ir daugiau nei 100 litru!");
	if(PI[params[0]][pMoney] < (params[1] * BenzinCena[carid])) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Sis zmogus neturi tiek pinigu, kad jums sumoketu!");
	if(params[0] == playerid) return 0;
	if(GetPlayerState(params[0]) != 2) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas, kuriam norite padeti, turi buti uz vairo!");
	if(!ProxDetectorS(9.0, playerid, params[0], 1)) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate toli nuo zaidejo!");
	if(!IsPlayerLogged{params[0]}) return 0;
	if(BenzinCount[carid] < params[1]) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jusu automobilyje nepakanka benzino pardavimui!");
	PanelPlayerID[params[0]] = playerid;
	CenaRaboti[params[0]] = (params[1] * BenzinCena[carid]);
	f(global_str, 145, "Mechanikas {52A32A}%s{FFFFFF} siulo uzpildyti jusu transporta {52A32A}%d{FFFFFF}l. uz {52A32A}%.1f${FFFFFF}.", PN(playerid), params[1], (params[1] * BenzinCena[carid]));
	SPD(params[0], 1898, DIALOG_STYLE_MSGBOX, !"Sutinkate?", global_str, !"Priimti", !"Atsaukti");
    f(global_str, 145, "Jus pasiulete {52A32A}%s{FFFFFF} uzpildyti transporta uz {52A32A}%.1f${FFFFFF}.", PN(params[0]), (params[1] * BenzinCena[carid]));
	SCM(playerid, COLOR_WHITE, global_str);
	Ingatre[params[0]] = 2;
	return 1;
}
CMD:azsmonitor(playerid, params[])
{
    new carid = GetPlayerVehicleID(playerid);
    if(PlayerJob[playerid]!= JOB_MECHANIC) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate mechanikas!");
	if(VehicleInfo[carid][vJob]!=JOB_MECHANIC)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus turite buti mechaniko automobilyje!");
    global_str = "";
    SCM(playerid,COLOR_GREY, !"Degaliniu stebejimas.");
	for(new i = 1;i<OWNABLEBIZES;i++)
	{
	    if(BizData[i][bState] == 6 && !GetString(BizData[i][bOwner],"The State"))
	    {
	        f(global_str, 145,"-{FFFFFF} Degalines numeris: %d. Kaina {AFAFAF}1{FFFFFF} litro: {AFAFAF}$%.1f${FFFFFF}",i,BizData[i][bEnterPrice]);
	        SCM(playerid,COLOR_GREY, global_str);
	    }
	}
	return 1;
}
CMD:contractfill(playerid,param[])
{
	new carid = GetPlayerVehicleID(playerid);
	if(PlayerJob[playerid]!= JOB_MECHANIC) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus nesate mechanikas!");
	if(VehicleInfo[carid][vJob]!=JOB_MECHANIC)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus turite buti mechaniko automobilyje!");
    if(!IsAtGasStation(playerid)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Jus turite buti prie vienos is degaliniu!");
    new fuelid = GetGasStation(playerid);
	new bizid = FuelInfo[fuelid][fBizzID];
	new Float:cost = BizData[bizid][bEnterPrice],benz = BizData[bizid][bProducts];
	if(benz< (1000-BenzinCount[carid]))return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Sioje degalineje nepakanka benzino jusu automobiliui uzpildyti!");
	if(cost<2)return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Sioje degalineje benzinas per pigus pardavimui!");
	if(BenzinCount[carid]>950)return 0;
	BizData[bizid][bProducts]-=(1000-BenzinCount[carid]);
	UpdateFuels(bizid);
	Contracter[carid] = bizid;
	BenzinCount[carid]= 1000;
	BenzinCena[carid]=cost;
	f(global_str, 150,"{57B22C}Uzpildymas %.1f$\n{FFFFFF}Benzino: %d/1000",BenzinCena[carid],BenzinCount[carid]);
	UpdateDynamic3DTextLabelText(Benzin[carid], 0xFFFFFFFF, global_str);
	f(global_str,145,"[Informacija] {FFFFFF}Jus sekmingai sudarete degaliniu sutarti ir gausite po {52A32A}%.1f${FFFFFF} uz kiekviena litra benzino!",BenzinCena[carid]/2);
	SCM(playerid,COLOR_VALIK,global_str);
	SCM(playerid,COLOR_VALIK, !"[Informacija] {FFFFFF}Noredami nutraukti sutarti su sia degaline, uztenka sudaryti nauja sutarti su kita degaline!");
	return 1;
}
CMD:givekey(playerid, params[])
{
	new id,car;
	if(sscanf(params,"ud",id,car)) return SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Naudokite: /givekey [id] [carid]");
	if(!IsPlayerRegCar(playerid,car)) return SCM(playerid,COLOR_GREY, !"[Klaida] {FFFFFF}Jus nesate sio transporto savininkas!");
	if(ProxDetectorS(10.0,playerid,id))
	{
	    if(IsPlayerHaveCar(playerid,car))
	    {
	        if(IsValidNumberCars(id))
			{
		        SetCarKeyer(car,PN(id));
		        f(global_str, 333, "\n\n{FFFFFF}Zaidejas %s jums dave raktu kopija transporto {ae433d}%s\n{ae433d}[Demesio]: {FFFFFF}Naudokite ""/keys"" noredami perziureti galimus raktus\n", PN(playerid), GetVehicleName(car));
		        SPD(id, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}Perdavimas | {ae433d}Raktai", global_str, "x", "");
		        f(global_str, 145,"[Informacija] {FFFFFF}Jus davete %s transporto в„– %d raktu kopija",PN(id),car);
		        SCM(playerid,COLOR_LIGHTBLUE,global_str);
		        GetNumberCars(id,PI[id][pCars]);
	        }
			else SCM(playerid,COLOR_RED,!"[Klaida] {FFFFFF}Zaidejas, kuriam norite duoti raktus, negali ju pasiimti!");
	    }
	}
	return 1;
}
CMD:cheeps(playerid) return eatcheeps(playerid);
CMD:jfish(playerid)
{
    if(GetCount(playerid, 549) < 1) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus neturite keptos zuvies!");
    if(PI[playerid][pHeal])
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ligonineje negalima!");
    if(Int_GetPlayerData(playerid, !"itemtime") > Global_Time) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Tarp daiktu naudojimo turi praeiti 3 sekundes!");
    SetPVarInt(playerid, !"itemtime", Global_Time+3);
	new Float:Health;
	GetPlayerHealth(playerid,Health);
	f(global_str, 100, "%s suvalge kepta zuvi", PN(playerid));
	ProxDetector(25.0, playerid, global_str, COLOR_PURPLE);
	if(Fullness[playerid] <= 95) GiveFullness(playerid,4);
	else SetFullness(playerid, 100);
	DeleteItem(playerid, 549, 1);
	return ApplyAnimationEx(playerid,"FOOD","EAT_Burger",4.1,0,0,0,0,0,1);
}
CMD:trade(playerid, data[])
{
	if PI[playerid][pLevel] < 2 *then return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Prekiu keitimo funkcija prieinama nuo 2 lygio.");
	else if !(Lavka[playerid] == -1) *then return SCM(playerid, COLOR_OLDRED, !"Pardavimo metu negalima prekiauti!");
	else if !(GetDataTrade(playerid, tradePlayer) == INVALID_PLAYER_ID) *then return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus jau su kazkuo prekiaujate!");
	extract data -> new player:target; else
		return SCM(playerid, COLOR_RED, !"[Informacija] {FFFFFF}Naudokite: /trade [ID]");
	if !IsPlayerOnline(target) or !ProxDetectorS(10.0, playerid, target, 1) or playerid == target *then return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus esate toli nuo zaidejo!");
	else if !SettingData[target][sdActionTrade] *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Sis zaidejas atmete pasiulyma del mainu!");
	else if PI[playerid][pDemorgan] or PI[target][pDemorgan] *then
    	return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus negalite mainytis/perduoti daiktu sioje vietoje!");
	else if tradeopen{playerid} or tradeopen{target} *then return false;
	else if !(GetDataTrade(target, tradePlayer) == INVALID_PLAYER_ID) *then return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Zaidejas jau prekiauja!");
	else if GetDataTrade(target, tradeLastTime) > Global_Time *then return SCMF(playerid, COLOR_RED, "[Klaida]{FFFFFF} Zaidejas neseniai prekiavo. Palaukite dar %d sekundziu", GetDataTrade(target, tradeLastTime) - Global_Time);
	SCMF(playerid, COLOR_YELLOW, "Jus pasiulete %s[%d] atlikti prekyba, laukite atsakymo!", PN(target), target);
	SetDataTrade(target, tradeTime, 10);
	SetDataTrade(target, tradeAccept, 0);
	SetDataTrade(target, tradePlayer, playerid);
	SetDataTrade(playerid, tradePlayer, target);
	SetDataTrade(playerid, tradeSendTrade, true);
	SetDataTrade(target, tradeTimer, CallTimeOutFunction("UpdateTrade", 1000, true, "d", target));
	return SPDF(target, 7372, DIALOG_STYLE_MSGBOX, !"{AFAFAF}Prekyba", "{FFFFFF}Zaidejas %s[%d] siulo jums prekyba.\nTurite 10 sekundziu atsakyti", !"Priimti", !"Atsaukti", PN(playerid), playerid);
}
CMD:invent(playerid) return ShowInvent(playerid);
CMD:slet(playerid) return SletMenu(playerid);
CMD:oillist(playerid)
{
	global_str = "Verslas\tNaftos atsargos\tSavininkas\n";
	for new i; i < sizeof NeftBizID; i++ do
		f(global_str, 1250, "%s[%d] Verslo numeris: %d\t{AEF7A6}%d/1000000 litru{FFFFFF}\t[%s]\n",
			global_str, i, NeftBizID[i], BizData[NeftBizID[i]][bProducts], BizData[NeftBizID[i]][bOwner]);
	f(mysql_string, 100, "Is viso naftos greziniu: %d | Veikia: %d", sizeof NeftBizID, sizeof NeftBizID);
	return SPD(playerid, 1727, DIALOG_STYLE_TABLIST_HEADERS, mysql_string, global_str, !"Isrinkti", !"Atsaukti");
}
cmd:sobes(playerid)
{
	global_str = "Organizacija\tPlanuojama\tVieta\n";
	for(new i = 1; i < MAX_ORGS; i++)
	{
		switch(i)
		{
			case TEAM_LSPD,TEAM_LVPD,TEAM_RCPD,TEAM_FBI,TEAM_ARMY,TEAM_ARMYLV,TEAM_LICENSERS,TEAM_SFPD,TEAM_M4C,TEAM_MEDICLV,TEAM_MERIALS,TEAM_BANK,TEAM_RADIO,TEAM_RADIOSF,TEAM_RADIOLV,TEAM_ARMYSF,TEAM_STRAH:
			{
				f(global_str, 1500,"%s{FFFFFF}- %s\t{CBEC39}%s\t%s\n", global_str, OrgInfo[i][oName], SobesStatus[i] ? (SobesTime[i]):("{D2D0C9}Nenumatyta"), SobesStatus[i] ? (SobesMesto[i]):("{D2D0C9}Nepaskirta!"));
			}
		}
	}
	SPD(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{E4DB5E}Pokalbiai", global_str, "Supratau", "");
	return true;
}
CMD:gnews(playerid)
{
    if !IsAtFrakcia(playerid) *then return false;
    if PI[playerid][pRank] < 9 && PI[playerid][pLeader] == 0 *then return SCM(playerid,COLOR_RED,!"Jus nesate lyderis arba 9 rango");
    if PI[playerid][pMuteTime] > 0 *then return SCM(playerid, 0xAFAFAFFF, !"[Klaida] Jus turite MUTE!");
	SPD(playerid,3443,1,"","{FFFFFF}Nurodykite {A5F253}laika{FFFFFF}, kada norite paskirti pokalbi!\n\nParasykite {A5F253}valandas, minutes ir vieta{FFFFFF} per kableli!\n\nPavyzdys:[ {F2DF53}19,20,LSPD{FFFFFF} ]\n\n", !"Priimti", !"Atsaukti");
    return 1;
}
CMD:herbas(playerid, params[])
{
	new biz = BizEntered[playerid];
	if biz == -1 or !(BizData[biz][bState] == 1) *then
		return SCM(playerid, COLOR_GREY, !"Jus turite buti bare!");
	else if sscanf(params, "ud", params[0], params[1]) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite /herbas [zaidejo ID] [statymas]");
	else if !(1 <= params[1] <= (1000000000)) *then
		return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Minimali statymo suma yra 1, maksimali - 1.000.000.000 EURO.");
	else if GetCount(playerid, 615) < params[1] or GetCount(params[0], 615)< params[1] *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Kazkam is jusu truksta pinigu!");
	else if(params[0] == playerid)
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Negalite pateikti pasiulymo sau!");
	else if(!ProxDetectorS(7.0, playerid, params[0]))
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF}Jus esate toli nuo zaidejo!");
	else if (OrelName[playerid] != INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF}Jus jau pateikete pasiulyma!");
	else if OrelName[params[0]] != INVALID_PLAYER_ID *then
		return false;
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 506.1710,-69.5010,999.6721) || IsPlayerInRangeOfPoint(playerid, 5.0, 493.8653,-17.5930,1001.1519) || IsPlayerInRangeOfPoint(playerid, 5.0, -2652.9382,1410.2617,906.2734))
	{
		ZapretOrel[playerid] = 1;
		ZapretOrel[params[0]] = 1;
		OrelName[playerid] = params[0];
		OrelName[params[0]] = playerid;
		OrelMoney[params[0]] = params[1];
		OrelMoney[playerid] = params[1];
		StatusMoneta[playerid] = "Herb.";
		StatusMoneta[params[0]] = "Skai.";
		SCMF(playerid, COLOR_VALIK,"[Pranesimas]{FFFFFF} Jus pasiulete zaidejui {FFFF00}%s{FFFFFF} suzaisti 'Skaicius ir Herbas', statymas: {FFFF00}%d${FFFFFF}.", PN(params[0]), params[1]);
		SCM(playerid, COLOR_VALIK, !"[Uzuomina]{AFAFAF} (/or_cancel - atsaukti pasiulyma)");
		f(global_str, 300,"{FFFF00}%s{FFFFFF} siulo suzaisti ''Skaicius ir Herbas''.\nStatymas: {FFFF00}%d${FFFFFF}\nZaidejas pasirinko: {FFFF00}Herbas{FFFFFF}",PN(playerid),params[1]);
	 	SPD(OrelName[playerid], 3724, DIALOG_STYLE_MSGBOX, !"Skaicius ir Herbas", global_str, !"Zaisti", !"Atsaukti");
	}
	else
		SCM(playerid,COLOR_GREY, !"Jus turite buti bare!");
	return true;
}
CMD:skaicius(playerid, params[])
{
	new biz = BizEntered[playerid];
	if biz == -1 or !(BizData[biz][bState] == 1) *then
		return SCM(playerid, COLOR_GREY, !"Jus turite buti bare!");
	else if sscanf(params, "ud", params[0], params[1]) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite /skaicius [zaidejo ID] [statymas]");
	else if !(1 <= params[1] <= (1000000000)) *then
		return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Minimali statymo suma yra 1, maksimali - 1.000.000.000 EURO.");
	else if GetCount(playerid, 615) < params[1] or GetCount(params[0], 615) < params[1] *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Kazkam is jusu truksta pinigu!");
	else if(params[0] == playerid)
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Negalite pateikti pasiulymo sau!");
	else if(!ProxDetectorS(7.0, playerid, params[0]))
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF}Jus esate toli nuo zaidejo!");
	else if (OrelName[playerid] != INVALID_PLAYER_ID)
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF}Jus jau pateikete pasiulyma!");
	else if OrelName[params[0]] != INVALID_PLAYER_ID *then
		return false;
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 506.1710,-69.5010,999.6721) || IsPlayerInRangeOfPoint(playerid, 5.0, 493.8653,-17.5930,1001.1519) || IsPlayerInRangeOfPoint(playerid, 5.0, -2652.9382,1410.2617,906.2734))
	{
		ZapretOrel[playerid] = 1;
		ZapretOrel[params[0]] = 1;
		OrelName[playerid] = params[0];
		OrelName[params[0]] = playerid;
		OrelMoney[params[0]] = params[1];
		OrelMoney[playerid] = params[1];
		StatusMoneta[playerid] = "Herb.";
		StatusMoneta[params[0]] = "Skai.";
		SCMF(playerid, COLOR_VALIK, "[Pranesimas]{FFFFFF} Jus pasiulete zaidejui {FFFF00}%s{FFFFFF} suzaisti 'Skaicius ir Herbas', statymas: {FFFF00}%d BTC{FFFFFF}.", PN(params[0]), params[1]);
		SCM(playerid, COLOR_VALIK, !"[Uzuomina]{AFAFAF}(/or_cancel - atsaukti pasiulyma)");
		f(global_str, 300, "{FFFF00}%s{FFFFFF} siulo suzaisti ''Skaicius ir Herbas''.\nStatymas: {FFFF00}%d BTC{FFFFFF}\nZaidejas pasirinko: {FFFF00}Skaicius{FFFFFF}", PN(playerid), params[1]);
	 	SPD(OrelName[playerid], 3724, DIALOG_STYLE_MSGBOX, "Skaicius ir Herbas" ,global_str, !"Zaisti", !"Atsaukti");
	}
	else SCM(playerid,COLOR_GREY, !"Jus turite buti bare!");
	return true;
}
CMD:or_cancel(playerid)
{
	if(OrelName[playerid] == INVALID_PLAYER_ID) return 1;
	OrelMoney[playerid] = 0;
	ZapretOrel[playerid] = 0;
	ZapretOrel[OrelName[playerid]] = 0;
	StatusMoneta[playerid] = "0";
	StatusMoneta[OrelName[playerid]] = "0";
	SCM(OrelName[playerid], COLOR_VALIK, !"[Informacija] {FFFFFF}Zaidejas atsisake statymo!");
	SCMF(playerid, COLOR_VALIK, "[Pranesimas]{FFFFFF} Kvietimas i zaidima \"Skaicius ir Herbas\" su {FFFF00}%s{FFFFFF} atmestas.", OrelName[playerid]);
	OrelName[OrelName[playerid]]= INVALID_PLAYER_ID;
	OrelName[playerid] = INVALID_PLAYER_ID;
	return 1;
}
CMD:settag(playerid, params[])
{
	if(!PI[playerid][pMember]) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus nesate organizacijos narys.");
	if(PI[playerid][pRank] < 9 && !PI[playerid][pLeader]) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Prieinama tik organizacijos lyderiui/pavaduotojui");
	if(sscanf(params,"us[32]",params[0],params[1])) return SCM(playerid, COLOR_VALIK, !"Naudokite:{FFFFFF} /settag [zaidejo ID/Nick] [naujas tag (iki 15 simboliu)]");
	if(!IsPlayerLogged{params[0]}) return 1;
	if PI[playerid][pAdmin] *then return 0;
	if IsADomen(params[1]) || IsAIP(params[1]) *then return 0;
	if(PI[playerid][pMember] != PI[params[0]][pMember]) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus esate skirtingose organizacijose.");
	if(strlen(params[1]) < 3) return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Tag ilgis turi buti didesnis nei 3 simboliai.");
	f(global_str, 145, "[Informacija]{FFFFFF} %s nustate jums nauja tag: %s",PN(playerid),params[1]);
	SCM(params[0], COLOR_VALIK, global_str);
	f(global_str, 145, "[Informacija]{FFFFFF} Jus nustatete zaidejui %s nauja tag: %s",PN(params[0]),params[1]);
	SCM(playerid, COLOR_VALIK, global_str);
	SetString(PI[params[0]][pTag],params[1]);
	UpdatePlayerDataStr(params[0], "Tag", PI[params[0]][pTag]);
	return 1;
}
CMD:trunk(playerid, params[])
{
	new vehicleid;
	if sscanf(params, "d", vehicleid) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /trunk [id]");
	if !IsAOwnableCar(vehicleid) || !IsValidVehicle(vehicleid) *then return false;
	if !TrunkInfo[vehicleid][tOpen] *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Bagazine dabar uzdaryta!");
	new Float:X,Float:Y,Float:Z;
	GetVehiclePos(vehicleid, X,Y,Z);
	if !IsPlayerInRangeOfPoint(playerid, 5.0, X,Y,Z) *then return false;
	trunk[playerid] = vehicleid;
	return OtherInvOpen(playerid, 3, vehicleid);
}
CMD:tet(playerid)
{
	if GetPlayerInterior(playerid) || GetPlayerVirtualWorld(playerid) *then return false;
	new Float:X,Float:Y,Float:Z;
	new Float:angle;
	foreach(new i: Vehicle)
	{
		if !IsValidVehicle(i) || IsABike(i) *then continue;
		GetVehicleShiftPos(i,1,X,Y,Z,2.0);
		angle = GetPlayerAngleToPoint(playerid, X, Y);
		if IsPlayerInRangeOfPoint(playerid,2,X,Y,Z) *then
		{
			if angle >= -55 && angle <= 55 *then {
			    if(PI[playerid][pLevel] < 10) return SCM(playerid, COLOR_GREY, "[Klaida] Norint naudotis bagazine, reikia tureti 10 lygi!");
				f(global_str, 256, "{C62929}Atidaryti asmenini inventoriu\n{FFFFFF}Bagazine: %s\n{C62929}Pazvelgti i bagazine", !TrunkInfo[i][tOpen] ? "{C62929}[Uzdaryta]{FFFFFF}":"{56A736}[Atidaryta]{FFFFFF}");
				SPD(playerid, 1966, 2, "{FFFFFF}Bagazine | {ae433d}Masina", global_str, "Priimti", "Atsaukti");
				return SetPVarInt(playerid, "openCARTRUNK", i);
			}
		}
	}
	return true;
}
CMD:rewards(playerid)
{
	SPD(playerid, 5060, 2, !"Visi pasiekimai", !"\
	{FFFFFF}Perziureti visus {5afad5}kasdienius bonusus\n\
	{FFFFFF}Perziureti visus {88a862}globalius pasiekimus\n\
	{FFFFFF}Perziureti visus pasiekimus darbe\n\
	Perziureti visus frakciju pasiekimus\n\
	Perziureti pasiektu pasiekimu zurnala", !"Isrinkti", !"Atsaukti");
	return 1;
}
CMD:rcveh(playerid)
{
	if !IsACarInv( ItemsInfo[AksSlot[playerid][0][2]][ItemModel] ) *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Jus neturite ant saves devimo nuotoliniu budu valdomu transporto!");
	else if GetPlayerState(playerid) == 2 or !(GetPlayerVirtualWorld(playerid) == 0) or !(GetPlayerInterior(playerid) == 0) or AnimPlayed{playerid} *then
		return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Transportu naudotis galima tik stovint ant koju");
	else if RC_KillTimer[playerid] > Global_Time *then
		return SCMF(playerid, COLOR_RED, "[Klaida] {FFFFFF}Jums draudziama naudoti nuotoliniu budu valdoma transporta. Liko %s", Convert(RC_KillTimer[playerid] - Global_Time));
	new Float:A;
	GetPlayerPos(playerid, DeathPos[playerid][0], DeathPos[playerid][1], DeathPos[playerid][2]);
	GetPlayerFacingAngle(playerid, A);
	PI[playerid][plveh] = J_AddStaticVehicleEx(ItemsInfo[AksSlot[playerid][0][2]][ItemModel], DeathPos[playerid][0], DeathPos[playerid][1], DeathPos[playerid][2], A);
 	VehicleInfo[PI[playerid][plveh]][vEngine] = true;
 	Fuel[PI[playerid][plveh]] = 100.0;
 	SetVehicleParamsEx(PI[playerid][plveh], 1, 0,0,0,0,0,0);
 	PutPlayerInVehicle(playerid, PI[playerid][plveh], 0);
 	RCzone[playerid] = GangZoneCreate(DeathPos[playerid][0]+150,  DeathPos[playerid][1]+150, DeathPos[playerid][0]-150, DeathPos[playerid][1]-150);
 	GangZoneShowForPlayer(playerid, RCzone[playerid], 0x96f78d99);
 	RCzoneTimer[playerid] = 10;
 	return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"{FFFFFF}Nuotoliniu budu valdomos technikos naudojimo taisykles:\n{BE5555}- Draudziama zaloti zaidejus bet kokiais budais\n- Draudziama iseiti uz pazymetu ribu (zemelapyje)\n\n{DAD858}Iseiti naudokite 'F' arba 'ENTER'", !"Iseiti", !"");
}
CMD:freeleaders(playerid)
{
	global_str = "";
	new str[35];
	for(new i = 1; i < MAX_ORGS; i++)
	{
	    if(GetString(OrgInfo[i][oLeader], "Laisva"))
	    {
	        f(str, sizeof(str), "{FFFFFF}%s\n", OrgInfo[i][oName]);
	        strcat(global_str, str);
		}
	}
	SPD(playerid, 0, DIALOG_STYLE_LIST, !"{FFFF00}Laisvos organizacijos", global_str, !"Uzdaryti", !"");
	return 1;
}
CMD:trmenu(playerid)
{
	if(GetTrailer(playerid) == -1 && PI[playerid][pTrailerKey] == -1) return SCM(playerid, COLOR_ORANGE, !"Klaida: {FFFFFF}Jus neturite priekabos!");
	new pric[15];
	new ID = PI[playerid][pTrailerKey];
	if(TrailerVeh[playerid] != INVALID_VEHICLE_ID)
	{
	    if(IsTrailerAttachedToVehicle(TrailerVeh[playerid])) pric = "Pastatyti";
		else pric = "Prikabinti";
	}
	new trnal[50];
    if(TrailerInfo[ID][tLocks]) trnal = "{9ACD32}Atrakinti {FFFFFF}durys";
    else trnal = "{FF6347}Uzrakinti {FFFFFF}durys";
    if(!TrailerInfo[ID][tParked]) trnal = "{FFFFFF}Atsikabinti priekaba";
	if(TrailerInfo[ID][tParked] && !IsTrailerAttachedToVehicle(TrailerInfo[ID][tIDcar])) pric = "Prikabinti";
	if(TrailerInfo[ID][tObj] == INVALID_STREAMER_ID && TrailerInfo[ID][tObjPark] == INVALID_STREAMER_ID) pric = "Prikabinti";
	f(global_str, 259, "%s priekaba\n\
	%s\n\
	Parduoti priekaba prekeiviui\n\
	Parduoti priekaba zaidejui\n\
	{FAAC58}Rasti priekaba\n\
	{FFFFFF}Sumoketi mokescius (suma: %d$ / 48000$)", pric, trnal, TrailerInfo[ID][tNalog]);
	SPD(playerid, 4343, DIALOG_STYLE_LIST, !"{FAAC58}Priekabos meniu", global_str, !"Isrinkti", !"Uzdaryti");
	return true;
}
CMD:captchatop(playerid) return SPD(playerid, 9929, DIALOG_STYLE_LIST, !"Pasirinkite formata", !"{D08D94}В»{FFFFFF} TOP 30 per paskutine valanda\n{D08D94}В»{FFFFFF} TOP 30 per diena\n{D08D94}В»{FFFFFF} TOP 30 per savaite\n{D08D94}В»{FFFFFF} TOP 50 per menesi\n{D08D94}В»{FFFFFF} Asmeninis TOP ( jusu geriausio laiko sarasas )", !"Isrinkti", !"Atsaukti");
CMD:captcha(playerid) return CreateCaptcha_BOT(playerid, 3);
CMD:faminvite(playerid, params[])
{
	new id = FP_Data[playerid][F_FAMILY_ID], player;
	if id == -1 *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai seimai!");
	else if !GetFamilyAcces(PN(playerid), id) *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Si komanda prieinama tik lyderiui ir pavaduotojui!");
	else if strlen(GetFamilyDataString(id, "slogan")) < 3 *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Seima dar nera nustatyta! Naudokite /fammenu");
	else if sscanf(params, "u", player) *then return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /faminvite [id]");
	if player == INVALID_PLAYER_ID *then return false;
	if !ProxDetectorS(5.0, playerid, player) *then
		return callcmd::fammenu(playerid), SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ivyko klaida, zaidejas yra per toli nuo jusu!");
	else if !(FP_Data[player][F_FAMILY_ID] == -1) *then
		return callcmd::fammenu(playerid), SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ivyko klaida, zaidejas priklauso kitai seimai!");
	else if PI[player][pLevel] < 2 *then
	    return callcmd::fammenu(playerid), SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ivyko klaida, zaidejas turi buti 2 lygio!");
	else if Int_GetPlayerData(player, !"FamInvited") > Global_Time *then
        return callcmd::fammenu(playerid), SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ivyko klaida, jus jau pakvietete si zaideja!");
	SCMF(player, COLOR_ORANGE, "[Informacija] {FFFFFF}Zaidejas %s[%d] kviecia jus i seima: {c8ec36}%s.", PN(playerid), playerid, GetFamilyDataString(id, "name"));
	SCM(player, -1, !"Iveskite {c8ec36}/acceptfam{FFFFFF}, kad priimtumete pasiulyma, arba {ec4636}/cancelfam{FFFFFF}, kad atmestumete.");
	SCMF(playerid, COLOR_ORANGE, "[Informacija] {FFFFFF}Jus sekmingai pasiulete %s[%d] prisijungti prie jusu seimos!", PN(player), player);
	SetPVarInt(player, !"FamInvitedIDInvite", playerid);
	SetPVarInt(player, !"FamInvited", Global_Time + 120);
	return false;
}
CMD:famuninvite(playerid, params[])
{
	new id = FP_Data[playerid][F_FAMILY_ID];
	if id == -1 *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai seimai!");
	else if !GetFamilyAcces(PN(playerid), id) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Si komanda prieinama tik lyderiui ir pavaduotojui!");
	extract params -> new player:target; else
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Naudokite: /famuninvite [id]");
	if target == INVALID_PLAYER_ID *then
		return false;
	if GetFamilyAcces(PN(target), id) *then return false;
	if !(FP_Data[target][F_FAMILY_ID] == FP_Data[playerid][F_FAMILY_ID]) *then
		return callcmd::fammenu(playerid), SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Ivyko klaida, zaidejas nepriklauso jusu seimai!");
	f(global_str, 128, "{%s}[Seima (Naujienos)] %s[%d]: {B9C1B8}ismete jus is seimos: %s[%d]!", FamilyColor[GetFamilyDataInt(id, "color")], PN(playerid), playerid, PN(target), target);
	SendFamilyMessage(id, global_str);
	SPDF(target, 0, DIALOG_STYLE_MSGBOX, !"Informacija", "{FFFFFF}%s[%d] ismete jus is seimos: %s.", !"Priimti", !"", PN(playerid), playerid, GetFamilyDataString(id, "name"));
	UpdatePlayerDataInt(target, "Family", FP_Data[target][F_FAMILY_ID] = -1);
	if FamilyText[target] *then
	    DestroyDynamic3DTextLabel(FamilyText[target]),
	    FamilyText[target] = Text3D:false;
	return 1;
}
CMD:setfrank(playerid, data[])
{
	new id = FP_Data[playerid][F_FAMILY_ID];
	if id == -1 *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai seimai!");
	else if !GetFamilyAcces(PN(playerid), id) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Si komanda prieinama tik lyderiui ir pavaduotojui!");
	extract data -> new player:target, rang; else
		return SCM(playerid, COLOR_VALIK, !"Naudokite: {FFFFFF}/setfrank [zaidejo ID/Nick] [naujas rangas: nuo 1 iki 10]");
	if !IsPlayerOnline(target) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Zaidejas neprisijunges arba neautorizuotas.");
	else if !(1 <= rang <= 10) *then
		return SCM(playerid, COLOR_VALIK, !"Naudokite: {FFFFFF}/setfrank [zaidejo ID/Nick] [naujas rangas: nuo 1 iki 10]");
	else if !(FP_Data[playerid][F_FAMILY_ID] == FP_Data[target][F_FAMILY_ID]) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Sis zaidejas nepriklauso jusu seimai.");
	SCMF(playerid, COLOR_LIGHTBLUE, "[Family Rank]{FFFFFF} Jus pakeitete %s i %s (Buvo: %s)", PN(target), GetFamilyDataArrayString(id, "rank", rang), GetFamilyDataArrayString(id, "rank", FP_Data[target][F_FAMILY_RANG]));
	SCMF(target, COLOR_LIGHTBLUE, "[Family Rank]{FFFFFF} Seimos lyderis %s pakeite jusu ranga i %s (Buvo: %s)", PN(playerid), GetFamilyDataArrayString(id, "rank", rang), GetFamilyDataArrayString(id, "rank", FP_Data[target][F_FAMILY_RANG]));
	return UpdatePlayerDataInt(target, "FamilyRang", FP_Data[target][F_FAMILY_RANG] = rang);
}
CMD:acceptfam(playerid)
{
	if Int_GetPlayerData(playerid, !"FamInvited") < Global_Time *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums niekas nesiunte kvietimo prisijungti prie seimos!");
	new player = Int_GetPlayerData(playerid, !"FamInvitedIDInvite");
	if !ProxDetectorS(5.0, playerid, player) *then
		return SCM(player, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate per toli nuo zaidejo, kuri pakvietete i seima!"),
 	  		   SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus esate per toli nuo zaidejo, kuris pakviete jus i seima!"),
			   DeletePVar(playerid, !"FamInvited");
	SQL("UPDATE accounts SET Family = %d, FamilyRang = 1 WHERE ID = %d;", FP_Data[playerid][F_FAMILY_ID] = FP_Data[player][F_FAMILY_ID], PI[playerid][pID]);
	new id = FP_Data[playerid][F_FAMILY_ID];
	f(global_str, 145, "{%s}[Seima (Naujienos)] %s[%d]: {B9C1B8}pakviete nauja seimos nari: %s[%d]!", FamilyColor[GetFamilyDataInt(id, "color")], PN(player), player, PN(playerid), playerid);
	SendFamilyMessage(id, global_str);
    SetString(PI[playerid][pFamPrefix], "None");
    SetString(PI[playerid][pFamPrefixColor], "ffffff");
	UpdatePlayerDataStr(playerid, "FamPrefix", PI[playerid][pFamPrefix]), UpdatePlayerDataStr(playerid, "FamPrefixColor", PI[playerid][pFamPrefixColor]);
	SCMF(player, COLOR_ORANGE, "[Informacija] {FFFFFF}%s[%d] prieme jusu kvietima prisijungti prie seimos!", PN(playerid), playerid);
	SCMF(playerid, COLOR_ORANGE, "[Informacija] {FFFFFF}Jus sekmingai priemete pasiulyma prisijungti prie seimos: {e39f20}%s", GetFamilyDataString(id, "name"));
	SCM(playerid, -1, !"Naudokite /fammenu noredami gauti daugiau informacijos.");
	DeletePVar(playerid, !"FamInvitedIDInvite"), DeletePVar(playerid, !"FamInvited");
	return UpdateFamilyText(playerid, id);
}
CMD:cancelfam(playerid)
{
	if Int_GetPlayerData(playerid, !"FamInvited") < Global_Time *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums niekas nesiunte kvietimo prisijungti prie seimos!");
	SCMF(Int_GetPlayerData(playerid, !"FamInvitedIDInvite"), COLOR_RED, "[Informacija] {FFFFFF}Zaidejas %s[%d] atmete jusu pasiulyma prisijungti prie seimos!", PN(playerid), playerid);
	SCM(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus sekmingai atsisakete prisijungti prie seimos!");
	DeletePVar(playerid, !"FamInvited");
	return DeletePVar(playerid, !"FamInvitedIDInvite");
}
CMD:famdisband(playerid)
{
	if FP_Data[playerid][F_FAMILY_ID] == -1 *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai seimai!");
	new id = FP_Data[playerid][F_FAMILY_ID];
	if !GetString(GetFamilyDataString(id, "ownername"), PN(playerid)) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Pasiekiama tik lyderiui ir pavaduotojui!");
	return SPD(playerid, 8887, DIALOG_STYLE_MSGBOX, !"", !"\n\n{FFFFFF}Ar tikrai norite isformuoti savo seima?\n\n{633169}Jei ja isformuosite, visi joje esantys zaidejai bus ismesti, o jus\nprarasite lyderyste savo seimoje ir negalesite jos valdyti!\n\n", !"Priimti", !"Atsaukti");
}
CMD:fammenu(playerid)
{
	if FP_Data[playerid][F_FAMILY_ID] == -1 *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai seimai!");
	return ShowFamilyDialog(playerid, 0, FP_Data[playerid][F_FAMILY_ID]);
}
CMD:fam(playerid, params[])
{
	new id = FP_Data[playerid][F_FAMILY_ID];
	if FP_Data[playerid][F_FAMILY_ID] == -1 *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai seimai!");
	else if sscanf(params, "s[128]", global_str) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /fam [text]");
	else if Int_GetPlayerData(playerid, "nakaztimer") > Global_Time *then return SCM(playerid, COLOR_RED, !"[Klaida]{FFFFFF} Ne FLOODink!");
	Int_SetPlayerData(playerid, "nakaztimer", Global_Time + 5);
	if(GetString(PI[playerid][pFamPrefix], "None"))
	{
		f(global_str, 145, "{%s}[Seima] [%s] %s[%d]:{B9C1B8} %s", FamilyColor[GetFamilyDataInt(id, "color")], GetFamilyDataArrayString(id, "rank", FP_Data[playerid][F_FAMILY_RANG]), PN(playerid), playerid, global_str);
		SendFamilyMessage(id, global_str);
	}
	else
	{
		f(global_str, 145, "{%s}[Seima] {%s}[%s]{%s} [%s] %s[%d]:{B9C1B8} %s", FamilyColor[GetFamilyDataInt(id, "color")],  PI[playerid][pFamPrefixColor], PI[playerid][pFamPrefix], FamilyColor[GetFamilyDataInt(id, "color")], GetFamilyDataArrayString(id, "rank", FP_Data[playerid][F_FAMILY_RANG]), PN(playerid), playerid, global_str);
		SendFamilyMessage(id, global_str);
	}
	return 1;
}
CMD:buyfam(playerid)
{
	new id = FP_Data[playerid][F_FAMILY_ID];
	if id == -1 *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai seimai!");
	else if !GetFamilyAcces(PN(playerid), id) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Si komanda pasiekiama tik lyderiui ir pavaduotojui!");
	else if !(GetFamilyDataInt(id, "kv_id") == -1) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jusu seima jau turi seimos buta.");
	new kv = FP_Data[playerid][F_FAMILY_PICK_KV];
	if kv == -1 or !GetPlayerDistanceFromPickup(2.0, playerid, FKV_Data[kv][kvPickup]) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus turite buti salia seimos buto, kuri norite isigyti.");
	else if GetFamilyDataInt(id, "reputation") < 10000 *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jusu seimos saskaitoje yra maziau nei 10000 reputacijos tasku.");
	SQL("UPDATE family_kv SET family_id = %d WHERE ID = %d;", id, FKV_Data[kv][kvSqlId]);
	UpdateFamilyData(id, "kv_id = %d, reputation = `reputation` - 10000", kv);
	SendFamilyMessage(id, (str_f("{%s}[Seima (Naujienos)] %s[%d]: {FFFFFF}nupirko buta seimai!", FamilyColor[GetFamilyDataInt(id, "color")], PN(playerid), playerid)));
	foreach(Player, i)
	{
		if !(id == FP_Data[i][F_FAMILY_ID]) *then continue;
		FP_Data[i][F_FAMILY_SPAWN_DATA] = kv;
		FP_Data[i][F_FAMILY_SPAWN_TYPE] = 0;
	}
	UpdateFamilyData(id, "`spawn_type` = 0, `spawn_data` = %d", kv);
	FKV_Data[kv][kvFamilyId] = id;
	UpdateFamilyKV(kv);
	return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"", !"\n \n{FFFFFF}Jus sekmingai nupirkote buta savo seimai.\n ", !"Uzdaryti", !"");
}
alias:vipmenu("vip", "vip_menu");
CMD:vipmenu(playerid)
{
	if PI[playerid][pVIP] < 7 *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jusu VIP statusas mazesnis nei SAG."), SCM(playerid, COLOR_YELLOW, "Noredami isigyti unikalu VIP statusa, iveskite: /donate");
	global_str = "";
	for new i; i < sizeof VipMenu_Data; i++ do
		strcat(global_str, (str_f("{8400c2}%d. {FFFFFF}%s\t%s\n", i + 1, VipMenu_Data[i][vmFunction], VipMenu_Data[i][vmVIPName])));
	return SPD(playerid, 2760, DIALOG_STYLE_TABLIST, !"{FFFFFF}Pasirinkite punkta | {8400c2}VIP meniu", global_str, !"Isrinkti", !"Uzdaryti");
}
CMD:hotel(playerid)
{
	if PI[playerid][pFrom] == -1 *then return SCM(playerid, -1, !">> {633169}Jus negyvenate viesbutyje");
	return SPDF(playerid, 342, DIALOG_STYLE_LIST, !"Meniu", "1. Statusas: %s{FFFFFF}\n2. Apmokejimas uz apgyvendinima.\n3. Atsisakyti nuomos.", !"Priimti", !"Atsaukti", RoomOtel[PI[playerid][pFrom]][otRoomStatus] ? "{B22C2C}[Uzrakintas]":"{57B22C}[Atrakintas]");
}
CMD:smug(playerid)
{
	if !AirDrop[air_Status] *then
		return SCM(playerid, COLOR_OLDRED, !"[Informacija]{FFFFFF} Kontrabandos konteineris dar neismestas.");
	EnableGPSForPlayer(playerid, AirDrop[air_PosX], AirDrop[air_PosY], AirDrop[air_PosZmap]);
	return SCM(playerid, COLOR_VALIK, !"[Informacija]{FFFFFF} Kontrabandos konteinerio koordinates pazymetos jusu GPS.");
}
CMD:bilet(playerid)
{
	f(global_str, 1954, "\
	{FFFFFF}Laba diena, gerbiamas pradedanciausias zaidejau arba jau projekto turtuolis.\n\
	{FFFFFF}Musu komanda jums parenge {42B02C}Nauja premiju programa{FFFFFF}, kuri pades jums dar greiciau atrasti naujienas serveryje!\n\n\
	{42B02C}Uz kiekviena {ffffff}valanda{42B02C}, praleista serveryje, jums bus suteiktas {ffffff}1 zaidimo bilietas{42B02C}, uz kuri galesite atsiimti viena is vertingu prizu.{ffffff}\n\n\
	{FFFFFF}Zemiau pateikiamas sarasas zaidimu prizu, kuriuos galima gauti:\n\n\
	{42B02C}[1]{FFFFFF} Vaizdo plokste [Random 1 - 4 lygio] ({FFFF00}1 %%{ffffff})\n\
	{42B02C}[2]{FFFFFF} Unikalus \"{FF0000}DIAMOND{FFFFFF}\" VIP ({FFFF00}1 %%{ffffff})\n\
	{42B02C}[3]{FFFFFF} Tepalas vaizdo plokstes spartinimui [Nuo 1 iki 2 vnt.] ({FFFF00}1 %%{ffffff})\n\
	{42B02C}[4]{FFFFFF} Vaizdo plokstes ausinimo skystis [Nuo 1 iki 2 vnt.] ({FFFF00}1 %%{ffffff})\n\
	{42B02C}[5]{FFFFFF} Masina \"Sultan\" ({FFFF00}10 %%{ffffff})\n\
	{42B02C}[6]{FFFFFF} Masina \"Skydas\" ({FFFF00}10 %%{ffffff})\n\
	{42B02C}[7]{FFFFFF} Masina \"Masina su radijo valdymu\" ({FFFF00}10 %%{ffffff})\n\
	{42B02C}[8]{FFFFFF} Modifikacija Kupidonas ({FFFF00}10 %%{ffffff})\n\
	{42B02C}[9]{FFFFFF} Modifikacija Demonas #2 ({FFFF00}10 %%{ffffff})\n\
	{42B02C}[10]{FFFFFF} Trys atsitiktiniai skinai ({FFFF00}1 %%{ffffff})\n\
	{42B02C}[11]{FFFFFF} 20.000$ ({FFFF00}36 %%{ffffff})\n\
	{42B02C}[12]{FFFFFF} 100 EURO ({FFFF00}9 %%{ffffff})\n\n\
	Noredami isbandyti savo laime, jums reikia 10 bilietu!\n\
	{FFFFFF}Siuo metu turite {42B02C}%d {ffffff}bilietus naudoti.", PI[playerid][pBilets]);
	return SPD(playerid, 15500, DIALOG_STYLE_MSGBOX, (str_f("{cccccc}Premiju programa | {ae433d}"Mode_City" Gyvenimas ", Mode_City)), global_str, !"Atsiimti", !"Uzdaryti");
}
alias:memberbonus("mbonus");
cmd:memberbonus(playerid)
{
    if !PI[playerid][pMember] *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nesate organizacijos narys!");
    global_str = "{8400c2}Apdovanojimas\t{8400c2}Reikia suzaisti\t{FFFF00}Statusas\n";
	for new i; i < sizeof MemberBonusData; i++ do {
		strcat(global_str, (str_f("{FFFF00}[%d]{FFFFFF} %s\t%dval.\t%s\n", i + 1, MemberBonusData[i][mbonusName],  MemberBonusData[i][mbonusCost], PI[playerid][pMemberBonusTake][i] ? "{cccccc}Jau gauta": PI[playerid][pMemberPlayHours] < MemberBonusData[i][mbonusCost] ? "{fe4e4e}Nepasiekiama":"{00FF00}Galima gauti")));
	}
	return SPD(playerid, 25120, DIALOG_STYLE_TABLIST_HEADERS, (str_f("{8400c2}Frakcijos {FFFFFF}premiju sistema | Jus suzaidete: {8400c2}%dval.", PI[playerid][pMemberPlayHours])), global_str, !"Atsiimti", !"Atsaukti");
}
CMD:finditem(playerid) return SPD(playerid, 15300, 2, !"{FFFFFF}Daiktu paieska | "Mode_City"", !"{FFFFFF}Visu prieinamu serveriu daiktu sarasas.\n{FFFFFF}Daikto paieska pagal pavadinima (Daikto trumpasis pavadinimas)", !"Toliau", !"Uzdaryti");
cmd:code(playerid, params[])
{
	if sscanf(params, "s[30]", params[0]) *then
		return SCM(playerid, COLOR_OLDRED, !"Naudokite: /code [name]");
	f(mysql_string, 256, "SELECT * FROM gift_use WHERE gift = '%s' AND playerId = '%d' LIMIT 1;", params[0], PI[playerid][pID]);
	mysql_tquery(mysql, mysql_string, "setgiftusage", "ds", playerid, params[0]);
	return false;
}
/*ADM-Tools (kad ne FLOODintu Nezinoma komanda)*/
cmd:lasttp(playerid) return 1;
cmd:iskamen(playerid) return 1;
alias:familymembers("fmembers", "fm");
cmd:familymembers(playerid)
{
	if FP_Data[playerid][F_FAMILY_ID] == -1 *then
	    return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nepriklausote jokiai seimai!");
    new count = 0;
	global_str = !"{b0e73a}(Rangas) Zaidejo Nick [lygis]\t{ffffff}Seimos uzduotis\t{ffffff}Atstumas\t{ffffff}AFK\n\n";
	foreach(Player, i)
	{
		new Float:posfam[3];
		GetPlayerPos(i, posfam[0], posfam[1], posfam[2]);
		if FP_Data[i][F_FAMILY_ID] == FP_Data[playerid][F_FAMILY_ID] *then
			f(mysql_string, 128, "(%d) %s(%d) [%d]\t0/8\t%fm.\t%d\n", FP_Data[i][F_FAMILY_RANG], PN(i), i, PI[i][pLevel], GetPlayerDistanceFromPoint(playerid, posfam[0], posfam[1], posfam[2]), PlayerAFKTime[i]),
			strcat(global_str, mysql_string),
			count++;
	}
	return SPD(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, (str_f("%s (Prisijunge: %d) | {ae433d}Seima", GetFamilyDataString(FP_Data[playerid][F_FAMILY_ID], "name"), count)), global_str, !"Priimti", !"Atsaukti");
}
cmd:mtop(playerid)
{
	if !PI[playerid][pMember] *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nesate organizacijos narys!");
	return mysql_tquery(mysql, "SELECT `NickName`, `TempPlayHours` FROM `accounts` WHERE `Member` != '0' AND `NickName` ORDER BY `TempPlayHours` DESC LIMIT 10", "MemberTop", "d", playerid);
}
CMD:auc(playerid)
{
	global_str = "";
	for new i; i < OWNABLEHOUSES; i++ do
	{
	    if HouseInfo[i][hAuction] *then
	    {
	        AUCTION_HOUSE++;
			strcat(global_str, (str_f("\n{FFFFFF}Namas ID: {FFFF00}%i{FFFFFF} | Yra aukcione! Paskutinis statymas: %i BTC", HouseInfo[i][hID], HouseInfo[i][hAuctionMoney])));
		}
	}
 	if AUCTION_HOUSE == 0 *then
		return strcat(global_str, "{FFFFFF}Siuo metu aukcione nera namu!"), SPD(playerid, 0, 0, "", global_str, "OK", "");
	return SPD(playerid, 0, 0, "", global_str, "OK", "");
}
CMD:payment(playerid)
{
	if PI[playerid][pVIP] < 10 *then
	    return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Si komanda prieinama tik su {ff0000}SuperSAG VIP");
	new cost = 0;
	global_str = "{FFFFFF}";
	for new i; i < MAX_VEHICLES; i++ do
	{
		if !(OwnableCar[i] == INVALID_VEHICLE_ID) *then
		{
			new carid = OwnableCar[i];
			if IsPlayerHaveCar(playerid, carid) && CarInfo[i][cShtrafer] *then
			{
				cost += CarInfo[i][cShtrafer];
				strcat(global_str, (str_f("Transportas %s: $%d\n", GetVehicleName(carid), CarInfo[i][cShtrafer])));
			}
		}
		if i < OWNABLEHOUSES && (GetString(HouseInfo[i][hOwner],PN(playerid)) or IsPlayerTenant(playerid, i)) && HouseInfo[i][hNalog] *then
		{
			cost += HouseInfo[i][hNalog];
			strcat(global_str, (str_f("Namas в„–%d: $%d\n", i, HouseInfo[i][hNalog])));
		}
		if i < OWNABLEBIZES && (GetString(BizData[i][bOwner], PN(playerid)) or GetString(BizData[i][bZam], PN(playerid))) && BizData[i][bLevel] *then
		{
			cost += BizData[i][bLevel];
			strcat(global_str, (str_f("Verslas в„–%d (%s): $%d\n", i, BizData[i][bName], BizData[i][bLevel])));
		}
	}
	SetPVarInt(playerid, "AllNalogBank", cost);
	strcat(global_str, (str_f("{ffffff}\n\n\n{ffffff}Is viso uz viska: {ffff00}$%d%s\n{ffffff}Ar norite sumoketi visus auksciau isvardytus mokescius?", cost, ImprovementsData[playerid][imFreeloader] ? (str_f("\n{42B02C}Kadangi turite patobulinima \'Chaliavscikas\', suma sumazinta perpus:\n{ffffff}Mokesciu suma: {ffff00}$%d", cost/2)):"")));
	if cost != 0 *then
		SPD(playerid, 15252, DIALOG_STYLE_MSGBOX, !"Visu mokesciu mokejimas", global_str, !"Sumoketi", !"Atsaukti");
	else
	    return SCM(playerid, COLOR_VALIK, "Jus neturite skolu!");
	return 0;
}
cmd:dm(playerid)
{
	if(GetPVarInt(playerid, #indm) == 1) return false;
	SCM(playerid, -1, !"{FF6347}[Informacija]{FFFFFF} Noredami iseiti is DM zonos, iveskite '/dm_exit'");
	SetPlayerVirtualWorld(playerid, 1);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, -1404.7185,1490.1533,7.1016);
	SetPVarInt(playerid, #indm, 1);
	return GivePlayerWeapon(playerid, 31, 999), GivePlayerWeapon(playerid, 24, 999);
}
CMD:dm_exit(playerid)
{
    if(GetPVarInt(playerid, #indm) == 0) return false;
	SCM(playerid, -1, !"{FF6347}[Informacija]{FFFFFF} Jus palikote DM zona!");
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, 1985.1310,-1985.1903,13.5469);
	DeletePVar(playerid, #indm);
	return _ResetGun(playerid);
}
cmd:thanks(playerid, params[])
{
	if PI[playerid][pAdmin] && !IsAOwner(playerid) *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Administracijai draudziama naudoti sia komanda!");
	extract params -> new player:id; else
	    return SCM(playerid, COLOR_VALIK, "Naudokite: /thanks [administratoriaus ID/Nick]"), SCMF(playerid, COLOR_GREY, "[Uzuomina] {FFFFFF}Siandien turite {42B02C}%d %s padeku", PI[id][pThanks], PI[id][pThanks] == 1 ? "taska" : "tasku");
	if !PI[playerid][pThanks] *then
		return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Jus neturite padekos tasku.");
	if !PI[id][pAdmin] *then
	    return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Padekos taskus galima suteikti tik administratoriui.");
    if OtvetReport[playerid] != id && PI[playerid][pLevel] < 10 *then
        return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}Sis administratorius neatsake i jusu reporta."), SCM(playerid, COLOR_GREY, "[Uzuomina] {FFFFFF}Zaidejai iki 10 lygio gali dekoti tik tam administratoriui, kuris atsake i ju reporta.");
 	SCMF(playerid, COLOR_VALIK, "[Informacija] {FFFFFF}Jus padekojote administratoriui %s[ID: %d].", PN(id), id);
	SCMF(id, COLOR_VALIK, "[Informacija] {FFFFFF}Zaidejas %s[ID: %d] jums padekojo.", PN(playerid), playerid);
	PI[playerid][pThanks]--;
	UpdatePlayerDataInt(playerid, "Thanks", PI[playerid][pThanks]);
	OtvetReport[playerid] = -1;
	if !PI[playerid][pThanks] *then
	    SCM(playerid, COLOR_GREY, "[Uzuomina] {FFFFFF}Siandien jums baigesi padekos taskai.");
	return AddItem(id, 2467, 1);
}
CMD:bonus(playerid) return ShowBonusMenu(playerid);
CMD:donate(playerid) return ShowADonateMenu(playerid);
CMD:famport(playerid)
{
	if FP_Data[playerid][F_FAMILY_ID] == -1 *then return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Jus nepriklausote jokiai seimai!");
	ShowPlayerDialog(playerid, 0000, 0, "{DC9E6B}Seimu karas",
	"- Sis renginys vyksta karta per valanda kas 15 minuciu!\n\
	- Esme paprasta: nugaleti seima, kuri pradejo uosto uzgrobima, trunka lygiai 5 minutes.\n\
	- Seima uz pergale uoste gauna: 3500 reputacijos ir 25.000.000$ i seimos saskaita.\n\
	\n\
	- Asmuo, kuris padejo seimai uzgrobti uosta, gauna atsitiktini priza.",!"Supratau", !"");
	return EnableGPSForPlayer(playerid, -1390.0710,1482.9603,1.8672);
}
CMD:buy_skin(playerid, params[])
{
    new skin;
	if(PI[playerid][pGetSkins] == 0) return SCM(playerid, -1, "Jus nepirkote sios funkcijos /donate");
    if sscanf(params, "d", skin) *then return SCM(playerid, COLOR_OLDRED, !"Naudokite: /buy_skin [0 - 744]");
   	if !(0 <= skin <= 732) *then return false;
    if(PI[playerid][pSkin] != 18) AddItem(playerid, GetSkinInfo(PI[playerid][pSkin], 3));
	PI[playerid][pSkin] = skin;
	SetPlayerSkinEx(playerid, skin);
	PI[playerid][pGetSkins] = 0;
	return SCM(playerid, -1, "Jus sekmingai nusipirkote skina");
}
CMD:ceftune(playerid)
{
    if GetPlayerState(playerid) != PLAYER_STATE_DRIVER *then
		return SCM(playerid, COLOR_GREY, !"Jus ne uz vairo!");
	SPD(playerid, 8004, DIALOG_STYLE_LIST, !"Tuning meniu", !"Diskai\nHidraulika\nArchangelo tuningas\nSpalva\nVinilai\nAzotas\n{00BFFF}Neonas\n{00BFFF}Zibintai\n{00BFFF}Dumai", !"Isrinkti", !"Atsaukti");
	return 1;
}
CMD:mypromo(playerid)
{
	f(global_str, 128, "SELECT * FROM promo WHERE owner = '%s'", PN(playerid));
	mysql_tquery(mysql, global_str, "MyPromo", "d", playerid);
	return 1;
}
CMD:buyhouse(playerid)
{
	if(!IsPlayerOnline(playerid)) return 1;
	new value;
	for new i; i < OWNABLEHOUSES; i++ do
	{
 		if(i != 0)
   		{
     		if(IsPlayerInRangeOfPoint(playerid,2.0,HouseInfo[i][hEnter_X],HouseInfo[i][hEnter_Y],HouseInfo[i][hEnter_Z]))
       		{
       		    value++;
         		if(GetString(HouseInfo[i][hOwner],"The State"))
				{
				    if(PI[playerid][pLevel] < 6) return SCM(playerid, COLOR_GREY, "[Klaida] Norint isigyti nama, reikia 6 lygio!");
				    InfoHouse[playerid] = i;
					if(GetHouseCost(playerid, i)) return CreateCaptcha_BOT(playerid, 1);
     				else SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jums nepakanka pinigu. Galite papildyti savo saskaita [/donate]");
				}
			}
		}
	}
	if(value == 0) return SCM(playerid, COLOR_GREY, "[Klaida] Reikia buti salia namo!");
	return 1;
}
cmd:settuning(playerid, data[])
{
	if !IsPlayerInAnyVehicle(playerid) *then return SCM(playerid, COLOR_VALIK, "Jus turite buti automobilyje!");
	extract data -> new type, detail, color, size, window; else
		return SCM(playerid, COLOR_VALIK, "Naudokite /settuning [tipas] [detale] [spalva] [skaidrumas] [langas]"),
			SCM(playerid, COLOR_VALIK, "[Informacija] Tipai [0 - Tonavimas] [1 - Vinilai] [2 - Neonas] [3 - Zibintai] [4 - Dumai]"),
			SCM(playerid, COLOR_VALIK, "[Informacija] Tipai [5 - Kapotas] [6 - Spoileris] [7 - Ismetimas] [8 - Diskai]"),
			SCM(playerid, COLOR_VALIK, "[Informacija] SVARBU - detale naudojama tipuose 1,5,6,7,8 - tipuose 1,8 tai vinilu arba disku numeriai nuo 0 iki 19B,17D"),
			SCM(playerid, COLOR_VALIK, "[Informacija] SVARBU - skaidrumas ir langas naudojami tipe 0, nuo 0 iki 255"),
			SCM(playerid, COLOR_VALIK, "[Informacija] SVARBU - tipuose 5,6,7 detale nuo 0 iki 4"),
			SCM(playerid, COLOR_VALIK, "[Informacija] SPALVOS nuo 0 iki 7!");
	new car = GetPlayerVehicleID(playerid);
	if IsAOwnableCar(car) *then
	{
		switch type do
		{
			case 0: vehicle_BlackoutData[GetVehicleID(car)][window][0] = size, vehicle_BlackoutData[GetVehicleID(car)][window][1] = color;
			case 1: vehicle_VinilData[GetVehicleID(car)][0] = detail, vehicle_VinilData[GetVehicleID(car)][1] = color;
			case 2,3,4: vehicle_VisualData[GetVehicleID(car)][type-2] = color;
		}
	}
	switch type do
	{
		case 0: AttachWindowBlackout(car, size, window, color, playerid);
		case 1:	SetVinilCar(car, detail, color, playerid);
		case 2,3,4: SetVehicleTuning(car, type-2, color, playerid);
		case 5,6,7:	SetComponentVehicle(car, type-5, detail);
		case 8:	SetVehicleWheel(car, detail, color, playerid);
	}
	return SaveOwnableCar(GetVehicleID(car));
}
CMD:cl(playerid, params[])
{
    extract params -> new player:targetid; else return SCM(playerid, COLOR_RED, !"Naudokite: /cl [id]");
    if(targetid == INVALID_PLAYER_ID) return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Zaidejas neprisijunges!");
    if(GetPlayerLauncher(targetid)) SCMF(playerid, -1, "Zaidejas %s[%i] {4EFF2B}Naudoja Launcher!", PN(targetid), targetid);
	else SCMF(playerid, -1, "Zaidejas %s[%i] {FF2B2B}Ne naudoja Launcher ir Mobile Launcher!", PN(targetid), targetid);
    return 1;
}
cmd:premium(playerid, params[])
{
	new money,org = GetTeamID(playerid),rang, value_money;
	if(PI[playerid][pLeader] == 0 || PI[playerid][pRank] < 9) return SCM(playerid, COLOR_RED, !"[Klaida]{ffffff} Si komanda jums neprieinama!");
    if(sscanf(params, "dd", money, rang)) return SCM(playerid, COLOR_OLDRED, !"Naudokite: /premium [money] [rang]");
    if(OrgInfo[org][oBank] < money) return SCM(playerid, COLOR_RED, "[Klaida]{FFFFFF} Organizacijos Banke truksta pinigu premijai ismoketi!");
   	if(rang < 1 || rang > 9) return SCM(playerid, COLOR_RED,"[Klaida]{FFFFFF} Neteisingai, iveskite ranga nuo 1 iki 9!");
	foreach(new i: Player)
	{
		if(IsPlayerLogged{i})
		{
			if(IsAtGang(playerid))
			{
				if(GetTeamID(i) == GetTeamID(playerid))
				{
					if(PI[i][pRank] != rang) return SCM(playerid, COLOR_OLDRED, "[Klaida] {FFFFFF}Siuo metu tokiu zmoniu su tokiu rangu nera!");
					{
						value_money = money/i;
						GiveMoney(i, value_money);
						OrgInfo[org][oBank]-=money;
					}
					return 1;
				}
		    }
		    else SCM(playerid, COLOR_RED, "[Klaida]{ffffff} Jums neprieinama, nes si funkcija yra tik Getto Lyderiams ir Pavaduotojams!");
		}
	}
	f(global_str, sizeof(global_str), "%s[ID: %i] skyre premija (%i$) visiems organizacijos nariams, kurie turi %i ranga.", PN(playerid), playerid, money, rang);
	return SendTeamMessage(playerid, COLOR_VALIK, global_str);
}
CMD:premiumplayer(playerid, params[])
{
    new premvp[100],num=1;
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if(PI[i][pVIP]==5)
			{
			    format(premvp,sizeof(premvp),"Savininkai [Premium VIP]: %s[%d]",PN(i),i);
				SCM(playerid,0x969696FF,premvp);
				num++;
			}
		}
	}
	new stringvip[26];
	format(stringvip,sizeof(stringvip),"\nIs viso %d zmoniu.\n\n",(num-1));
	SCM(playerid,0xdf994eFF,stringvip);
}
CMD:titanplayer(playerid, params[])
{
    new premvp[100],num=1;
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if(PI[i][pVIP]==4)
			{
			    format(premvp,sizeof(premvp),"Savininkai [Titan VIP]: %s[%d]",PN(i),i);
				SCM(playerid,0x969696FF,premvp);
				num++;
			}
		}
	}
	new stringvip[26];
	format(stringvip,sizeof(stringvip),"\nIs viso %d zmoniu.\n\n",(num-1));
	SCM(playerid,0xdf994eFF,stringvip);
}
alias:gunhelp("guninfo", "guns");
CMD:gunhelp(playerid, params[])
{
    return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"ID gun", !"{FFFFFF}\
    {FFA500}ID:\n\
    {FFFFFF}- 1-Kastetas\n\
    {FFFFFF}- 2-Golfo lazdas\n\
    {FFFFFF}- 3-Policijos lazda\n\
    {FFFFFF}- 4-Peilis\n\n\
    {FFFFFF}- 5-Beisbolo lazda\n\
    {FFFFFF}- 6-Kastuvas\n\
    {FFFFFF}- 7-Biliardo lazda\n\
    {FFFFFF}- 8-Katana\n\
    {FFFFFF}- 9-Benzopjukla\n\
    {FFFFFF}- 10-Dvipusis dildo\n\
    {FFFFFF}- 11-Dildo\n\
    {FFFFFF}- 12-Vibratorius\n\
    {FFFFFF}- 13-Sidabrinis vibratorius\n\n\
    {FFFFFF}- 14-Geliu puokste\n\
    {FFFFFF}- 15-Lazda\n\
    {FFFFFF}- 16-Granata\n\
    {FFFFFF}- 17-Asarines dujos\n\
    {FFFFFF}- 18-Molotovo kokteilis\n\
    {FFFFFF}- 22-Pistoletas 9mm\n\
    {FFFFFF}- 23-Pistoletas 9mm su slopintuvu\n\
    {FFFFFF}- 24-Desert Eagle\n\
    {FFFFFF}- 25-ShotGun\n\
    {FFFFFF}- 26-Obreztas Sautuvas\n\
	{FFFFFF}- 27-Greitasaudziai Shotgun\n\
	{FFFFFF}- 28-Uzi\n\
	{FFFFFF}- 29-MP5\n\
	{FFFFFF}- 30-AK-47\n\
	{FFFFFF}- 31-M4\n\
	{FFFFFF}- 32-Tec-9\n\
	{FFFFFF}- 33-Medziokles sautuvas\n\
	{FFFFFF}- 34-Sniper GUN\n\
	{FFFFFF}- 35-RPG\n\
	{FFFFFF}- 36-Savitaikancios raketos HS\n\
	{FFFFFF}- 37-Liepsnosvaidis\n\
	{FFFFFF}- 38-MiniGun\n\
	{FFFFFF}- 39-Krepsys su TNT\n\
	{FFFFFF}- 40-Detonatorius krepsyje\n\
	{FFFFFF}- 41-Purskiamoji dazu skardine\n\
	{FFFFFF}- 42-Gesintuvas\n\
	{FFFFFF}- 43-Fotoaparatas\n\
	{FFFFFF}- 44-Naktinio matymo prietaisas\n\
	{FFFFFF}- 45-Televizorius\n\
    {FFFFFF}- 46-Parasiutas.", "Perskaiciau", "");
}
alias:infoluxe("luxeinfo", "luxecars");
CMD:infoluxe(playerid, params[])
{
	if PI[playerid][pAdmin] < 1 *then return SCM(playerid, COLOR_OLDRED, "[Klaida] {cccccc}Jums neprieinama si komanda.");
    return SPD(playerid, 0, DIALOG_STYLE_MSGBOX, !"Luxe Cars ID", !"{FFFFFF}\
    {FFA500}ID:\n\
    {F81414}- KAI KURIE ID GALI NEVEIKTI!!\n\
    {FFFFFF}- 612 - Mercedes AMG GT63S || 613 - Mercedes-Benz G63 AMG || 614 - Audi RS6 || 662 - BMW X5\n\
    {FFFFFF}- 663 - CHEVCOR || 665 - CHEVROLET || 666 - Lexus LX || 667 - Porsche 911\n\
    {FFFFFF}- 668 - Porsche Cayenne || 699 - Bentley || 793 - BMW M8 || 794 - Mercedes-Benz E63S\n\
    {FFFFFF}- 909 - Mersedes-Benz S63 || 965 - Volkswagen Touareg || 1194 - Lamborgini Urus || 1195 - ABT Q8 Review\n\n\
    {FFFFFF}- 1196 - Dodge Challenger || 1197 - Acura NSX || 1198 - Volvo || 1199 - Range Rover\n\
    {FFFFFF}- 1200 - CivTR || 1201 - Lexus || 1202 - Ford Mustang || 1203 - Volvo XC\n\
    {FFFFFF}- 1204 - Kajovil Jagfp || 1205 - Optima || 3155 - BMW ZF || 3156 - Mercedes-Benz W140\n\
    {FFFFFF}- 3157 - BMW XF || 3158 - Lexus RX || 3195 - Ducati || 3196 - Ducati Ducnaked\n\
    {FFFFFF}- 3197 - Kawasaki ZX10R || 3198 - Kanuni Western || 3199 - Rolls-Royce || 3200 - Volkswagen Beetle || 3201 - Bug Divo\n\
    {FFFFFF}- 3202 - Bugati Chiron || 3203 - Fiat 500 || 3204 - Mercedes Gls 2020 || 3205 - Mercedes-Benz G65 AMG\n\
    {FFFFFF}- 3206 - Lamborghini Aventador SVJ || 3207 - Landscape || 3208 - BMW 530I || 3209 - Mercedes-Benz W221\n\
    {FFFFFF}- 3210 - Tesla Model X || 3211 - NISSAN LEAF || 3213 - Subary Forest || 3215 - Subaru Legasy\n\
    {FFFFFF}- 3216 - Hyundai Sonata || 3217 - BMW e38 || 3218 - Mercedes e55 || 3219 - Mercedes e500\n\
    {FFFFFF}- 3220 - Storm || 3222 - Makvin || 3223 - Mater || 3224 - Buckingham || 3232 - Infinity || 3233 - Lexus RX\n\
    {FFFFFF}- 3234 - Kia Sportage || 3235 - Volkswagen Golf || 3236 - Audi R8 || 3237 - Tayota Camry || 3238 - Tayota Camry\n\
    {FFFFFF}- 3239 - BMW M5E60 || 3240 - BMW M5F90 || 3245 - Mercedes-Maybach || 3247 - Mercedes-benz Amg Gt || 3248 - Porsh Panamera\n\
    {FFFFFF}- 3251 - Volkswagen Passat || 3254 - Chevrole Corvette 1980 || 3266 - Dodge SRT || 3348 - GT500 || 3974 - Aston Martin DB5\n\
    {FFFFFF}- 4542 - BMW M3 E46 || 4543 - Chevrolete Camaro || 4544 - Mazda RX-7 || 4545 - Mazda RX-8\n\
    {FFFFFF}- 4546 - Mitsubishi Eclipse || 4547 - Ford Mustang (OLD) || 4548 - Nissan 350-Z || 4794 - Dodge Caravan Medic\n\
    {FFFFFF}- 4797 - Dodge Medic || 4798 - Ford Explorer Medic || 4799 - Dodge RAM Medic || 4791 - Uaz Patriot\n\
    {FFFFFF}- 4792 - Volga || 4788 - Lada Vesta SVF || 4702 - Lamborghini Police || 4703 - Ferarri Police\n\
    {FFFFFF}- 6604 - Audi A6 || 6605 - Audi Q7 || 6606 - BMW M6 || 6607 - BMW M6 Old\n\
    {FFFFFF}- 6608 - Mercedes Cls46 || 6609 - Mercedes Cls || 6610 - Haval || 6611 - Tayota Tlc200\n\
	{FFFFFF}- 6612 - Lincoln || 6613 - Porshe Macan || 6614 - Matiz || 6615 - Mercedes 6x6\n\
	{FFFFFF}- 6616 - Mercedes 63 || 6617 - MonsterTruck 1 || 6618 - MonsterTruck 2 || 6619 - MonsterTruck 3\n\
	{FFFFFF}- 6620 - MonsterTruck 4 || 6621 - Tayota Prado || 6622 - Tayota Rav4 || 6623 - Tayota Supra\n\
	{FFFFFF}- 6624 - UAZ Old || 6625 - Volvo Xc90 || 4785 - Ferrari Spider || 4790 - Ferrari J50\n\
	{FFFFFF}- 4774 - BMW 760li || 4777 - Bentley Bentayga || 4776 - Bentley Mulliner || 4786 - Mercedes SLR\n\
	{FFFFFF}- 12713 - Mercedes-Benz GL 63 AMG || 12715 - Mercedes-Benz CLS 53 AMG || 12714 - Renault Laguna || 12716 - Audi RS5\n\
	{FFFFFF}- 12717 - Cadillac Escalade || 12718 - Tesla Cybertruck || 12719 - Tesla Model S || 12720 - Ford GT\n\
	{FFFFFF}- 12721 - Dodge Viper || 12722 - Volkswagen Polo || 12723 - Mitsubishi Lancer EVOIX || 12724 - Audi TT RS\n\
	{FFFFFF}- 12725 - Roadtrain ACTROS || 12726 - Audi S4 || 12727 - BMW 4S || 12728 - Cadillac Escalade 2007\n\
	{FFFFFF}- 12729 - Toyota Chaser || 12730 - Dacia || 12731 - Mitsubishi Lancer EVOX || 12732 - Chevrolet Impala 1964\n\
	{FFFFFF}- 12733 - Chevrolet Impala 1967 || 12734 - Roadtrain KENWOOTH || 12735 - Trailer KENWTRL || 12736 - McLaren MP4\n\
	{FFFFFF}- 14123 - Delimobile L || 14913 - Vision || 14906 - Hotwheels || 14767 - Amgone || 14768 - Valkyrie\n\
	{FFFFFF}- 14769 - Aveo || 14857 - Bugbol || 14884 - Buggys || 14899 - Buster || 14904 - Monza || 14910 - Priora\n\
    {FFFFFF}- INFO LUXE", "Perskaiciau", "");
}
CMD:vhud(playerid)
{
	if(GetPVarInt(playerid, #vhud) == 0)
	{
	    SetPVarInt(playerid, #vhud, 1);
		HidePlayerHud(playerid);
		HideLogo(playerid);
		HideAddVIP(playerid);
	}
	else
	{
	    DeletePVar(playerid, #vhud);
		UpdatePlayerLauncher(playerid);
		ShowLogo(playerid);
		ShowPlayerHud(playerid);
		ShowAddVIP(playerid);
	}
	return 1;
}
CMD:topfam(playerid) return mysql_tquery(mysql, "SELECT `name`, `reputation` FROM family WHERE `reputation` > 0 ORDER BY `reputation` DESC LIMIT 10", "@TopFamily", "d", playerid);
CMD:setfamprefix(playerid, params[])
{
	new id = FP_Data[playerid][F_FAMILY_ID];
	if id == -1 *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Jus nepriklausote ne vienai is seimu!");
	else if !GetFamilyAcces(PN(playerid), id) *then
		return SCM(playerid, COLOR_RED, !"[Klaida] {FFFFFF}Si komanda pasiekiama tik Lyderiui ir Pavaduotojui!");
	new target, colorpf[32], prefix[64];
	if sscanf(params, "us[32]s[64]", target, colorpf, prefix) *then
		return SCM(playerid, COLOR_VALIK, !"Naudokite: {FFFFFF}/setfamprefix [zaidejo ID/Nick] [spalva] [prefix]"), SCM(playerid, -1, !"Noredami nustatyti numatytaji [prefix] arba [color], irasykite i prefixa arba spalva.");
	if !IsPlayerOnline(target) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Zaidejas neprisijunges arba neautorizuotas.");
	else if !(FP_Data[playerid][F_FAMILY_ID] == FP_Data[target][F_FAMILY_ID]) *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida]{FFFFFF} Sis zaidejas nera is jusu seimos.");
    if !GetString(prefix, "1") *then SetString(PI[target][pFamPrefix], prefix);
    else SetString(PI[target][pFamPrefix], "None");
    if !GetString(colorpf, "1") *then SetString(PI[target][pFamPrefixColor], colorpf);
    else SetString(PI[target][pFamPrefixColor], "ffffff");
	SCMF(playerid, COLOR_LIGHTBLUE, "[Family Prefix]{FFFFFF} Jus pakeitete prefixa zaidejui %s i {%s}%s", PN(target), PI[target][pFamPrefixColor], PI[target][pFamPrefix]);
	SCMF(target, COLOR_LIGHTBLUE, "[Family Prefix]{FFFFFF} Seimos lyderis %s pakeite jusu prefixa i {%s}%s", PN(playerid), PI[target][pFamPrefixColor], PI[target][pFamPrefix]);
	return UpdatePlayerDataStr(target, "FamPrefix", PI[target][pFamPrefix]), UpdatePlayerDataStr(target, "FamPrefixColor", PI[target][pFamPrefixColor]);
}
CMD:setradio(playerid, params[])
{
	switch(random(27))
	{
		case 0:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Jakomo_AVG_-_Platina_73881376.mp3");
		case 1:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/aljona_shvec_MJEJJBI_BJEJJBI_-_Tamagochi_66968616.mp3");
		case 2:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Neizvestnyjj_-_U_menya_net_problem_krome_moejj_bashki_73243128.mp3");
		case 3:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MJEJJBI_BJEJJBI_-_sH1pu4Ka_73816633.mp3");
		case 4:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Platina_dora_-_San_Laran_73389989.mp3");
		case 5:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/84_Volodya_XXL_LOOKBUFFALO_-_Krugom_golova_73681954.mp3");
		case 6:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/dora_-_Dora_dura_67181158.mp3");
		case 7:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/dora_MJEJJBI_BJEJJBI_-_Barbisajjz_73591529.mp3");
		case 8:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Ganvest_-_Durman_64403903.mp3");
		case 9:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Platina_OG_BUDA_-_JEto_ne_lyubov_56706313.mp3");
		case 10:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/daybe_-_Venom_2_prod_by_retroyse_Roney_prod_by_retroyse_Roney_73283320%20(1).mp3");
		case 11:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Big_Baby_Tape_kizaru_-_Bon_Voyage_73212032.mp3");
		case 12:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/KIZARU_-_Dezhavyu_66123347.mp3");
		case 13:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Big_Baby_Tape_kizaru_-_Million_73212025%20(1).mp3");
		case 14:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Big_Baby_Tape_kizaru_-_Bandana_73212029%20(1).mp3");
		case 15:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/Platina_OG_BUDA_-_Grupi_63793663.mp3");
		case 16:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/slava-marlow-snova-ya-napivayus-denis-bravo-radio-edit-mp3.mp3");
		case 17:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/T1hxN_-_tjolka-drejjn_73326198.mp3");
		case 18:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_-_Domojj_73591541.mp3");
		case 19:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_-_Novyjj_Merin_66404393.mp3");
		case 20:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_Imanbek_Fetty_Wap_KDDK_-_Leck_72934757.mp3");
		case 21:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_-_DINERO_72984967.mp3");
		case 22:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_-_ARISTOCRAT_72984961.mp3");
		case 23:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_SODA_LUV_OG_Buda_MAYOT_blago_white_-_Cristal_MOJOT_72958624.mp3");
		case 24:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_-_DULO_72947606.mp3");
		case 25:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_-_12_73936814.mp3");
		case 26:
			PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/MORGENSHTERN_-_POCHEMU_73780426.mp3");
	}
	SendClientMessage(playerid, COLOR_GREY, "{5500ff}[Informacija]: {ffffff}Noredami isjungti, iveskite /noradio");
}
CMD:noradio(playerid)
    return StopAudioStreamForPlayer(playerid);
CMD:nabor(playerid)
{
    if(GetPVarInt(playerid,"advertise") > gettime()) return SCMF(playerid, -1, "Skelbimus galima siusti po {80FF00}%d {FFFFFF}sek", GetPVarInt(playerid,"advertise") - gettime());
    if(GetMoney(playerid) < 10000) return SCM(playerid, -1, "Jus parasete skelbima apie idarbinima, kainuojanti {34c924}10.000${FFFFFF}, bet jus neturite tiek pinigu!");
    if(!IsAtGang(playerid) && !IsAtMafia(playerid)) return SCM(playerid, COLOR_RED, "Nepasiekiama!");
    new FFText[15];
    if(IsAtGang(playerid) && PI[playerid][pRank] >= 7)
    {
        switch(PI[playerid][pMember])
        {
            case TEAM_BALLAS: FFText = "Ballas";
            case TEAM_VAGOS: FFText = "Vagos";
            case TEAM_GROOVE: FFText = "Grove";
            case TEAM_CORONOS: FFText = "Aztec";
            case TEAM_RIFA: FFText = "Rifa";
            case TEAM_WOLFS: FFText = "Night Wolfs";
        }
        format(str_1, sizeof(str_1), "{80FF00}Skelbimas: %s rajone vyksta apgyvendinimas. Laukiame norinciu rajone. Siuntejas: %s[%d]", FFText, PN(playerid),playerid);
    }
    if(IsAtMafia(playerid) && PI[playerid][pRank] > 4)
    {
        switch(PI[playerid][pMember])
        {
            case TEAM_LCN: FFText = "LCN";
            case TEAM_YAKUZA: FFText = "Yakuza";
            case TEAM_RM: FFText = "RM";
        }
        format(str_1, sizeof(str_1), "{80FF00}Skelbimas: Vyksta idarbinimas i mafija <<%s>>. Siuntejas: %s[%d].", FFText, PN(playerid), playerid);
    }
    SCMALL(-1, str_1);
    SCM(playerid, -1, "{ff1200}> {ffffff}Jus parasete apie idarbinima, {ffffff}kainuojanti {34c924}10.000${ffffff}!");
    GiveMoney(playerid, -10000);
    SetPVarInt(playerid,"advertise", gettime() + (10*6) );
    return true;
}
CMD:fakedrugs(playerid)
{
	new str_fake[70];
    f(str_fake,sizeof(str_fake)," %s vartoja narkotiku doze",PN(playerid));
    ProxDetector(30,playerid,str_fake,COLOR_PURPLE);
    if(!IsPlayerInAnyVehicle(playerid))ApplyAnimation(playerid,"SMOKING","M_smk_drag",4.1,0,0,0,0,0,1);
	return 1;
}
CMD:online(playerid)
{
    new query[70];
    format(query, sizeof query, "Siandien prisijunge prie serverio: {8b00ff}%d {ffffff}zmoniu",attendance);
	SendClientMessage(playerid, -1, query);
}
CMD:reg_players(playerid)
{
    new query[70];
    format(query, sizeof query, "Siandien uzsiregistravo {8b00ff}%d {ffffff}zmoniu",regplayer);
	SendClientMessage(playerid, -1, query);
}
CMD:usegarage(playerid)
{
	if(PI[playerid][pHouseG] != 1) return SCM(playerid, COLOR_GREY, "[Klaida] Jus nenusipirkote namu patobulinimo 'Garazas'!");
	if(GetPlayerInterior(playerid) != 0) return SCM(playerid, COLOR_GREY, "[Klaida] Norint irengti garaza, reikia palikti interjera!");
	if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "[Klaida] Norint irengti garaza, reikia palikti interjera!");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "[Klaida] Norint irengti garaza, reikia islipti is transporto!");
	if(!IsPlayerOnline(playerid)) return 1;
	new value;
	for new i; i < OWNABLEHOUSES; i++ do
	{
 		if(i != 0)
   		{
     		if(IsPlayerInRangeOfPoint(playerid,15.0,HouseInfo[i][hEnter_X],HouseInfo[i][hEnter_Y],HouseInfo[i][hEnter_Z]))
       		{
         		if(GetString(HouseInfo[i][hOwner],PN(playerid)))
				{
				    value++;
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					HouseInfo[i][hGarage] = 1;
					HouseInfo[i][hGarage_X] = X;
					HouseInfo[i][hGarage_Y] = Y;
					HouseInfo[i][hGarage_Z] = Z;
					UpdateHouse(i);
					UpdateHouseGarage(i);
					SCM(playerid, COLOR_RED, "Jus pridejote garaza prie jusu nurodyto namo");
					PI[playerid][pHouseG] = 0;
				}
			}
		}
	}
	if(value == 0) return SCM(playerid, COLOR_GREY, "[Klaida] Norint irengti garaza, reikia buti 15 metru atstumu nuo savo namo!");
	return 1;
}
CMD:stanim(playerid)
{
	if(AnimPlayed{playerid})
	{
 		ClearAnimationsEx(playerid);
   		if Int_GetPlayerData(playerid, "P_SEAT_STATUS") *then DeletePVar(playerid, "P_SEAT_STATUS");
	    TextDrawHideForPlayer(playerid, StopAnimation);
	}
	return 1;
}
CMD:iznas(playerid, get[])
{
	if PI[playerid][pVIP] < 7 *then
		return SCM(playerid, COLOR_RED, !"[Klaida] Jums neprieinama si komanda! (su SAG VIP)");
	extract get -> new player:id; else return SCM(playerid, COLOR_RED, "[Klaida] {FFFFFF}/iznas [zaidejo ID]");
	if PI[id][pVIP] < 7 *then
		return SCM(playerid, COLOR_RED, !"[Klaida] Sio zaidejo rura yra suvirinta. {FFFFFF}( Turi SAG VIP )");
	if(!IsPlayerLogged[id] || !ProxDetectorS(2.0, playerid, id) || id == playerid
	|| GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || GetPlayerState(id) != PLAYER_STATE_ONFOOT) return SCM(playerid, COLOR_RED, !"Jus esate toli nuo zaidejo!");
	ApplyAnimation(id, !"SNM", !"SPANKINGW",4.1,0,1,1,1,1);
	ApplyAnimation(playerid, !"SNM", !"SPANKEDW",4.1,0,1,1,1,1);
	SCMF(playerid, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus isprevartavote %s[%i]", PN(id), id);
	SCMF(id, COLOR_VALIK, !"[Informacija] {FFFFFF}Jus isprevartavo %s[%i]", PN(playerid), playerid);
	return 1;
}
CMD:gc(playerid, params[])
{
	if(!IsAtGang(playerid)) return SCM(playerid, COLOR_LIGHTRED, "[Klaida] {FFFFFF}Sis Chat prieinamas tik gaujoms!");
	if(GetPVarInt(playerid,"GcTime") > gettime())return SendClientMessage(playerid,COLOR_LIGHTRED,"[Klaida] {FFFFFF}Ne FLOODink!");
	if(PI[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
 	if(sscanf(params,"s[100]",params[0]))return SCM(playerid, COLOR_LIGHTRED, "[Klaida] {FFFFFF}Naudokite: /gc [tekstas]");
	new ttext[56];
	switch(PI[playerid][pMember])
	{
		case 11: ttext = "[Grove]{CCFFFF}";
		case 12: ttext = "[Vagos]{CCFFFF}";
		case 13: ttext = "[Ballas]{CCFFFF}";
		case 14: ttext = "[Aztecas]{CCFFFF}";
		case 15: ttext = "[Rifa]{CCFFFF}";
		case 25: ttext = "[Night Wolfes]{CCFFFF}";
	}
 	foreach(new i: Player)
  	{
       if(IsAtGang(i))
       {
        	SCMF(i,COLOR_LIGHTRED, "[GHETTO] {FFFFFF}%s %s[%d]: %s", ttext, PN(playerid), playerid, params[0]);
       }
   	}
	SetPVarInt(playerid,"GcTime",gettime()+5);
	return true;
}
