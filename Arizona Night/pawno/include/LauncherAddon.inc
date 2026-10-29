native SetLauncherStatus(playerid, bool:status);
native GetLauncherStatus(playerid);

forward GetLauncherSkinModel(current_model);
public GetLauncherSkinModel(current_model)
{
	new model = -1;
	switch(current_model)
	{
		case 312: model = 200;
		case 313: model = 280;
		case 314: model = 5;
		case 315: model = 279;
	}
	return model;
}

forward GetLauncherVehicleModel(current_model);
public GetLauncherVehicleModel(current_model)
{
	new model = -1;
	switch(current_model)
	{
	    case 612: model = 541;
	    case 613: model = 451;
	    case 614: model = 411;
		case 662: model = 400;
		case 668: model = 541;
		case 1196: model = 451;
		case 3194: model = 522;
	}
	return model;
}