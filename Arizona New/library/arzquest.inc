
enum p_quest_bonus {
	
	P_QUEST_ID,
	P_QUEST_PROGRESS
};

new const P_QuestBonus[MAX_PLAYERS][p_quest_bonus];

enum bonus_quest_data {
	
	bQuestName[100],
	bQuestStory[500],
	bQuestPayHour,
	bQuestMaxProgress
};


new const QuestBonus[][bonus_quest_data] = {
	
	{"Что-то странное в лесу...", "На днях фермеры работающие в шахте слышали странные стоны доносящиеся из глубины океана.\nРаботники года так и не смогли понять в чем дело, поэтому сообщили мне чтобы я им помог.\nНо так как я не могу им помочь в данный момент, за меня мою работу выполнишь ты.", 25, 2},
	{"Амнезия", "... Хватит, ну е-мае, Братан, отпусти ее\nНе помню.. ничего не помню, какое сегодня число, год? Что со мной было..", 50, 3},
	{"Я у мамы математик", "Йоу.... братанчик\nВ этом году в штате проходит олимпиада по математике, она очень легкая\nпойдика пройди её.", 50, 1}
	//{"Несправедливая реальность", "Единственное перед чем все равно это, несправедливая реальность.", 50, 3}

};


new const QuestBonusStory[][][] = {

	{"Приезжайте на координаты которые будут отмечены у вас на GPS после нажатия клавиши \'Далее\'.\nПосле чего поговорите с Ронни.", "Подтягивайся на точку и сделай красивую фотографию леса.", ""},
	{"В опасном районе под мостом был обнаружен человек без признаков жизни,\nно не все так просто... Поедь и узнай что там случилось.", "На смертном одре Рафаель собрался с силами и рассказал где спрятано нечто секретное.\nНе дай смерти Рафаеля быть напрасной, исполни его волю.\nЕго желание было написано и спрятано под деревом,\nместоположение древа где находится записка уже тебе известно.", "Заминируйте гараж главного из отребьей перешедшему дорогу Рафаилу.\nТем самым безжалостно убив его.\nНа этом свете не должно быть таких меркантильнентальных личностей как он."},
	{"Приезжай на точку отмеченную у тебя на GPS и пройди олимпиаду.", "", ""}
};

new const QuestQuestions[][][] = {
	
	{"10 * 10", "100"},
	{"90 / 2", "45"},
	{"S = (a + b) * 2\na = 20, b = 5\nЧему равно S?", "50"},
	{"Корень из 144", "12"},
	{"Первая цифра числа ПИ?", "3"}

};


cmd:arzquest(playerid)
{
	global_str = "{FFFFFF}Название квеста\t{FFFF00}Прогресс\n";

	for new i; i < sizeof (QuestBonus); i++ do {

		strcat(global_str, (str_f("\n%s\t%s", QuestBonus[i][bQuestName], P_QuestBonus[playerid][P_QUEST_ID] > i ? "{73B461}[Выполнен]{FFFFFF}":"{D5736E}[Не выполнен]{FFFFFF}")));

	}

	return SPD(playerid, 9924, DIALOG_STYLE_TABLIST_HEADERS, !"Бонусная квестовая линия", global_str, !"Далее", !"Отмена");
}

