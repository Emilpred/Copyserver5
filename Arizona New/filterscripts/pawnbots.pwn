#include a_samp
#include dialogs
#include foreach
#include Pawn.RakNet


native PB_RegisterBot(name[]);

#define MAX_NAME 		(4096)
#define MAX_ADMIN 		(32)
#define MAX_LVL 		(128)
#define MAX_PING 		(128)
#define MAX_COLOR 		(128)

new Iterator:fNickC<MAX_NAME>;

new gSlotCount;
new gRealCount;
new gFakeCount;
new gNickCount;
new gPingCount;
new gScoreCount;
new gColorCount;
new gAdminCount;
new gTickCheckSl;
new gTimerDelay;
new gTimerDCount;
new gTimerDLRand;
new gTimerMaxTick;
new gTimerLastTick;

new gSetting;
new gAtHour[24];
new gLvl[MAX_LVL];
new gPing[MAX_PING];
new gColor[MAX_COLOR];
new gNick[MAX_NAME][25];
new gAdmin[MAX_ADMIN][25];
new gNickC[MAX_NAME char];
new gNickCplId[MAX_NAME] = {-1, ...};

new playerLvl[MAX_PLAYERS];
new playerPing[MAX_PLAYERS];
new playerColor[MAX_PLAYERS];
new playerPBot[MAX_PLAYERS];
new playerNick[MAX_PLAYERS][25];
new playerSetList[MAX_PLAYERS char];
new playerRakNetScore[MAX_PLAYERS];
new playerRakNetPing[MAX_PLAYERS];

