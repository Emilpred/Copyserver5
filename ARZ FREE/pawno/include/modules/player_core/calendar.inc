cmd:calendar(playerid) return ShowPlayerGiftMenu(playerid);
stock ShowPlayerGiftMenu(playerid)
{
    executeEvent(playerid, 0, "window.executeEvent('event.setActiveView', `[\"RewardsNewYear\"]`);");
    global_str[0] = EOS;
    for(new i; i < sizeof(GiftInfo); i++)
    {
        f(global_str, sizeof(global_str), "%s{\"id\":%d,\"day\":%d,\"title\":\"%s\",\"amount\":%d,\"image\":\"24\"},",\
            global_str,\
            i, i+1,\
            GiftInfo[i][GIFT_TITLE],\
            GiftInfo[i][GIFT_AMOUNT]);
    }

    strdel(global_str, strlen(global_str)-1, strlen(global_str));
    executeEvent(playerid, 0, (str_f("window.executeEvent('event.rewardsNewYear.rewards', `[[%s]]`);", global_str)));


    executeEvent(playerid, 0, (str_f("window.executeEvent('event.rewardsNewYear.initializePlayerDay', `[{\"currentDay\":%d,\"needToPlay\":%d,\"played\":%d,\"received\":0}]`);",\
        GiftPlayer[playerid][GIFT_DAY]+1, GiftInfo[GiftPlayer[playerid][GIFT_DAY]][GIFT_PLAYED], GiftPlayer[playerid][GIFT_PLAYED]+1)));

    cursorPlayer(playerid, 0, true);

    return true;
}


cmd:test_gift(playerid, data[])
    ShowPlayerGiftMenu(playerid);

cmd:setgift(playerid, data[])
{
    new type_gift[2];
    sscanf(data, "dddd", type_gift[0], type_gift[1]);

    GiftPlayer[playerid][GIFT_DAY] = type_gift[0];
    GiftPlayer[playerid][GIFT_PLAYED] = type_gift[1];
    executeEvent(playerid, 0, "window.executeEvent('event.battlepass.MenuPressKeyBattlePass', [1,  \"Осенний календарь \",  \"Заберите ежедневную награду в 'Осеннем календаре'\", 1, 14]');"); //саня
}
forward UpdateGiftTime();
public UpdateGiftTime()
{
    foreach (new playerid : Player)
    {
        if (!IsPlayerConnected(playerid)) continue;

        if (GiftPlayer[playerid][GIFT_DAY] >= sizeof(GiftInfo)) continue;

        if (GiftPlayer[playerid][GIFT_PLAYED] < GiftInfo[GiftPlayer[playerid][GIFT_DAY]][GIFT_PLAYED])
        {
            GiftPlayer[playerid][GIFT_PLAYED]++;
        }
    }
    return 1;
}