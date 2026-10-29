// OPTIMIZATION BY CS 

stock UpdatePlayerDataFloat(playerid, fieldss[], Float:data)
	return SQL("UPDATE `accounts` SET `%s` = '%.4f' WHERE `ID` = '%d'",fieldss, data, PI[playerid][pID]);

stock UpdatePlayerDataStr(playerid, fieldss[], data[])
	return  SQL("UPDATE `accounts` SET `%s` = '%s' WHERE `ID` = '%d'", fieldss, data, PI[playerid][pID]);

stock UpdatePlayerDataInt(playerid, fieldss[], data)
	return SQL("UPDATE `accounts` SET `%s` = '%d' WHERE `ID` = '%d'",fieldss, data, PI[playerid][pID]);