new Float:BotPos[][3]=  {
	{439.0985,1698.2605,1001.0000},// ???? 1
	{439.7822,1715.4479,1001.6250}, // ???? 2
	{436.6999,1708.1768,1001.0000}, // ???? 3
	{430.6002,1704.8046,1001.0000}, // ???? 4
	{422.9055,1697.3839,1001.0000}, // ???? 5
	{1638.9009,2411.8066,13.1821}, // ???? 6
	{1632.2700,2582.3967,13.1836}, // ???? 7
	{1819.7117,2258.7178,15.2729}, // ???? 8
	{1831.6870,2246.9561,15.2625}, // ???? 9
	{1899.6289,2640.3091,14.7637}, // ???? 10
	{563.8661,2168.9441,12.0000}, // ???? 11
	{529.9409,2120.3755,12.0000}, // ???? 11
	{388.8304,1567.7369,12.0500}, // ???? 12
	{393.6379,1564.0135,12.0500}, // ???? 13
	{406.8498,1548.6422,12.0500}, // ???? 14
	{399.7895,1546.0293,12.0500}, // ???? 16
	{398.7513,1539.4741,12.0500}, // ???? 17
	{401.8238,1558.3441,12.0500}, // ???? 18
	{407.0520,1560.3708,12.0500}, // ???? 19
	{389.9883,1522.0863,12.0500}, // ???? 20
	{399.4109,1517.1741,12.0500}, // ???? 21
	{299.3054,1112.4568,12.0000}, // ???? 22
	{140.2153,815.2914,12.0010}, // ???? 23
	{-112.2559,973.2074,12.1494}, // ???? 24
	{1659.4940,2206.0149,14.2129}, // ???? 30
	{1652.4734,2192.8274,14.1282}, // ???? 31
	{1643.3372,2191.1638,14.3911}, // ???? 32
	{1641.2123,2200.2417,14.3090}, // ???? 33
	{1658.4912,2231.6331,14.1955}, // ???? 34
	{1649.8564,2230.9731,14.0894}, // ???? 35
	{1652.5538,2214.9434,14.1231}, // ???? 36
	{1944.4373,2162.0051,15.7060}, // ???? 37
	{1936.5640,2172.6118,15.7060}, // ???? 38
	{1822.4730,2091.4304,15.8538}, // ???? 39
	{2497.5564,1406.7711,1000.0214}, // ???? 40
	{2494.7205,1405.8837,1000.0214}, // ???? 41
	{-2520.2500,1477.8911,1080.4944}, // ???? 42
	{-2517.5530,1476.1780,1080.4944}, // ???? 43
	{-2500.2615,1466.4459,1080.5190}, // ???? 44
	{-2506.4021,1478.3152,1080.4944}, // ???? 45
	{-2461.8281,1549.9309,53.0278}, // ???? 46
	{-2439.2854,1557.9626,53.0278}, // ???? 47
	{-2473.8083,2843.7651,37.6340}, // ???? 48
	{-2459.9900,2839.4377,38.4074}, // ???? 48
	{-2504.3081,2832.1060,37.4309}, // ???? 49
	{399.4384,1542.6489,12.0752},
	{403.4945,1538.2101,12.0752},
	{404.0831,1558.9628,12.0752},
	{388.6143,1569.0125,12.0500},
	{386.5907,1570.5875,12.0474},
	{396.7306,1530.2678,12.0500},
	{358.6360,1623.1473,12.0160},
	{385.4460,1734.0918,12.1003},
	{423.2436,1697.7410,1001.0000},
	{426.7300,1713.4943,1001.0000},
	{429.4155,1696.2356,1001.0000},
	{433.3367,1714.3243,1001.0000},
	{1650.4406,2194.4771,14.1001},
	{1660.5729,2232.6775,14.2151},
	{1660.4414,2235.1367,14.1774},
	{1648.8693,2276.1606,14.1095},
	{1688.5629,2217.5889,14.8741},
	{0.0240,0.0078,-7.7743},
	{399.4384,1542.6489,12.0752},
	{2627.6990,2819.4497,20.5958}, // 1
	{2144.9470,2973.1960,10.8397}, // 2
	{1919.0024,2095.2075,15.7053}, // 3
	{1911.4021,2077.2056,15.7053}, // 4
	{1848.9390,2040.7709,15.8850}, // 5
	{1952.0001,1938.7156,15.6822}, // 6
	{2048.6274,1867.3264,15.2734}, // 7
	{2402.0818,-2340.2939,22.0000}, // 1
	{2402.7175,-2324.6047,22.0000}, // 32
	{2389.7119,-2366.9666,21.9710}, // 1
	{2330.3176,-2364.5071,21.9710}, // 8
	{2284.8049,-2445.2915,21.9830}, // 9
	{2197.2869,-2418.9402,25.1818}, // 10
	{2094.1343,-2388.9053,21.9430}, // 11
	{2075.6279,-2277.2974,21.9430}, // 12
	{1923.5742,-2236.7375,11.2390}, // 13
	{1850.0723,-2262.5503,11.0244}, // 14
	{1794.5902,-2264.8633,11.0147}, // 15
	{1777.7748,-2267.1108,11.0294}, // 16
	{1791.2444,-2244.5464,11.0294}, // 17
	{1733.2015,-2326.8347,10.8003}, // 118
	{1763.4656,-2419.9163,10.9982}, // 17
	{1802.3954,-2530.6555,10.9982}, // 20
	{1831.6757,-2583.9116,10.8057}, // 21
	{1948.7122,-2661.8875,11.1438}, // 22
	{2396.1453,-2658.4370,21.9886}, // 23
	{2489.2925,-2571.6667,22.0062}, // 24
	{2453.2139,-2470.9497,21.9728}, // 26
	{2555.4285,-2198.5645,21.9629}, // 27
	{2555.4285,-2198.5645,21.9629}, // 28
	{2555.4285,-2198.5645,21.9629}, // 29
	{2555.4285,-2198.5645,21.9629}, // 30
	{2529.9775,-2180.3179,21.9676}, // 3
	{2520.8882,-2127.7969,21.9700}, // 2
	{2451.0076,-1917.0862,21.9619}, // 12
	{2381.6243,-1898.1696,21.9330}, // 12
	{2296.3750,-1803.5592,21.9619}, // 13
	{2249.1445,-1708.7894,22.3893}, // 16
	{2262.9456,-1686.6533,22.0300}, // 16
	{2263.4539,-1729.2871,22.0000}, // 19
	{2580.0186,-1536.9301,23.5892}, // 20
	{2623.5793,-1487.4226,24.4137}, // 22
	{2761.2324,-1357.6943,23.8923}, // 25
	{476.9566,475.5016,11.9798}, // 1
	{475.2523,449.7275,12.0481}, // 4
	{498.4309,441.9636,12.0000}, // 7
	{546.3448,414.6986,12.1015}, // 8
	{599.6365,445.0762,12.0000}, // 9
	{781.3563,568.5792,15.2361}, // 21
	{786.3455,607.5328,15.8906}, // 25
	{824.2944,606.2174,15.6719}, // 27
	{862.8488,601.5920,15.8697}, // 26
	{858.6887,591.3447,15.8697}, // 28
	{758.2475,646.8736,13.2528}, //
	{731.8549,668.2434,12.5901}, // 28
	{727.8233,749.5500,12.1797}, // 21
	{784.4459,853.3281,12.0609}, // 27
	{794.5605,942.8181,12.0483} // 29
};

