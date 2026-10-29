
enum PR_JoinData
{
	PR_iVersion,
	PR_byteMod,
	PR_byteNicknameLen,
	PR_NickName[24],
	PR_uiClientChallengeResponse,
	PR_byteAuthKeyLen,
	PR_auth_key[50],
	PR_iClientVerLen,
	PR_ClientVersion[30]
};

stock BS_ReadJoinServer(BitStream:bs, data[PR_JoinData])
{
    BS_ReadValue(
        bs,
        PR_INT32, data[PR_iVersion],
		PR_UINT8, data[PR_byteMod],
		PR_UINT8, data[PR_byteNicknameLen],
		PR_STRING, data[PR_NickName], data[PR_byteNicknameLen],
		PR_UINT32, data[PR_uiClientChallengeResponse],
		PR_UINT8, data[PR_byteAuthKeyLen],
		PR_STRING, data[PR_auth_key], data[PR_byteAuthKeyLen],
		PR_UINT8, data[PR_iClientVerLen]
	);

	BS_ReadValue(
		bs,
		PR_STRING, data[PR_ClientVersion], (data[PR_iClientVerLen] >= 30 ? 30:data[PR_iClientVerLen]) 
	);
}

stock BS_WriteJoinServer(BitStream:bs, data[PR_JoinData])
{
    BS_WriteValue(
        bs,
        PR_INT32, data[PR_iVersion],
		PR_UINT8, data[PR_byteMod],
		PR_UINT8, data[PR_byteNicknameLen],
		PR_STRING, data[PR_NickName],
		PR_UINT32, data[PR_uiClientChallengeResponse],
		PR_UINT8, data[PR_byteAuthKeyLen],
		PR_STRING, data[PR_auth_key],
		PR_UINT8, data[PR_iClientVerLen],
		PR_STRING, data[PR_ClientVersion]
	);
}

stock CheckPlayerLogged(playerid, Name[])
{
	foreach(Player, i)
	{
		if playerid == i *then 
			continue; 

		if !strcmp(PlayerName[i], Name, true) *then
		{
			if IsPlayerLogged{i} *then
			{	
				return false;
			}

			return true;
		}
	}

	return 2;
}

const PLAYER_SERVER_JOIN = 25;

IRPC:PLAYER_SERVER_JOIN(playerid, BitStream:bs)
{
	new JoinData[PR_JoinData];
	BS_ReadJoinServer(bs, JoinData);
	
	if ANTI_RAK_BOT *then
		BS_Delete(bs);
	
	log("JoinServer => {\n\
		\tPR_iVersion - %d,\n\
		\tPR_byteMod - %d,\n\
		\tPR_byteNicknameLen - %d,\n\
		\tPR_NickName - %s,\n\
		\tPR_uiClientChallengeResponse - %d,\n\
		\tPR_byteAuthKeyLen - %d,\n\
		\tPR_auth_key - %s,\n\
		\tPR_iClientVerLen - %d,\n\
		\tPR_ClientVersion - %s\n\
		};", JoinData[PR_iVersion], JoinData[PR_byteMod], JoinData[PR_byteNicknameLen], JoinData[PR_NickName], JoinData[PR_uiClientChallengeResponse], JoinData[PR_byteAuthKeyLen], JoinData[PR_auth_key], JoinData[PR_iClientVerLen], JoinData[PR_ClientVersion] );
	
	SetString(PlayerName[playerid], JoinData[PR_NickName]);
	LauncherState[playerid] = ( GetString(JoinData[PR_ClientVersion], "Arizona PC") or GetString(JoinData[PR_ClientVersion], "arizona-mobile") ) ? 1:0;
	SetLauncherStatus(playerid, ( GetString(JoinData[PR_ClientVersion], "Arizona PC") or GetString(JoinData[PR_ClientVersion], "arizona-mobile") ) ? true:false);

	if ANTI_RAK_BOT *then
	{
		new BitStream:BIT = BS_New();

		SetString(JoinData[PR_NickName], (str_f("Player_%d(%d)", random(22222)+111111, playerid)));
		JoinData[PR_byteNicknameLen] = strlen(JoinData[PR_NickName]);
		
		BS_WriteJoinServer(BIT, JoinData);
		PR_EmulateIncomingRPC(BIT, playerid, 25);
		BS_Delete(BIT);
		return false;
	}
	
	return true;
}
