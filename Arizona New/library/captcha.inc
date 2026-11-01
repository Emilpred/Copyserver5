const Float:MAX_CAPTCHA_WIDTH = 180.0;
const Float:MAX_CAPTCHA_HEIGHT = 60.0;

const Float:CAPTCHA_NUMBER_SIZE = 1.2;
const Float:CAPTCHA_NUMBER_SIZE_HEIGHT = 1.17;
const Float:CAPTCHA_NUMBER_BOXSIZE = 12.8;
const Float:CAPTCHA_NUMBER_BOXSIZE_HEIGHT = 14.0;

enum captch
{
	PlayerText:tdNumber[30],
	PlayerText:tdNumberBox[5],
	Float:dNumberX[5],
	Float:dNumberY[5],
	Float:dNumberWidth[5],
	Float:dNumberHeight[5],
	Number[5],
	Numberstr[5],
	PlayerText:tdbox[2],
	
	Float:captchposx,
	Float:captchposy,
	Float:captchwidth,
	Float:captchheight,
	
	lastcaptchid,
	tdtoopen
}
new captchaInfo[MAX_PLAYERS][captch];

stock CreateNumberTD(playerid, PlayerText:td, &id)
{
	PlayerTextDrawLetterSize(playerid, td, 0.480000, 1.120000),
	PlayerTextDrawAlignment(playerid, td, 1),
	PlayerTextDrawColor(playerid, td, 0x759DA3FF - random(30)),
	PlayerTextDrawUseBox(playerid, td, 0),
	PlayerTextDrawBoxColor(playerid, td, 0x80808080),
	PlayerTextDrawSetShadow(playerid, td, 2),
	PlayerTextDrawSetOutline(playerid, td, 0),
	PlayerTextDrawBackgroundColor(playerid, td, 0x00000000),
	PlayerTextDrawFont(playerid, td, 4),
	PlayerTextDrawSetProportional(playerid, td, 1),
	PlayerTextDrawSetSelectable(playerid, td, 0);
	
	captchaInfo[playerid][tdtoopen] ++;
	
	id = captchaInfo[playerid][tdtoopen];
	
}

