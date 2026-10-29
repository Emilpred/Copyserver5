new 
	PlayerText:AuctionTD[MAX_PLAYERS][33];

const MAX_AUCTIONS = 100;

enum auction_data
{
	bool:auction_status,
	auction_time,
	auction_dataId,
	auction_type,
	auction_ownerId,
	auction_sqlId,
	auction_min_cost,
	auction_cost,
	auction_betId,
	auction_betSqlId,
	auction_bet[MAX_PLAYER_NAME],
	auction_owner[MAX_PLAYER_NAME],
	auction_item[2]
};

new AuctionData[MAX_AUCTIONS][auction_data];

enum auction_data_player
{
	bool:p_status_open,
	p_select_id,
	p_auction_id,
	p_auction_page,
	p_auction_timetype,
	p_auction_type,
	p_auction_dataId,
	p_auction_showId[6],
	p_auction_item[3]
};

new 
	AuctionData_player[MAX_PLAYERS][auction_data_player],
	PlayerText:AuctionData_TD[MAX_PLAYERS][6][7];

stock SelectAuctionType(playerid, type, page = 0)
{
	for new i; i < 4; i++ do
		PlayerTextDrawColor(playerid, AuctionTD[playerid][11 + i], i == type ? COLOR_GREEN:-1),
		ShowPlayerTD(playerid, AuctionTD[playerid][11 + i]);

	AuctionData_player[playerid][p_select_id] = type;
	AuctionData_player[playerid][p_auction_page] = page;

	destroyalltdbet_au(playerid);

	for new i, id; i < MAX_AUCTIONS; i++ do
	{
		if !AuctionData[i][auction_status] *then
			continue;
		
		if !(AuctionData[i][auction_type] == type) *then
			continue;
		
		if id >= (page * 6) && id < ((page + 1) * 6) *then {

			AuctionData_player[playerid][p_auction_showId][id - page * 6] = i;

			CreateTDBET_au(playerid, id - page * 6, i);

		}

		id++;
	} 	

	return true;
}

stock destroyalltdbet_au(playerid)
{
	for new i; i < 6; i++ do
	{
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][i][0]);
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][i][1]);
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][i][2]);
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][i][3]);
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][i][4]);
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][i][5]);
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][i][6]);

		AuctionData_player[playerid][p_auction_showId][i] = -1;
	}

	return true;
}

