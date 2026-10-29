#define FILTERSCRIPT
#include a_samp
#include streamer

stock ffo_CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 300.0) return CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, DrawDistance);
stock ffo_SetObjectMaterial(objectid, materialindex, modelid, txdname[], texturename[], materialcolor = 0) return SetObjectMaterial(objectid, materialindex, modelid, txdname, texturename, materialcolor);
stock ffo_SetPlayerObjectMaterial(playerid, objectid, materialindex, modelid, txdname[], texturename[], materialcolor = 0) return SetPlayerObjectMaterial(playerid, objectid, materialindex, modelid, txdname, texturename, materialcolor);

stock fo_CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 300.0, Float:drawdistance = 300.0, areaid = -1, priority = 0)
{
	if(streamdistance > 600.0) streamdistance = 600.0;
	
    return CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
}

#if defined _ALS_CreateDynamicObject
	#undef CreateDynamicObject
#else
	#define _ALS_CreateDynamicObject
#endif
#define CreateDynamicObject fo_CreateDynamicObject

stock fo_CreateDynamicObjectEx(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:streamdistance = 300.0, Float:drawdistance = 300.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, areas[] = { -1 }, priority = 0, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players, maxareas = sizeof areas)
{
	if(streamdistance > 600.0) streamdistance = 600.0;
	
	return CreateDynamicObjectEx(modelid, x, y, z, rx, ry, rz, streamdistance, drawdistance, worlds, interiors, players, areas, priority, maxworlds, maxinteriors, maxplayers, maxareas);
}

#if defined _ALS_CreateDynamicObjectEx
	#undef CreateDynamicObjectEx
#else
	#define _ALS_CreateDynamicObjectEx
#endif
#define CreateDynamicObjectEx fo_CreateDynamicObjectEx

stock fo_CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 300.0) return CreateDynamicObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, -1, -1, -1, 300.0, DrawDistance);
#if defined _ALS_CreateObject
	#undef CreateObject
#else
	#define _ALS_CreateObject
#endif
#define CreateObject fo_CreateObject

stock fo_DestroyObject(objectid) return DestroyDynamicObject(objectid);
#if defined _ALS_DestroyObject
	#undef DestroyObject
#else
	#define _ALS_DestroyObject
#endif
#define DestroyObject fo_DestroyObject

stock fo_SetObjectMaterialText(objectid, text[], materialindex = 0, materialsize = OBJECT_MATERIAL_SIZE_256x128, fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0) return SetDynamicObjectMaterialText(objectid, materialindex, text, materialsize, fontface, fontsize, bold, fontcolor, backcolor, textalignment);
#if defined _ALS_SetObjectMaterialText
	#undef SetObjectMaterialText
#else
	#define _ALS_SetObjectMaterialText
#endif
#define SetObjectMaterialText fo_SetObjectMaterialText

stock fo_GetObjectModel(objectid) return Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID);
#if defined _ALS_GetObjectModel
	#undef GetObjectModel
#else
	#define _ALS_GetObjectModel
#endif
#define GetObjectModel fo_GetObjectModel

#if defined _ALS_AttachObjectToVehicle
	#undef AttachObjectToVehicle
#else
	#define _ALS_AttachObjectToVehicle
#endif
#define AttachObjectToVehicle AttachDynamicObjectToVehicle

#if defined _ALS_AttachObjectToObject
	#undef AttachObjectToObject
#else
	#define _ALS_AttachObjectToObject
#endif
#define AttachObjectToObject AttachDynamicObjectToObject

#if defined _ALS_AttachObjectToPlayer
	#undef AttachObjectToPlayer
#else
	#define _ALS_AttachObjectToPlayer
#endif
#define AttachObjectToPlayer AttachDynamicObjectToPlayer

#if defined _ALS_SetObjectPos
	#undef SetObjectPos
#else
	#define _ALS_SetObjectPos
#endif
#define SetObjectPos SetDynamicObjectPos

#if defined _ALS_GetObjectPos
	#undef GetObjectPos
#else
	#define _ALS_GetObjectPos
#endif
#define GetObjectPos GetDynamicObjectPos

#if defined _ALS_SetObjectRot
	#undef SetObjectRot
#else
	#define _ALS_SetObjectRot
#endif
#define SetObjectRot SetDynamicObjectRot

#if defined _ALS_GetObjectRot
	#undef GetObjectRot
