#if !defined MAX_REMOVED_OBJECTS
	#define MAX_REMOVED_OBJECTS 1100
#endif

enum RemovedObjectsENUM {_model, Float:_oX, Float:_oY, Float:_oZ, Float:_oRadius}
new RemovedObjects[MAX_REMOVED_OBJECTS][RemovedObjectsENUM];

stock RemoveBuilding(modelid, Float:oX, Float:oY, Float:oZ, Float:oRadius)
{
	new slot = GetObjectFreeSlot();
	if(slot == -1) return printf("\tCannot remove any more objects.\nIncrease MAX_REMOVED_OBJECTS in your script.\nIt is currently: %i", MAX_REMOVED_OBJECTS);
	RemovedObjects[slot][_model] = modelid;
	RemovedObjects[slot][_oX] = oX;
	RemovedObjects[slot][_oY] = oY;
	RemovedObjects[slot][_oZ] = oZ;
	RemovedObjects[slot][_oRadius] = oRadius;
	
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    RemoveBuildingForPlayer(i, modelid, oX, oY, oZ, oRadius);
	}
	return 1;
}

forward REMOBJ_OnPlayerConnect(playerid);
public OnPlayerConnect(playerid)
{
	for(new i; i < MAX_REMOVED_OBJECTS; i++)
	{
	    if(RemovedObjects[i][_model] != 0) RemoveBuildingForPlayer(playerid, RemovedObjects[i][_model], RemovedObjects[i][_oX], RemovedObjects[i][_oY], RemovedObjects[i][_oZ], RemovedObjects[i][_oRadius]);
	}
	if(funcidx("REMOBJ_OnPlayerConnect") != -1) CallLocalFunction("REMOBJ_OnPlayerConnect", "i", playerid);
	return 1;
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect REMOBJ_OnPlayerConnect

stock GetObjectFreeSlot()
{
	for(new i; i < MAX_REMOVED_OBJECTS; i++)
	{
	    if(RemovedObjects[i][_model] == 0) return i;
	}
	return -1;
}

stock CountRemovedObjects()
{
    new count = 0;
    for(new i; i < MAX_REMOVED_OBJECTS; i++)
    {
        if(RemovedObjects[i][_model] != 0) count++;
    }
	return count;
}


stock _RemoveBuildingForPlayer(playerid, modelid, Float:fX, Float:fY, Float:fZ, Float:fRadius)
{
	return RemoveBuilding(modelid, fX, fY, fZ, fRadius);
	#pragma unused playerid
}
#define RemoveBuildingForPlayer _RemoveBuildingForPlayer