stock CreateTDBET_au(playerid, number, auId)
{
	for new i; i < 7; i++ do
		DestroyPlayerTD(playerid, AuctionData_TD[playerid][number][i]);

	AuctionData_TD[playerid][number][0] = CreatePlayerTextDraw(playerid, 167.9999, 142.9703 + 30.0 * number, "LD_SPAC:white"); // tuscia
	PlayerTextDrawTextSize(playerid, AuctionData_TD[playerid][number][0], 305.0000, 28.0000);
	PlayerTextDrawAlignment(playerid, AuctionData_TD[playerid][number][0], 1);
	PlayerTextDrawColor(playerid, AuctionData_TD[playerid][number][0], 471802367);
	PlayerTextDrawBackgroundColor(playerid, AuctionData_TD[playerid][number][0], 255);
	PlayerTextDrawFont(playerid, AuctionData_TD[playerid][number][0], 4);
	PlayerTextDrawSetProportional(playerid, AuctionData_TD[playerid][number][0], 0);
	PlayerTextDrawSetShadow(playerid, AuctionData_TD[playerid][number][0], 0);

	AuctionData_TD[playerid][number][1] = CreatePlayerTextDraw(playerid, 172.6666, 147.2740 + 30.0 * number, "~"); // tuscia
	PlayerTextDrawLetterSize(playerid, AuctionData_TD[playerid][number][1], 0.2786, 0.9694);
	PlayerTextDrawAlignment(playerid, AuctionData_TD[playerid][number][1], 1);
	PlayerTextDrawColor(playerid, AuctionData_TD[playerid][number][1], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionData_TD[playerid][number][1], 255);
	PlayerTextDrawFont(playerid, AuctionData_TD[playerid][number][1], 1);
	PlayerTextDrawSetProportional(playerid, AuctionData_TD[playerid][number][1], 1);
	PlayerTextDrawSetShadow(playerid, AuctionData_TD[playerid][number][1], 0);

	switch AuctionData[auId][auction_type] do
	{
		case 0,1:
			format(global_str, 100, "%s #%d", AuctionData[auId][auction_type] ? "biz":"house", AuctionData[auId][auction_dataId]);
		case 2:
			format(global_str, 100, "%s:(%d)", GetVehicleName(AuctionData[auId][auction_dataId]), GetVehicleModel(AuctionData[auId][auction_dataId]));
		case 3:
			format(global_str, 100, "Item [id:%d, level:+%d]", AuctionData[auId][auction_dataId], AuctionData[auId][auction_item][0]);
	}

	AuctionData_TD[playerid][number][2] = CreatePlayerTextDraw(playerid, 172.6667, 157.6444 + 30.0 * number, global_str); // tuscia
	PlayerTextDrawLetterSize(playerid, AuctionData_TD[playerid][number][2], 0.2786, 0.9694);
	PlayerTextDrawAlignment(playerid, AuctionData_TD[playerid][number][2], 1);
	PlayerTextDrawColor(playerid, AuctionData_TD[playerid][number][2], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionData_TD[playerid][number][2], 255);
	PlayerTextDrawFont(playerid, AuctionData_TD[playerid][number][2], 1);
	PlayerTextDrawSetProportional(playerid, AuctionData_TD[playerid][number][2], 1);
	PlayerTextDrawSetShadow(playerid, AuctionData_TD[playerid][number][2], 0);

	AuctionData_TD[playerid][number][3] = CreatePlayerTextDraw(playerid, 280.0000, 147.2741 + 30.0 * number, (str_f("Min Bet: %.3f", AuctionData[auId][auction_min_cost]))); // tuscia
	PlayerTextDrawLetterSize(playerid, AuctionData_TD[playerid][number][3], 0.2786, 0.9694);
	PlayerTextDrawAlignment(playerid, AuctionData_TD[playerid][number][3], 1);
	PlayerTextDrawColor(playerid, AuctionData_TD[playerid][number][3], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionData_TD[playerid][number][3], 255);
	PlayerTextDrawFont(playerid, AuctionData_TD[playerid][number][3], 1);
	PlayerTextDrawSetProportional(playerid, AuctionData_TD[playerid][number][3], 1);
	PlayerTextDrawSetShadow(playerid, AuctionData_TD[playerid][number][3], 0);


	AuctionData_TD[playerid][number][4] = CreatePlayerTextDraw(playerid, 280.3333, 158.4741 + 30.0 * number, "~"); // tuscia
	PlayerTextDrawLetterSize(playerid, AuctionData_TD[playerid][number][4], 0.1700, 0.9362);
	PlayerTextDrawAlignment(playerid, AuctionData_TD[playerid][number][4], 1);
	PlayerTextDrawColor(playerid, AuctionData_TD[playerid][number][4], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionData_TD[playerid][number][4], 255);
	PlayerTextDrawFont(playerid, AuctionData_TD[playerid][number][4], 1);
	PlayerTextDrawSetProportional(playerid, AuctionData_TD[playerid][number][4], 1);
	PlayerTextDrawSetShadow(playerid, AuctionData_TD[playerid][number][4], 0);

	AuctionData_TD[playerid][number][5] = CreatePlayerTextDraw(playerid, 403.6667, 145.0444 + 30.0 * number, "LD_SPAC:white"); // tuscia
	PlayerTextDrawTextSize(playerid, AuctionData_TD[playerid][number][5], 67.0000, 24.0000);
	PlayerTextDrawAlignment(playerid, AuctionData_TD[playerid][number][5], 1);
	PlayerTextDrawColor(playerid, AuctionData_TD[playerid][number][5], -2139062017);
	PlayerTextDrawBackgroundColor(playerid, AuctionData_TD[playerid][number][5], 255);
	PlayerTextDrawFont(playerid, AuctionData_TD[playerid][number][5], 4);
	PlayerTextDrawSetProportional(playerid, AuctionData_TD[playerid][number][5], 0);
	PlayerTextDrawSetShadow(playerid, AuctionData_TD[playerid][number][5], 0);
	PlayerTextDrawSetSelectable(playerid, AuctionData_TD[playerid][number][5], true);

	AuctionData_TD[playerid][number][6] = CreatePlayerTextDraw(playerid, 439.0000, 146.4443 + 30.0 * number, FixText("Padaryti~n~statyma")); // tuscia
	PlayerTextDrawLetterSize(playerid, AuctionData_TD[playerid][number][6], 0.2819, 1.0524);
	PlayerTextDrawTextSize(playerid, AuctionData_TD[playerid][number][6], 0.0000, -19.0000);
	PlayerTextDrawAlignment(playerid, AuctionData_TD[playerid][number][6], 2);
	PlayerTextDrawColor(playerid, AuctionData_TD[playerid][number][6], -1);
	PlayerTextDrawBackgroundColor(playerid, AuctionData_TD[playerid][number][6], 255);
	PlayerTextDrawFont(playerid, AuctionData_TD[playerid][number][6], 1);
	PlayerTextDrawSetProportional(playerid, AuctionData_TD[playerid][number][6], 1);
	PlayerTextDrawSetShadow(playerid, AuctionData_TD[playerid][number][6], 0);

	for new i; i < 7; i++ do
		ShowPlayerTD(playerid, AuctionData_TD[playerid][number][i]);

	return true;
}

stock GetAuctionName(id)
{
	new name[60];

	switch AuctionData[id][auction_type] do
	{
		case 0,1:
			format(name, sizeof name, "{ffffff}#%d - [%s #{6760D4}%d{ffffff}]", id, !AuctionData[id][auction_type] ? "namas":"verslas", AuctionData[id][auction_dataId]);
		case 2:
			format(name, sizeof name, "{ffffff}#%d - [%s #{6760D4}%d{ffffff}]", id, GetVehicleName(AuctionData[id][auction_dataId]), GetVehicleModel(AuctionData[id][auction_dataId]));
		case 3:
			format(name, sizeof name, "{ffffff}#%d - [%s +%d]", id, ItemsInfo[AuctionData[id][auction_dataId]][ItemName2], AuctionData[id][auction_item][0]);
	}

	return name;
}

