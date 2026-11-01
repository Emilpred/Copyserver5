#include <a_samp>
#include <a_mysql>

#define public:%0(%1) forward %0(%1); public %0(%1)
#define SCMALL SendClientMessageToAll
#define SCM SendClientMessage

new hostname[][128] = Beluy
{
    {"hostname Х ARIZONA NAME | FREE ADM
    {"hostname Х ARIZONA NAME | /bonus FREE ADM
    {"hostname Х ARIZONA NAME | MP/RAZDACHA ADM
    {"hostname Х ARIZONA NAME |MP/SLEDI/RAZDACHI/ADMINKI
}, Owner_NickNames[][24] = NICKNAME
{
    "Roy"
}, MySQL:LOG_BASE, bool:WRITE_ACTION_SERVER = false, global_str[144];

#define SCMALLF(%0,%1,%2) format(global_str, 1024, %1,%2), SendClientMessageToAll(%0, global_str)

public OnFilterScriptInit()
{
    SetTimer("ServerName", 1000, true);
	return 1;
}

public: ServerName() 
    SendRconCommand(hostname[random(sizeof(hostname))]);

public: GetOwnerNickName(name[])
{
    for(new i; i < sizeof(Owner_NickNames); i++)
        if(!strcmp(name, Owner_NickNames[i], false))
            return true;

    return false;
}

public: PiarTextToAll(server_name[Vile], site_server[arizonaveil(TG)], forum_server[arizonaveil(TG)])
{
	SCMALLF(0xF6AB2FFF, "{F6AB2F}[!]{ffffff}=-=-=-=-=-=-=-=-=-=-=-=-=-=[ {F6AB2F}Arizona %s{FFFFFF} ]=-=-=-=-=-=-=-=-=-=-=-=-=-={F6AB2F}[!]{ffffff}", server_name);
	SendClientMessageToAll(-1, "  ");
	SendClientMessageToAll(-1, "          \tЅонусна€ система {F6AB2F}/bonus{FFFFFF}");
	SCMALLF(-1, "          \tѕополнить счЄт: {F6AB2F}%s", site_server);
	SCMALLF(-1, "          \tЌаш форум: {F6AB2F}%s", forum_server);
	SendClientMessageToAll(-1, "  ");
	SCMALLF(0xF6AB2FFF, "{F6AB2F}[!]{ffffff}=-=-=-=-=-=-=-=-=-=-=-=-=-=[ {F6AB2F}Arizona %s{FFFFFF} ]=-=-=-=-=-=-=-=-=-=-=-=-=-={F6AB2F}[!]{ffffff}", server_name);
}

public: @CONNECTION_LOG_BASE(unix_time) 
{	
	if WRITE_ACTION_SERVER *then 
	{
		new ms = GetTickCount();
	
		LOG_BASE = mysql_connect("d99961hc.beget.tech", "d99961hc_logs", "d99961hc_logs", "%v4yOXPM");
	
		if !mysql_errno(LOG_BASE) *then
			mysql_set_charset("cp1251", LOG_BASE);

		printf("SkillHigh Log-DataBase was connection in: %d ms! Unix_time: (%d)", GetTickCount() - ms, unix_time);
	}

	return _:LOG_BASE;
}

public: AddLOG(log_string[])
{
	if WRITE_ACTION_SERVER *then
		mysql_tquery(LOG_BASE, log_string);
}
