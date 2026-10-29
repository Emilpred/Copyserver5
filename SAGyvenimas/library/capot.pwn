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
