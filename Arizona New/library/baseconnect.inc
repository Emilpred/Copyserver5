	// ftp - qv91o81ILw
	//mysql = mysql_connect("localhost", "gromov", "server", "gromov2283351");
	
	if GetString(global_str, "127.0.0.1") *then
		mysql = mysql_connect("localhost", "root", "arizona", "");

	else if GetString(global_str, "45.95.203.117") *then
		mysql = mysql_connect("localhost", "root", "arizona", "q7ewVX4gkCEvHGfb");
		
	else
		mysql = mysql_connect("51.68.139.153", "country_bonus", "country_bonus", "XihKO7nCEfk1IfeN");
	//mysql = mysql_connect("triniti.ru-hoster.com", "arzpgMYg", "arzpgMYg", "!wjJWHbC~:RBbi@0lVZn=9!P~{4!P|tC");
	
	//mysql = mysql_connect("triniti.ru-hoster.com", "sammaAod", "sammaAod", "Ersatoptoptoptoptop"), SendRconCommand("password tes8918187");

	if !mysql_errno(mysql) *then
		print("  [Data Base]: Ошибок не выявлено, загрузка продолжается!");
	else
		printf("  [Data Base]: Найденна ошибка '%d', повторяем подключение.", mysql_errno(mysql));