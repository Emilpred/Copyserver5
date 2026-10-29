
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
			if pTemp[i][tAuthorized] *then
			{	
				return false;
			}

			return true;
		}
	}

	return 2;
}

IRPC:25(playerid, BitStream:bs)
{
	new JoinData[PR_JoinData];
	BS_ReadJoinServer(bs, JoinData);
	
	if ANTI_RAK_BOT *then
		BS_Delete(bs);

	SetString(PlayerName[playerid], JoinData[PR_NickName]);
	LauncherState[playerid] = GetString(JoinData[PR_ClientVersion], "Arizona PC") ? 1 : GetString(JoinData[PR_ClientVersion], "arizona-mobile") ? 2 : 0;
	//SetLauncherStatus(playerid, ( GetString(JoinData[PR_ClientVersion], "Arizona PC") or GetString(JoinData[PR_ClientVersion], "arizona-mobile") ) ? true:false);

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

public OnOutgoingRPC(playerid, rpcid, BitStream:bs)
{
	if(rpcid == 164)
	{
		new wVehicleID, offsetSize;

		BS_ReadInt16(bs, wVehicleID);

		if(GetVehicleModelEx(wVehicleID) >= 612 && GetPlayerLauncher(playerid)) 
		{
			BS_GetWriteOffset(bs, offsetSize), BS_SetWriteOffset(bs, 16);
			BS_WriteInt32(bs, GetVehicleModelEx(wVehicleID));
			BS_SetWriteOffset(bs, offsetSize);
		}
	}

	else if(rpcid == 32)
	{
		new wPlayerID, dSkinId;

		BS_ReadValue(bs, PR_UINT16, wPlayerID, PR_IGNORE_BITS, 8, PR_UINT32, dSkinId);

		if(dSkinId > 311)
			SetPlayerSkin(wPlayerID, GetPlayerLauncher(playerid) ? dSkinId : GetSkinInfo(dSkinId, 3));
	}

	return true;
}

IRawPacket:20(playerid, BitStream:bs) 
{ 
	new packetid, rpcid, NumberOfBitsOfData; 

	BS_ReadValue(bs, PR_UINT8, packetid, PR_UINT8, rpcid, PR_CUINT32, NumberOfBitsOfData); 
	
	if(packetid == 40 || (NumberOfBitsOfData >= 0x1FFFFF || NumberOfBitsOfData <= 0x80000000 || NumberOfBitsOfData < 0)) 
		return BanEx(playerid, "Raknet Bot"), false; 
		
	return true; 
}