stock ShowAuctionDialog(playerid, id)
{
	AuctionData_player[playerid][p_select_id] = id;
	
	format(global_str, 1024, "\
	{FFFFFF}Aukcionas ¹%d\n\
	Pastate: %s (uID: %d)\n\
	Minimalus statymas: {6760D4}%d{FFFFFF} BTC\n\
	Lotas: %s %s\n\n ",
	id,
	AuctionData[id][auction_owner],
	AuctionData[id][auction_sqlId],
	AuctionData[id][auction_min_cost],
	GetAuctionName(id),
	!(AuctionData[id][auction_betId] == -1) ? (str_f("\n\nPaskutinis statymas: {6760D4}%d{FFFFFF} BTC\nPastate: %s (uID: %d)", AuctionData[id][auction_cost], AuctionData[id][auction_bet], AuctionData[id][auction_betSqlId])):"" );

	return SPD(playerid, 9937, DIALOG_STYLE_INPUT, !"{FFFFFF}Auction-System |{8C65E9} Statymas", global_str, !"Pastatyti", !"Uzdaryti");
}

stock ShowAuctionTD(playerid)
{
	if AuctionData_player[playerid][p_status_open] *then
		return false;

	AuctionData_player[playerid][p_status_open] = true;
	AuctionData_player[playerid][p_select_id] = -1;
	
	#include ../library/td/auction

	for new i; i < 33 ; i++ do
		ShowPlayerTD(playerid, AuctionTD[playerid][i]);

	return SelectTextDraw(playerid, 0xA55252FF);
}

stock update_auction_data()
{
	for new i; i < MAX_AUCTIONS; i++ do
	{
		if AuctionData[i][auction_status] *then {

			if AuctionData[i][auction_time] < Global_Time *then	{

				AuctionData[i][auction_status] = false;
				
				if !(AuctionData[i][auction_betId] == -1) *then {
					
					mysql_format(mysql, global_str, 200, "SELECT `PlayerID`, `Online_status` FROM accounts WHERE ID = %d LIMIT 1;", AuctionData[i][auction_sqlId]);
					mysql_tquery(mysql, global_str, "GiveBTCAuction", "idd", AuctionData[i][auction_ownerId], AuctionData[i][auction_sqlId], AuctionData[i][auction_cost]);

					SetString(global_str, AuctionData[i][auction_bet]);
				}
				else
					SetString(global_str, AuctionData[i][auction_owner]);
				
				switch AuctionData[i][auction_type] do
				{
					case 0: {
							
						SetString(HouseInfo[AuctionData[i][auction_dataId]][hOwner], global_str);
						SaveHouse(AuctionData[i][auction_dataId]);
					}

					case 1: {
							
						SetString(BizData[AuctionData[i][auction_dataId]][bOwner], global_str);
						UpdateBusinessText(AuctionData[i][auction_dataId], 1);
					}

					case 2: {
							
						new vehicle = GetVehicleID(AuctionData[i][auction_dataId]);

						SetString(CarInfo[vehicle][cOwner], global_str);

						SaveOwnableCar(vehicle);

					}

					case 3: {
						
						new giveId = AuctionData[i][auction_betId] == -1 ? GetPlayerID(AuctionData[i][auction_owner]):GetPlayerID(AuctionData[i][auction_bet]);

						if !(giveId == INVALID_PLAYER_ID) *then
							AddItem(giveId, AuctionData[i][auction_dataId], 1, AuctionData[i][auction_item][0], AuctionData[i][auction_item][1]);
					}
				}
			}
		}
	}

	return true;
}

public: GiveBTCAuction(playerid, sqlId, bet)
{
	if !cache_get_row_count() *then
		return false;

	if !cache_get_row_int(0, 1, mysql) *then
	{
		//SQL("UPDATE accounts SET `CSCoin` = `CSCoin` + %f WHERE ID = %d LIMIT 1;", bet, sqlId);
	}

	else if !(PI[playerid][pID] == sqlId) *then
		playerid = cache_get_row_int(0, 0, mysql);

	
	if PI[playerid][pID] == sqlId *then
	{
		AddItem(playerid, 1461, bet);
		SCMF(playerid, COLOR_VALIK, "[Informacija]{FFFFFF} Jums iskaityta %d BTC i saskaita. | (statymo grazinimas uz aukciona/loto isdavimas)!", bet);
	}

	return true;
}

stock CloseAuctionTD(playerid)
{
	AuctionData_player[playerid][p_status_open] = false;

	destroyalltdbet_au(playerid);

	for new i; i < 33 ; i++ do
		DestroyPlayerTD(playerid, AuctionTD[playerid][i]);

	return CancelSelectTextDraw(playerid);
}
