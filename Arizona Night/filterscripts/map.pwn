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


    #include ../library/map/stolikicasino
	#include ../library/map/bank
	#include ../library/map/kvartiri
	#include ../library/map/bolka
	#include ../library/map/bikerent
	#include ../library/map/spawns
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
	#include ../library/map/sklads
	#include ../library/map/autoservice 
	#include ../library/map/newhousesarz
	#include ../library/map/cinema
}
