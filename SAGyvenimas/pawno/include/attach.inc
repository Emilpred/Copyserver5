/* SA-MP Include Attach3DTextLabelToObject
 *
 * (c) by Kaliber, 2015
 *
 */
#if !defined _samp_included
    #include <a_samp>
#endif
#if defined _samp_attach
    #endinput
#endif
#define _samp_attach
#if !defined MAX_LABEL_TEXT
    #define MAX_LABEL_TEXT 128
#endif
#define std(%0) %0[0]='\0'
#define Push(%0,%1) std(%0),strcat(%0,%1,0x80)
#define A:: A_Q_Z_
/*
    native Attach3DTextLabelToObject(Text3D:id, objectid, Float:OffsetX, Float:OffsetY, Float:OffsetZ);
    native Detach3DTextLabel(Text3D:id);

    native AttachPlayer3DTextLabelToObject(playerid, PlayerText3D:id, objectid, Float:OffsetX, Float:OffsetY, Float:OffsetZ);
    native DetachPlayer3DTextLabel(PlayerText3D:id);
*/
#if defined FILTERSCRIPT
    forward Attach_OnFilterScriptInit();
#else
    forward Attach_OnGameModeInit();
#endif
native Text3D:__Create3DTextLabel(text[], color, Float:X, Float:Y, Float:Z, Float:DrawDistance, virtualworld, testLOS) = Create3DTextLabel;
native __Update3DTextLabelText(Text3D:id, color, text[]) = Update3DTextLabelText;
native __Delete3DTextLabel(Text3D:id) = Delete3DTextLabel;

native PlayerText3D:__CreatePlayer3DTextLabel(playerid,text[],color,Float:X,Float:Y,Float:Z,Float:DrawDistance,attachedplayer,attachedvehicle,testLOS) = CreatePlayer3DTextLabel;
native __UpdatePlayer3DTextLabelText(playerid, PlayerText3D:id, color, text[]) = UpdatePlayer3DTextLabelText;
native __DeletePlayer3DTextLabel(playerid, PlayerText3D:id) = DeletePlayer3DTextLabel;
enum A::P {
    A::text[MAX_LABEL_TEXT],A::color,Float:A::X,Float:A::Y,Float:A::Z,Float:A::f[3],Float:A::Draw,A::World,A::Los,A::attached,A::player,A::flag
};
static A::Q[MAX_3DTEXT_GLOBAL][A::P],flag=-1;

stock Text3D:_Create3DTextLabel(text[], color, Float:X, Float:Y, Float:Z, Float:DrawDistance, virtualworld=0, testLOS=0) {
    flag++,Push(A::Q[flag][A::text],text),A::Q[flag][A::color]=color,A::Q[flag][A::X]=X,A::Q[flag][A::Y]=Y,A::Q[flag][A::Z]=Z,A::Q[flag][A::Draw]=DrawDistance;
    A::Q[flag][A::flag]=_:__Create3DTextLabel(text,color,X,Y,Z,DrawDistance,virtualworld,testLOS);
    return A::Q[flag][A::World]=virtualworld,A::Q[flag][A::Los]=testLOS,A::Q[flag][A::player]=-1,Text3D:A::Q[flag][A::flag];
}
#if defined _ALS_Create3DTextLabel
    #undef Create3DTextLabel
#else
    #define _ALS_Create3DTextLabel
#endif
#define Create3DTextLabel _Create3DTextLabel
stock PlayerText3D:_CreatePlayer3DTextLabel(playerid,text[],color,Float:X,Float:Y,Float:Z,Float:DrawDistance,attachedplayer=INVALID_PLAYER_ID,attachedvehicle=INVALID_VEHICLE_ID,testLOS=0) {
    if(!IsPlayerConnected(playerid)) return PlayerText3D:INVALID_PLAYER_ID;
    flag++,Push(A::Q[flag][A::text],text),A::Q[flag][A::color] = color,A::Q[flag][A::X] = X,A::Q[flag][A::Y] = Y,A::Q[flag][A::Z] = Z,A::Q[flag][A::Draw] = DrawDistance;
    A::Q[flag][A::flag] = _:__CreatePlayer3DTextLabel(playerid,text,color,X,Y,Z,DrawDistance,attachedplayer,attachedvehicle,testLOS);
    return A::Q[flag][A::Los] = testLOS,PlayerText3D:A::Q[flag][A::flag];
}
#if defined _ALS_CreatePlayer3DTextLabel
    #undef CreatePlayer3DTextLabel
