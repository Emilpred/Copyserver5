// CAPTCHA SYSTEM BY CSS LAB
const Float:CAPTCHA_WINDOW_STANDART_X = 248.848007;
const Float:CAPTCHA_WINDOW_STANDART_Y = 123.900002;
const Float:CAPTCHA_NUMBER_STANDART_X = 281.389984;
const Float:CAPTCHA_NUMBER_STANDART_Y = 132.508331;

const Float:CAPTCHA_WINDOW_MIN_X = 225.848007;
const Float:CAPTCHA_WINDOW_MAX_X = 250.848007;
const Float:CAPTCHA_WINDOW_MIN_Y = 117.900002;
const Float:CAPTCHA_WINDOW_MAX_Y = 129.900002;

enum captcha_player_data 
{
	PlayerText:captcha_window_td[2],
	PlayerText:number_window_td[5],
	PlayerText:number_td[30],
	Float:CaptchaSize_X,
	Float:CaptchaSize_Y,
	Numberstr[6]
};

new CaptchaData[MAX_PLAYERS][captcha_player_data];

stock Float:GetCaptchaSize_Y(Float:one)
{
	new Float:test = 0.0, count = floatround(one - 118.000);

	test = 0.09 * count;

	return test;
}

stock Float:GetCaptchaSize_X(Float:one)
	return (one/5);

stock CreateCapcha_windownumber(playerid, Float:X, Float:sizeX, Float:Y, position)
{
	new 
		Float:pos_X = X + 32.541977 + (GetCaptchaSize_X(sizeX) * position) -(1.5 * position), 
		Float:pos_Y = Y + 8.608329,
		Float:size_X = X + 4.5 + (GetCaptchaSize_X(sizeX) * position)-position,
		Float:size_Y = 4.224949 + floatrandom(0.0, GetCaptchaSize_Y(Y));

	CaptchaData[playerid][number_window_td][position] = CreatePlayerTextDraw(playerid, pos_X, pos_Y, "usebox");
	PlayerTextDrawLetterSize(playerid, CaptchaData[playerid][number_window_td][position], 0.000000, size_Y );
	PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_window_td][position], size_X, 0.000000);
	PlayerTextDrawAlignment(playerid, CaptchaData[playerid][number_window_td][position], 1);
	PlayerTextDrawColor(playerid, CaptchaData[playerid][number_window_td][position], 0xE1E1E1FF);
	PlayerTextDrawUseBox(playerid, CaptchaData[playerid][number_window_td][position], 1);
	PlayerTextDrawBoxColor(playerid, CaptchaData[playerid][number_window_td][position], 0x1A2432FF);
	PlayerTextDrawSetShadow(playerid, CaptchaData[playerid][number_window_td][position], 2);
	PlayerTextDrawSetOutline(playerid, CaptchaData[playerid][number_window_td][position], 0);
	PlayerTextDrawBackgroundColor(playerid, CaptchaData[playerid][number_window_td][position], 0x000000FF);
	PlayerTextDrawFont(playerid, CaptchaData[playerid][number_window_td][position], 0);
	PlayerTextDrawSetProportional(playerid, CaptchaData[playerid][number_window_td][position], 1);
	PlayerTextDrawSetSelectable(playerid, CaptchaData[playerid][number_window_td][position], 0);

	ShowPlayerTD(playerid, CaptchaData[playerid][number_window_td][position]);
	
	return CreateNumberCaptchaTD(playerid, pos_X, pos_Y, size_X, size_Y, position);
}
//0xCD6679FF 0x759DA3FF
#define default_captcha(%1,%0) PlayerTextDrawAlignment(%1, %0, 1), PlayerTextDrawColor(%1, %0, 0x759DA3FF), PlayerTextDrawLetterSize(%1, %0, 0.480000, 1.120000), PlayerTextDrawUseBox(%1, %0, 0), PlayerTextDrawBoxColor(%1, %0, 0x80808080), PlayerTextDrawSetShadow(%1, %0, 2), PlayerTextDrawSetOutline(%1, %0, 0), PlayerTextDrawBackgroundColor(%1, %0, 0x00000000), PlayerTextDrawFont(%1, %0, 4), PlayerTextDrawSetProportional(%1, %0, 1), PlayerTextDrawSetSelectable(%1, %0, 0), ShowPlayerTD(%1, %0)

