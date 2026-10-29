/*enum 
{
    Custom_Speedometer,    // 0: Off, 1: Mobile Speedometer (1), 2: Mobile Speedometer (2) 3: Advanced (PC), 4: Simplified (PC),
	Custom_Hud,            // 0: Off, 1: PUBG (PC), 2: Vice City (PC), 3: San Andreas (PC), 4: Custom (1) (Mobile), 5: Custom (2) (Mobile), 6: Custom (3) (Mobile)
	Custom_Radar,          // 0: Off, 1: Custom (1) (PC/Mobile), 2: Custom (2) (PC/Mobile), 3: Vice City (PC)
	Custom_Fuel,           // 0 to 300 (PC/Mobile)
	Custom_Milage,         // 0 to 999999 (PC/Mobile)
	Custom_TypeFuel,       // 0: Petrol, 1: Electric, 2: Hide Icon (PC)
	Custom_Hunger,         // 0 to 100 (PC/Mobile)
	Custom_Hints,          // 0: Off, 1: On (PC)
	Custom_TypeDialog,     // 0: Full, 1: Simplified, 2: Simple (PC/Mobile)
	Custom_Map,            // 0: Off, 1: On (Mirror View) (PC/Mobile)
	Custom_Discord,        // 0: Off, 1: On (Discord Stream) (PC/Mobile)
	Custom_Dialog,         // 0: Off, 1: On (Save Dialog) (PC/Mobile)
	Custom_Chat,           // 0: Off, 1: On (Transparent Chat) (PC/Mobile)
	Custom_SetRadius,      // 0 to 500 (3D Text Drawing) (PC/Mobile)
	Custom_Show,           // 0: Off, 1: On (Snowfall) (PC/Mobile)
	Custom_Wanted,         // 0 to 7 (Change Wanted Level) (PC/Mobile)
	Custom_ChatBoard,      // 0: Off, 1: On (Player Text Board) (PC/Mobile)
	Custom_WallHack,       // 0: Off, 1: On (Player Wall Hack) (PC/Mobile)
	Custom_TypeAim		   // 0 to 10 (Type of Aim) (PC/Mobile)
}
native CustomInterface(playerid, type, index);
*/
/*
native showPlayerChatRoom(playerid, bool:toggle, room_id);
native updateHotKeyInfo(playerid, key_id, const nameKey[]);

native createPed(pedId, skin, Float:x, Float:y, Float:z, Float:a, color_1, name_1[], color_2, name_2[], gun, gunammo, Float:Health, Float:Armour);
native setPos(pedId, Float:x, Float:y, Float:z);
native movePed(pedId, Float:x, Float:y, Float:z, time);
native attackPlayer(pedId, playerid);
native enterToVehicle(pedId, vehicleid, seatid, time);
native removeFromVehicle(pedId);
native updatePedStatsOnfoot(pedId, Float:health, Float:armour);
native updatePedStatsDriver(pedId, Float:health, Float:armour);
native setPedAnim(pedId, anim_lib[], anim_name[], time);
native setPedChatBubble(pedId, text[], color, Float:radius, time);
native DestroyPed(pedId);

native setPlayerAttach(playerid, index = -1, boneid = -1, modelid = -1, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0);
native destroyPlayerAttach(playerid, index);

native SetVehicleShotsExhaust(vehicleid, bool:toggle);
native SetVehicleFrontLight(vehicleid, color);
native SetVehicleExhaustColor(vehicleid, color);
native SetVehicleBottomColor(vehicleid, color);
native SetVehicleWindowTint(vehicleid, window_id, color);
native SetVehicleWadPainting(vehicleid, wad_id, color);
native SetVehicleNumberPlates(vehicleid, number_type, number[], region[]);
native SetVehicleWheelDisks(vehicleid, disks, color);
native AddVehicleComponentEx(vehicleid, component, bool:remove = false);
native SetVehicleWheelSize(vehicleid, Float:wheel_size = 0.85);
native SetVehicleWheelSettings(vehicleid, wheel_id, Float:corner_wheel, Float:drop_wheel);
*/

native CreateAZVoiceStream(playerid, stream_type, Float:radius = 25.0, streamColor = 0xFFFFFFFF, const streamName[] = "");
native SetKeyAZVoice(playerid, keyID, bool:block = false, const keyName[] = "");
native SetAZVoiceUsedPort(port);