#else
    #define _ALS_CreatePlayer3DTextLabel
#endif
#define CreatePlayer3DTextLabel _CreatePlayer3DTextLabel
stock _Update3DTextLabelText(Text3D:id, color, text[]) {
    new tmp = A::H(id);
    if(tmp == INVALID_3DTEXT_ID) return 0;
    return Push(A::Q[tmp][A::text],text),A::Q[tmp][A::color]=color,__Update3DTextLabelText(id,color,text);
}
#if defined _ALS_Update3DTextLabelText
    #undef Update3DTextLabelText
#else
    #define _ALS_Update3DTextLabelText
#endif
#define Update3DTextLabelText _Update3DTextLabelText
stock _UpdatePlayer3DTextLabelText(playerid, PlayerText3D:id, color, text[]) {
    new tmp = A::G(id);
    if(tmp == INVALID_3DTEXT_ID) return 0;
    return Push(A::Q[tmp][A::text],text),A::Q[tmp][A::color]=color,__UpdatePlayer3DTextLabelText(playerid,id,color,text);
}
#define UpdatePlayer3DTextLabelText _UpdatePlayer3DTextLabelText
stock _Delete3DTextLabel(Text3D:id) {
    new tmp = A::H(id);
    if(tmp == INVALID_3DTEXT_ID) return 0;
    return std(A::Q[tmp][A::text]),A::Q[tmp][A::attached]=0,__Delete3DTextLabel(id);
}
#if defined _ALS_Delete3DTextLabel
    #undef Delete3DTextLabel
#else
    #define _ALS_Delete3DTextLabel
#endif
#define Delete3DTextLabel _Delete3DTextLabel
stock _DeletePlayer3DTextLabel(playerid, PlayerText3D:id) {
    new tmp = A::G(id);
    if(tmp == INVALID_3DTEXT_ID) return 0;
    return std(A::Q[tmp][A::text]),A::Q[tmp][A::player]=-1,A::Q[tmp][A::attached]=0,__DeletePlayer3DTextLabel(playerid,id);
}
#if defined _ALS_DeletePlayer3DTextLabel
    #undef DeletePlayer3DTextLabel
#else
    #define _ALS_DeletePlayer3DTextLabel
#endif
#define DeletePlayer3DTextLabel _DeletePlayer3DTextLabel
stock Attach3DTextLabelToObject(Text3D:id, objectid, Float:OffsetX, Float:OffsetY, Float:OffsetZ) {
    new tmp = A::H(id);
    if(tmp == INVALID_3DTEXT_ID) return 0;
    if(!GetObjectPos(objectid,A::Q[tmp][A::X],A::Q[tmp][A::Y],A::Q[tmp][A::Z])) return 0;
    A::Q[tmp][A::f][0] = OffsetX,A::Q[tmp][A::f][1] = OffsetY,A::Q[tmp][A::f][2] = OffsetZ,
    A::Q[tmp][A::attached] = objectid,__Delete3DTextLabel(id);
    return __Create3DTextLabel(A::Q[tmp][A::text],A::Q[tmp][A::color],
                               A::Q[tmp][A::X]+A::Q[tmp][A::f][0],
							   A::Q[tmp][A::Y]+A::Q[tmp][A::f][1],
			       			   A::Q[tmp][A::Z]+A::Q[tmp][A::f][2],
			       			   A::Q[tmp][A::Draw],A::Q[tmp][A::World],A::Q[tmp][A::Los]),1;
}
stock AttachPlayer3DTextLabelToObject(playerid, PlayerText3D:id, objectid, Float:OffsetX, Float:OffsetY, Float:OffsetZ) {
    if(!IsPlayerConnected(playerid)) return 0;
    new tmp = A::G(id);
    if(tmp == INVALID_3DTEXT_ID) return 0;
    if(!GetObjectPos(objectid,A::Q[tmp][A::X],A::Q[tmp][A::Y],A::Q[tmp][A::Z])) return 0;
    A::Q[tmp][A::f][0] = OffsetX,A::Q[tmp][A::f][1] = OffsetY,A::Q[tmp][A::f][2] = OffsetZ,
    A::Q[tmp][A::attached] = objectid,__DeletePlayer3DTextLabel(playerid,id);
    return __CreatePlayer3DTextLabel(playerid,A::Q[tmp][A::text],A::Q[tmp][A::color],
                                     A::Q[tmp][A::X]+A::Q[tmp][A::f][0],
				     				 A::Q[tmp][A::Y]+A::Q[tmp][A::f][1],
				     				 A::Q[tmp][A::Z]+A::Q[tmp][A::f][2],
				     				 A::Q[tmp][A::Draw],INVALID_PLAYER_ID,INVALID_VEHICLE_ID,A::Q[tmp][A::Los]),1;
}
stock Detach3DTextLabel(Text3D:id) {
    new tmp = A::G(PlayerText3D:id);
    if(tmp == INVALID_3DTEXT_ID) tmp = A::H(id);
    if(tmp == INVALID_3DTEXT_ID) return 0;
    return A::Q[tmp][A::attached]=0;
}
#define DetachPlayer3DTextLabel(%0) Detach3DTextLabel(Text3D:%0)
stock A::G(PlayerText3D:id) {
    for(new i; i<MAX_3DTEXT_GLOBAL; i++) if(PlayerText3D:A::Q[i][A::flag] == id) return i;
    return INVALID_3DTEXT_ID;
}
stock A::H(Text3D:id) {
    for(new i; i<MAX_3DTEXT_GLOBAL; i++) if(Text3D:A::Q[i][A::flag] == id && A::Q[i][A::player] == -1) return i;
    return INVALID_3DTEXT_ID;
}
#if defined FILTERSCRIPT
    public OnFilterScriptInit() return SetTimer("@a_OBJ",199,1),CallLocalFunction("Attach_OnFilterScriptInit","");
    #if defined _ALS_OnFilterScriptInit
        #undef OnFilterScriptInit
    #else
        #define _ALS_OnFilterScriptInit
    #endif
    #define OnFilterScriptInit Attach_OnFilterScriptInit