stock GetTickDiff(newtick, oldtick)
{
	if(oldtick >= 0 && newtick < 0 || oldtick > newtick) return ((cellmax - oldtick + 1) - (cellmin - newtick));
	return (newtick - oldtick);
}

stock CompareText(string1[], string2[])
{
	new id = strcmp(string1, string2);
    if(id != 0) return id;
	if(string1[0] && string2[0]) return 0;
	return 255;
}

stock HexToInt(string[])
{
   	new curent = 1, result = 0;
   	for(new i = (strlen(string) - 1); i >= 0; i--)
 	{
  		if(string[i] < 58) result = (result + curent * (string[i] - 48));
  		else result = (result + curent * (string[i] - 65 + 10));
     	curent = curent*16;
   	}
   	return result;
}

stock ShowSetting0(playerid)
{
    new string0[60] = "{FFFFFF}", string1[50] = "{FFFFFF}Автоматический онлайн: ";
	strcat(string1, (gSetting) ? ("{00CC00}Запущен") : ("{FF6600}Остановлен"));
	strcat(string0, (gSetting) ? ("Остановить") : ("Запустить"));
	strcat(string0, "\nПерезагрузить\nНастройка\nСтатистика");
	ShowPlayerDialog(playerid, 4460, DIALOG_STYLE_LIST, string1, string0, "Выбрать", "Закрыть");
	return 1;
}

