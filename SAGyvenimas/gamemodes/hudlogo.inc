// ============================================================================
//  HUD LOGOTIPAS - logotipas virsuje prie serverio pavadinimo (Arizona HUD).
//  Launcheris turi kelis integruotus logotipus, jie parenkami numeriu.
//  /hudlogo [numeris] (admin 8 lvl) - pakeicia logotipa visiems ir issaugo.
//  /hudlogo [numeris] test - pakeicia tik jums (isbandymui).
// ============================================================================
#define HUDLOGO_FILE "hudlogo.txt"

stock HudLogo_Load()
{
	if(!fexist(HUDLOGO_FILE)) return 0;
	new File:hFile = fopen(HUDLOGO_FILE, io_read), line[16];
	if(hFile)
	{
		if(fread(hFile, line)) HudLogo = strval(line);
		fclose(hFile);
	}
	printf("[HUD] Logotipas: %d", HudLogo);
	return 1;
}

stock HudLogo_Save()
{
	new File:hFile = fopen(HUDLOGO_FILE, io_write), line[16];
	if(!hFile) return 0;
	format(line, sizeof line, "%d", HudLogo);
	fwrite(hFile, line);
	fclose(hFile);
	return 1;
}

stock HudLogo_Send(playerid, logo)
{
	if(!IsPlayerCefInit(playerid)) return 0;
	ExecuteEvent(playerid, 0, (str_f("window.executeEvent('event.arizonahud.serverInfo', '[{\"id\":1,\"title\":\""Mode_City"\",\"project\":\"San Andreas\",\"type\":\"Gyvenimas\",\"onLine\":%d,\"flag\":0,\"logo\":%d,\"multiplier\":%d}]');", Iter_Count(Player), logo, XDonate)));
	return 1;
}

CMD:hudlogo(playerid, params[])
{
	if(!IsPlayerLogged{playerid} || PI[playerid][pAdmin] < 8) return 0;
	new logo, mode[8];
	if(sscanf(params, "dS()[8]", logo, mode))
		return SCMF(playerid, -1, "Naudokite: /hudlogo [numeris] (prie galo 'test' - tik sau). Dabar: %d", HudLogo);
	if(!strcmp(mode, "test", true))
	{
		HudLogo_Send(playerid, logo);
		return SCMF(playerid, -1, "[HUD] Isbandomas logotipas %d (tik jums). Patvirtinti visiems: /hudlogo %d", logo, logo);
	}
	HudLogo = logo;
	HudLogo_Save();
	foreach(new i : Player) if(IsPlayerLogged{i}) HudLogo_Send(i, HudLogo);
	return SCMF(playerid, -1, "[HUD] Logotipas pakeistas i %d visiems ir issaugotas.", HudLogo);
}