stock CreateNumber(playerid, value, color, Float:size, Float:hsize)
{	
	captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]] = captchaInfo[playerid][captchposx]+(30*captchaInfo[playerid][lastcaptchid]);
	captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]] = captchaInfo[playerid][captchposy]+4+floatrandom(1, 3);
	
	captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]] = (captchaInfo[playerid][captchwidth]/floatrandom(8, 8.1))*size;
	captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]] = (captchaInfo[playerid][captchheight]/floatrandom(1.7, 2.0))*hsize;
	
	captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]], "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]);
	PlayerTextDrawAlignment(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 1);
	PlayerTextDrawColor(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], color);
	PlayerTextDrawUseBox(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 0);
	PlayerTextDrawBoxColor(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 0x80808080);
	PlayerTextDrawSetShadow(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 2);
	PlayerTextDrawSetOutline(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 0);
	PlayerTextDrawBackgroundColor(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 0x000000FF);
	PlayerTextDrawFont(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 4);
	PlayerTextDrawSetProportional(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 1);
	PlayerTextDrawSetSelectable(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]], 0);
    ShowPlayerTD(playerid, captchaInfo[playerid][tdNumberBox][captchaInfo[playerid][lastcaptchid]]);
	
	new id = captchaInfo[playerid][tdtoopen];
	switch value do
	{
		case 0:
		{
		    if !(random(12) == 3) *then
				captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.5), "LD_SPAC:white"),
				PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE+floatrandom(0.2, 0.5)), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT+floatrandom(0.2, 0.5))),
				CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 1:
		{
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]], "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-((CAPTCHA_NUMBER_BOXSIZE*0.5)+floatrandom(0.2, 0.5)), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]] - (random(2) ? (floatrandom(0.2, 0.5)) : (Float:0)));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 2:
		{
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.3), "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*2));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
			
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*1.5), "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*2));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 3:
		{
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.3), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*1.97)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
			
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*1.4), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*1.8)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 4:
		{
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.49), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]], "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]*0.45, captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]*floatrandom(0.5, 0.6)-(CAPTCHA_NUMBER_BOXSIZE*0.5));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);

			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*1.5), "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), (captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]*0.5)-(random(2) ? (floatrandom(0.2, 0.5)) : (Float:0)));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 5:
		{
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.3), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*1.86)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);

			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*1.5), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*2)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 6:
		{
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*1.65), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]*0.45, captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]*0.4-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.4)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);

			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.5), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5)-(random(2) ? (floatrandom(0,0.5)) : (Float:0)), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*2)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 7:
		{
		    captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]], captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.5), "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5), captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 8:
		{
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.49), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.4), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]*0.4, captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]*floatrandom(0.45, 0.5)-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.55)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);

			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.49), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*1.5), "LD_SPAC:white"),
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]*0.4, captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]*floatrandom(0.45, 0.5)-(CAPTCHA_NUMBER_BOXSIZE_HEIGHT*0.5)),
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
		case 9:
		{
		    new Float:rndx = random(2) ? (floatrandom(0,0.5)) : (Float:0);
			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.49), captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*0.5), "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]*0.45, captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]*0.4-(CAPTCHA_NUMBER_BOXSIZE*0.5));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);

			captchaInfo[playerid][tdNumber][id] = CreatePlayerTextDraw(playerid, captchaInfo[playerid][dNumberX][captchaInfo[playerid][lastcaptchid]]+rndx, captchaInfo[playerid][dNumberY][captchaInfo[playerid][lastcaptchid]]+(CAPTCHA_NUMBER_BOXSIZE*1.5), "LD_SPAC:white");
			PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdNumber][id], captchaInfo[playerid][dNumberWidth][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*0.5)-rndx, captchaInfo[playerid][dNumberHeight][captchaInfo[playerid][lastcaptchid]]-(CAPTCHA_NUMBER_BOXSIZE*1.8));
			CreateNumberTD(playerid, captchaInfo[playerid][tdNumber][id], id);
		}
	}
	format(captchaInfo[playerid][Numberstr], 6, "%s%d", captchaInfo[playerid][Numberstr], value);
	captchaInfo[playerid][lastcaptchid] ++;
}

stock CreateCaptchaBox(playerid, Float:x, Float:y, Float:maxwidth, Float:maxheight)
{
	if !(random(12) == 3) *then
		captchaInfo[playerid][tdbox][0] = CreatePlayerTextDraw(playerid, x, y, "LD_SPAC:white"),
		PlayerTextDrawLetterSize(playerid, captchaInfo[playerid][tdbox][0], 0.480000, 1.120000),
		PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdbox][0], maxwidth, maxheight),
		PlayerTextDrawAlignment(playerid, captchaInfo[playerid][tdbox][0], 1),
		PlayerTextDrawColor(playerid, captchaInfo[playerid][tdbox][0], 0x1A2432FF),
		PlayerTextDrawUseBox(playerid, captchaInfo[playerid][tdbox][0], 0),
		PlayerTextDrawBoxColor(playerid, captchaInfo[playerid][tdbox][0], 0x80808080),
		PlayerTextDrawSetShadow(playerid, captchaInfo[playerid][tdbox][0], 2),
		PlayerTextDrawSetOutline(playerid, captchaInfo[playerid][tdbox][0], 0),
		PlayerTextDrawBackgroundColor(playerid, captchaInfo[playerid][tdbox][0], 0x000000FF),
		PlayerTextDrawFont(playerid, captchaInfo[playerid][tdbox][0], 4),
		PlayerTextDrawSetProportional(playerid, captchaInfo[playerid][tdbox][0], 1),
		PlayerTextDrawSetSelectable(playerid, captchaInfo[playerid][tdbox][0], 0),
		ShowPlayerTD(playerid, captchaInfo[playerid][tdbox][0]);
	
	captchaInfo[playerid][tdbox][1] = CreatePlayerTextDraw(playerid, x+3, y+3, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, captchaInfo[playerid][tdbox][1], 0.480000, 1.120000);
	PlayerTextDrawTextSize(playerid, captchaInfo[playerid][tdbox][1], maxwidth-6, maxheight-6);
	PlayerTextDrawAlignment(playerid, captchaInfo[playerid][tdbox][1], 1);
	PlayerTextDrawColor(playerid, captchaInfo[playerid][tdbox][1], 0x759DA3FF);
	PlayerTextDrawUseBox(playerid, captchaInfo[playerid][tdbox][1], 0);
	PlayerTextDrawBoxColor(playerid, captchaInfo[playerid][tdbox][1], 0x80808080);
	PlayerTextDrawSetShadow(playerid, captchaInfo[playerid][tdbox][1], 2);
	PlayerTextDrawSetOutline(playerid, captchaInfo[playerid][tdbox][1], 0);
	PlayerTextDrawBackgroundColor(playerid, captchaInfo[playerid][tdbox][1], 0x000000FF);
	PlayerTextDrawFont(playerid, captchaInfo[playerid][tdbox][1], 4);
	PlayerTextDrawSetProportional(playerid, captchaInfo[playerid][tdbox][1], 1);
	PlayerTextDrawSetSelectable(playerid, captchaInfo[playerid][tdbox][1], 0);
	
	ShowPlayerTD(playerid, captchaInfo[playerid][tdbox][1]);
	
	captchaInfo[playerid][captchposx] = x + 10;
	captchaInfo[playerid][captchposy] = y + 5;
	captchaInfo[playerid][captchwidth] = maxwidth;
	captchaInfo[playerid][captchheight] = maxheight;
}