stock ShowSetting1(playerid)
{
	new string[320] = "{FFFFFF}";
    for(new i; i < 24; i++) format(string, sizeof(string), "%s%i:00 - %i\n", string, i, gAtHour[i]);
	ShowPlayerDialog(playerid, 4461, DIALOG_STYLE_LIST, "{FFFFFF}Настройка", string, "Выбрать", "Назад");
	return 1;
}
stock LoadSetting()
{
	new File:id, count, string[25];
	id = fopen("pawnbots/setting.ini", io_read);
	if(!id)
	{
		print("[PB] file 'setting.ini' error");
		return 0;
	}
	fread(id, string, sizeof(string));
	gSetting = strval(string);
	fclose(id);

	id = fopen("pawnbots/online.ini", io_read);
	if(!id)
	{
		print("[PB] file 'online.ini' error");
		return 0;
	}
	count = 0;
	while(fread(id, string, sizeof(string)))
	{
		if(++count > 24) break;
		gAtHour[count - 1] = (strval(string) > (gSlotCount - 1)) ? (gSlotCount - 1) : strval(string);
	}
	fclose(id);
	
	id = fopen("pawnbots/score.ini", io_read);
	if(!id)
	{
		print("[PB] file 'score.ini' error");
		return 0;
	}
	count = 0;
	while(fread(id, string, sizeof(string)))
	{
	    if(++count > MAX_LVL) break;
		gLvl[count - 1] = strval(string);
	}
	gScoreCount = count;
	fclose(id);

	id = fopen("pawnbots/ping.ini", io_read);
	count = 0;
	if(!id)
	{
		print("[PB] file 'ping.ini' error");
		return 0;
	}
	while(fread(id, string, sizeof(string)))
	{
		if(++count > MAX_PING) break;
		gPing[count - 1] = strval(string);
	}
	gPingCount = count;
	fclose(id);

	id = fopen("pawnbots/color.ini", io_read);
	if(!id)
	{
		print("[PB] file 'color.ini' error");
		return 0;
	}
	count = 0;
	while(fread(id, string, sizeof(string)))
	{
	    if(++count > MAX_COLOR) break;
	    for(new i = (strlen(string) - 1); i >= 0; i--) switch(string[i])
	    {
	        case 'A'..'Z', 'a'..'z', '0'..'9': {}
	        default: strdel(string, i, (i + 1));
	    }
		gColor[count - 1] = HexToInt(string[2]);
	}
	gColorCount = count;
	fclose(id);

	id = fopen("pawnbots/nick.ini", io_read);
	if(!id)
	{
		print("[PB] file 'nick.ini' error");
		return 0;
	}
	count = 0;
	while(fread(id, string, sizeof(string)))
	{
	    if(++count > MAX_NAME) break;
	    for(new i = (strlen(string) - 1); i >= 0; i--) switch(string[i])
	    {
	        case 'A'..'Z', 'a'..'z', '0'..'9', '_': {}
	        default: strdel(string, i, (i + 1));
	    }
		strmid(gNick[count - 1], string, 0, strlen(string), 25);
	}
	gNickCount = count;
	fclose(id);

	id = fopen("pawnbots/admin.ini", io_read);
	if(!id)
	{
		print("[PB] file 'admin.ini' error");
		return 0;
	}
	count = 0;
	while(fread(id, string, sizeof(string)))
	{
	    if(++count > MAX_ADMIN) break;
	    for(new i = (strlen(string) - 1); i >= 0; i--) switch(string[i])
	    {
	        case 'A'..'Z', 'a'..'z', '0'..'9', '_': {}
	        default: strdel(string, i, (i + 1));
	    }
		strmid(gAdmin[count - 1], string, 0, strlen(string), 25);
	}
	gAdminCount = count;
	fclose(id);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(!CompareText(text, ".botiki")) { switch(GetPlayerState(playerid))
 	{
	    case PLAYER_STATE_NONE, PLAYER_STATE_WASTED, PLAYER_STATE_SPECTATING: {}
		default: { for(new i = (gAdminCount - 1); i >= 0; i--) if(!CompareText(playerNick[playerid], gAdmin[i]))
		{
			ShowSetting0(playerid);
			return 0;
		}}
	}}
	return 1;
}

