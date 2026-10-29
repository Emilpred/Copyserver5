/*Info Zones*/
enum familyterinfo
{
	Float:familyPosX,
	Float:familyPosY,
	Float:familyPosZ,
	famZoneId
}
new FamilyTerInfo[][familyterinfo] =
{
	{1562.087768, 2002.635620, 10.820312, -1},
	{1685.756225, 2004.815673, 10.820312, -1},
	{1508.352783, 1882.832641, 10.820312, -1},
	{1563.331420, 1680.473754, 10.820312, -1},
	{1503.579711, 1575.096313, 10.820312, -1},
	{1502.835815, 1447.734252, 10.834452, -1},
	{1502.947021, 1311.906494, 10.861051, -1},
	{1672.762939, 1177.779907, 10.820312, -1},
	{1749.520874, 913.630432, 10.712100, -1},
	{1752.516235, 1145.698730, 10.820312, -1},
	{1741.294067, 1284.071777, 10.836406, -1},
	{1725.610107, 1442.621337, 10.802625, -1},
	{1734.616333, 1561.885375, 10.820312, -1},
	{1728.972412, 1724.125244, 10.817836, -1},
	{1752.187500, 2026.884399, 10.820312, -1},
	{1747.846923, 2350.534667, 10.828130, -1},
	{1775.123657, 2569.206542, 10.820312, -1},
	{1904.453735, 2568.315429, 10.820312, -1},
	{1971.311523, 2495.145263, 11.178249, -1},
	{2014.962280, 2380.078613, 10.820312, -1},
	{1922.065795, 2020.876342, 10.812517, -1},
	{1933.797119, 1815.308837, 12.714401, -1},
	{1899.635620, 1726.007324, 10.820312, -1},
	{2187.669921, 1003.153991, 10.820312, -1},
	{2114.051757, 1139.817993, 10.820312, -1},
	{2125.463623, 1573.157592, 10.820312, -1},
	{2037.339477, 1600.754028, 10.820312, -1},
	{2046.848022, 1731.581665, 10.820312, -1},
	{2177.086425, 1718.373779, 11.046875, -1},
	{2162.725585, 1905.046752, 10.812500, -1},
	{2169.291992, 1970.643554, 10.820312, -1},
	{2218.388427, 2007.928955, 10.820312, -1},
	{2299.184326, 1051.116088, 10.820312, -1},
	{2267.660888, 938.923583, 10.822090, -1},
	{2391.455322, 958.506225, 10.820312, -1},
	{2294.409423, 1181.295410, 10.820312, -1},
	{2418.246093, 1299.654174, 10.820312, -1},
	{2281.635986, 1868.374511, 10.820312, -1},
	{2484.474853, 2509.371337, 21.880126, -1},
	{2688.250488, 909.179199, 10.691453, -1},
	{2622.052734, 1459.365966, 10.830274, -1},
	{2594.714111, 1618.578979, 10.820312, -1},
	{2665.964599, 2012.483520, 10.828125, -1},
	{2601.967041, 2091.960693, 10.821537, -1},
	{2593.419433, 2480.115478, 10.820312, -1},
	{1315.272827, 914.698059, 9.899659, -1},
	{1302.770629, 1068.402099, 10.820312, -1},
	{1367.525024, 1292.624267, 10.820312, -1},
	{1367.448120, 1441.593994, 10.820312, -1},
	{1367.790771, 1579.706176, 10.820312, -1},
	{1308.077026, 1671.619995, 10.820312, -1},
	{1367.567626, 1687.841796, 10.820312, -1},
	{1342.702270, 1884.982910, 10.820312, -1},
	{1442.601806, 1888.016723, 10.820312, -1},
	{1329.154296, 1958.272460, 10.820312, -1},
	{1392.710937, 2006.140747, 10.820312, -1},
	{1305.496215, 2354.845703, 10.820312, -1},
	{1377.641601, 2558.084960, 10.820312, -1},
	{1245.075927, 2521.934570, 10.820312, -1},
	{1530.270996, 2540.541748, 10.820312, -1},
	{1639.982421, 2546.187500, 10.820312, -1},
	{1663.103637, 2134.392089, 10.820312, -1}
};

