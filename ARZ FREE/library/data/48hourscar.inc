
stock ShowActionCar(playerid)
{
    if ActionCar{playerid} *then
        return false;
    
    ActionCar{playerid} = true;

    #include ../library/td/48car // Текстдравы ACTION CAR

    for new i; i < 46; i++ do
        ShowPlayerTD(playerid, ActionCarTD[playerid][i]);

    return SelectTextDraw(playerid, 0xFF5858FA);
}

stock HideActionCar(playerid)
{
    
    for new i; i < 46; i++ do
        DestroyPlayerTD(playerid, ActionCarTD[playerid][i]);

    return ActionCar{playerid} = false;
}

cmd:actioncar(playerid)
    return ShowActionCar(playerid);