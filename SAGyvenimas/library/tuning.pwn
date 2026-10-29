#define FILTERSCRIPT
new SQL_STRING[4097];

#include a_samp.inc
#include sscanf2.inc
#include foreach.inc
#include Pawn.RakNet.inc
#include Pawn.CMD.inc

#define public:%0(%1) forward%0(%1); public%0(%1)
#define str_f(%0,%1) format(SQL_STRING, sizeof SQL_STRING, %0, %1), SQL_STRING

#include massivehelper.inc

enum infocars
{
	id_model,
	carname_td[24],
	car_name[44],
	car_capot[6],
	car_spoiler[6],
	car_vixlop[6]
};

new const InfoCar[][infocars] = {
	{612, "gtsamg", "Mercedes GT63s AMG", {7412, 7413, 7414, 7974, 7975}, {12343, 12344, 12345, 12346, 12347}, {12067, 12068, 12069, 12070, 12071}},
	{613, "g63amg", "Mercedes G63 AMG", {7397, 7398, 7399, 7400, 7401}, {12331, 12332, 12333, 12334, 12335}, {12052, 12053, 12054, 12055, 12056}},
	{614, "rs6", "Audi RS6", {11879, 11880, 11881, 11882, 11883}, {12463, 12464, 12465, 12466, 12467}, {12186, 12187, 12188, 12189, 12190}},
	{662, "bmwxfive", "BMW X5m", {-1, -1, -1, -1, -1, -1}, {-1, -1, -1, -1, -1, -1}, {-1, -1, -1, -1, -1, -1}},
	{663, "chevcor", "Chevrolet Corvette", {-1, -1, -1, -1, -1, -1}, {-1, -1, -1, -1, -1, -1}, {-1, -1, -1, -1, -1, -1}},
	{665, "checruz", "Chevrolet Cruze", {6825, 6826, 6827, 6828, 6829}, {12301, 12302, 12303, 12304, 12305}, {12017, 12018, 12019, 12020, 12021}}
};

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

new TuningColors[][] = {
	{0, 0, 0},
	{245, 245, 245},
	{161, 119, 42},
	{16, 4, 132},
	{57, 55, 38},
	{110, 68, 134},
	{16, 142, 215},
	{183, 117, 76},
	{198, 190, 189},
	{114, 112, 94},
	{122, 89, 70},
	{121, 106, 101},
	{141, 126, 93},
	{90, 89, 88}
};

stock SearchCarName(model)
{
	for new i; i < sizeof InfoCar; i++ do
		if model == InfoCar[i][id_model] *then return i;

	return false;
}

public: SetWadCar(carid, wad, color)
{
	new BitStream:bs = BS_New();

	BS_WriteValue(bs, PR_UINT16, carid, PR_UINT16, 256, PR_UINT16, wad > 19 || wad < 1 ? 259 : 260),
	BS_WriteValue(bs, PR_UINT16, strlen((str_f("%s_wad", InfoCar[SearchCarName(GetVehicleModel(carid))][carname_td]))), PR_STRING, (str_f("%s_wad", InfoCar[SearchCarName(GetVehicleModel(carid))][carname_td]))),
  	BS_WriteValue(bs, PR_UINT8, 255, PR_UINT8, TuningColors[color][0], PR_UINT8, TuningColors[color][1], PR_UINT8, TuningColors[color][2]),
	BS_WriteValue(bs, PR_UINT16, strlen((str_f("wad%i", wad))), PR_STRING, (str_f("wad%i", wad)));

    PR_SendRPCToVehicleStream(bs, carid, 161);
    return BS_Delete(bs);
}

public: SetTintWindow(carid, window, size, color)
{
	new BitStream:bs = BS_New(),
		wnd_str[][] = {"wndfrl", "wnd", "wdor_f", "wdor_r", "wnd_rr", "wndrrl"};

	BS_WriteValue(bs, PR_UINT32, carid, PR_UINT8, 4, PR_UINT8, 1),
	BS_WriteValue(bs, PR_UINT16, strlen((str_f("%s_%s", InfoCar[SearchCarName(GetVehicleModel(carid))][carname_td], wnd_str[window]))), PR_STRING, (str_f("%s_%s", InfoCar[SearchCarName(GetVehicleModel(carid))][carname_td], wnd_str[window]))),
	BS_WriteValue(bs, PR_UINT8, size, PR_UINT8, TuningColors[color][0], PR_UINT8, TuningColors[color][1], PR_UINT8, TuningColors[color][2]),
	BS_WriteValue(bs, PR_UINT16, strlen("white"), PR_STRING, "white");

    PR_SendRPCToVehicleStream(bs, carid, 161);
    return BS_Delete(bs);
}

public: SetNeonCar(carid, color)
{
    new BitStream:bs = BS_New();
    
    BS_WriteValue(bs, PR_UINT8, 220, PR_UINT8, 142, PR_UINT16, carid),
    BS_WriteValue(bs, PR_UINT8, 255, PR_UINT8, TuningColors[color][0], PR_UINT8, TuningColors[color][1], PR_UINT8, TuningColors[color][2]);
    
    PR_SendPacketToVehicleStream(bs, carid);
    return BS_Delete(bs);
    
}