stock DestroyCaptcha_BOT(playerid)
{
	PlayerTextDrawDestroy(playerid, captchaInfo[playerid][tdbox][0]),
	DestroyPlayerTD(playerid, captchaInfo[playerid][tdbox][1]);
	
	for new i; i < 30; i++ do 
	{
		DestroyPlayerTD(playerid, captchaInfo[playerid][tdNumber][i]);
		if i < 5 *then DestroyPlayerTD(playerid, captchaInfo[playerid][tdNumberBox][i]);
	}
	captchaInfo[playerid][lastcaptchid] = 
	captchaInfo[playerid][tdtoopen] = 0;
	captchaInfo[playerid][Numberstr][0] = EOS;
	DeletePVar(playerid, "captchaOpen");
	DeletePVar(playerid, "CaptchaAPIstr");
	return DeletePVar(playerid, "lsd");
}

stock CreateCaptcha_BOT(playerid, type)
{
	if GetPVarInt(playerid, "captchaOpen") *then return false;
	
	//73.464, 172.179
	
	new Float:MAX_CAPTCHA_X = GetPlayerLauncher(playerid) == 2 ? 73.464 : 280.0, Float:MAX_CAPTCHA_Y = GetPlayerLauncher(playerid) == 2 ? 172.179 : 125.0;
	
    DestroyCaptcha_BOT(playerid);
	CreateCaptchaBox(playerid,floatrandom(MAX_CAPTCHA_X-80,MAX_CAPTCHA_X),floatrandom(MAX_CAPTCHA_Y-20,MAX_CAPTCHA_Y),floatrandom(MAX_CAPTCHA_WIDTH-20,MAX_CAPTCHA_WIDTH),floatrandom(MAX_CAPTCHA_HEIGHT-3, MAX_CAPTCHA_HEIGHT));
	for new i; i < 5; i++ do CreateNumber(playerid, i == 4 ? (random(100) <= 90 ? 0:random(10)):random(10), 0x1A2432FF, CAPTCHA_NUMBER_SIZE, CAPTCHA_NUMBER_SIZE_HEIGHT);


	for new i; i < captchaInfo[playerid][lastcaptchid]; i++ do ShowPlayerTD(playerid, captchaInfo[playerid][tdNumberBox][i]);
	for new i; i < captchaInfo[playerid][tdtoopen]; i++ do ShowPlayerTD(playerid, captchaInfo[playerid][tdNumber][i]);
	
	new CaptchaAPIstr[16];
	
	format(CaptchaAPIstr, 16, "%d,%s", type, captchaInfo[playerid][Numberstr]);
	
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
