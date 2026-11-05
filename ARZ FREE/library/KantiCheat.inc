// AntiCheat by coder_supreme

#if defined _ac_supreme
	#endinput
#endif
#define _ac_supreme

#tryinclude <a_samp>

#if !defined FILTERSCRIPT

#if !defined DEBUG
	//#define DEBUG
#endif

#define	AC_VERSION "0.0.1"

#define AC_SERVER_VER "0.3.7"

#endif

#include <Pawn.RakNet>

// DataBase

static bool:ac_ACAllow[] =
{
	true,	//0 Anti-AirBreak (onfoot)
	true,	//1 Anti-AirBreak (in vehicle)
	true,	//2 Anti-teleport hack (onfoot)
	true,	//3 Anti-teleport hack (in vehicle)
	true,	//4 Anti-teleport hack (into/between vehicles)
	true,	//5 Anti-teleport hack (vehicle to player)
	true,	//6 Anti-teleport hack (pickups)
	true,	//7 Anti-FlyHack (onfoot)
	true,	//8 Anti-FlyHack (in vehicle)
	true,	//9 Anti-SpeedHack (onfoot)
	true,	//10 Anti-SpeedHack (in vehicle)
	true,	//11 Anti-Health hack (in vehicle)
	true,	//12 Anti-Health hack (onfoot)
	true,	//13 Anti-Armour hack
	true,	//14 Anti-Money hack
	true,	//15 Anti-Weapon hack
	true,	//16 Anti-Ammo hack (add)
	true,	//17 Anti-Ammo hack (infinite)
	true,	//18 Anti-Special actions hack
	true,	//19 Anti-GodMode from bullets (onfoot)
	true,	//20 Anti-GodMode from bullets (in vehicle)
	true,	//21 Anti-Invisible hack
	true,	//22 Anti-lagcomp-spoof
	true,	//23 Anti-Tuning hack
	false,	//24 Anti-Parkour mod
	true,	//25 Anti-Quick turn
	true,	//26 Anti-Rapid fire
	true,	//27 Anti-FakeSpawn
	true,	//28 Anti-FakeKill
	true,	//29 Anti-Pro Aim
	true,	//30 Anti-CJ run
	true,	//31 Anti-CarShot
	true,	//32 Anti-CarJack
	false,	//33 Anti-UnFreeze
	true,	//34 Anti-AFK Ghost
	true,	//35 Anti-Full Aiming

	false,	//36 Anti-Fake NPC
	true,	//37 Anti-Reconnect
	true,	//38 Anti-High ping
	true,	//39 Anti-Dialog hack
	true,	//40 Protection from sandbox
	true,	//41 Protection from invalid version
	true,	//42 Anti-Rcon hack

	true,	//43 Anti-Tuning crasher
	true,	//44 Anti-Invalid seat crasher
	true,	//45 Anti-Dialog crasher
	true,	//46 Anti-Attached object crasher
	true,	//47 Anti-Weapon Crasher

	true,	//48 Protection from connection flood in one slot
	true,	//49 Anti-callback functions flood
	true,	//50 Anti-flood by seat changing

	true,	//51 Anti-DoS

	true	//52 Anti-NOPs
};

new ac_VehicleSpeeds[] =
{
	160, 160, 200, 120, 150, 165, 110, 170, 110, 180, 160, 270, 160, 160, 140,
	230, 155, 200, 150, 160, 180, 180, 165, 145, 170, 200, 200, 170, 170, 200,
	190, 130, 800, 180, 200, 120, 160, 160, 160, 160, 160, 750, 150, 150, 110,
	165, 190, 200, 190, 150, 120, 240, 190, 190, 190, 140, 160, 160, 165, 160,
	200, 190, 260, 190, 750, 750, 160, 160, 190, 200, 170, 160, 190, 190, 160,
	160, 200, 200, 150, 165, 200, 120, 150, 120, 190, 160, 100, 200, 200, 170,
	170, 160, 160, 190, 220, 170, 200, 200, 140, 140, 160, 750, 260, 260, 160,
	260, 230, 165, 140, 120, 140, 200, 200, 200, 120, 120, 165, 165, 160, 340,
	340, 190, 190, 190, 110, 160, 160, 160, 170, 160, 600, 700, 140, 200, 160,
	160, 160, 110, 110, 150, 160, 230, 160, 165, 260, 160, 160, 160, 200, 160,
	160, 165, 160, 200, 170, 180, 110, 110, 200, 200, 200, 200, 200, 200, 750,
	200, 160, 160, 170, 110, 110, 900, 600, 110, 600, 160, 160, 200, 110, 160,
	165, 190, 160, 170, 120, 165, 260, 200, 140, 200, 260, 120, 200, 200, 600,
	190, 200, 200, 200, 160, 165, 110, 200, 200, 260, 260, 160, 160, 160, 140,
	160, 260, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 
	300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 
	300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 
	300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 
	300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 
	300, 300, 300, 300, 300, 300, 300, 300, 300
};