public: SetLightCar(carid, color)
{
    new BitStream:bs = BS_New();

    BS_WriteValue(bs, PR_UINT8, 220, PR_UINT8, 132, PR_UINT16, carid),
    BS_WriteValue(bs, PR_UINT8, 255, PR_UINT8, TuningColors[color][0], PR_UINT8, TuningColors[color][1], PR_UINT8, TuningColors[color][2]);

    PR_SendPacketToVehicleStream(bs, carid);
    return BS_Delete(bs);

}

public: SetSmokeCar(carid, color)
{
    new BitStream:bs = BS_New();

    BS_WriteValue(bs, PR_UINT8, 220, PR_UINT8, 132, PR_UINT16, carid),
    BS_WriteValue(bs, PR_UINT8, 205, PR_UINT8, 204, PR_UINT8, 204, PR_UINT8, 62),
    BS_WriteValue(bs, PR_UINT8, TuningColors[color][0], PR_UINT8, TuningColors[color][1], PR_UINT8, TuningColors[color][2], PR_UINT8, 0);

    PR_SendPacketToVehicleStream(bs, carid);
    return BS_Delete(bs);

}

public: SetWheelCollapse(carid, type, Float:lunge, Float:collapse)
{
	static const WheelType[][] = {"wheel_lf_dummy", "wheel_rf_dummy", "wheel_lb_dummy", "wheel_rb_dummy"};

 	for(new i; i < 2; i++) {
 	    new BitStream:bs = BS_New();
 	    
		BS_WriteValue(bs, PR_UINT16, carid),
	    BS_WriteValue(bs, PR_UINT8, 0, PR_UINT8, 0),
	    BS_WriteValue(bs, PR_UINT8, 2, PR_UINT8, 1),
	    BS_WriteValue(bs, PR_UINT16, strlen(WheelType[type == 1 ? i : i+2])),
	    BS_WriteValue(bs, PR_STRING, WheelType[type == 1 ? i : i+2]),
	    BS_WriteValue(bs, PR_FLOAT, i ? lunge : -lunge, PR_FLOAT, 0.000000, PR_FLOAT, 0.000000, PR_FLOAT, i ? type == 1 ? -collapse : collapse : type == 1 ? collapse : -collapse);
	    
	    PR_SendRPCToVehicleStream(bs, carid, 161);
	    BS_Delete(bs);
	    
	}
	return true;
}

public: SetCarNumber(carid, type, const number[], const region[])
{
	new BitStream:bs = BS_New();
	
	BS_WriteValue(bs, PR_UINT8, 220, PR_UINT8, 153, PR_UINT16, carid, PR_UINT8, type),
	BS_WriteValue(bs, PR_STRING32, number, PR_STRING32, region);

    PR_SendPacketToVehicleStream(bs, carid);
	return BS_Delete(bs);
}

public: SetWheelSize(carid, Float:size)
{
    new BitStream:bs = BS_New();
    
    BS_WriteValue(bs, PR_UINT8, 220, PR_UINT8, 135, PR_UINT16, carid),
    BS_WriteValue(bs, PR_FLOAT, size);
    
    PR_SendPacketToVehicleStream(bs, carid);
	return BS_Delete(bs);
}

public: SetVehicleComponent(carid, type, component)
{
	if(type < 1 && type > 3) return false;
	else if(component > 4) return false;
	
    new BitStream:bs = BS_New(), model;
    
 	switch(type)
	{
	    case 1: model = InfoCar[SearchCarName(GetVehicleModel(carid))][car_capot][component];
	    case 2: model = InfoCar[SearchCarName(GetVehicleModel(carid))][car_spoiler][component];
	    case 3: model = InfoCar[SearchCarName(GetVehicleModel(carid))][car_vixlop][component];
	}

	BS_WriteValue(bs, PR_UINT8, 255, PR_UINT8, 255, PR_UINT32, 2),
	BS_WriteValue(bs, PR_UINT32, carid, PR_UINT32, model, PR_UINT32, 2, PR_UINT8, 0);
	PR_SendRPCToVehicleStream(bs, carid, 96);
	return BS_Delete(bs);
}

public: UnSetVehicleComponent(carid, type, component)
{
    new BitStream:bs = BS_New(), model;
    
    switch(type)
	{
	    case 1: model = InfoCar[SearchCarName(GetVehicleModel(carid))][car_capot][component];
	    case 2: model = InfoCar[SearchCarName(GetVehicleModel(carid))][car_spoiler][component];
	    case 3: model = InfoCar[SearchCarName(GetVehicleModel(carid))][car_vixlop][component];
	}

	BS_WriteValue(bs, PR_UINT16, carid, PR_UINT16, model),
	BS_WriteValue(bs, PR_UINT8, 0, PR_UINT8, 0);
	PR_SendRPCToVehicleStream(bs, carid, 57);
	return BS_Delete(bs);
}