stock CreateNumberCaptchaTD(playerid, Float:X, Float:Y, Float:sizeX, Float:sizeY, td)
{
	new 
		number,	Float:randomX, Float:randomY = floatrandom(-7.0, 1.0);

	number = td == 4 ? (random(100) < 9 ? random(10):0):(random(10));
	strcat(CaptchaData[playerid][Numberstr], IntToStr(number));

	switch number do
	{
		case 0:
		{
			randomX = floatrandom(-3.0, -1.5);

			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X + (-3.0 + randomX), Y - randomY, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 6.0 + (randomX * -2), (Y / 4.0) + 6.0 + randomY * 2);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);
		}

		case 1:
		{
			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X - 6.0, Y - 3.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 6.0, (Y / 4.0) + 15.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);
		}

		case 2:
		{
			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X - 4.0, Y + 5.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 4.0, (Y / 8.0) - 5.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);

			CaptchaData[playerid][number_td][1 + td *6] = CreatePlayerTextDraw(playerid, X, Y + 23.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][1 + td * 6], sizeX - X + 5.0, (Y / 4.0) - 23.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][1 + td * 6]);
		}

		case 3:
		{
			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X - 4.0, Y + 5.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 4.0, (Y / 8.0) - 5.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);

			CaptchaData[playerid][number_td][1 + td *6] = CreatePlayerTextDraw(playerid, X - 4.0, Y + 23.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][1 + td * 6], sizeX - X + 4.0, (Y / 4.0) - 23.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][1 + td * 6]);
		}

		case 4:
		{
			randomX = floatrandom(-4.0, 0.5);

			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X + (-6.0 + randomX), Y - 4.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 12.0 + (randomX * -2), (Y / 8.0) + 4.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);

			CaptchaData[playerid][number_td][1 + td *6] = CreatePlayerTextDraw(playerid, X + (-6.0 + randomX), Y + 23.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][1 + td * 6], sizeX - X + 6.0 + (randomX * -1.5), (Y / 4.0) - 10.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][1 + td * 6]);
		}

		case 5:
		{
			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X , Y + 5.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 8.0, (Y / 8.0) - 5.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);

			CaptchaData[playerid][number_td][1 + td *6] = CreatePlayerTextDraw(playerid, X - 8.0, Y + 23.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][1 + td * 6], sizeX - X + 8.0, (Y / 4.0) - 23.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][1 + td * 6]);
		}

		case 6:
		{
			randomX = floatrandom(-1.5, 1.5), randomY = floatrandom(0.0, 2.0);

			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X - randomX, Y + 5.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 8.0 + randomX*1.5, (Y / 8.0) - 5.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);

			CaptchaData[playerid][number_td][1 + td *6] = CreatePlayerTextDraw(playerid, X - 4.0 - randomX, Y + 23.0 + randomY, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][1 + td * 6], sizeX - X + 12.0 + randomX*3, (Y / 4.0) - 23.0 + randomY*2);
			default_captcha(playerid, CaptchaData[playerid][number_td][1 + td * 6]);
		}

		case 7:
		{
			randomY = floatrandom(0.0, 2.5);

			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X + (-6.0 + randomX) - randomY, Y + 4.0 + randomY, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 6.0 + (randomX * -1.5) + randomY, (Y / 2.9) - 4.0 - randomY);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);
		}

		case 8:
		{
			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X - 6.0, Y + 4.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 12.0, (Y / 8.0) - 4.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);

			CaptchaData[playerid][number_td][1 + td *6] = CreatePlayerTextDraw(playerid, X - 6.0, Y + 23.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][1 + td * 6], sizeX - X + 12.0, (Y / 4.0) - 23.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][1 + td * 6]);
		}

		case 9:
		{
			randomX = floatrandom(0.0, 2.5), randomY = floatrandom(0.0, 2.0);

			CaptchaData[playerid][number_td][0 + td *6] = CreatePlayerTextDraw(playerid, X - 8.0 + randomX, Y + 5.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][0 + td * 6], sizeX - X + 16.0 - randomX*2, (Y / 8.0) - 5.0);
			default_captcha(playerid, CaptchaData[playerid][number_td][0 + td * 6]);

			CaptchaData[playerid][number_td][1 + td *6] = CreatePlayerTextDraw(playerid, X - 6.0, Y + 23.0, "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][number_td][1 + td * 6], sizeX - X + 6.0, (Y / 4.0) - 23.0 + floatrandom(0.0, (sizeY - 4.2) * 10));
			default_captcha(playerid, CaptchaData[playerid][number_td][1 + td * 6]);
		}
	}

	return true;
}