stock QuestBonus_next(playerid, bool:up_etap = false)
{
	new data = P_QuestBonus[playerid][P_QUEST_PROGRESS], id = P_QuestBonus[playerid][P_QUEST_ID];

	if up_etap == false *then { 

		data ++;

		P_QuestBonus[playerid][P_QUEST_PROGRESS] = data;

		if P_QuestBonus[playerid][P_QUEST_PROGRESS] == QuestBonus[id][bQuestMaxProgress] *then {

			// выдача призов тут

			P_QuestBonus[playerid][P_QUEST_PROGRESS] = 0;
			P_QuestBonus[playerid][P_QUEST_ID] ++;
			
			PI[playerid][pPlayHour] += QuestBonus[id][bQuestPayHour];

			SPDF(playerid, 0, DIALOG_STYLE_MSGBOX, !"Вознаграждение за квест", "{FFFFFF}Вы успешно прошли задание и получили: {D5736E}- {FFFFFF}%d час(ов) в /arz", !"Спасибо", !"", QuestBonus[id][bQuestPayHour]);
		}

		SQL("UPDATE arzquest SET quest_id = %d, quest_progress = %d WHERE player_id = %d LIMIT 1;", P_QuestBonus[playerid][P_QUEST_ID], P_QuestBonus[playerid][P_QUEST_PROGRESS], PI[playerid][pID]);

		if !(P_QuestBonus[playerid][P_QUEST_ID] == id) *then
			return true;
	}

	switch id do 
	{
		case 0: {

			switch data do {

				case 0: {
					
					EnableGPSForPlayer(playerid, -1404.3688,-1925.4354,22.0040);
					SCM(playerid, COLOR_VALIK, !"[Информация]{FFFFFF} Местоположение Ронни отмечено у вас на миникарте.");
				}

				case 1: {

					EnableGPSForPlayer(playerid, -1877.7156,-1897.4963,88.5346);

					_GiveGun(playerid, 43, 10);

				}
			}
			
		}

		case 1: {

			switch data do {
				
				case 0: {

					EnableGPSForPlayer(playerid, 2200.4019,-1532.5143,10.8281);
				}

				case 1: {
					
					EnableGPSForPlayer(playerid, 955.1244,-1874.4138,8.6123);
					SCM(playerid, COLOR_GREY, !"Исполни мою волю... измени будущие.");

				}

				case 2: {
					
					EnableGPSForPlayer(playerid, 767.2220,-582.0569,17.3359);
					SCM(playerid, COLOR_VALIK, !"[Инфорация]{FFFFFF} Для выполнения квеста вам нужно заминировать гараж будущего лидера мафии \'Don La Gandon\'.");
				}
			}
		}

		case 2: {

			switch data do {
				
				case 0: {

					EnableGPSForPlayer(playerid, -2703.4348,373.1399,4.9689);
				}
			}

		}
	}

	return SCM(playerid, COLOR_OLDRED, !"[Информация]{FFFFFF} Если вы забыли что от вас требуется или не поняли => /arzquest");
}


stock QuestBonusData(playerId, data)
{
	if !(P_QuestBonus[playerId][P_QUEST_ID] - data == 0) *then
		return SCM(playerId, COLOR_OLDRED, !"[Ошибка]{FFFFFF} Выполняйте бонусные квесты по порядку!");

	format(global_str, 1250, "\
	\t\t\t\t\t{D5736E}%s{FFFFFF}\n\n\
	{FFFF00}Пролог: {FFFFFF}%s\n\n\
	{FFFF00}За выполнение задания вам дадут:\n\
	{D5736E}- {FFFFFF}%d час(ов) в /arz\n\n\
	{FFFF00}Прогресс выполнения квеста: {FFFFFF}%d из %d.\n\n\
	{FFFF00}Что делать?: {FFFFFF}%s",
	
	QuestBonus[data][bQuestName],
	QuestBonus[data][bQuestStory],
	QuestBonus[data][bQuestPayHour],
	P_QuestBonus[playerId][P_QUEST_PROGRESS],
	QuestBonus[data][bQuestMaxProgress],
	QuestBonusStory[data][P_QuestBonus[playerId][P_QUEST_PROGRESS]]);


	return SPD(playerId, 9923, DIALOG_STYLE_MSGBOX, !"Бонусная квестовая линия", global_str, !"Далее", !"Отмена");
}

stock GetBonusQuest(playerid, data) {

	if !(data == P_QuestBonus[playerid][P_QUEST_ID]) *then
		return -1;
		
	return P_QuestBonus[playerid][P_QUEST_PROGRESS];

}

public: QuestBonusLoad(playerid) {

	if cache_get_row_count() *then {

		global_str = "[Информация]{FFFFFF} Ваш прогресс успешно восстановлен: /arzquest";

		P_QuestBonus[playerid][P_QUEST_ID] = cache_get_row_int(0, 1, mysql);
		P_QuestBonus[playerid][P_QUEST_PROGRESS] = cache_get_row_int(0, 2, mysql);

	}
	else {

		global_str = "[Информация]{FFFFFF} Новые бонусные квесты уже ждут вас, /arzquest ( Ваш прогресс не найден. )";

		P_QuestBonus[playerid][P_QUEST_ID] = 
		P_QuestBonus[playerid][P_QUEST_PROGRESS] = 0;

		SQL("INSERT INTO arzquest (`player_id`) VALUES ('%d')", PI[playerid][pID]);
	}
	
	return SCM(playerid, COLOR_OLDRED, global_str);
}