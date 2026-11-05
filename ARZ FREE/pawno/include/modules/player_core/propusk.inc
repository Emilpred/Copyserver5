stock newwbp(playerid)
{
	executeEvent(playerid, 0, "window.executeEvent('event.setActiveView', `[\"EventPass\"]`);");
	executeEvent(playerid, 0, "window.executeEvent('event.arizonahud.activeQuestVisible', `[false]`);");
	executeEvent(playerid, 0, "window.executeEvent('event.eventPass.updatePageBit', `[1]`);");
	executeEvent(playerid, 0, "window.executeEvent('event.eventPass.initializeBattlePass', `[{ \"level\":8,\"exp\":87,\"maxExp\":100,\"availableToReceive\":[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}]`);");
	executeEvent(playerid, 0, "window.executeEvent('event.eventPass.initializePassCoins', `[24]`);");
	
	cursorPlayer(playerid, 0, true);
	
	return true;
}