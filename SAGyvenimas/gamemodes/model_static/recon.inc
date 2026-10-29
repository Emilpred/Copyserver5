stock ShowButtonRecon(playerid, id)
{
	for new i; i < 6; i++ do DestroyPlayerTD(playerid, recon_p[playerid][i]);
	new position = Int_GetPlayerData(playerid,"selectrecon");
	#include <textdraws/cataloges/recon>
	for new i; i < 6; i++ do
	{
		if (i > 0 && i < 5)
		{
			PlayerTextDrawColor(playerid, recon_p[playerid][i], i == 4-Int_GetPlayerData(playerid,"selectrecon1") ? 0xC0C0C0FF:0xA52A2AFF);
		}	

		ShowPlayerTD(playerid,recon_p[playerid][i]);
	}	
	switch(id)
	{
		case 1:
		{
			PlayerTextDrawSetString(playerid, recon_p[playerid][1],"PASS");
			PlayerTextDrawSetString(playerid, recon_p[playerid][2],"JSTAT");
			PlayerTextDrawSetString(playerid, recon_p[playerid][3],"IWEP");
			PlayerTextDrawSetString(playerid, recon_p[playerid][4],"USTAT");
		}
		case 2:
		{
			PlayerTextDrawSetString(playerid, recon_p[playerid][1],"RWEAP");
			PlayerTextDrawSetString(playerid, recon_p[playerid][2],"-HEALT");
			PlayerTextDrawSetString(playerid, recon_p[playerid][3],"+HEALT");
			PlayerTextDrawSetString(playerid, recon_p[playerid][4],"SLAP");
		}
		case 3,4:
		{
			PlayerTextDrawSetString(playerid, recon_p[playerid][1],"WARN");
			PlayerTextDrawSetString(playerid, recon_p[playerid][2],"JAIL");
			PlayerTextDrawSetString(playerid, recon_p[playerid][3],"MUTE");
			PlayerTextDrawSetString(playerid, recon_p[playerid][4],"BAN");
		}
		case 5:
		{
			PlayerTextDrawSetString(playerid, recon_p[playerid][1],"SPAWN");
			PlayerTextDrawSetString(playerid, recon_p[playerid][2],"GHEALT");
			PlayerTextDrawSetString(playerid, recon_p[playerid][3],"FLIP");
			PlayerTextDrawSetString(playerid, recon_p[playerid][4],"GCAR");
		}
		case 6:
		{
			PlayerTextDrawSetString(playerid, recon_p[playerid][1],"LIC");
			PlayerTextDrawSetString(playerid, recon_p[playerid][2],"INV");
			PlayerTextDrawSetString(playerid, recon_p[playerid][3],"CSKILLS");
			PlayerTextDrawSetString(playerid, recon_p[playerid][4],"SKILLS");
		}
		case 8:
		{
			PlayerTextDrawSetString(playerid, recon_p[playerid][1],"EXIT");
			PlayerTextDrawSetString(playerid, recon_p[playerid][2],"GETHER");
			PlayerTextDrawSetString(playerid, recon_p[playerid][3],"GOTO");
			PlayerTextDrawSetString(playerid, recon_p[playerid][4],"AZ");
		}
	}
	return 1;
}