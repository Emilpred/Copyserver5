stock SendVK (playerid, arguments_str[], usecallback = 1)
{
	f(global_str, sizeof global_str, "d99961hc.beget.tech/api/studio/samp/vkapi_2.php?%s&server=%s", arguments_str, Setting_Server[7]);
	HTTP(playerid, HTTP_POST, global_str, "", usecallback ? "VKResponse":"");
}

public: VKResponse(index, response_code, data[])
{
	if !(response_code == 200) *then
		data[0] = EOS;
		
	switch GetPlayerDialogID(index) do
	{
		case 2,7782:
			return SPDF(index, 7782, DIALOG_STYLE_INPUT, "{BFBBBA}{FFFFFF}Авторизация | {ae433d}ВКонтакте", "\n{ffffff}Через личное сообщение Вам на страницу\n%s {ffffff}отправлен {ae443d}код{ffffff},\nкоторый необходимо ввести в строку ниже.\n\n{ae443d}Чтобы свернуть игру и зайти в браузер,\nиспользуйте комбинацию клавиш: ALT + TAB!\n\n", !"»", !"«", data);
		
		case 7778:
		{
			if GetString(data, "-1") *then
				return SCM(index, 0x4c75a3FF, !"Вконтакте:{FFFFFF} Указанному Вами пользователю запрещено отправлять личные сообщения от страницы: {ae433d}SAMP: Arizona Role Play"),
						PlayerDialogVK(index, 1);
			
			return SPDF(index, 7779, DIALOG_STYLE_INPUT, "{FFFFFF}Ввод кода | {ae433d}ВКонтакте", "\n{ffffff}Через личное сообщение Вам на страницу\n%s отправлен {ae443d}код{ffffff},\nкоторый необходимо ввести в строку ниже.\n\n{ae443d}Чтобы свернуть игру и зайти в браузер,\nиспользуйте комбинацию клавиш: ALT + TAB!\n\n", !"»", !"«", data);
		}
		case 7779:
		{
			sscanf(data, "s[64]d", mysql_string, PI[index][pVkontakte]);
			DeletePVar(index, "Stranicia"), DeletePVar(index, "CodeVK");
			
			for new i; i < strlen(mysql_string); i++ do
			{
				if mysql_string[i] == '|' *then { mysql_string[i] = ' '; break; }
			}
			
			UpdatePlayerDataInt(index, "Vkontakte", PI[index][pVkontakte]);
					
			f(global_str, 600, "\n{FFFFFF}Информация:\n- Аккаунт: {4c75a3}%s\n{FFFFFF}- Идентификатор: {4c75a3}%d\n\n{FFFFFF}Вы {aeFF3d}успешно {ffffff}привязали игровой аккаунт к странице {4c75a3}ВКонтакте{ffffff}.\nТеперь при авторизации с {ae443d}ip-адреса {ffffff}отличного от того,\nс которого был произведен последний {ae443d}успешный {ffffff}вход\nВам будет отправлен {ae443d}код для подтверждения входа{ffffff}!\n\n", mysql_string, PI[index][pVkontakte]);
			return SPD(index, 0, DIALOG_STYLE_MSGBOX, !"{FFFFFF}Привязка | {ae433d}ВКонтакте", global_str, !"x", !"");
		}
		case 7780:
			return SPDF(index, 7781, DIALOG_STYLE_INPUT, !"{FFFFFF}Отвязка | {ae433d}ВКонтакте", "\n{ffffff}Через личное сообщение Вам на страницу\n%s {ffffff}отправлен {ae443d}код{ffffff},\nкоторый необходимо ввести в строку ниже.\n\n{ae443d}Чтобы свернуть игру и зайти в браузер,\nиспользуйте комбинацию клавиш: ALT + TAB!\n\n", !"»", !"«", data);

		case 7781:
		{
			SPDF(index, 0, DIALOG_STYLE_MSGBOX, !"{FFFFFF}Отвязка | {ae433d}ВКонтакте", "\n{FFFFFF}Информация:\n- Аккаунт: {4c75a3}%s\n{FFFFFF}- Идентификатор: {4c75a3}%d\n\n{FFFFFF}Вы {aeFF3d}успешно {ffffff}отвязали игровой аккаунт от страницы {4c75a3}ВКонтакте{ffffff}.\n\nСледующие привелегии Вам более {ae433d}недоступны:\n{ae433d}- {ffffff}Возможность двухфакторной авторизации\n{ae433d}- {ffffff}Информирование о слёте имущества\n{ae433d}- {ffffff}Информирование о предстоящих и текущих акциях\n{ae433d}- {ffffff}Оффлайн уведомления игрового аккаунта\n\n", !"x", !"", data, PI[index][pVkontakte]);
			UpdatePlayerDataInt(index, "Vkontakte", PI[index][pVkontakte] = 0);
			DeletePVar(index, "CodeVK"); 
			return false;
		}
		case 7723:
		{
			if GetString(data, "-1") *then {
				
				SCM(index, 0x4c75a3FF, !"[restorevk]:{FFFFFF} Данная страница не привязана к данному аккаунту");
				return PlayerDialogVK(index, 4);
			}
			return SPDF(index, 7724, DIALOG_STYLE_INPUT, "{BFBBBA}{FFFFFF}Восстановление | {ae433d}ВКонтакте", "\n{ffffff}Через личное сообщение Вам на страницу\n%s отправлен {ae443d}код{ffffff},\nкоторый необходимо ввести в строку ниже.\n\n{ae443d}Чтобы свернуть игру и зайти в браузер,\nиспользуйте комбинацию клавиш: ALT + TAB!\n\n", !"»", !"«", data);
		}
		case 154:
			return SPDF(index, 7777, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Информация | {ae433d}ВКонтакте", "{FFFFFF}Параметр\t{FFFFFF}Значение\n{2787F5}1. {FFFFFF}Аккаунт:\t%s\n{2787F5}2. {FFFFFF}Отвязать аккаунт\n{2787F5}3. {FFFFFF}Привязка IP\t{9ACD32}Включено{FFFFFF}", !"»", !"«", data);
		
	}
	return false;
}

stock PlayerDialogVK(playerid, list = 0)
{
	switch list do
	{
		case 0:
		{
			if PI[playerid][pVkontakte] *then
				return GetVKName(playerid, 0);
			else 
				SPD(playerid, 7777, DIALOG_STYLE_TABLIST_HEADERS, !"{FFFFFF}Информация | {ae433d}ВКонтакте", "{FFFFFF}Параметр\t{FFFFFF}Значение\n{2787F5}1. {FFFFFF}Аккаунт:\t{ae433d}Не привязан\n{2787F5}2. {FFFFFF}Привязать аккаунт\n", !"»", !"«");
		}
		case 1: return SPD(playerid, 7778, DIALOG_STYLE_INPUT, !"{FFFFFF}Соглашение | {ae433d}ВКонтакте", "\n{ffffff}Каждый раз при входе с нового {ae433d} ip-адреса {ffffff} у Вас будет запрашиваться код, который будет отправлен вам через \n{ae433d}личное сообщени{FFFFFF}.\n\nПри утере доступа к личной странице {4c75a3}ВКонтакте {ffffff}Вы так же потеряете доступ к игровому аккаунту.\nПозаботьтесь о защите личной страницы {4c75a3}ВКонтакте{ffffff}. Обезопасив личную страницу и включив данную функцию - \nВы {ae433d}надежно {ffffff}защитите свой игровой аккаунт!\n\nГлавные преимущества:\n{ae433d}- {ffffff}Возможность авторизации\n{ae433d}- {ffffff}Информация о слете имущества\n{ae433d}- {ffffff}Информация о предстоящих и текущих акциях\n{ae433d}- {ffffff}Оффлайн уведомления игрового аккаунта\n\nДля включения данной функции следуйте инструкции ниже:\n{ae433d}1. {ffffff}Перейдите по ссылке {4c75a3}https://vk.com/supreme.both {ffffff}({4c75a3}SAMP: Arizona Role Play{ffffff})\n{ae433d}2. {ffffff}Разрешите сообщения от группы через кнопку {ae433d}\"Разрешить сообщения\"\n{ae433d}3. {ffffff}Вставьте ссылку на свою страницу {4c75a3}ВКонтакте {ffffff}в поле ниже и нажмите {ae433d}\"Далее\"\n\n", !"»", !"«");
		case 2: return SPD(playerid, 7780, DIALOG_STYLE_MSGBOX, !"{FFFFFF}Отвязка | {ae433d}ВКонтакте", !"{FFFFFF}Вы действительно желайте снять привязку {4c75a3}ВКонтакте{FFFFFF}?", !"»", !"«");
		case 3:
		{
			new code = 100000+random(900000);
			SetPVarInt(playerid, "CodeVK", code);
			
			f(mysql_string, 400, "vk_id=%d&msg=%d&list=3&nickname=%s", PI[playerid][pVkontakte], code, PN(playerid));
			SendVK(playerid, mysql_string);
		}
		case 4: return SPD(playerid, 7723, DIALOG_STYLE_INPUT, !"{FFFFFF}Восстановление | {ae433d}ВКонтакте", !"{ffffff}Введите ссылку на привязанную к аккаунту страницу {4c75a3}Вконтакте", !"»", !"«");
	}
	return false;
}

stock GetVKName(playerid, did = 1)
{	
	f(mysql_string, 400, "vk_id=%d&list=2", PI[playerid][pVkontakte]);
	SendVK(playerid, mysql_string);
	return DialogListID[playerid] = did;
}