#else
    public OnGameModeInit() return SetTimer("@a_OBJ",199,1),CallLocalFunction("Attach_OnGameModeInit","");
    #if defined _ALS_OnGameModeInit
        #undef OnGameModeInit
    #else
        #define _ALS_OnGameModeInit
    #endif
    #define OnGameModeInit Attach_OnGameModeInit
#endif
@a_OBJ();@a_OBJ() {
    new Float:tmp[3],i;
    for(;; i++) {
        if(i==MAX_3DTEXT_GLOBAL) break;
		if(!A::Q[i][A::attached]) continue;
		#if !defined STREAMER_OBJECT_TYPE_DYNAMIC
		if(!GetObjectPos(A::Q[i][A::attached],tmp[0],tmp[1],tmp[2])) {Detach3DTextLabel(Text3D:i); continue;}
		#else
	  	if(!GetDynamicObjectPos(A::Q[i][A::attached],tmp[0],tmp[1],tmp[2])) {Detach3DTextLabel(Text3D:i); continue;}
		#endif
		if(A::Q[i][A::X] != tmp[0] || A::Q[i][A::Y] != tmp[1] || A::Q[i][A::Z] != tmp[2]) {
  		A::Q[i][A::X] = tmp[0],A::Q[i][A::Y] = tmp[1], A::Q[i][A::Z] = tmp[2];
	    switch(A::Q[i][A::player]) {
	        case -1: __Delete3DTextLabel(Text3D:A::Q[i][A::flag]),
                     __Create3DTextLabel(A::Q[i][A::text],A::Q[i][A::color],
		  		             			 A::Q[i][A::X]+A::Q[i][A::f][0],A::Q[i][A::Y]+A::Q[i][A::f][1],
				             			 A::Q[i][A::Z]+A::Q[i][A::f][2], A::Q[i][A::Draw],A::Q[i][A::World],A::Q[i][A::Los]);

			default: __DeletePlayer3DTextLabel(A::Q[i][A::player],PlayerText3D:A::Q[i][A::flag]),
 					 __CreatePlayer3DTextLabel(A::Q[i][A::player],A::Q[i][A::text],A::Q[i][A::color],
					           				   A::Q[i][A::X]+A::Q[i][A::f][0],A::Q[i][A::Y]+A::Q[i][A::f][1],
					           				   A::Q[i][A::Z]+A::Q[i][A::f][2], A::Q[i][A::Draw],
					           				   INVALID_PLAYER_ID,INVALID_VEHICLE_ID,A::Q[i][A::Los]);
            }
        }
    }
    return 1;
}
#undef std
