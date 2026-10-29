#include <a_samp>

#define public:%0(%1) forward %0(%1); public %0(%1)
#define SCMALL SendClientMessageToAll
#define SCM SendClientMessage

new hostname[][128] =
{
    {"hostname ARZ NIGHTMARES | 3.000.000 AZ + | /BONUS ADM"},
    {"hostname ARZ NIGHTMARES | 3.000.000 AZ + | /BONUS ADM"},
    {"hostname ARZ NIGHTMARES | 3.000.000 AZ + | /BONUS ADM"},
    {"hostname ARZ NIGHTMARES | 3.000.000 AZ + | /BONUS ADM"}
};

public OnFilterScriptInit()
{
    SetTimer("ServerName", 1000, true);
	return 1;
}

public: ServerName() SendRconCommand(hostname[random(sizeof(hostname))]);