DLG(4463, playerid, response, listitem, inputtext[])
{
	ShowSetting0(playerid);
	return 1;
}
DLG(4460, playerid, response, listitem, inputtext[])
{
    if(!response) return 1;
	switch(listitem)
	{
	    case 0:
	    {
	        gSetting = !gSetting;
	        new File:id = fopen("pawnbots/setting.ini", io_write);
			if(!id)
			{
				print("[PB] file 'setting.ini' error");
				return 1;
			}
		 	new string[4];
		 	valstr(string, gSetting);
			fwrite(id, string);
			fclose(id);
			ShowSetting0(playerid);
	    }
	    case 1:
	    {
	        gSetting = 0;
	        for(new i = (gSlotCount - 1); i >= 0; i--) { if(playerPBot[i] != -1) Kick(i); }
         	LoadSetting();
         	gSetting = 1;
         	ShowSetting0(playerid);
	    }
	    case 2: ShowSetting1(playerid);
		case 3:
		{
			new string[136];
			format(string, sizeof(string), "{FFFFFF}Последние время выполнения: %iмс.\nМаксимальное время выполнения: %iмс.\nНастоящих игроков: %i\nФейковых игроков: %i", gTimerLastTick, gTimerMaxTick, gRealCount, gFakeCount);
		    ShowPlayerDialog(playerid, 4463, DIALOG_STYLE_MSGBOX, "{FFFFFF}Статистика", string, "Назад", "");
		}
	}
	return 1;
}
DLG(4461, playerid, response, listitem, inputtext[])
{
    if(!response || listitem < 0 || listitem > 24)
	{
		ShowSetting0(playerid);
		return 1;
	}
    playerSetList{playerid} = listitem;
    new string[14] = "{FFFFFF}";
	valstr(string, listitem);
	strcat(string, ":00");
    ShowPlayerDialog(playerid, 4462, DIALOG_STYLE_INPUT, string, "{FFFFFF}", "Принять", "Назад");
    return 1;
}
		
DLG(4462, playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		ShowSetting1(playerid);
		return 1;
	}
	new list = playerSetList{playerid}, vall = strval(inputtext);
	if(!strlen(inputtext) || vall < 0 || vall > (gSlotCount - 1))
	{
	    new string[14] = "{FFFFFF}";
		valstr(string, list);
		strcat(string, ":00");
		ShowPlayerDialog(playerid, 4462, DIALOG_STYLE_INPUT, string, "{FFFFFF}", "Принять", "Назад");
		return 1;
	}
	for(new i = (strlen(inputtext) - 1); i >= 0; i--) if(inputtext[i] < '0' || inputtext[i] > '9')
    {
        new string[14] = "{FFFFFF}";
		valstr(string, list);
		strcat(string, ":00");
		ShowPlayerDialog(playerid, 4462, DIALOG_STYLE_INPUT, string, "{FFFFFF}", "Принять", "Назад");
		return 1;
	}
	gAtHour[list] = vall;
	ShowSetting1(playerid);
	new File:id = fopen("pawnbots/online.ini", io_write);
	if(!id)
	{
		print("[PB] file 'online.ini' error");
		return 1;
	}
 	new string[122];
    for(new i; i < 24; i++) format(string, sizeof(string), "%s%i\n", string, gAtHour[i]);
	fwrite(id, string);
	fclose(id);
	return 1;
}

public OnPlayerConnect(playerid)
{
    playerPBot[playerid] = -1;
    GetPlayerName(playerid, playerNick[playerid], 25);
    
    new id = -1;
    foreach(fNickC, slot) if(!CompareText(playerNick[playerid], gNick[slot])) { id = slot; break; }
    if(id != -1)
	{
	    gNickCplId[id] = playerid;
	    playerPBot[playerid] = id;
		playerLvl[playerid] = gLvl[random(gScoreCount)];
		playerPing[playerid] = gPing[random(gPingCount)];
		playerColor[playerid] = gColor[random(gColorCount)];
	}
	else gRealCount++;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new id = playerPBot[playerid];
	if(id != -1)
	{
	    gFakeCount--;
		gNickC{id} = 0;
		gNickCplId[id] = -1;
		Iter_Remove(fNickC, id);
	}
	else gRealCount--;
	return 1;
}

public OnFilterScriptInit()
{
    gSlotCount = GetMaxPlayers();
    Iter_Clear(fNickC);
    if(LoadSetting()) SetTimer("OnPBotUpdate", 2000, 1);
 	return 1;
}

public OnFilterScriptExit()
{
    for(new i = (gSlotCount - 1); i >= 0; i--) { if(playerPBot[i] != -1) Kick(i); }
	return 1;
}

forward IsPlayerPBot(playerid);
public IsPlayerPBot(playerid) return (playerPBot[playerid] != -1);