stock ShowFamilyCapture(playerid)
{    
	if FamilyCaptureOpen{playerid} *then
		return false;
		
    FamilyCapture[playerid][16] = CreatePlayerTextDraw(playerid, 182.999802, 58.762699, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][16], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][16], 272.609497, 313.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][16], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][16], 0x1E1E1EFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][16], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][16], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][16], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][16], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][16], 4);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][16], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][16], 0);

    FamilyCapture[playerid][15] = CreatePlayerTextDraw(playerid, 183.233200, 64.829300, "");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][15], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][15], 272.459412, 3.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][15], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][15], 0xA52A2AFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][15], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][15], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][15], 0x00000000);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][15], 5);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][15], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][15], 0);
    PlayerTextDrawSetPreviewModel(playerid, FamilyCapture[playerid][15], 19063);
    PlayerTextDrawSetPreviewRot(playerid, FamilyCapture[playerid][15], 0.000000, 0.000000, 50.000000, 0.234500);

    FamilyCapture[playerid][14] = CreatePlayerTextDraw(playerid, 183.133102, 49.636501, "");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][14], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][14], 272.370300, 12.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][14], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][14], 0xA52A2AFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][14], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][14], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][14], 0x00000000);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][14], 5);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][14], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][14], 0);
    PlayerTextDrawSetPreviewModel(playerid, FamilyCapture[playerid][14], 19063);
    PlayerTextDrawSetPreviewRot(playerid, FamilyCapture[playerid][14], 0.000000, 75.000000, 177.000000, 0.234500);

    FamilyCapture[playerid][13] = CreatePlayerTextDraw(playerid, 187.033203, 71.836700, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][13], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][13], 264.000000, 258.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][13], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][13], 0x141414FF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][13], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][13], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][13], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][13], 4);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][13], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][13], 0);

    FamilyCapture[playerid][12] = CreatePlayerTextDraw(playerid, 188.666504, 73.695999, "samaps:gtasamapbit2");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][12], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][12], 261.000000, 291.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][12], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][12], 0xCAC3CCFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][12], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][12], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][12], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][12], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][12], 0);

    FamilyCapture[playerid][11] = CreatePlayerTextDraw(playerid, 183.333206, 318.436707, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][11], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][11], 270.000000, 48.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][11], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][11], 0x1E1E1EFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][11], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][11], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][11], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][11], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][11], 0);

    FamilyCapture[playerid][10] = CreatePlayerTextDraw(playerid, 187.033203, 318.051514, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][10], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][10], 264.000000, 1.469900);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][10], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][10], 0x141414FF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][10], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][10], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][10], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][10], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][10], 0);

    FamilyCapture[playerid][9] = CreatePlayerTextDraw(playerid, 296.633698, 330.459412, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][9], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][9], 46.000000, 27.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][9], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][9], 0x915C4AFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][9], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][9], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][9], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][9], 4);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][9], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][9], 1);

    FamilyCapture[playerid][8] = CreatePlayerTextDraw(playerid, 317.199585, 348.407501, "U");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][8], 0.397700, -1.656200);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][8], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][8], 2);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][8], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][8], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][8], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][8], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][8], 0);

    FamilyCapture[playerid][7] = CreatePlayerTextDraw(playerid, 317.932800, 344.259308, "EXIT");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][7], 0.170800, 0.770200);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][7], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][7], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][7], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][7], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][7], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][7], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][7], 0);

    FamilyCapture[playerid][6] = CreatePlayerTextDraw(playerid, 310.900208, 342.422211, "");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][6], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][6], 7.000000, 11.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][6], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][6], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][6], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][6], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][6], 0x00000000);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][6], 5);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][6], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][6], 0);
    PlayerTextDrawSetPreviewModel(playerid, FamilyCapture[playerid][6], 19177);
    PlayerTextDrawSetPreviewRot(playerid, FamilyCapture[playerid][6], 167.000000, 0.000000, 0.000000, 0.182400);

    FamilyCapture[playerid][5] = CreatePlayerTextDraw(playerid, 316.233307, 52.281399, "‹O…HA ˆA EPP…OP……");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][5], 0.169599, 0.803499);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][5], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][5], 2);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][5], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][5], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][5], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][5], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][5], 0);

    FamilyCapture[playerid][4] = CreatePlayerTextDraw(playerid, 441.566589, 70.948097, "::");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][4], 0.493299, 2.139199);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][4], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][4], 2);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][4], 0xA52A2AFF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][4], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][4], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][4], 255);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][4], 0x141414FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][4], 2);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][4], 0);

    FamilyCapture[playerid][3] = CreatePlayerTextDraw(playerid, 194.433395, 221.111099, "-~n~-~n~-~n~-~n~-~n~-~n~-~n~-~n~-~n~-~n~");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][3], 0.464899, 1.044100);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][3], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][3], 2);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][3], 0x141414FF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][3], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][3], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][3], 0x141414FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][3], 2);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][3], 0);

    FamilyCapture[playerid][2] = CreatePlayerTextDraw(playerid, 193.333298, 226.762894, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][2], 1.000000, 85.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][2], 1);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][2], 0x141414FF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][2], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][2], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][2], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][2], 0);

    FamilyCapture[playerid][1] = CreatePlayerTextDraw(playerid, 204.733505, 304.074097, "500");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][1], 0.146599, 1.006800);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][1], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][1], 2);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][1], 0x141414FF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][1], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][1], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][1], 0x141414FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][1], 2);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][1], 0);

    FamilyCapture[playerid][0] = CreatePlayerTextDraw(playerid, 213.133499, 307.807404, "KM");
    PlayerTextDrawLetterSize(playerid, FamilyCapture[playerid][0], 0.117600, 0.496499);
    PlayerTextDrawTextSize(playerid, FamilyCapture[playerid][0], 1280.000000, 1280.000000);
    PlayerTextDrawAlignment(playerid, FamilyCapture[playerid][0], 2);
    PlayerTextDrawColor(playerid, FamilyCapture[playerid][0], 0x141414FF);
    PlayerTextDrawUseBox(playerid, FamilyCapture[playerid][0], 0);
    PlayerTextDrawBoxColor(playerid, FamilyCapture[playerid][0], 0x80808080);
    PlayerTextDrawSetShadow(playerid, FamilyCapture[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, FamilyCapture[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyCapture[playerid][0], 0x141414FF);
    PlayerTextDrawFont(playerid, FamilyCapture[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, FamilyCapture[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyCapture[playerid][0], 0);

	// TOLIAU EINA ZONOS

    FamilyZones[playerid][0] = CreatePlayerTextDraw(playerid, 296.466614, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][0], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][0], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][0], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][0], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][0], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][0], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][0], 1);

    FamilyZones[playerid][1] = CreatePlayerTextDraw(playerid, 307.289795, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][1], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][1], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][1], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][1], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][1], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][1], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][1], 1);

    FamilyZones[playerid][2] = CreatePlayerTextDraw(playerid, 318.112976, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][2], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][2], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][2], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][2], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][2], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][2], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][2], 1);

    FamilyZones[playerid][3] = CreatePlayerTextDraw(playerid, 328.936157, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][3], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][3], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][3], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][3], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][3], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][3], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][3], 1);

    FamilyZones[playerid][4] = CreatePlayerTextDraw(playerid, 339.759338, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][4], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][4], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][4], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][4], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][4], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][4], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][4], 1);

    FamilyZones[playerid][5] = CreatePlayerTextDraw(playerid, 350.582520, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][5], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][5], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][5], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][5], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][5], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][5], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][5], 1);

    FamilyZones[playerid][6] = CreatePlayerTextDraw(playerid, 361.405701, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][6], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][6], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][6], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][6], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][6], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][6], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][6], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][6], 1);

    FamilyZones[playerid][7] = CreatePlayerTextDraw(playerid, 372.228882, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][7], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][7], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][7], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][7], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][7], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][7], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][7], 1);

    FamilyZones[playerid][8] = CreatePlayerTextDraw(playerid, 383.052063, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][8], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][8], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][8], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][8], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][8], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][8], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][8], 1);

    FamilyZones[playerid][9] = CreatePlayerTextDraw(playerid, 393.875244, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][9], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][9], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][9], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][9], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][9], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][9], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][9], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][9], 1);

    FamilyZones[playerid][10] = CreatePlayerTextDraw(playerid, 404.698425, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][10], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][10], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][10], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][10], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][10], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][10], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][10], 1);

    FamilyZones[playerid][11] = CreatePlayerTextDraw(playerid, 415.521606, 111.762848, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][11], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][11], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][11], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][11], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][11], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][11], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][11], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][11], 1);

    FamilyZones[playerid][12] = CreatePlayerTextDraw(playerid, 296.466614, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][12], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][12], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][12], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][12], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][12], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][12], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][12], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][12], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][12], 1);

    FamilyZones[playerid][13] = CreatePlayerTextDraw(playerid, 307.289795, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][13], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][13], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][13], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][13], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][13], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][13], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][13], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][13], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][13], 1);

    FamilyZones[playerid][14] = CreatePlayerTextDraw(playerid, 318.112976, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][14], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][14], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][14], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][14], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][14], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][14], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][14], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][14], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][14], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][14], 1);

    FamilyZones[playerid][15] = CreatePlayerTextDraw(playerid, 328.936157, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][15], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][15], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][15], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][15], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][15], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][15], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][15], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][15], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][15], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][15], 1);

    FamilyZones[playerid][16] = CreatePlayerTextDraw(playerid, 339.759338, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][16], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][16], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][16], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][16], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][16], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][16], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][16], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][16], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][16], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][16], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][16], 1);

    FamilyZones[playerid][17] = CreatePlayerTextDraw(playerid, 350.582520, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][17], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][17], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][17], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][17], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][17], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][17], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][17], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][17], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][17], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][17], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][17], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][17], 1);

    FamilyZones[playerid][18] = CreatePlayerTextDraw(playerid, 361.405701, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][18], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][18], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][18], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][18], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][18], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][18], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][18], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][18], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][18], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][18], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][18], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][18], 1);

    FamilyZones[playerid][19] = CreatePlayerTextDraw(playerid, 372.228882, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][19], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][19], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][19], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][19], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][19], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][19], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][19], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][19], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][19], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][19], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][19], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][19], 1);

    FamilyZones[playerid][20] = CreatePlayerTextDraw(playerid, 383.052063, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][20], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][20], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][20], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][20], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][20], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][20], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][20], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][20], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][20], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][20], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][20], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][20], 1);

    FamilyZones[playerid][21] = CreatePlayerTextDraw(playerid, 393.875244, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][21], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][21], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][21], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][21], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][21], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][21], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][21], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][21], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][21], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][21], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][21], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][21], 1);

    FamilyZones[playerid][22] = CreatePlayerTextDraw(playerid, 404.698425, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][22], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][22], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][22], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][22], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][22], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][22], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][22], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][22], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][22], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][22], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][22], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][22], 1);

    FamilyZones[playerid][23] = CreatePlayerTextDraw(playerid, 415.521606, 124.860008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][23], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][23], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][23], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][23], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][23], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][23], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][23], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][23], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][23], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][23], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][23], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][23], 1);

    FamilyZones[playerid][24] = CreatePlayerTextDraw(playerid, 296.466614, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][24], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][24], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][24], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][24], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][24], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][24], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][24], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][24], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][24], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][24], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][24], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][24], 1);

    FamilyZones[playerid][25] = CreatePlayerTextDraw(playerid, 307.289795, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][25], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][25], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][25], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][25], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][25], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][25], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][25], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][25], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][25], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][25], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][25], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][25], 1);

    FamilyZones[playerid][26] = CreatePlayerTextDraw(playerid, 318.112976, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][26], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][26], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][26], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][26], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][26], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][26], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][26], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][26], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][26], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][26], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][26], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][26], 1);

    FamilyZones[playerid][27] = CreatePlayerTextDraw(playerid, 328.936157, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][27], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][27], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][27], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][27], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][27], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][27], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][27], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][27], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][27], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][27], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][27], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][27], 1);

    FamilyZones[playerid][28] = CreatePlayerTextDraw(playerid, 339.759338, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][28], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][28], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][28], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][28], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][28], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][28], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][28], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][28], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][28], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][28], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][28], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][28], 1);

    FamilyZones[playerid][29] = CreatePlayerTextDraw(playerid, 350.582520, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][29], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][29], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][29], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][29], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][29], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][29], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][29], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][29], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][29], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][29], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][29], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][29], 1);

    FamilyZones[playerid][30] = CreatePlayerTextDraw(playerid, 361.405701, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][30], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][30], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][30], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][30], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][30], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][30], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][30], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][30], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][30], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][30], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][30], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][30], 1);

    FamilyZones[playerid][31] = CreatePlayerTextDraw(playerid, 372.228882, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][31], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][31], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][31], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][31], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][31], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][31], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][31], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][31], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][31], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][31], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][31], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][31], 1);

    FamilyZones[playerid][32] = CreatePlayerTextDraw(playerid, 383.052063, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][32], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][32], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][32], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][32], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][32], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][32], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][32], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][32], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][32], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][32], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][32], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][32], 1);

    FamilyZones[playerid][33] = CreatePlayerTextDraw(playerid, 393.875244, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][33], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][33], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][33], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][33], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][33], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][33], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][33], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][33], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][33], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][33], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][33], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][33], 1);

    FamilyZones[playerid][34] = CreatePlayerTextDraw(playerid, 404.698425, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][34], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][34], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][34], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][34], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][34], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][34], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][34], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][34], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][34], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][34], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][34], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][34], 1);

    FamilyZones[playerid][35] = CreatePlayerTextDraw(playerid, 415.521606, 137.957169, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][35], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][35], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][35], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][35], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][35], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][35], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][35], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][35], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][35], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][35], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][35], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][35], 1);

    FamilyZones[playerid][36] = CreatePlayerTextDraw(playerid, 296.466614, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][36], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][36], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][36], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][36], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][36], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][36], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][36], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][36], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][36], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][36], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][36], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][36], 1);

    FamilyZones[playerid][37] = CreatePlayerTextDraw(playerid, 307.289795, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][37], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][37], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][37], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][37], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][37], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][37], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][37], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][37], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][37], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][37], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][37], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][37], 1);

    FamilyZones[playerid][38] = CreatePlayerTextDraw(playerid, 318.112976, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][38], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][38], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][38], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][38], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][38], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][38], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][38], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][38], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][38], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][38], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][38], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][38], 1);

    FamilyZones[playerid][39] = CreatePlayerTextDraw(playerid, 328.936157, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][39], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][39], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][39], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][39], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][39], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][39], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][39], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][39], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][39], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][39], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][39], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][39], 1);

    FamilyZones[playerid][40] = CreatePlayerTextDraw(playerid, 339.759338, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][40], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][40], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][40], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][40], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][40], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][40], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][40], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][40], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][40], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][40], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][40], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][40], 1);

    FamilyZones[playerid][41] = CreatePlayerTextDraw(playerid, 350.582520, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][41], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][41], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][41], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][41], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][41], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][41], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][41], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][41], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][41], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][41], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][41], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][41], 1);

    FamilyZones[playerid][42] = CreatePlayerTextDraw(playerid, 361.405701, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][42], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][42], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][42], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][42], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][42], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][42], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][42], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][42], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][42], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][42], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][42], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][42], 1);

    FamilyZones[playerid][43] = CreatePlayerTextDraw(playerid, 372.228882, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][43], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][43], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][43], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][43], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][43], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][43], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][43], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][43], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][43], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][43], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][43], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][43], 1);

    FamilyZones[playerid][44] = CreatePlayerTextDraw(playerid, 383.052063, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][44], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][44], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][44], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][44], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][44], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][44], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][44], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][44], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][44], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][44], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][44], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][44], 1);

    FamilyZones[playerid][45] = CreatePlayerTextDraw(playerid, 393.875244, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][45], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][45], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][45], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][45], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][45], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][45], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][45], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][45], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][45], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][45], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][45], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][45], 1);

    FamilyZones[playerid][46] = CreatePlayerTextDraw(playerid, 404.698425, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][46], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][46], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][46], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][46], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][46], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][46], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][46], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][46], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][46], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][46], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][46], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][46], 1);

    FamilyZones[playerid][47] = CreatePlayerTextDraw(playerid, 415.521606, 151.054337, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][47], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][47], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][47], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][47], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][47], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][47], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][47], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][47], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][47], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][47], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][47], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][47], 1);

    FamilyZones[playerid][48] = CreatePlayerTextDraw(playerid, 296.466614, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][48], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][48], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][48], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][48], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][48], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][48], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][48], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][48], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][48], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][48], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][48], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][48], 1);

    FamilyZones[playerid][49] = CreatePlayerTextDraw(playerid, 307.289795, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][49], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][49], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][49], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][49], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][49], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][49], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][49], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][49], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][49], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][49], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][49], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][49], 1);

    FamilyZones[playerid][50] = CreatePlayerTextDraw(playerid, 318.112976, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][50], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][50], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][50], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][50], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][50], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][50], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][50], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][50], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][50], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][50], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][50], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][50], 1);

    FamilyZones[playerid][51] = CreatePlayerTextDraw(playerid, 328.936157, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][51], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][51], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][51], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][51], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][51], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][51], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][51], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][51], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][51], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][51], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][51], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][51], 1);

    FamilyZones[playerid][52] = CreatePlayerTextDraw(playerid, 339.759338, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][52], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][52], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][52], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][52], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][52], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][52], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][52], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][52], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][52], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][52], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][52], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][52], 1);

    FamilyZones[playerid][53] = CreatePlayerTextDraw(playerid, 350.582520, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][53], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][53], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][53], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][53], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][53], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][53], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][53], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][53], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][53], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][53], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][53], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][53], 1);

    FamilyZones[playerid][54] = CreatePlayerTextDraw(playerid, 361.405701, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][54], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][54], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][54], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][54], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][54], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][54], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][54], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][54], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][54], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][54], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][54], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][54], 1);

    FamilyZones[playerid][55] = CreatePlayerTextDraw(playerid, 372.228882, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][55], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][55], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][55], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][55], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][55], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][55], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][55], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][55], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][55], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][55], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][55], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][55], 1);

    FamilyZones[playerid][56] = CreatePlayerTextDraw(playerid, 383.052063, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][56], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][56], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][56], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][56], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][56], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][56], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][56], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][56], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][56], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][56], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][56], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][56], 1);

    FamilyZones[playerid][57] = CreatePlayerTextDraw(playerid, 393.875244, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][57], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][57], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][57], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][57], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][57], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][57], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][57], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][57], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][57], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][57], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][57], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][57], 1);

    FamilyZones[playerid][58] = CreatePlayerTextDraw(playerid, 404.698425, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][58], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][58], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][58], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][58], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][58], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][58], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][58], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][58], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][58], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][58], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][58], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][58], 1);

    FamilyZones[playerid][59] = CreatePlayerTextDraw(playerid, 415.521606, 164.151505, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][59], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][59], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][59], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][59], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][59], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][59], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][59], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][59], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][59], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][59], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][59], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][59], 1);

    FamilyZones[playerid][60] = CreatePlayerTextDraw(playerid, 296.466614, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][60], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][60], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][60], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][60], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][60], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][60], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][60], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][60], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][60], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][60], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][60], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][60], 1);

    FamilyZones[playerid][61] = CreatePlayerTextDraw(playerid, 307.289795, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][61], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][61], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][61], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][61], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][61], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][61], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][61], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][61], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][61], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][61], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][61], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][61], 1);

    FamilyZones[playerid][62] = CreatePlayerTextDraw(playerid, 318.112976, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][62], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][62], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][62], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][62], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][62], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][62], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][62], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][62], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][62], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][62], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][62], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][62], 1);

    FamilyZones[playerid][63] = CreatePlayerTextDraw(playerid, 328.936157, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][63], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][63], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][63], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][63], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][63], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][63], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][63], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][63], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][63], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][63], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][63], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][63], 1);

    FamilyZones[playerid][64] = CreatePlayerTextDraw(playerid, 339.759338, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][64], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][64], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][64], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][64], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][64], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][64], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][64], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][64], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][64], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][64], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][64], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][64], 1);

    FamilyZones[playerid][65] = CreatePlayerTextDraw(playerid, 350.582520, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][65], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][65], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][65], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][65], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][65], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][65], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][65], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][65], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][65], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][65], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][65], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][65], 1);

    FamilyZones[playerid][66] = CreatePlayerTextDraw(playerid, 361.405701, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][66], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][66], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][66], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][66], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][66], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][66], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][66], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][66], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][66], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][66], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][66], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][66], 1);

    FamilyZones[playerid][67] = CreatePlayerTextDraw(playerid, 372.228882, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][67], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][67], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][67], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][67], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][67], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][67], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][67], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][67], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][67], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][67], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][67], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][67], 1);

    FamilyZones[playerid][68] = CreatePlayerTextDraw(playerid, 383.052063, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][68], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][68], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][68], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][68], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][68], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][68], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][68], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][68], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][68], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][68], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][68], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][68], 1);

    FamilyZones[playerid][69] = CreatePlayerTextDraw(playerid, 393.875244, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][69], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][69], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][69], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][69], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][69], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][69], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][69], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][69], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][69], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][69], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][69], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][69], 1);

    FamilyZones[playerid][70] = CreatePlayerTextDraw(playerid, 404.698425, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][70], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][70], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][70], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][70], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][70], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][70], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][70], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][70], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][70], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][70], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][70], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][70], 1);

    FamilyZones[playerid][71] = CreatePlayerTextDraw(playerid, 415.521606, 177.248672, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][71], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][71], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][71], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][71], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][71], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][71], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][71], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][71], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][71], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][71], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][71], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][71], 1);

    FamilyZones[playerid][72] = CreatePlayerTextDraw(playerid, 296.466614, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][72], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][72], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][72], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][72], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][72], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][72], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][72], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][72], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][72], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][72], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][72], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][72], 1);

    FamilyZones[playerid][73] = CreatePlayerTextDraw(playerid, 307.289795, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][73], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][73], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][73], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][73], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][73], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][73], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][73], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][73], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][73], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][73], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][73], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][73], 1);

    FamilyZones[playerid][74] = CreatePlayerTextDraw(playerid, 318.112976, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][74], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][74], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][74], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][74], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][74], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][74], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][74], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][74], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][74], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][74], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][74], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][74], 1);

    FamilyZones[playerid][75] = CreatePlayerTextDraw(playerid, 328.936157, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][75], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][75], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][75], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][75], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][75], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][75], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][75], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][75], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][75], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][75], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][75], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][75], 1);

    FamilyZones[playerid][76] = CreatePlayerTextDraw(playerid, 339.759338, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][76], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][76], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][76], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][76], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][76], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][76], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][76], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][76], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][76], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][76], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][76], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][76], 1);

    FamilyZones[playerid][77] = CreatePlayerTextDraw(playerid, 350.582520, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][77], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][77], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][77], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][77], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][77], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][77], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][77], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][77], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][77], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][77], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][77], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][77], 1);

    FamilyZones[playerid][78] = CreatePlayerTextDraw(playerid, 361.405701, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][78], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][78], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][78], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][78], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][78], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][78], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][78], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][78], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][78], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][78], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][78], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][78], 1);

    FamilyZones[playerid][79] = CreatePlayerTextDraw(playerid, 372.228882, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][79], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][79], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][79], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][79], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][79], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][79], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][79], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][79], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][79], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][79], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][79], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][79], 1);

    FamilyZones[playerid][80] = CreatePlayerTextDraw(playerid, 383.052063, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][80], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][80], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][80], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][80], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][80], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][80], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][80], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][80], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][80], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][80], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][80], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][80], 1);

    FamilyZones[playerid][81] = CreatePlayerTextDraw(playerid, 393.875244, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][81], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][81], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][81], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][81], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][81], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][81], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][81], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][81], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][81], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][81], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][81], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][81], 1);

    FamilyZones[playerid][82] = CreatePlayerTextDraw(playerid, 404.698425, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][82], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][82], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][82], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][82], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][82], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][82], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][82], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][82], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][82], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][82], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][82], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][82], 1);

    FamilyZones[playerid][83] = CreatePlayerTextDraw(playerid, 415.521606, 190.345840, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][83], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][83], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][83], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][83], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][83], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][83], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][83], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][83], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][83], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][83], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][83], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][83], 1);

    FamilyZones[playerid][84] = CreatePlayerTextDraw(playerid, 296.466614, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][84], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][84], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][84], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][84], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][84], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][84], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][84], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][84], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][84], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][84], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][84], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][84], 1);

    FamilyZones[playerid][85] = CreatePlayerTextDraw(playerid, 307.289795, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][85], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][85], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][85], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][85], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][85], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][85], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][85], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][85], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][85], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][85], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][85], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][85], 1);

    FamilyZones[playerid][86] = CreatePlayerTextDraw(playerid, 318.112976, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][86], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][86], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][86], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][86], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][86], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][86], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][86], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][86], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][86], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][86], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][86], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][86], 1);

    FamilyZones[playerid][87] = CreatePlayerTextDraw(playerid, 328.936157, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][87], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][87], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][87], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][87], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][87], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][87], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][87], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][87], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][87], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][87], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][87], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][87], 1);

    FamilyZones[playerid][88] = CreatePlayerTextDraw(playerid, 339.759338, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][88], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][88], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][88], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][88], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][88], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][88], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][88], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][88], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][88], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][88], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][88], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][88], 1);

    FamilyZones[playerid][89] = CreatePlayerTextDraw(playerid, 350.582520, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][89], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][89], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][89], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][89], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][89], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][89], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][89], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][89], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][89], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][89], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][89], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][89], 1);

    FamilyZones[playerid][90] = CreatePlayerTextDraw(playerid, 361.405701, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][90], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][90], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][90], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][90], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][90], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][90], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][90], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][90], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][90], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][90], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][90], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][90], 1);

    FamilyZones[playerid][91] = CreatePlayerTextDraw(playerid, 372.228882, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][91], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][91], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][91], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][91], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][91], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][91], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][91], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][91], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][91], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][91], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][91], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][91], 1);

    FamilyZones[playerid][92] = CreatePlayerTextDraw(playerid, 383.052063, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][92], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][92], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][92], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][92], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][92], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][92], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][92], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][92], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][92], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][92], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][92], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][92], 1);

    FamilyZones[playerid][93] = CreatePlayerTextDraw(playerid, 393.875244, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][93], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][93], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][93], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][93], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][93], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][93], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][93], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][93], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][93], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][93], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][93], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][93], 1);

    FamilyZones[playerid][94] = CreatePlayerTextDraw(playerid, 404.698425, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][94], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][94], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][94], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][94], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][94], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][94], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][94], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][94], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][94], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][94], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][94], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][94], 1);

    FamilyZones[playerid][95] = CreatePlayerTextDraw(playerid, 415.521606, 203.443008, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][95], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][95], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][95], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][95], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][95], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][95], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][95], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][95], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][95], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][95], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][95], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][95], 1);

    FamilyZones[playerid][96] = CreatePlayerTextDraw(playerid, 296.466614, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][96], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][96], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][96], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][96], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][96], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][96], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][96], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][96], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][96], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][96], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][96], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][96], 1);

    FamilyZones[playerid][97] = CreatePlayerTextDraw(playerid, 307.289795, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][97], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][97], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][97], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][97], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][97], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][97], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][97], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][97], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][97], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][97], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][97], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][97], 1);

    FamilyZones[playerid][98] = CreatePlayerTextDraw(playerid, 318.112976, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][98], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][98], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][98], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][98], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][98], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][98], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][98], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][98], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][98], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][98], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][98], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][98], 1);

    FamilyZones[playerid][99] = CreatePlayerTextDraw(playerid, 328.936157, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][99], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][99], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][99], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][99], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][99], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][99], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][99], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][99], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][99], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][99], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][99], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][99], 1);

    FamilyZones[playerid][100] = CreatePlayerTextDraw(playerid, 339.759338, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][100], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][100], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][100], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][100], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][100], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][100], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][100], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][100], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][100], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][100], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][100], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][100], 1);

    FamilyZones[playerid][101] = CreatePlayerTextDraw(playerid, 350.582520, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][101], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][101], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][101], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][101], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][101], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][101], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][101], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][101], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][101], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][101], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][101], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][101], 1);

    FamilyZones[playerid][102] = CreatePlayerTextDraw(playerid, 361.405701, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][102], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][102], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][102], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][102], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][102], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][102], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][102], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][102], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][102], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][102], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][102], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][102], 1);

    FamilyZones[playerid][103] = CreatePlayerTextDraw(playerid, 372.228882, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][103], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][103], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][103], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][103], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][103], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][103], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][103], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][103], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][103], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][103], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][103], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][103], 1);

    FamilyZones[playerid][104] = CreatePlayerTextDraw(playerid, 383.052063, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][104], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][104], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][104], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][104], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][104], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][104], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][104], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][104], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][104], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][104], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][104], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][104], 1);

    FamilyZones[playerid][105] = CreatePlayerTextDraw(playerid, 393.875244, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][105], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][105], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][105], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][105], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][105], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][105], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][105], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][105], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][105], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][105], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][105], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][105], 1);

    FamilyZones[playerid][106] = CreatePlayerTextDraw(playerid, 404.698425, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][106], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][106], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][106], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][106], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][106], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][106], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][106], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][106], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][106], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][106], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][106], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][106], 1);

    FamilyZones[playerid][107] = CreatePlayerTextDraw(playerid, 415.521606, 216.540176, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][107], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][107], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][107], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][107], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][107], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][107], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][107], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][107], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][107], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][107], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][107], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][107], 1);

    FamilyZones[playerid][108] = CreatePlayerTextDraw(playerid, 296.466614, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][108], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][108], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][108], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][108], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][108], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][108], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][108], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][108], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][108], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][108], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][108], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][108], 1);

    FamilyZones[playerid][109] = CreatePlayerTextDraw(playerid, 307.289795, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][109], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][109], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][109], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][109], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][109], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][109], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][109], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][109], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][109], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][109], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][109], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][109], 1);

    FamilyZones[playerid][110] = CreatePlayerTextDraw(playerid, 318.112976, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][110], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][110], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][110], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][110], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][110], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][110], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][110], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][110], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][110], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][110], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][110], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][110], 1);

    FamilyZones[playerid][111] = CreatePlayerTextDraw(playerid, 328.936157, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][111], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][111], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][111], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][111], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][111], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][111], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][111], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][111], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][111], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][111], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][111], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][111], 1);

    FamilyZones[playerid][112] = CreatePlayerTextDraw(playerid, 339.759338, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][112], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][112], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][112], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][112], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][112], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][112], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][112], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][112], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][112], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][112], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][112], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][112], 1);

    FamilyZones[playerid][113] = CreatePlayerTextDraw(playerid, 350.582520, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][113], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][113], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][113], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][113], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][113], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][113], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][113], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][113], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][113], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][113], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][113], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][113], 1);

    FamilyZones[playerid][114] = CreatePlayerTextDraw(playerid, 361.405701, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][114], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][114], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][114], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][114], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][114], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][114], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][114], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][114], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][114], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][114], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][114], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][114], 1);

    FamilyZones[playerid][115] = CreatePlayerTextDraw(playerid, 372.228882, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][115], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][115], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][115], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][115], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][115], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][115], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][115], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][115], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][115], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][115], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][115], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][115], 1);

    FamilyZones[playerid][116] = CreatePlayerTextDraw(playerid, 383.052063, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][116], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][116], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][116], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][116], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][116], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][116], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][116], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][116], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][116], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][116], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][116], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][116], 1);

    FamilyZones[playerid][117] = CreatePlayerTextDraw(playerid, 393.875244, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][117], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][117], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][117], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][117], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][117], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][117], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][117], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][117], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][117], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][117], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][117], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][117], 1);

    FamilyZones[playerid][118] = CreatePlayerTextDraw(playerid, 404.698425, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][118], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][118], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][118], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][118], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][118], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][118], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][118], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][118], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][118], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][118], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][118], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][118], 1);

    FamilyZones[playerid][119] = CreatePlayerTextDraw(playerid, 415.521606, 229.637344, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][119], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][119], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][119], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][119], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][119], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][119], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][119], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][119], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][119], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][119], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][119], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][119], 1);

    FamilyZones[playerid][120] = CreatePlayerTextDraw(playerid, 296.466614, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][120], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][120], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][120], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][120], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][120], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][120], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][120], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][120], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][120], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][120], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][120], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][120], 1);

    FamilyZones[playerid][121] = CreatePlayerTextDraw(playerid, 307.289795, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][121], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][121], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][121], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][121], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][121], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][121], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][121], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][121], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][121], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][121], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][121], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][121], 1);

    FamilyZones[playerid][122] = CreatePlayerTextDraw(playerid, 318.112976, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][122], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][122], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][122], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][122], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][122], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][122], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][122], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][122], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][122], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][122], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][122], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][122], 1);

    FamilyZones[playerid][123] = CreatePlayerTextDraw(playerid, 328.936157, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][123], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][123], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][123], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][123], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][123], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][123], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][123], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][123], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][123], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][123], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][123], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][123], 1);

    FamilyZones[playerid][124] = CreatePlayerTextDraw(playerid, 339.759338, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][124], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][124], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][124], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][124], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][124], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][124], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][124], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][124], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][124], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][124], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][124], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][124], 1);

    FamilyZones[playerid][125] = CreatePlayerTextDraw(playerid, 350.582520, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][125], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][125], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][125], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][125], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][125], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][125], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][125], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][125], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][125], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][125], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][125], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][125], 1);

    FamilyZones[playerid][126] = CreatePlayerTextDraw(playerid, 361.405701, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][126], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][126], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][126], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][126], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][126], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][126], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][126], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][126], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][126], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][126], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][126], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][126], 1);

    FamilyZones[playerid][127] = CreatePlayerTextDraw(playerid, 372.228882, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][127], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][127], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][127], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][127], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][127], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][127], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][127], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][127], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][127], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][127], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][127], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][127], 1);

    FamilyZones[playerid][128] = CreatePlayerTextDraw(playerid, 383.052063, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][128], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][128], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][128], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][128], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][128], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][128], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][128], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][128], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][128], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][128], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][128], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][128], 1);

    FamilyZones[playerid][129] = CreatePlayerTextDraw(playerid, 393.875244, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][129], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][129], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][129], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][129], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][129], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][129], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][129], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][129], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][129], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][129], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][129], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][129], 1);

    FamilyZones[playerid][130] = CreatePlayerTextDraw(playerid, 404.698425, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][130], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][130], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][130], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][130], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][130], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][130], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][130], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][130], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][130], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][130], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][130], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][130], 1);

    FamilyZones[playerid][131] = CreatePlayerTextDraw(playerid, 415.521606, 242.734512, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][131], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][131], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][131], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][131], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][131], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][131], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][131], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][131], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][131], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][131], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][131], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][131], 1);

    FamilyZones[playerid][132] = CreatePlayerTextDraw(playerid, 296.466614, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][132], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][132], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][132], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][132], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][132], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][132], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][132], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][132], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][132], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][132], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][132], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][132], 1);

    FamilyZones[playerid][133] = CreatePlayerTextDraw(playerid, 307.289795, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][133], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][133], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][133], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][133], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][133], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][133], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][133], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][133], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][133], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][133], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][133], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][133], 1);

    FamilyZones[playerid][134] = CreatePlayerTextDraw(playerid, 318.112976, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][134], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][134], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][134], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][134], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][134], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][134], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][134], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][134], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][134], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][134], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][134], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][134], 1);

    FamilyZones[playerid][135] = CreatePlayerTextDraw(playerid, 328.936157, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][135], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][135], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][135], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][135], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][135], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][135], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][135], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][135], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][135], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][135], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][135], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][135], 1);

    FamilyZones[playerid][136] = CreatePlayerTextDraw(playerid, 339.759338, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][136], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][136], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][136], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][136], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][136], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][136], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][136], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][136], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][136], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][136], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][136], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][136], 1);

    FamilyZones[playerid][137] = CreatePlayerTextDraw(playerid, 350.582520, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][137], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][137], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][137], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][137], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][137], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][137], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][137], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][137], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][137], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][137], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][137], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][137], 1);

    FamilyZones[playerid][138] = CreatePlayerTextDraw(playerid, 361.405701, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][138], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][138], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][138], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][138], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][138], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][138], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][138], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][138], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][138], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][138], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][138], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][138], 1);

    FamilyZones[playerid][139] = CreatePlayerTextDraw(playerid, 372.228882, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][139], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][139], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][139], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][139], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][139], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][139], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][139], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][139], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][139], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][139], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][139], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][139], 1);

    FamilyZones[playerid][140] = CreatePlayerTextDraw(playerid, 383.052063, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][140], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][140], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][140], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][140], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][140], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][140], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][140], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][140], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][140], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][140], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][140], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][140], 1);

    FamilyZones[playerid][141] = CreatePlayerTextDraw(playerid, 393.875244, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][141], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][141], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][141], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][141], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][141], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][141], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][141], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][141], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][141], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][141], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][141], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][141], 1);

    FamilyZones[playerid][142] = CreatePlayerTextDraw(playerid, 404.698425, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][142], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][142], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][142], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][142], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][142], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][142], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][142], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][142], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][142], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][142], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][142], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][142], 1);

    FamilyZones[playerid][143] = CreatePlayerTextDraw(playerid, 415.521606, 255.831680, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][143], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][143], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][143], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][143], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][143], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][143], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][143], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][143], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][143], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][143], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][143], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][143], 1);

    FamilyZones[playerid][144] = CreatePlayerTextDraw(playerid, 296.466614, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][144], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][144], 304.609772, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][144], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][144], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][144], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][144], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][144], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][144], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][144], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][144], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][144], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][144], 1);

    FamilyZones[playerid][145] = CreatePlayerTextDraw(playerid, 307.289795, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][145], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][145], 315.432953, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][145], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][145], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][145], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][145], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][145], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][145], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][145], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][145], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][145], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][145], 1);

    FamilyZones[playerid][146] = CreatePlayerTextDraw(playerid, 318.112976, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][146], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][146], 326.256134, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][146], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][146], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][146], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][146], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][146], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][146], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][146], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][146], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][146], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][146], 1);

    FamilyZones[playerid][147] = CreatePlayerTextDraw(playerid, 328.936157, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][147], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][147], 337.079315, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][147], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][147], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][147], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][147], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][147], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][147], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][147], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][147], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][147], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][147], 1);

    FamilyZones[playerid][148] = CreatePlayerTextDraw(playerid, 339.759338, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][148], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][148], 347.902496, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][148], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][148], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][148], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][148], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][148], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][148], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][148], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][148], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][148], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][148], 1);

    FamilyZones[playerid][149] = CreatePlayerTextDraw(playerid, 350.582520, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][149], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][149], 358.725677, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][149], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][149], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][149], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][149], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][149], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][149], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][149], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][149], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][149], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][149], 1);

    FamilyZones[playerid][150] = CreatePlayerTextDraw(playerid, 361.405701, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][150], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][150], 369.548859, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][150], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][150], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][150], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][150], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][150], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][150], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][150], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][150], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][150], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][150], 1);

    FamilyZones[playerid][151] = CreatePlayerTextDraw(playerid, 372.228882, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][151], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][151], 380.372040, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][151], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][151], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][151], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][151], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][151], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][151], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][151], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][151], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][151], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][151], 1);

    FamilyZones[playerid][152] = CreatePlayerTextDraw(playerid, 383.052063, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][152], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][152], 391.195221, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][152], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][152], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][152], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][152], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][152], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][152], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][152], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][152], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][152], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][152], 1);

    FamilyZones[playerid][153] = CreatePlayerTextDraw(playerid, 393.875244, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][153], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][153], 402.018402, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][153], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][153], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][153], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][153], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][153], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][153], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][153], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][153], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][153], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][153], 1);

    FamilyZones[playerid][154] = CreatePlayerTextDraw(playerid, 404.698425, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][154], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][154], 412.841583, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][154], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][154], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][154], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][154], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][154], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][154], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][154], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][154], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][154], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][154], 1);

    FamilyZones[playerid][155] = CreatePlayerTextDraw(playerid, 415.521606, 268.928833, "_");
    PlayerTextDrawLetterSize(playerid, FamilyZones[playerid][155], 0.140000, 1.086518);
    PlayerTextDrawTextSize(playerid, FamilyZones[playerid][155], 423.664764, 10.500000);
    PlayerTextDrawAlignment(playerid, FamilyZones[playerid][155], 1);
    PlayerTextDrawColor(playerid, FamilyZones[playerid][155], 0xFFFFFFFF);
    PlayerTextDrawUseBox(playerid, FamilyZones[playerid][155], 1);
    PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][155], 0xFFFFFF80);
    PlayerTextDrawSetShadow(playerid, FamilyZones[playerid][155], 0);
    PlayerTextDrawSetOutline(playerid, FamilyZones[playerid][155], 0);
    PlayerTextDrawBackgroundColor(playerid, FamilyZones[playerid][155], 0x000000FF);
    PlayerTextDrawFont(playerid, FamilyZones[playerid][155], 1);
    PlayerTextDrawSetProportional(playerid, FamilyZones[playerid][155], 1);
    PlayerTextDrawSetSelectable(playerid, FamilyZones[playerid][155], 1);
	
	/*for new i = 155, td = 0; i > -1; i-- do	
		PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][td], FamilyZone[i][fZoneOwnerId] == -1 ? 0xFFFFFF80:FZColors[GetFamilyDataInt(FamilyZone[i][fZoneOwnerId], "color")]), td ++;*/
		
	for(new i; i < 156; i++)
	{
		if(FamilyZone[i][fZoneOwnerId] == -1) PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][i], 0xFFFFFF80);
		else PlayerTextDrawBoxColor(playerid, FamilyZones[playerid][i], FZColors[GetFamilyDataInt(FamilyZone[i][fZoneOwnerId], "color")]);
	}

    for new i = 0; i < 156; i++ do
	{	
        if i < 17 *then
			ShowPlayerTD(playerid, FamilyCapture[playerid][i]);
			
		ShowPlayerTD(playerid, FamilyZones[playerid][i]);	
	}  

	SelectTextDraw(playerid, 0xA52A2AFF);

	return FamilyCaptureOpen{playerid} = true;
}

stock DestroyFamCapture(playerid)
{
	for new i = 0; i < 17; i++ do
		DestroyPlayerTD(playerid, FamilyCapture[playerid][i]);

	for new i = 0; i < 156; i++ do
	    DestroyPlayerTD(playerid, FamilyZones[playerid][i]);
	
	CancelSelectTextDraw(playerid);
	
	return FamilyCaptureOpen{playerid} = false;
}