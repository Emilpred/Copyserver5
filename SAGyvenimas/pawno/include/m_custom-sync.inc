native SetLauncherStatus(playerid, bool:status);
native GetLauncherStatus(playerid);

enum
{
	Arz_Speedometer, /*Спидометр | 0 - выключен, 1 - первый тип, 2 - второй тип*/
	Arz_Hud, /*Худ | 0 - выключен, 1 - первый тип, 2 - второй тип*/
	Arz_Radar, /*Радар | 0 - выключен, 1 - первый тип, 2 - второй тип*/
	Arz_Fuel, /*Бензин*/
	Arz_Hunger, /*Голод*/
	Arz_Hints, /*Подсказки | 0 - показано, 1 - скрыто (Не работает)*/
	Arz_TransparentChat, /*Прозрачный чат | 0 - выключен, 1 - включен*/
	Arz_SaveDialog, /*Сохранение диалога | 0 - выключен, 1 - включен*/
	Arz_NewNametag, /*Новый нэймтег | 0 - выключен, 1 - включен*/
	Arz_Snow, /*Снег | 0 - выключен, 1 - включен*/
	Arz_RenderDialog /*Рендер диалогов  | 0 - полная, 1 - упрощенный, 2 - простой*/
};
native Interface_Arizona(playerid, interface_id, type);

public: GetLauncherSkinModel(current_model)
{
	new model = -1;
	switch current_model do
	{
	    case 312: model = 21;
		case 313: model = 43;
		case 314: model = 24;
		case 315: model = 26;
		case 316: model = 47;
		case 317: model = 29;
		case 318: model = 30;
		case 319: model = 223;
		case 329: model = 152;
		case 332: model = 101;
		case 340: model = 247;
		case 382: model = 111;
		case 383: model = 121;
		case 398: model = 155;
		case 399: model = 146;
		case 795: model = 234;
		case 796: model = 165;
		case 797: model = 159;
		case 798: model = 126;
		case 799: model = 115;
		case 907: model = 194;
		case 908: model = 186;
		case 1206: model = 104;
		case 1326: model = 0;
		case 1573: model = 101;
		case 1699: model = 111;
		case 2883: model = 242;
		case 2884: model = 264;
		case 3136: model = 123;
		case 3137: model = 136;
		case 3138: model = 168;
		case 3139: model = 154;
		case 3140: model = 177;
		case 3141: model = 178;
		case 3142: model = 165;
		case 3143: model = 230;
		case 3144: model = 230;
		case 3145: model = 230;
		case 3146: model = 230;
		case 3147: model = 230;
		case 3148: model = 230;
		case 3149: model = 230;
		case 3150: model = 230;
		case 3151: model = 230;
		case 3152: model = 230;
		case 3153: model = 230;
		case 3154: model = 230;
		case 3159: model = 230;
		case 3160: model = 230;
		case 3161: model = 230;
		case 3162: model = 230;
		case 3163: model = 230;
		case 3164: model = 230;
		case 3165: model = 230;
		case 3166: model = 230;
		case 3176: model = 230;
		case 3177: model = 230;
		case 3179: model = 230;
		case 3180: model = 230;
		case 3181: model = 230;
		case 3182: model = 230;
		case 3183: model = 230;
		case 3184: model = 230;
		case 3185: model = 286;
		case 3186: model = 295;
		case 3188: model = 230;
		case 3189: model = 230;
		case 3190: model = 230;
		case 3191: model = 230;
		case 3192: model = 230;
		case 3225: model = 230;
		case 3226: model = 230;
		case 3227: model = 230;
		case 3228: model = 230;
		case 3229: model = 230;
		case 3230: model = 230;
		case 3231: model = 230;
		case 3349: model = 230;
		case 3416: model = 230;
		case 3429: model = 230;
		case 3610: model = 230;
		case 3611: model = 230;
		case 3784: model = 230;
		case 3870: model = 230;
		case 3871: model = 230;
		case 3883: model = 230;
		case 3889: model = 230;
	}
	return model;
}

public: GetLauncherVehicleModel(current_model)
{
	new model = -1;
	switch current_model do
	{
		case 612: model = 560;
		case 613: model = 579;
		case 614: model = 560;
		case 662: model = 579;
		case 663: model = 411;
		case 665: model = 560; // sultan
		case 666: model = 579;
		case 667: model = 415; // cheetah
		case 668: model = 579; // huntley
		case 699: model = 411; // infernus
		case 793: model = 541; // bullet
		case 794: model = 411;
		case 909: model = 411;
		case 965: model = 579;
		case 1194: model = 579;
		case 1195: model = 579;
		case 1196: model = 603;
		case 1197: model = 415;
		case 1198: model = 560;
		case 1199: model = 579;
		case 1200: model = 560;
		case 1201: model = 560;
		case 1202: model = 603;
		case 1203: model = 579;
		case 1204: model = 579;
		case 1205: model = 560;
		case 3155: model = 541;
		case 3156: model = 560;
		case 3157: model = 579;
		case 3158: model = 579;
		case 3194: model = 521;
		case 3195: model = 522;
		case 3196: model = 522;
		case 3197: model = 522;
		case 3198: model = 463;
		case 3199: model = 579;
		case 3200: model = 562;
		case 3201: model = 541;
		case 3202: model = 541;
		case 3203: model = 562;
		case 3204: model = 579;
		case 3205: model = 579;
		case 3206: model = 415;
		case 3207: model = 579;
		case 3208: model = 560;
		case 3209: model = 560;
		case 3210: model = 560;
		case 3211: model = 560;
		case 3212: model = 562;
		case 3213: model = 579;
		case 3215: model = 560;
		case 3216: model = 560;
		case 3217: model = 560;
		case 3218: model = 560;
		case 3219: model = 560;
		case 3220: model = 541;
		case 3222: model = 541;
		case 3223: model = 541;
		case 3224: model = 487;
		case 3232..3234: model = 579;
		case 3235: model = 589;
		case 3236: model = 415;
		case 3237..3240, 3245, 3248, 3251: model = 560;
		case 3247: model = 541;

		case 3254: model = 562;
		case 3266: model = 562;
		case 3348: model = 562;
		case 4800: model = 593;
		case 4802,4803: model = 596;
		
		case 12734: model = 403;
		case 12725: model = 403;
		case 12740: model = 403;
	}
	return model;
}