forward OnPBotUpdate();
public OnPBotUpdate()
{
	new tick = GetTickCount();
	if(++gTickCheckSl >= 5)
	{
	    gTickCheckSl = 0;
	}
	new string[136];
	foreach(Player, playerid)
	{
		if(playerPBot[playerid] != -1)
		{
			SetPlayerScore(playerid, random(25));
			SetPlayerColor(playerid, playerColor[playerid]);
			continue;
		}
		if(IsDialogOpen(playerid, 4463))
		{
			format(string, sizeof(string), "{FFFFFF}Последние время выполнения: %iмс.\nМаксимальное время выполнения: %iмс.\nНастоящих игроков: %i\nФейковых игроков: %i", gTimerLastTick, gTimerMaxTick, gRealCount, gFakeCount);
		    ShowPlayerDialog(playerid, 4463, DIALOG_STYLE_MSGBOX, "{FFFFFF}Статистика", string, "Назад", "");
   		}
	}
	if(gTimerDelay) gTimerDelay--;
	else { if(gSetting)
	{
		new hour, count, id = -1, botcount = Iter_Count(fNickC);
		gettime(hour);
		if(gAtHour[hour] < botcount && botcount)
		{
			while(!gNickC{(id = random(gNickCount))}) if(++count >= 20)
			{
				for(new i = (gNickCount - 1); i >= 0; i--) if(gNickC{i}) { id = i; break; }
				break;
			}
			if(id != -1) { for(new i = (gSlotCount - 1); i >= 0; i--) if(playerPBot[id] != -1) { if(!CompareText(gNick[id], playerNick[i])) Kick(i); }}
		}
		if(gAtHour[hour] > botcount && botcount < gNickCount && (gFakeCount + gRealCount) < (gSlotCount - 1))
		{
			while(gNickC{(id = random(gNickCount))}) if(++count >= 20)
			{
				for(new i = (gNickCount - 1); i >= 0; i--) if(!gNickC{i}) { id = i; break; }
				break;
			}
			if(id != -1)
			{
			    gFakeCount++;
			    gNickC{id} = 1;
			    Iter_Add(fNickC, id);
				PB_RegisterBot(gNick[id]);
				ConnectNPC(gNick[id], "pawnbots");
			}
		}
		if(++gTimerDCount >= gTimerDLRand)
	    {
	        gTimerDelay = (5 + random(6));
	        gTimerDLRand = (2 + random(3));
	        gTimerDCount = 0;
		}
	}}
	new diff = GetTickDiff(GetTickCount(), tick);
	gTimerLastTick = diff;
	if(diff > gTimerMaxTick) gTimerMaxTick = diff;
	return 1;
}

ORPC:155(playerid, BitStream:bs)
{
	new bytes;
	BS_GetNumberOfBytesUsed(bs, bytes);
	for(new i = (bytes / 10) - 1; i >= 0; i--)
	{
	    new otherid, score, ping;
		BS_ReadValue(bs, PR_UINT16, otherid, PR_INT32, score, PR_UINT32, ping);
		if(!IsPlayerConnected(otherid)) continue;
		playerRakNetScore[otherid] = score;
		playerRakNetPing[otherid] = ping;
	}
	new BitStream:stream = BS_New();
	foreach(Player, otherid)
	{
		if(playerPBot[otherid] == -1) BS_WriteValue(stream, PR_UINT16, otherid, PR_INT32, playerRakNetScore[otherid], PR_UINT32, playerRakNetPing[otherid]);
		else BS_WriteValue(stream, PR_UINT16, otherid, PR_INT32, playerLvl[otherid], PR_UINT32, (playerPing[otherid] + random(10)));
	}
	PR_SendRPC(stream, playerid, 155, PR_LOW_PRIORITY, PR_RELIABLE_ORDERED);
	BS_Delete(stream);
	return 0;
}
