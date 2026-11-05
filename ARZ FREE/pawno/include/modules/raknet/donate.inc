new 
	DonatePlayerCat[MAX_PLAYERS],
	bool:donateOpen[MAX_PLAYERS],
	DonatePlayerPage[MAX_PLAYERS] = 0;

enum newdonate_int
{
	data_Page,
	data_ID,
	data_Category,
	data_Item,
	data_Price,
	data_Value,
	data_Visible
};
static const KalashDonate[][newdonate_int] = {
};

stock ShowDonateDialog(playerid, type, value = 0)
{
	return true;
}

stock ErrorBuyingItem(playerid)
	return SPD(playerid, 0, 0, !"{ff6666}Ошибка", !"{ff6666}Данный товар временно не доступен для покупки!", "Окей", "");	