/*--------[Launcher]--------*/
native SetLauncherStatus(playerid, bool:status);//Устанавливает статус лаунчера игрока. Если указан true, то у игрока будут работать авто, CEF вызовы и другие функции лаунчера.
native GetLauncherStatus(playerid);//Возвращает статус лаунчера игрока.

native Arz_SetPlayerCollision(playerid, bool:status);//Устанавливает статус коллизии игрока. Если указан false, то игрок сможет проходить сквозь игроков и авто.
native Arz_GetPlayerCollisionStatus(playerid);//Возвращает статус коллизии игрока.

#define MAX_ARIZONA_TUNING_SLOTS (8)
#define ARIZONA_TUNING_SLOT_BONNET (1)
#define ARIZONA_TUNING_SLOT_EXHAUST (2)
#define ARIZONA_TUNING_SLOT_SPOILER (3)
#define ARIZONA_TUNING_SLOT_WHEELS (4)
native Arz_SetVehicleComponent(vehicleid, slot, componentid);
/*
	[native Arz_SetVehicleComponent]
	Установка тюнинга для авто.
	Пример использования: Arz_SetVehicleComponent(1, ARIZONA_TUNING_SLOT_BONNET, 7412); - в таком случае машине под ID 1 будет установлен тюнинг в слот капота под ID 7412 (капот gtsamg).
	Слоты необходимо указывать вручную.
	Чтобы убрать тюнинг, componentid указываете 0
*/
native Arz_GetVehicleComponentInSlot(vehicleid, slot);
#define ARIZONA_NUMBERPLATE_DISABLE (0)
#define ARIZONA_NUMBERPLATE_COUNTRY_KZ (1)
#define ARIZONA_NUMBERPLATE_COUNTRY_RU (2)
#define ARIZONA_NUMBERPLATE_COUNTRY_UA (3)
#define ARIZONA_NUMBERPLATE_COUNTRY_BY (4)
#define ARIZONA_NUMBERPLATE_COUNTRY_NONE (5)
native Arz_SetVehicleNumberPlate(vehicleid, country, numberplate[], region[]);
/*
	[native Arz_SetVehicleNumberPlate]
	Установка номерных знаков для авто.
	Пример использования: Arz_SetVehicleNumberPlate(1, ARIZONA_NUMBERPLATE_COUNTRY_KZ, "TEST", "AZ"); - это установит номерной знак страны KZ для авто с ID 1, с номером TEST и регионом AZ
*/
/*--------[Interface]--------*/
enum
{
	/*
		[OLD Interface Functions]
		Данные функции работают только на лаунчере Arizona R1 и старом Mobile, где нет поддержки CEF.
	*/
	_Arz_Speedometer, //Спидометр | 0 - выключен, 1 - первый тип, 2 - второй тип
	_Arz_Hud, //Худ | 0 - выключен, 1 - первый тип, 2 - второй тип
	_Arz_Radar, //Радар | 0 - выключен, 1 - первый тип, 2 - второй тип
	_Arz_Fuel, //Бензин | От 0 до 100
	_Arz_Hunger, //Голод | От 0 до 100
	_Arz_TransparentChat, //Прозрачный чат | 0 - выключен, 1 - включен
	_Arz_SaveDialog, //Сохранение диалога | 0 - выключен, 1 - включен
	_Arz_NewNametag, //Новый нэймтег | 0 - выключен, 1 - включен
	_Arz_Snow, //Снег | 0 - выключен, 1 - включен
	_Arz_RenderDialog, //Рендер диалогов  | 0 - полная, 1 - упрощенный, 2 - простой
	/*
		[NEW Interface Functions]
		Данные функции работают только на лаунчере Arizona R3 и новом Mobile, где есть поддержка CEF
	*/
	Arz_Speedometer, //Спидометр | 0 - выключен, 1 - первый тип, 2 - второй тип
	Arz_Hud, //Худ | 0 - выключен, 1 - первый тип (San Andreas), 2 - второй тип (Vice City)
	Arz_Radar, //Радар | 0 - выключен, 1 - первый тип, 2 - второй тип, 3 - третий тип (Vice City)
	Arz_Fuel, //Бензин | От 0 до 100
	Arz_Hunger, //Голод | От 0 до 100
	Arz_Hints, //Подсказки | 0 - показано, 1 - скрыто
	Arz_TransparentChat, //Прозрачный чат | 0 - выключен, 1 - включен
	Arz_SaveDialog, //Сохранение диалога | 0 - выключен, 1 - включен
	Arz_NewNametag, //Новый нэймтег | 0 - выключен, 1 - включен
	Arz_Snow, //Снег | 0 - выключен, 1 - включен
	Arz_RenderDialog, //Рендер диалогов  | 0 - полная, 1 - упрощенный, 2 - простой
	Arz_Notification, //Уведомления | Аргументы: type[Тип уведомления: 0 - info, 1 - success, 2 - error], param_str_1[Текст уведомления]
	Arz_CEF_CreateBrowser, //Пример использования Interface_Arizona(playerid, Arz_CEF_CreateBrowser, 1 (ID браузера), "https://test.com/test.html"); Чтобы удалить браузер, в поле для ввода ссылки введите пустую строку ("")
	Arz_CEF_ExecuteEvent, //Пример использования Interface_Arizona(playerid, Arz_CEF_ExecuteEvent, 1 (ID браузера), "window.executeEvent('event.notify.initialize', '[\"success\",\"Уведомление\",\"Тест\",1500]');");
	Arz_CEF_EnableCursor, //Включить курсор | Аргументы: type[ID браузера]
	Arz_CEF_DisableCursor //Выключить курсор | Аргументы: type[ID браузера]
};
native Interface_Arizona(playerid, interface_id, type, param_str_1[] = "");
/*
	[native Interface_Arizona]
	Функция используется для взаимодействием с интерфейсом игрока.
	Пример использования: Interface_Arizona(playerid, Arz_Hud, 2); - в таком случае, игроку будет показан HUD Vice City.
	Если вы используете CEF вызовы (прим. Arz_CEF_ExecuteEvent, можно указать ID браузера -1, чтобы использовать заранее созданный браузер лаунчером Arizona RP Sanya Games (Будет использован ID: 98723662))
	Если вы не используете лаунчер Arizona RP Sanya Games, вам необходимо создать браузер при входе в игру. (см. Arz_SetLauncherBrowsersID)
*/
native Arz_SetLauncherInfo(project[], type[], title[], server_id, logo_id, flag_id, payday_multipler);
/*
	[native Arz_SetLauncherInfo]
	Если не устанавливать информацию о лаунчере, будут использованы следующие данные:
	project_name = Arizona
	type = Role play
	title = Server
	server_id = 1
	logo_id = 1
	flag_id = 0
	payday_multipler = 0
*/
native Arz_SetLauncherBrowsersID(cef_vue_js_id, cef_svelte_js_id);
/*
	[native Arz_SetLauncherBrowsersID]
	Функция отвечает за установку стандартных ID браузеров в лаунчере.
	Эти ID используются для функций Interface_Arizona.
	Лаунчер Arizona RP от Sanya Games по умолчанию создаёт браузер при входе в игру,
	что позволяет использовать стандартные вызовы CEF без необходимости предварительно создавать браузер со стороны сервера.
	По умолчанию установлены:
    cef_vue_js_id = 62623742
    cef_svelte_js_id = 98723662
*/

/*--------[Custom Skins Models]--------*/
forward GetLauncherSkinModel(current_model);
public GetLauncherSkinModel(current_model)
{
	new model = -1;
	switch(current_model)
	{
	    case 312: model = 296;
	    case 313: model = 230;
	    case 908: model = 200;
	}
	return model;
}
/*--------[Custom Vehicles Models]--------*/
forward GetLauncherVehicleModel(current_model);
public GetLauncherVehicleModel(current_model)
{
	new model = -1;
	switch(current_model)
	{
	    case 612: model = 541;
	    case 613: model = 451;
	    case 614: model = 411;
		case 662: model = 400;
		case 668: model = 541;
		case 1196: model = 451;
		case 3194: model = 522;
	}
	return model;
}

forward OnPlayerResolutionUpdate(playerid, X_1, Y_1, X_2, Y_2);//Вызывается при смене разрешения экрана у игрока.
forward OnPlayerSendCefQuery(playerid, function_id, query[]);//Вызывается при CEF вызовах со стороны игрока