stock CreateCaptchaWindow(playerid, Float:X, Float:Y)
{
	new 
		Float:sizeX = X - (X > CAPTCHA_WINDOW_STANDART_X ? (102.226013 + (CAPTCHA_WINDOW_STANDART_X - X)*2):(102.226013 - (CAPTCHA_WINDOW_STANDART_X - X)*2)), 
		Float:sizeY = Y - 63.630002;

	CaptchaData[playerid][CaptchaSize_X] = CAPTCHA_WINDOW_STANDART_X - X;
	CaptchaData[playerid][CaptchaSize_Y] = CAPTCHA_WINDOW_STANDART_Y - Y;

	for new i = 1; i > -1; i-- do
	{		
		if !i *then
			CaptchaData[playerid][captcha_window_td][i] = CreatePlayerTextDraw(playerid, X + 3.0, Y + 3.0, "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][captcha_window_td][i], sizeX - 6.0, sizeY - 6.0);
		else
			CaptchaData[playerid][captcha_window_td][i] = CreatePlayerTextDraw(playerid, X, Y, "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, CaptchaData[playerid][captcha_window_td][i], sizeX, sizeY);
		
		PlayerTextDrawLetterSize(playerid, CaptchaData[playerid][captcha_window_td][i], 0.480000, 1.120000);
		PlayerTextDrawAlignment(playerid, CaptchaData[playerid][captcha_window_td][i], 1);
		PlayerTextDrawColor(playerid, CaptchaData[playerid][captcha_window_td][i], !i ? 0x759DA3FF:0x1A2432FF);
		PlayerTextDrawUseBox(playerid, CaptchaData[playerid][captcha_window_td][i], 0);
		PlayerTextDrawBoxColor(playerid, CaptchaData[playerid][captcha_window_td][i], 0x80808080);
		PlayerTextDrawSetShadow(playerid, CaptchaData[playerid][captcha_window_td][i], 2);
		PlayerTextDrawSetOutline(playerid, CaptchaData[playerid][captcha_window_td][i], 0);
		PlayerTextDrawBackgroundColor(playerid, CaptchaData[playerid][captcha_window_td][i], 0x000000FF);
		PlayerTextDrawFont(playerid, CaptchaData[playerid][captcha_window_td][i], 4);
		PlayerTextDrawSetProportional(playerid, CaptchaData[playerid][captcha_window_td][i], 1);
		PlayerTextDrawSetSelectable(playerid, CaptchaData[playerid][captcha_window_td][i], 0);

		ShowPlayerTD(playerid, CaptchaData[playerid][captcha_window_td][i]);
	}

	for new i; i < 5; i++ do
		CreateCapcha_windownumber(playerid, X, sizeX, Y, i);

	return true;
}

stock DestroyCaptcha_BOT(playerid)
{
	for new i; i < 2; i++ do
		DestroyPlayerTD(playerid, CaptchaData[playerid][captcha_window_td][i]);
	
	for new i; i < 5; i++ do
		DestroyPlayerTD(playerid, CaptchaData[playerid][number_window_td][i]);

	for new i; i < 30; i++ do
		DestroyPlayerTD(playerid, CaptchaData[playerid][number_td][i]);

	CaptchaData[playerid][Numberstr][0] = EOS;
	DeletePVar(playerid, "captchaOpen");
	DeletePVar(playerid, "CaptchaAPIstr");
	return DeletePVar(playerid, "lsd");
}

stock CreateCaptcha_BOT(playerid, type)
{
	if GetPVarInt(playerid, "captchaOpen") *then return false;
	
    DestroyCaptcha_BOT(playerid);

	CreateCaptchaWindow(playerid, floatrandom(CAPTCHA_WINDOW_MIN_X, CAPTCHA_WINDOW_MAX_X), floatrandom(CAPTCHA_WINDOW_MIN_Y, CAPTCHA_WINDOW_MAX_Y) );
	
	new CaptchaAPIstr[16];
	
	format(CaptchaAPIstr, 16, "%d,%s", type, CaptchaData[playerid][Numberstr]);
	
	SetPVarString(playerid, "CaptchaAPIstr", CaptchaAPIstr);
	
	switch type do
	{
		case 1,2: 
		{
			f (global_str, 256, "\
			{FFFFFF}Введите {C6FB4A}5{FFFFFF} символов, которые\n\
			видно на {C6FB4A}вашем{FFFFFF} экране.\n\n\
			Стоимость %s: {C6FB4A}%d$", 
			type == 1 ? "дома":"бизнеса",
			type == 1 ? HouseInfo[InfoHouse[playerid]][hCost]:BizData[InfoBiz[playerid]][bCost]);
			if GetCount(playerid, 952) *then
			{
				f (global_str, 325, "\
				%s\n\
				{FFFFFF}Скидка на %s: {C6FB4A}%d${FFFFFF} ( {C6FB4A}50{FFFFFF} процентов )", 
				global_str, type == 1 ? "дом":"бизнес",
				type == 1 ? HouseInfo[InfoHouse[playerid]][hCost]/2:BizData[InfoBiz[playerid]][bCost]/2);
			}
			SPD(playerid, 23045, DIALOG_STYLE_INPUT, !"{F89168}Проверка на робота", global_str, !"Принять", !"Отмена");
			SetPVarInt(playerid, "CaptchAntiDeBug", type == 1 ? InfoHouse[playerid]:InfoBiz[playerid]);
		}
		default: SPD(playerid, 23045, DIALOG_STYLE_INPUT, !"{F89168}Проверка на робота", !"{FFFFFF}Введите {C6FB4A}5{FFFFFF} символов, которые\nвидно на {C6FB4A}вашем{FFFFFF} экране.", !"Принять", !"Отмена");
	}
	SetPVarInt(playerid, "lsd", GetTickCount());

	return SetPVarInt(playerid, "captchaOpen", true);
}