#else
	#define _ALS_GetObjectRot
#endif
#define GetObjectRot GetDynamicObjectRot

#if defined _ALS_SetObjectNoCameraCol
	#undef SetObjectNoCameraCol
#else
	#define _ALS_SetObjectNoCameraCol
#endif
#define SetObjectNoCameraCol SetDynamicObjectNoCameraCol

#if defined _ALS_IsValidObject
	#undef IsValidObject
#else
	#define _ALS_IsValidObject
#endif
#define IsValidObject IsValidDynamicObject

#if defined _ALS_SetObjectMaterial
	#undef SetObjectMaterial
#else
	#define _ALS_SetObjectMaterial
#endif
#define SetObjectMaterial SetDynamicObjectMaterial

public OnFilterScriptInit()
{
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 1500);

	#include ../library/map/bank
	#include ../library/map/kvartiri
	#include ../library/map/bolka
	#include ../library/map/maze
	#include ../library/map/sto
	#include ../library/map/centre
    #include ../library/map/autoz
    #include ../library/map/salonbuild
    #include ../library/map/trailer1
    #include ../library/map/trailer2
    #include ../library/map/trailer3
    #include ../library/map/trailersalon
    #include ../library/map/tsriint
    #include ../library/map/tsrint2
    #include ../library/map/ultsr
    #include ../library/map/nefti
	#include ../library/map/accshop
	#include ../library/map/armyls
	#include ../library/map/pawnshop
	#include ../library/map/armysf
	#include ../library/map/banklv
	#include ../library/map/bankparking
	#include ../library/map/housesintnew
	#include ../library/map/blockpost
	#include ../library/map/FBI-LSPD
	#include ../library/map/Mafia
	#include ../library/map/meria
	#include ../library/map/Mexanik-24.7
	#include ../library/map/news
	#include ../library/map/other
	#include ../library/map/Wolfs
	#include ../library/map/zanyat
	#include ../library/map/sfhouse
	#include ../library/map/avtobazar
	#include ../library/map/avtosalon
	#include ../library/map/aztec
	#include ../library/map/vagos
	#include ../library/map/ballas
	#include ../library/map/groove
	#include ../library/map/rifa
	#include ../library/map/baiker
	#include ../library/map/greentown
	#include ../library/map/semya
	#include ../library/map/casino
	#include ../library/map/autoschool
	#include ../library/map/jail
	#include ../library/map/housesint
	#include ../library/map/autoint
	#include ../library/map/garages
	#include ../library/map/podval
	#include ../library/map/doma
	#include ../library/map/policelc
	#include ../library/map/newintamerie
 	#include ../library/map/mapping
 	#include ../library/map/newmap
 	#include ../library/map/newmapping
    #include ../library/map/otelsmap
    #include ../library/map/zavodmap
    #include ../library/map/tuning
	#include ../library/map/familykv
	#include ../library/map/cont
	#include ../library/map/LoadCity
	#include ../library/map/autoservice
	#include ../library/map/newhousesarz
	#include ../library/map/humanitar
	#include ../library/map/sampbet
	#include ../library/map/ostrovarz
	#include ../library/map/villagearz
	#include ../library/map/spawnnew
	#include ../library/map/activity_dvorec
	#include ../library/map/magazvsedlyadoma
	#include ../library/map/elitehousearz
	#include ../library/map/newelitehouses
	#include ../library/map/quests
	#include ../library/map/new_videoint
	#include ../library/map/new_neft
	#include ../library/map/sklad_inta
	#include ../library/map/armylv
	//#include ../library/map/vice_city_map
	#include ../library/map/Strax
	#include ../library/map/StraxINT
	#include ../library/map/truckers
	#include ../library/map/obmen_source
	#include ../library/map/roads_new
	#include ../library/map/other_island
	#include ../library/map/other_newisland
	#include ../library/map/arz_aks_lov
	#include ../library/map/newelitehouseaspire.pwn
	
	new mapp;
	mapp = CreateObject(19353, 1399.430664, -40.152339, 1001.676025, 0.000000, 0.000000, 289.994995, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1402.137695, -38.606449, 1001.676025, 0.000000, 0.000000, 309.996002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1404.151367, -36.216800, 1001.676025, 0.000000, 0.000000, 329.996002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1405.230468, -33.277339, 1001.676025, 0.000000, 0.000000, 349.997009, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1405.222656, -30.094289, 1001.676025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1387.454101, -30.125980, 1008.676025, 0.000000, 0.000000, 169.996994, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1404.175781, -27.205080, 1005.176025, 0.000000, 0.000000, 29.993000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1402.166015, -24.804689, 1008.676025, 0.000000, 0.000000, 49.999000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1399.473632, -23.245119, 1001.676025, 0.000000, 0.000000, 69.994003, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1396.364257, -22.700199, 1001.676025, 0.000000, 0.000000, 89.995002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1393.269531, -23.236330, 1001.676025, 0.000000, 0.000000, 109.989997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1388.529296, -27.181640, 1001.676025, 0.000000, 0.000000, 149.990997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1387.447265, -33.166019, 1005.176025, 0.000000, 0.000000, 189.998001, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1393.260742, -40.098628, 1001.676025, 0.000000, 0.000000, 249.000000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1388.512695, -36.106449, 1008.676025, 0.000000, 0.000000, 209.992996, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1390.537109, -38.511718, 1001.676025, 0.000000, 0.000000, 229.998992, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1396.329101, -40.683589, 1001.676025, 0.000000, 0.000000, 270.000000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1390.546875, -24.793949, 1005.176025, 0.000000, 0.000000, 129.996002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1388.529296, -27.181640, 1005.176025, 0.000000, 0.000000, 149.990997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1393.269531, -23.236330, 1008.676025, 0.000000, 0.000000, 109.989997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1396.364257, -22.700199, 1005.176025, 0.000000, 0.000000, 89.995002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1399.473632, -23.245119, 1005.176025, 0.000000, 0.000000, 69.994003, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1402.166015, -24.804689, 1001.676025, 0.000000, 0.000000, 49.999000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1404.175781, -27.205080, 1001.676025, 0.000000, 0.000000, 29.993000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1405.232421, -30.142580, 1005.176025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1405.230468, -33.276371, 1005.176025, 0.000000, 0.000000, 349.997009, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1404.151367, -36.216800, 1005.176025, 0.000000, 0.000000, 329.990997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1402.137695, -38.606449, 1005.176025, 0.000000, 0.000000, 309.996002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1399.430664, -40.151371, 1005.176025, 0.000000, 0.000000, 289.989990, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1396.329101, -40.682621, 1005.176025, 0.000000, 0.000000, 270.000000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1393.260742, -40.097660, 1008.676025, 0.000000, 0.000000, 249.000000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1390.537109, -38.511718, 1005.176025, 0.000000, 0.000000, 229.998992, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19604, 1389.315917, -37.477424, 1002.729125, 90.000000, -170.000045, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	mapp = CreateObject(19353, 1389.950195, -26.398439, 1005.176025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1392.115234, -38.634769, 1001.676025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1392.115234, -38.634769, 1005.176025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1389.950195, -26.398439, 1008.676025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19383, 1387.447265, -33.166019, 1001.676025, 0.000000, 0.000000, 189.998001, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19383, 1388.512695, -36.106449, 1001.676025, 0.000000, 0.000000, 209.992996, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19383, 1387.454101, -30.125980, 1001.676025, 0.000000, 0.000000, 169.996994, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1390.546875, -24.793949, 1008.676025, 0.000000, 0.000000, 129.996002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1390.546875, -24.793949, 1001.676025, 0.000000, 0.000000, 129.996002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1389.950195, -26.398439, 1001.676025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1387.454101, -30.125980, 1005.176025, 0.000000, 0.000000, 169.996994, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1387.447265, -33.166019, 1008.676025, 0.000000, 0.000000, 189.998001, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1388.512695, -36.106449, 1005.176025, 0.000000, 0.000000, 209.992996, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1392.115234, -38.634769, 1008.676025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1393.260742, -40.097660, 1005.176025, 0.000000, 0.000000, 249.000000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1396.329101, -40.682621, 1008.676025, 0.000000, 0.000000, 270.000000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1399.430664, -40.151371, 1008.676025, 0.000000, 0.000000, 289.989990, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1402.137695, -38.606449, 1008.676025, 0.000000, 0.000000, 309.996002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1405.230468, -33.276371, 1008.676025, 0.000000, 0.000000, 349.997009, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1405.232421, -30.142580, 1008.676025, 0.000000, 0.000000, 9.998000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1404.175781, -27.205080, 1008.676025, 0.000000, 0.000000, 29.993000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1402.166015, -24.804689, 1005.176025, 0.000000, 0.000000, 49.999000, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1399.473632, -23.245119, 1008.676025, 0.000000, 0.000000, 69.994003, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1396.364257, -22.700199, 1008.676025, 0.000000, 0.000000, 89.995002, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1393.269531, -23.236330, 1005.176025, 0.000000, 0.000000, 109.989997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19353, 1388.529296, -27.181640, 1008.676025, 0.000000, 0.000000, 149.990997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(2209, 1396.101196, -37.814998, 999.925964, 0.000000, 0.000000, 152.800064, 300.00);
	SetObjectMaterial(mapp, 1, 3857, "ottos_glass", "carshowroom1", 0x00000000);
	mapp = CreateObject(19353, 1390.537109, -38.511718, 1008.676025, 0.000000, 0.000000, 229.998992, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19354, 1390.201171, -37.431640, 1005.176025, 0.000000, 0.000000, 99.986999, 300.00);
	SetObjectMaterial(mapp, 0, 14808, "lee_strip2", "HS3_wall1", 0x00000000);
	mapp = CreateObject(19354, 1390.201171, -37.431640, 1008.676025, 0.000000, 0.000000, 99.986999, 300.00);
	SetObjectMaterial(mapp, 0, 14808, "lee_strip2", "HS3_wall1", 0x00000000);
	mapp = CreateObject(19354, 1388.549804, -28.185550, 1005.176025, 0.000000, 0.000000, 99.986999, 300.00);
	SetObjectMaterial(mapp, 0, 14808, "lee_strip2", "HS3_wall1", 0x00000000);
	mapp = CreateObject(19859, 1387.381835, -30.903320, 1001.181030, 0.000000, 0.000000, 79.997001, 300.00);
	SetObjectMaterial(mapp, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
	mapp = CreateObject(19859, 1387.639892, -33.902259, 1001.181030, 0.000000, 0.000000, 99.998001, 300.00);
	SetObjectMaterial(mapp, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
	mapp = CreateObject(19859, 1388.953125, -36.721679, 1001.181030, 0.000000, 0.000000, 119.998001, 300.00);
	SetObjectMaterial(mapp, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
	mapp = CreateObject(19377, 1392.482666, -37.256736, 999.840026, 0.000000, 90.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 14709, "lamidint2", "mp_apt1_bathfloor1", 0xAAFFFFFF);
	mapp = CreateObject(19377, 1392.442626, -27.618000, 999.840026, 0.000000, 90.001998, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 14709, "lamidint2", "mp_apt1_bathfloor1", 0xAAFFFFFF);
	mapp = CreateObject(19377, 1402.982666, -37.176761, 999.840026, 0.000000, 90.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 14709, "lamidint2", "mp_apt1_bathfloor1", 0xAAFFFFFF);
	mapp = CreateObject(19377, 1402.942626, -27.557998, 999.840026, 0.000000, 90.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 14709, "lamidint2", "mp_apt1_bathfloor1", 0xAAFFFFFF);
	mapp = CreateObject(19353, 1404.151367, -36.216800, 1008.676025, 0.000000, 0.000000, 329.990997, 300.00);
	SetObjectMaterial(mapp, 0, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19464, 1392.247924, -39.537864, 997.045715, 90.000000, 180.000000, -170.399963, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1393.101318, -40.056060, 997.465454, 0.000000, 0.000000, 69.000038, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1397.192016, -40.675476, 997.465332, 0.000000, 0.000000, 90.399993, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1399.395874, -40.161777, 997.466186, 0.000000, 0.000000, 109.799949, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1402.562133, -38.254745, 997.475097, 0.000000, 0.000000, 129.799942, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1404.544311, -35.526683, 997.475708, 0.000000, 0.000000, -30.199985, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1405.349731, -32.518207, 997.485351, 0.000000, 0.000000, -9.799995, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1404.983032, -28.928010, 997.475097, 0.000000, 0.000000, 9.799994, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1403.582763, -26.211530, 997.465820, 0.000000, 0.000000, 29.800022, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1401.047119, -23.912569, 997.465698, 0.000000, 0.000000, 50.700000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1398.819580, -23.041292, 997.465209, 0.000000, 0.000000, -109.900016, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1396.002319, -22.723842, 997.455566, 0.000000, 0.000000, -89.699935, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1393.122070, -23.310007, 997.455688, 0.000000, 0.000000, -69.999908, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1390.447387, -24.901201, 997.465576, -0.099999, 180.000000, -50.199897, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19464, 1389.719238, -25.079128, 997.465698, 0.000000, 0.000000, 9.899997, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19604, 1387.705932, -28.440168, 1002.747253, 90.000000, 9.999998, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	mapp = CreateObject(19087, 1387.664550, -33.894432, 1002.325439, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19431, 1386.097290, -33.418746, 1002.365661, 0.000000, 90.000000, 9.799990, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19087, 1387.419921, -32.418518, 1002.295898, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19431, 1386.134033, -29.875461, 1002.445434, 0.000000, 92.199974, -11.499996, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19087, 1387.696655, -29.460710, 1002.306274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19087, 1388.229125, -35.400714, 1002.376647, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19087, 1388.977416, -36.720664, 1002.365783, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19431, 1387.381713, -36.773727, 1002.396362, 0.000000, 90.000000, 30.800018, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(2774, 1399.467407, -34.714859, 1008.500793, 90.000000, 0.000000, 100.899978, 300.00);
	SetObjectMaterial(mapp, 1, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(2774, 1397.704467, -27.345727, 1008.530822, 90.000000, 0.000000, 100.899978, 300.00);
	SetObjectMaterial(mapp, 1, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(2774, 1399.156860, -30.182224, 1008.570861, 90.000000, 0.000000, 190.899978, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	SetObjectMaterial(mapp, 1, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(18766, 1393.785034, -32.541915, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(18766, 1392.913452, -27.648933, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(18766, 1388.651123, -32.968936, 1008.226806, 90.000000, 0.000000, 100.099983, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(18766, 1392.041870, -22.755956, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(18766, 1394.875854, -38.665515, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(18766, 1404.604614, -30.614633, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(19089, 1392.415649, -39.672836, 1004.386352, 0.000000, 0.000000, 90.000000, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(18766, 1403.729248, -25.701967, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(18766, 1402.854736, -20.799158, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(2774, 1387.946411, -32.341728, 1008.460754, 90.000000, 0.000000, 190.899978, 300.00);
	SetObjectMaterial(mapp, 1, 5406, "jeffers5a_lae", "vgshopwall05_64", 0x00000000);
	mapp = CreateObject(19859, 1405.118164, -33.454891, 1001.175354, 0.000000, 0.000000, 80.099952, 300.00);
	SetObjectMaterial(mapp, 0, 4887, "downtown_las", "ws_glassnbrassdoor", 0x00000000);
	mapp = CreateObject(19089, 1405.344482, -31.974401, 1002.525756, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
	mapp = CreateObject(19089, 1405.097412, -33.449092, 1002.536560, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
	mapp = CreateObject(19431, 1406.735595, -32.968433, 1002.487609, 0.000000, 90.000000, -10.300003, 300.00);
	SetObjectMaterial(mapp, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
	mapp = CreateObject(2441, 1391.714599, -27.265909, 999.915771, 0.621999, 1.004000, 8.600004, 300.00);
	SetObjectMaterial(mapp, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 1, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	SetObjectMaterial(mapp, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 3, 8534, "tikimotel", "sa_wood03_128", 0x00000000);
	mapp = CreateObject(19354, 1388.549804, -28.185550, 1008.676025, 0.000000, 0.000000, 99.998001, 300.00);
	SetObjectMaterial(mapp, 0, 14808, "lee_strip2", "HS3_wall1", 0x00000000);
	mapp = CreateObject(19354, 1390.201171, -37.431640, 1001.676025, 0.000000, 0.000000, 99.986999, 300.00);
	SetObjectMaterial(mapp, 0, 14808, "lee_strip2", "HS3_wall1", 0x00000000);
	mapp = CreateObject(19354, 1388.549804, -28.185550, 1001.676025, 0.000000, 0.000000, 99.986999, 300.00);
	SetObjectMaterial(mapp, 0, 14808, "lee_strip2", "HS3_wall1", 0x00000000);
	mapp = CreateObject(19087, 1387.447875, -30.882350, 1002.386413, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(949, 1388.483886, -31.611782, 1000.556030, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 13131, "cunte_blockammo", "ws_patchygravel", 0x00000000);
	SetObjectMaterial(mapp, 1, 5461, "glenpark6d_lae", "tiledwall01_LA", 0x00000000);
	SetObjectMaterial(mapp, 2, 3946, "bistro_plants", "starflower2", 0x00000000);
	mapp = CreateObject(949, 1388.914306, -34.531799, 1000.556030, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 13131, "cunte_blockammo", "ws_patchygravel", 0x00000000);
	SetObjectMaterial(mapp, 1, 5461, "glenpark6d_lae", "tiledwall01_LA", 0x00000000);
	SetObjectMaterial(mapp, 2, 3946, "bistro_plants", "starflower2", 0x00000000);
	mapp = CreateObject(19325, 1388.125854, -28.361061, 1002.905944, 90.000000, 0.000000, 100.000175, 300.00);
	SetObjectMaterial(mapp, 0, -1, "none", "none", 0xFF00CCFF);
	mapp = CreateObject(19325, 1388.125854, -28.361061, 1009.536193, 90.000000, 0.000000, 100.000175, 300.00);
	SetObjectMaterial(mapp, 0, -1, "none", "none", 0xFF00CCFF);
	mapp = CreateObject(19089, 1391.776123, -37.062767, 1004.386352, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1391.776123, -37.062767, 1011.666687, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1389.444213, -37.462703, 1011.666687, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1389.444213, -37.462703, 1004.307556, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19325, 1389.724609, -37.421283, 1009.536193, 90.000000, 0.000000, 100.000175, 300.00);
	SetObjectMaterial(mapp, 0, -1, "none", "none", 0xFF00CCFF);
	mapp = CreateObject(19325, 1389.724609, -37.421283, 1002.917053, 90.000000, 0.000000, 100.000175, 300.00);
	SetObjectMaterial(mapp, 0, -1, "none", "none", 0xFF00CCFF);
	mapp = CreateObject(19431, 1387.198364, -31.664148, 998.276123, 0.000000, 0.000000, -9.299995, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19431, 1387.984619, -28.193496, 998.236145, 0.000000, 0.099999, -27.600114, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19431, 1387.761230, -28.639726, 998.235900, 0.000000, 0.000000, -10.000006, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19431, 1387.196044, -31.625003, 998.276123, 0.000000, 0.000000, 9.799989, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19431, 1387.726440, -34.689620, 998.276123, 0.000000, 0.000000, 9.799989, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19431, 1387.746582, -34.750808, 998.276123, 0.000000, 0.000000, 31.000003, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19431, 1389.329956, -37.462898, 998.276123, 0.000000, 0.000000, 31.000003, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19089, 1390.146118, -27.992750, 1004.386352, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1390.146118, -27.992750, 1011.664611, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1387.924804, -28.412755, 1014.564514, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1387.924804, -28.412755, 1007.234680, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(7313, 1388.467895, -32.909111, 1006.545715, 0.000000, 0.000000, 100.399971, 300.00);
	SetObjectMaterialText(mapp, "{ffff00}Welcome to {ffffff}San Andreas Gyvenimas", 0, 70, "SAG", 20, 1, 0xFFFFFFFF, 0xFF101010, 1);
	mapp = CreateObject(2441, 1392.909301, -25.679178, 999.899780, 0.621999, 1.004000, 98.600021, 300.00);
	SetObjectMaterial(mapp, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 1, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	SetObjectMaterial(mapp, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 3, 8534, "tikimotel", "sa_wood03_128", 0x00000000);
	mapp = CreateObject(2442, 1392.683227, -27.125638, 999.905944, 0.000000, 0.002000, 8.499984, 300.00);
	SetObjectMaterial(mapp, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 1, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	SetObjectMaterial(mapp, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 3, 8534, "tikimotel", "sa_wood03_128", 0x00000000);
	mapp = CreateObject(2441, 1390.725830, -27.415605, 999.933105, 0.621999, 1.004000, 8.600004, 300.00);
	SetObjectMaterial(mapp, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 1, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	SetObjectMaterial(mapp, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetObjectMaterial(mapp, 3, 8534, "tikimotel", "sa_wood03_128", 0x00000000);
	mapp = CreateObject(948, 1394.010498, -26.372066, 999.925781, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 2, 4830, "airport2", "bevflower2", 0x00000000);
	mapp = CreateObject(948, 1397.910766, -40.032089, 999.925781, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 2, 4830, "airport2", "bevflower2", 0x00000000);
	mapp = CreateObject(2581, 1390.779052, -25.027879, 1001.155883, 0.000000, 0.000000, 41.799995, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	SetObjectMaterial(mapp, 1, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	SetObjectMaterial(mapp, 2, 1649, "wglass", "carshowwin2", 0x00000000);
	SetObjectMaterial(mapp, 3, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1391.441772, -24.502782, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1391.281860, -24.662788, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1391.121704, -24.822788, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1390.921508, -24.912780, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1390.771484, -25.082784, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1390.601318, -25.202787, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1390.451171, -25.342784, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1390.291015, -25.462787, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19087, 1390.160888, -25.612791, 1002.146179, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 1355, "break_s_bins", "CJ_WOOD_DARK", 0x00000000);
	mapp = CreateObject(19327, 1390.935791, -25.194553, 1002.231750, 0.000000, 0.000000, 45.600006, 300.00);
	SetObjectMaterialText(mapp, "Room Keys", 0, 130, "Wingdings 2", 30, 1, 0xFFFFFDAB, 0x00000000, 1);
	mapp = CreateObject(19579, 1392.595581, -27.192197, 1000.835876, 0.000000, 0.000000, 37.799987, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(2266, 1392.872924, -27.557695, 1001.026550, 5.000000, 0.000000, 36.399997, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(2266, 1392.316528, -26.770689, 1001.106140, -5.000000, 0.000000, 216.399993, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 1, 14392, "dr_gsstudio", "monitors_128", 0x00000000);
	mapp = CreateObject(19808, 1392.183105, -27.043128, 1000.986022, 0.000000, 0.000000, -128.299987, 300.00);
	SetObjectMaterial(mapp, 0, -1, "none", "none", 0xFF000000);
	mapp = CreateObject(2324, 1392.347656, -27.743638, 1007.647521, 0.000000, 90.000000, 90.000000, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 2, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 3, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 4, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 5, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 6, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 7, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 8, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 9, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 10, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 11, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 12, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 13, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 14, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetObjectMaterial(mapp, 15, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(18766, 1405.699584, -36.767761, 1008.936950, 90.000000, 0.000000, 190.099975, 300.00);
	SetObjectMaterial(mapp, 0, 3967, "cj_airprt", "ceiling_256", 0x00000000);
	mapp = CreateObject(19089, 1392.415649, -39.672836, 1011.716552, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1391.882202, -36.729137, 1008.427673, 0.000000, 90.000000, 100.099884, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1389.191894, -21.607151, 1008.408325, 0.000000, 90.000000, 100.099739, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1392.879516, -40.616832, 1008.417846, 0.000000, 90.000000, -179.000244, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1395.144287, -41.691440, 1008.428283, 0.000000, 90.000000, -158.600128, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1391.614868, -35.342830, 1015.135070, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1390.614624, -29.562852, 1015.125183, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1391.631469, -35.405963, 1007.766601, 90.000000, 90.000000, -79.800109, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1391.634765, -35.320125, 1008.405639, 0.000000, 90.000000, -169.299835, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1397.882812, -28.216325, 1008.405456, 0.000000, 90.000000, 10.600006, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1391.697998, -39.367908, 1008.405944, 90.000000, 0.000000, -111.400016, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1389.895385, -25.502843, 1011.716552, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1389.895385, -25.502843, 1004.518005, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1394.874755, -21.380727, 1008.406433, 0.000000, 90.000000, 39.599994, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1395.447265, -22.643777, 1008.416442, 0.000000, 90.000000, 18.699991, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1402.274902, -23.161605, 1008.416442, 0.000000, 90.000000, -2.700004, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1387.741210, -34.561378, 1007.638488, 0.000000, 90.000000, 119.899940, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1387.248046, -31.463640, 1007.659912, 0.000000, 90.000000, 99.899909, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1387.185791, -32.068378, 1007.607666, 0.000000, 90.500007, -100.200210, 300.00);
	SetObjectMaterial(mapp, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	mapp = CreateObject(19089, 1387.803955, -34.722724, 1007.688537, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1387.803955, -34.722724, 1000.349365, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1387.283447, -31.642713, 1007.698547, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	mapp = CreateObject(19089, 1387.283447, -31.642713, 1000.376770, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(mapp, 0, 16640, "a51", "Metal3_128", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	mapp = CreateObject(3785, 1387.644775, -33.196769, 1003.354492, -90.499984, 0.000000, 8.399974, 300.00);
	mapp = CreateObject(1702, 1401.496215, -38.067283, 999.915893, 0.000000, 0.000000, -151.900070, 300.00);
	mapp = CreateObject(1808, 1392.815551, -39.413581, 999.925964, 0.000000, 0.000000, 120.899963, 300.00);
	mapp = CreateObject(1705, 1392.974975, -38.233703, 999.925964, 0.000000, 0.000000, 92.799919, 300.00);
	mapp = CreateObject(3785, 1387.644897, -30.274543, 1003.309753, -90.499984, 0.000000, -6.600023, 300.00);
	mapp = CreateObject(3785, 1388.707153, -36.065536, 1003.322814, -90.499984, 0.000000, 30.899984, 300.00);
	mapp = CreateObject(19826, 1388.144531, -35.265228, 1001.297058, 0.000000, 0.000000, 121.399993, 300.00);
	mapp = CreateObject(19826, 1387.373413, -32.248439, 1001.297058, 0.000000, 0.000000, 98.999938, 300.00);
	mapp = CreateObject(19826, 1387.675659, -29.277759, 1001.297058, 0.000000, 0.000000, 80.800041, 300.00);
	mapp = CreateObject(2261, 1393.296264, -23.880842, 1002.225891, 0.000000, 0.000000, 20.100017, 300.00);
	mapp = CreateObject(1702, 1400.811035, -25.007453, 999.885864, 0.000000, 0.000000, -39.600059, 300.00);
	mapp = CreateObject(2286, 1394.910034, -22.895566, 1005.076477, 0.000000, 0.000000, 6.400000, 300.00);
	mapp = CreateObject(1702, 1398.093139, -23.711467, 999.885864, 0.000000, 0.000000, -19.500070, 300.00);
	mapp = CreateObject(1892, 1404.386230, -33.053413, 999.905944, 0.000000, 0.000000, 77.800018, 300.00);
	mapp = CreateObject(11746, 1390.330932, -25.347982, 1001.621765, 0.000000, 0.000000, 0.000000, 300.00);
	mapp = CreateObject(2257, 1387.659912, -33.134548, 1005.026123, 0.000000, 0.000000, 98.699943, 300.00);
	mapp = CreateObject(14629, 1395.306884, -31.148750, 1007.645629, 0.000000, 0.000000, 0.000000, 300.00);
	mapp = CreateObject(11746, 1391.151367, -24.507986, 1001.911926, 0.000000, 0.000000, 0.000000, 300.00);
	mapp = CreateObject(11746, 1390.561523, -24.987997, 1001.611755, 0.000000, 0.000000, 0.000000, 300.00);
	mapp = CreateObject(19610, 1392.592163, -27.177656, 1000.965820, 270.000000, 90.000000, 59.699977, 300.00);
	mapp = CreateObject(1714, 1391.712036, -26.446693, 999.925964, 0.000000, 0.000000, 29.700000, 300.00);
	mapp = CreateObject(18868, 1392.224853, -27.344184, 1000.955322, 0.000000, 0.000000, -129.699951, 300.00);
	mapp = CreateObject(19814, 1397.477294, -22.783863, 1000.436035, 0.000000, 0.000000, 0.000000, 300.00);
	mapp = CreateObject(19814, 1393.110961, -39.931266, 1000.275756, 0.000000, 0.000000, 162.199981, 300.00);
	mapp = CreateObject(19827, 1390.051513, -26.524370, 1001.775329, 0.000000, 0.000000, 105.600036, 300.00);
	mapp = CreateObject(1886, 1392.447753, -27.813863, 1007.827453, 30.300001, -2.099999, 73.200080, 300.00);
	mapp = CreateObject(19825, 1390.565185, -24.999065, 1003.455932, 0.000000, 0.000000, 44.599983, 300.00);
	mapp = CreateObject(1702, 1396.509399, -39.679107, 999.915893, 0.000000, 0.000000, 168.099960, 300.00);
	mapp = CreateObject(2261, 1396.248535, -39.975242, 1004.206237, 0.000000, 0.000000, 176.600082, 300.00);
	mapp = CreateObject(2262, 1399.811767, -39.249744, 1002.195922, 0.000000, 0.000000, -155.099822, 300.00);
}
