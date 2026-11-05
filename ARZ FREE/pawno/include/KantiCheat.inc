#include <Pawn.RakNet>

enum ac_player_info
{
    Float:ac_LastPos[3],
    ac_LastMassegeTick
};

new 
    AntiCheat_PData[MAX_PLAYERS][ac_player_info];

public OnIncomingPacket(playerid, packetid, BitStream:bs)
{
    switch packetid do
    {
        case 200:
        {
            new onDriverData[PR_InCarSync], PLAYER_STATE = GetPlayerState(playerid);
            BS_IgnoreBits(bs, 8);
            BS_ReadInCarSync(bs, onDriverData);

            if AC_CODE_TRIGGER_TYPE[10] && PLAYER_STATE == PLAYER_STATE_DRIVER *then
            {
                if GetPlayerVehicleSpeedZ(playerid) > float(GetVehicleMaxSpeed(GetVehicleModel(onDriverData[PR_vehicleId]))) + 10.0 *then
                    OnCheatDetected(playerid, 10);
            }
            
            BS_ResetReadPointer(bs);
        }
        case 207:
        {
            new onFootData[PR_OnFootSync], Float:X, Float:Y, Float:Z, Float:ac_dist, PLAYER_STATE = GetPlayerState(playerid);
            BS_IgnoreBits(bs, 8);
            BS_ReadOnFootSync(bs, onFootData);

            ///
            if AC_CODE_TRIGGER_TYPE[2] && PLAYER_STATE == PLAYER_STATE_ONFOOT *then
            {
                ac_dist = 80.0;
                if !(AntiCheat_PData[playerid][ac_LastPos][0] == 0.0) *then
                    X = AntiCheat_PData[playerid][ac_LastPos][0], 
                    Y = AntiCheat_PData[playerid][ac_LastPos][1],
                    Z = AntiCheat_PData[playerid][ac_LastPos][2],
                    AntiCheat_PData[playerid][ac_LastPos][0] = AntiCheat_PData[playerid][ac_LastPos][1] = AntiCheat_PData[playerid][ac_LastPos][2] = 0.0;

                else 
                    GetPlayerPos(playerid, X,Y,Z);

                if PointToPoint(X,Y,Z, onFootData[PR_position][0], onFootData[PR_position][1], onFootData[PR_position][2]) 
                     >= ac_dist *then
                        OnCheatDetected(playerid, 2);
            }

            if PLAYER_STATE == PLAYER_STATE_ONFOOT && (AC_CODE_TRIGGER_TYPE[0] || AC_CODE_TRIGGER_TYPE[7]) *then
            {
                ac_dist = float(floatround(floatsqroot(floatpower(floatabs(onFootData[PR_velocity][0]), 2.0) + floatpower(floatabs(onFootData[PR_velocity][1]), 2.0) + floatpower(floatabs(onFootData[PR_velocity][2]), 2.0)) * 179.28625));

                GetPlayerPos(playerid, X,Y,Z);
                new Float:dist = PointToPoint(X,Y,Z, onFootData[PR_position][0], onFootData[PR_position][1], onFootData[PR_position][2]);
                    
                if 10.0 <= ac_dist <= 45.0 *then
                {
                    if dist > ac_dist/10 *then
                        OnCheatDetected(playerid, 0);
                }
                else if ac_dist > 45.0 && floatabs( Z - onFootData[PR_position][2] ) < 1.0 *then
                    OnCheatDetected(playerid, 9);

                else if ac_dist > 45.0 && floatabs( Y - onFootData[PR_position][1] ) > 1.0 *then 
                    OnCheatDetected(playerid, 7);

            }

            if AC_CODE_TRIGGER_TYPE[12] && PLAYER_STATE == PLAYER_STATE_ONFOOT *then
            {
                new Float:Health;
                GetPlayerHealth(playerid, Health);

                if !(onFootData[PR_health] == floatround(PI[playerid][pHealth])) && !(onFootData[PR_health] == Health) *then
                    OnCheatDetected(playerid, 12),
                    onFootData[PR_health] = floatround(PI[playerid][pHealth]),
                    BS_SetWriteOffset(bs, 8),
                    BS_WriteOnFootSync(bs, onFootData);
            }
            
            if AC_CODE_TRIGGER_TYPE[13] && PLAYER_STATE == PLAYER_STATE_ONFOOT *then
            {
                new Float:Arm;
                GetPlayerArmour(playerid, Arm);

                if !(onFootData[PR_armour] == floatround(PI[playerid][pArmour])) && !(onFootData[PR_armour] == Arm) *then
                    OnCheatDetected(playerid, 13), UpdatePlayerArmour(floatround(PI[playerid][pArmour]));
            }
            ///

            BS_ResetReadPointer(bs);
        }
    }
    return 1;   
}