enum acInfo
{
	Float:AC_posX,
	Float:AC_posY,
	Float:AC_posZ
};

new APlayer[MAX_PLAYERS][acInfo];
//


// Функции

stock GetVehicleMaxSpeed(const carid)
{
	new model = GetVehicleModel(carid), id;

	if !ValidVehicleModel(model) *then
		return false;

	switch model do
	{
		case 662: id = 615;
		case 663: id = 616;
		case 665: id = 617;
		case 666: id = 618;
		case 667: id = 619;
		case 668: id = 620;
		case 699: id = 621;
		case 793: id = 622;
		case 794: id = 623;
		case 909: id = 624;
		case 965: id = 625;
		case 1194: id = 626;
		case 1195: id = 627;
		case 1196: id = 628;
		case 1197: id = 629;
		case 1198: id = 630;
		case 1199: id = 631;
		case 1200: id = 632;
		case 1201: id = 633;
		case 1202: id = 634;
		case 1203: id = 635;
		case 1204: id = 636;
		case 1205: id = 637;
		case 3155: id = 638;
		case 3156: id = 639;
		case 3157: id = 640;
		case 3158: id = 641;
		case 3194..3213: id = 642 + model - 3194;
		case 3215..3220: id = 662 + model - 3215;
		case 3222: id = 668;
		case 3223: id = 669;
		case 3224: id = 670;
		case 3232..3240: id = 671 + model - 3232;
		case 3245: id = 680;
		case 3247: id = 681;
		case 3248: id = 682;
		case 3251: id = 683;
		case 3254: id = 684;
		case 3266: id = 685;
		case 3348: id = 686;
		case 3974: id = 687;
		case 4542..4548: id = 688 + model - 4542;
		default: id = model;
	}

	return ac_VehicleSpeeds[id - 400];
}

stock EnableAntiCheat(code, enable)
	return ac_ACAllow[code] = bool:enable;

//

// Перехваты
stock ac_SetPlayerPos(playerid, Float:x, Float:y, Float:z)
{
	SetPlayerPos(playerid, x, y, z);
	
	APlayer[playerid][AC_posX] = x, APlayer[playerid][AC_posY] = y, APlayer[playerid][AC_posZ] = z;

	return true;
}

#if defined _ALS_SetPlayerPos
	#undef SetPlayerPos
#else
	#define _ALS_SetPlayerPos
#endif
#define SetPlayerPos ac_SetPlayerPos
//

// Pawn.RakNet AntiCheat

public OnIncomingPacket(playerid, packetid, BitStream:bs)
{
	switch packetid do
	{
		case 207:
		{
			new ac_Data[PR_OnFootSync];
			BS_IgnoreBits(bs, 8);
			BS_ReadOnFootSync(bs, ac_Data);
			
			
			printf("%d player position = {%f, %f, %f}, ac_data position = {%f, %f, %f}", playerid, ac_Data[PR_position][0], ac_Data[PR_position][1], ac_Data[PR_position][2], 
			APlayer[playerid][AC_posX], APlayer[playerid][AC_posY], APlayer[playerid][AC_posZ]);

			/* if(ac_fData[PR_surfingOffsets][0] != ac_fData[PR_surfingOffsets][0] ||
				ac_fData[PR_surfingOffsets][1] != ac_fData[PR_surfingOffsets][1] ||
				ac_fData[PR_surfingOffsets][2] != ac_fData[PR_surfingOffsets][2])
				{
					ac_fData[PR_surfingOffsets][0] =
					ac_fData[PR_surfingOffsets][1] =
					ac_fData[PR_surfingOffsets][2] = 0.0;
					ac_fData[PR_surfingVehicleId] = 0;
					BS_SetWriteOffset(bs, 8);
					BS_WriteOnFootSync(bs, ac_fData);
				}
				else if(ac_fData[PR_surfingVehicleId] != 0 &&
				ac_fData[PR_surfingOffsets][0] == 0.0 && ac_fData[PR_surfingOffsets][1] == 0.0 &&
				ac_fData[PR_surfingOffsets][2] == 0.0)
				{
					ac_fData[PR_surfingVehicleId] = 0;
					BS_SetWriteOffset(bs, 8);
					BS_WriteOnFootSync(bs, ac_fData);
				} */

			BS_ResetReadPointer(bs);
		}
	}

	return true;
}
//


stock EnableAntiCheatForPlayer(playerid, code, enable)
{
	return true;
}