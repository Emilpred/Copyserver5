#include <a_samp>
#include <streamer>
#include <Pawn.CMD>
#include <YSF>
#include <a_mysql>
#include <sscanf2>

#define FILTERSCRIPT

#define GetString(%0,%1) !strcmp(%0, %1, false)
#define public:%0(%1) forward%0(%1); public%0(%1)

#define COLOR_OLDRED 		0xBE2D2DFF
#define COLOR_VALIK 		0x73B461FF
#define COLOR_RED 			0xFF6347FF
#define COLOR_ORANGE 		0xFAAC58FF
#define COLOR_BROWN 		0xA52A2AFF
#define COLOR_GREEN 		0x42B02CFF
#define COLOR_GOLD          0xFFD700FF
#define COLOR_LIGHTRED 		0xFF6347FF
#define COLOR_LIGHTBLUE 	0x6495EDFF
#define COLOR_LIGHTGREEN 	0x9ACD32FF
#define COLOR_YELLOW 		0xFFFF00FF
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_BLACK 		0x000000FF
#define COLOR_BLUENEW 		0xB8CEF6FF
#define COLOR_BLUE 			0x94B0C1FF
#define COLOR_GRAD 			0xBFC0C2FF
#define COLOR_PURPLE 		0xC2A2DAFF
#define COLOR_LIME 			0x10F441FF
#define COLOR_TOMATO 		0xFF6347FF
#define COLOR_GREY 			0xAFAFAFFF
#define COLOR_INDIGO        0x400080FF
#define COLOR_CHAT			0xCECECEFF
#define COLOR_SCHAT			0xF0E68CFF
#define COLOR_DOCHAT		0x4682B4FF
#define COLOR_RACIO			0x2DB043FF
#define COLOR_DEPAR			0x3399ffFF
#define COLOR_ACHAT   		0x99CC00FF
#define COLOR_ME            0xFF99FFFF
#define COLOR_GOV           0x045FB4FF

#undef MAX_PLAYERS
#define MAX_PLAYERS 200
 
new Streamer_Types[STREAMER_MAX_TYPES] =
{
	STREAMER_TYPE_MAP_ICON,
	STREAMER_TYPE_3D_TEXT_LABEL,
	STREAMER_TYPE_PICKUP,
	STREAMER_TYPE_CP,
	STREAMER_TYPE_RACE_CP,
	STREAMER_TYPE_ACTOR,
	STREAMER_TYPE_AREA,
	STREAMER_TYPE_OBJECT
};

new str[3000], RinokCars[4];

#define SCM	SendClientMessage
#define SCMF(%0,%1,%2,%3) format(str, 144, %2,%3), SCM(%0, %1, str)

#define SDAVW(%0,%1) SetDynamicActorVirtualWorld(%0, %1)
new INTERIOS_SHOP24[] = {106,107,108,109,110,111,116,117,142,143,144,145,146,147,168,169,170,171,172,173,174,175,176,198,199,200,201,202,226,267,345,348,349};
new INTERIOS_AMMO[] = {100,101,102,164,165,166,212,213,214,215,224,225,232,259,265};
new INTERIOS_ZAKUS[] = {132,133,134,135,136,137,148,149,177,178,179,180,181,182,183,184,203,204,205,206,207,208,209,210,211,229,233,236,237,238,256,263,264,335,340};
new INTERIOS_AZS[] = {118,119,120,121,122,123,124,125,126,127,128,129,130,131,158,159,160,161,162,163,230,278,309,310,311,312,313,336,337,338,339,341};

public OnFilterScriptInit()
{
	Streamer_ToggleChunkStream(true);

	Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, 1000);

	Streamer_SetTypePriority(Streamer_Types, sizeof Streamer_Types);

	Streamer_TickRate(50);
	Streamer_SetTickRate(50);
	
	YSF_SetTickRate(5);
	
	CreateActors();
	Create3DTextLabels();
	CreatePickups();
	CreateMapIcons();
	CreateObjcets();
	CreateVehicles();
	CR_rinok();
//	load_PawnShop();
	return false;
}

new NickName[MAX_PLAYER_NAME];

public OnFilterScriptExit()
{
	for new i; i < 1000; i++ do
	{
		if IsValidDynamicObject(i) *then DestroyObject(i);

		if i < 4 *then DestroyVehicle(RinokCars[i]);
	}
}

stock CreateActors()
{ 
	new id; 
	
	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(36, 2580.3503,1426.5663,1800.9688,179.0684), E_STREAMER_WORLD_ID, INTERIOS_SHOP24);

	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(179, 295.2432,-40.5504,1001.5156,1.7996), E_STREAMER_WORLD_ID, INTERIOS_AMMO);

	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(155, 1081.6743,991.1944,1600.9989,357.7499), E_STREAMER_WORLD_ID, INTERIOS_ZAKUS);
    
    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(12, 497.6714,-77.4644,998.7651,356.6964), E_STREAMER_WORLD_ID, {105,150,185,190,191,154});
    
    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(12, 501.7258,-19.8993,1000.6797,93.3506), E_STREAMER_WORLD_ID, {104,186,189});

    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(12, -2655.5076,1406.6876,906.2734,268.9621), E_STREAMER_WORLD_ID, {103,128,131,135,139});

    Streamer_SetArrayData(STREAMER_TYPE_ACTOR,  CreateDynamicActor(37, 199.9442,-131.6396,1003.5078,27.3593), E_STREAMER_WORLD_ID, {112,113,114,187,188,216,217,218,234,253});

    Streamer_SetArrayData(STREAMER_TYPE_ACTOR,  CreateDynamicActor(267, -465.9878, 2217.9958, 1601.0859, 270.0000), E_STREAMER_WORLD_ID, {2,3,4,5});

    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(71, 1150.4928,-1304.2775,1019.4139,271.0594), E_STREAMER_WORLD_ID, {2,3,4});

    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(24, 666.1187,-566.1037,1700.7394,177.4561), E_STREAMER_WORLD_ID, INTERIOS_AZS);

    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(91, -398.2892,2232.0200,1801.0859,175.2628), E_STREAMER_WORLD_ID, {192,193,194,195,196,197,352});

    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(12, -1029.6779, -643.5944, 1500.9688, 358.4806), E_STREAMER_WORLD_ID, {191,193,219,221,224,230,231});
	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(13, 2018.6428, 2674.2532, 1500.9493, 179.2522), E_STREAMER_WORLD_ID, {192,218,220,222,227,228,229});
	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(3, 1811.9645, 2652.6387, 1500.9688, 90.6015), E_STREAMER_WORLD_ID, {188,189,190,194,223,225,226});

	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(5, 1756.8765,-315.1113,1654.5055, 359.2938), E_STREAMER_WORLD_ID, {298,299,300});
	for new i; i < 6; i++ do
	{
		switch i do
		{
			case 0: Streamer_SetArrayData(STREAMER_TYPE_ACTOR, id = CreateDynamicActor(101,1751.4460,-310.9987,1654.5376,178.7493), E_STREAMER_WORLD_ID, {298,299,300});
			case 1: Streamer_SetArrayData(STREAMER_TYPE_ACTOR, id = CreateDynamicActor(223,1751.3000,-304.0993,1654.5376,181.1334), E_STREAMER_WORLD_ID, {298,299,300});
			case 2: Streamer_SetArrayData(STREAMER_TYPE_ACTOR, id = CreateDynamicActor(2,1756.8878,-311.2824,1654.5376,179.7938), E_STREAMER_WORLD_ID, {298,299,300});
			case 3: Streamer_SetArrayData(STREAMER_TYPE_ACTOR, id = CreateDynamicActor(180,1756.9268,-304.4160,1654.5376,177.3654), E_STREAMER_WORLD_ID, {298,299,300});
			case 4: Streamer_SetArrayData(STREAMER_TYPE_ACTOR, id = CreateDynamicActor(13,1762.1881,-311.2039,1654.5376,179.9556), E_STREAMER_WORLD_ID, {298,299,300});
			case 5: Streamer_SetArrayData(STREAMER_TYPE_ACTOR, id = CreateDynamicActor(65,1762.1881,-307.8369,1654.5376,179.9556), E_STREAMER_WORLD_ID, {298,299,300});
		}
		switch random(5) do
		{
			case 0: ApplyDynamicActorAnimation(id, "DANCING","dnce_M_c",4.1,1,1,1,1,1);
			case 1: ApplyDynamicActorAnimation(id, "DANCING","DAN_Left_A",4.1,1,1,1,1,1);
			case 2: ApplyDynamicActorAnimation(id, "DANCING","bd_clap1",4.1,1,1,1,1,1);
			case 3: ApplyDynamicActorAnimation(id, "DANCING","DAN_Left_A",4.1,1,1,1,1,1);
			case 4: ApplyDynamicActorAnimation(id, "DANCING","dnce_M_c",4.1,1,1,1,1,1);
		}
	}

	SDAVW( CreateDynamicActor(20, 496.6649,1305.1852,774.4839,93.0393), 2);
	SDAVW( CreateDynamicActor(57, 496.6649,1306.9811,774.4839,104.0060), 2);
	SDAVW( CreateDynamicActor(141, 496.6650,1308.7821,774.4839,96.7993), 2);
	SDAVW( CreateDynamicActor(148, 496.6652,1310.6189,774.4839,91.7859), 2);
	SDAVW( CreateDynamicActor(150, 496.6651,1312.3998,774.4839,88.0259), 2);
	SDAVW( CreateDynamicActor(14, 496.4996,1318.7137,774.4839,125.3129), 2);

	SDAVW( CreateDynamicActor(164, 1526.2676, 1339.3668, 10.9787, 137.9433), 1);
	SDAVW( CreateDynamicActor(261, 1506.2684, 1310.1619, 10.9788, 268.4882), 1);
	SDAVW( CreateDynamicActor(76, 1507.2454, 1337.0317, 10.9788, 88.3297), 1);
	SDAVW( CreateDynamicActor(227, 1511.1278, 1362.1139, 10.9738, 181.6705), 1);

	SDAVW( CreateDynamicActor(153, -2670.0698,808.9360,1500.9688,189.1366), 1);
	SDAVW( CreateDynamicActor(187, -2665.1348,806.7042,1500.9688,93.2557), 1);
	SDAVW( CreateDynamicActor(227, -2665.1348,800.0263,1500.9688,98.8957), 1);
	SDAVW( CreateDynamicActor(228, -2665.1335,793.3651,1500.9688,93.8823), 1);
	SDAVW( CreateDynamicActor(148, -2684.8027,808.9371,1500.9688,181.3030), 1);
	SDAVW( CreateDynamicActor(150, -2677.3047,808.9442,1500.9688,180.6763), 1);	
	SDAVW( CreateDynamicActor(164, -2693.3257,792.3634,1500.9688,329.4222), 1);
	SDAVW( CreateDynamicActor(150, -2680.2732,795.8896,1501.0259,270.3133), 1);
	SDAVW( CreateDynamicActor(148, -2680.9580,797.1705,1501.0259,88.5783), 1);
	
	SDAVW( CreateDynamicActor(8, 949.9467,2451.9934,1601.9871,266.0435), 2);
	SDAVW( CreateDynamicActor(141, 950.3532,2460.3127,1601.9800,219.3799), 2);
	SDAVW( CreateDynamicActor(57, 952.9460,2464.3809,1601.9790,251.0268), 2);
	SDAVW( CreateDynamicActor(227, 946.3777,2458.5283,1601.9790,184.3746), 2);

	SDAVW( id = CreateDynamicActor(79, 2169.2637,-1053.1842,71.9548,132.8570), 1228), ApplyDynamicActorAnimation(id, "CRACK", "BBALBAT_IDLE_02", 4.1, 1, 0, 0, 1, 0);
	SDAVW( id = CreateDynamicActor(221, 2164.0886,-1046.4413,71.9966,192.7009), 1228), ApplyDynamicActorAnimation(id, !"PED", !"PHONE_TALK", 4.1, 1, 1, 1, 1, 1);
	SDAVW( id = CreateDynamicActor(77, 2168.1323,-1051.1493,71.9546,44.1829), 1228), ApplyDynamicActorAnimation(id, "CRACK", "CRCKIDLE1", 4.1, 1, 0, 0, 1, 0);
	SDAVW( id = CreateDynamicActor(91, 2161.3301,-1050.7638,71.9536,140.8112), 1228), ApplyDynamicActorAnimation(id, "BAR", "BARSERVE_LOOP", 4.1, 1, 0, 0, 1, 0);
	
	SDAVW ( CreateDynamicActor(6, 822.1429, 3.1134, 1004.1797, 199.3640), 3);
	
	CreateDynamicActor(172, 2287.3843, -818.3999, 1407.1273, 190.6998, 1, 100.0, 3, 215);
	CreateDynamicActor(172, 2295.1116, -816.3296, 1407.1273, 190.6998, 1, 100.0, 3, 215);
	CreateDynamicActor(11, 2287.5088, -828.7661, 1407.1273, 164.9999, 1, 100.0, 3, 215);
	CreateDynamicActor(171, 2294.6411, -830.9922, 1407.1273, 194.9998, 1, 100.0, 3, 215);
	CreateDynamicActor(11, 2233.7729, -824.5397, 1407.1273, 270.1074, 1, 100.0, 3, 215);
	CreateDynamicActor(11, 2231.5212, -828.2438, 1407.1273, 200.2337, 1, 100.0, 3, 215);
	CreateDynamicActor(164, 2271.4719, -788.2106, 1407.1273, 158.4156, 1, 100.0, 3, 215);
	CreateDynamicActor(163, 2262.4053, -788.4054, 1407.1273, 217.3229, 1, 100.0, 3, 215);
	CreateDynamicActor(164, 2271.9661, -871.1498, 1407.1273, 31.5143, 1, 100.0, 3, 215);
	CreateDynamicActor(163, 2260.6018, -870.8624, 1407.1273, 326.3403, 1, 100.0, 3, 215);
	CreateDynamicActor(171, 2257.1992, -853.4859, 1407.1273, 252.8747, 1, 100.0, 3, 215);
	CreateDynamicActor(172, 2259.2957, -845.6426, 1407.1273, 254.1276, 1, 100.0, 3, 215);
	CreateDynamicActor(171, 2273.3960, -845.7950, 1407.1273, 106.2327, 1, 100.0, 3, 215);
	CreateDynamicActor(172, 2275.4807, -853.5748, 1407.1273, 104.0394, 1, 100.0, 3, 215);
	CreateDynamicActor(12, 2232.5732, -819.6976, 1407.1273, 322.9395, 1, 100.0, 3, 215);

	SDAVW( CreateDynamicActor(164, 1544.0896, 1272.6919, 10.8475, 259.4740), 5);

	CreateDynamicActor(68, 334.1520, -1808.5800, 4.6678, -0.0000);
	CreateDynamicActor(194, 335.1220, -1815.4290, 4.6678, -0.0000);


	
	CreateDynamicActor(72, 1773.6903,-1891.7493,13.5504,139.4896);
	CreateDynamicActor(48, 1163.6832,-1754.9606,13.6180,89.7200);
	CreateDynamicActor(6, 1420.4176,-1685.8624,13.5469,245.4521);
    CreateDynamicActor(169, -1418.8385,2084.1316,1502.0374,1.0850);
	CreateDynamicActor(76, -1025.1711,1823.1455,1101.0859,352.5338);
	CreateDynamicActor(20,-1025.5941,1818.6888,1101.0859,280.7565);
	CreateDynamicActor(71,1298.6902,-1263.8916,13.5939,89.9531);
	CreateDynamicActor(3,1324.0098,287.2829,20.0452,269.6259);
	CreateDynamicActor(8,1972.5740,-1981.1592,13.5469,339.4531);
	CreateDynamicActor(6,644.0786,-1365.4963,13.6142,338.0643);
	CreateDynamicActor(185, 1800.4841, 409.9243, 20.2294, 177.3050);
	CreateDynamicActor(132, -256.7696, -1362.8536, 9.4421, 215.7267);
   	CreateDynamicActor(35, 523.8312, 848.2282, -42.9189, 5.9560);

	CreateDynamicActor(155, 1122.8033,-1465.7811,15.7834,213.1764);
	CreateDynamicActor(155, 1142.4574,-1474.5808,15.7969,317.5174);
	CreateDynamicActor(155, 1138.0466,-1456.4396,15.7969,90.3720);
	CreateDynamicActor(73, -2201.2429,-2340.7310,30.6250,121.5413);
	CreateDynamicActor(142, -2263.4514,177.9965,35.3056,109.1910);
	CreateDynamicActor(73, -1746.7738,156.5982,3.5547,176.5199);
	CreateDynamicActor(59, 1090.0826,1525.7831,1716.0868,268.1139);
	CreateDynamicActor(59, 1739.8818,-246.6380,1701.0857,269.1293);
	CreateDynamicActor(32,-38.4478,1180.5905,19.3594,284.8109);
	CreateDynamicActor(305,1467.7723,-1673.4635,13.3729,268.0522);
	
	SDAVW( CreateDynamicActor(34, 2355.8381,2829.5105,1500.9688,78.8462), 1);
	CreateDynamicActor(73,2108.4651,790.0165,1027.1191,93.4347);

	SDAVW( CreateDynamicActor(211, 1479.8870,-1274.1304,113.8064,1.7290), 2);
	SDAVW( CreateDynamicActor(235, 1470.5670,-1268.4434,113.8103,271.7989), 2);
	SDAVW( CreateDynamicActor(36, 1477.5751,-1266.6917,113.8103,271.5560), 2);
	
	CreateDynamicActor(260, 1771.7130,424.2505,20.1436,122.6339);
	CreateDynamicActor(28, 1110.7767, -1423.8966, 15.7969, 245.50609);
	CreateDynamicActor(189, 1090.1143,1526.4485,1716.0868,246.6860);

	CreateDynamicActor(209, 1589.7340,-1286.2540,17.5116,177.9591);
	CreateDynamicActor(209, 947.8748, 1720.1589, 8.8516, 182.6520);
	CreateDynamicActor(209, 1460.5244, 2785.7810, 10.8203, 168.7890);
	CreateDynamicActor(209, -1982.4241,127.5627,27.6875,87.1428);
	CreateDynamicActor(209, -1980.6304,174.8663,27.6875,105.3163);
	CreateDynamicActor(209, -1547.7957,673.8372,7.1875,87.4328);
	CreateDynamicActor(209, -2682.0137,582.9930,14.4531,339.0652);
	CreateDynamicActor(209, -2400.9304,337.9206,35.1719,240.9909);
	CreateDynamicActor(209, -1827.1926,-566.0032,16.4918,227.8308);
	CreateDynamicActor(209, 1501.9723,-1277.5680,14.5625,180.6366);
	CreateDynamicActor(209, 196.7574,-117.5487,1.5503,35.9374);
	CreateDynamicActor(209, 1433.8011,-1740.7983,13.5469,3.2460);
	CreateDynamicActor(209, 1182.1571,-1314.9563,13.5716,268.2516);
	CreateDynamicActor(209, 2327.6658,2422.2625,10.8203,178.0226);
	CreateDynamicActor(209, 2351.6204,2404.5659,10.8203,356.9377);
	CreateDynamicActor(209, -2022.6364,458.2961,35.1723,357.3295);
	CreateDynamicActor(209, 1772.6434,-1903.8330,13.5525,36.4124);
	CreateDynamicActor(209, 2219.7568,-1151.6548,25.7504,313.2577);
	CreateDynamicActor(209, 2404.4722,-1934.8497,13.5538,316.9001);
	CreateDynamicActor(209, -89.4332,101.0922,3.1172,253.9693);
	CreateDynamicActor(209, 159.6426,-1812.3201,3.7413,87.9031);
	CreateDynamicActor(209, 1104.3633,1381.8967,10.8203,189.9294);
	CreateDynamicActor(209, 2999.9612,530.3032,-3.3559,155.2348);
	CreateDynamicActor(209, 1576.5154,1843.9366,10.8203,75.3274);
	CreateDynamicActor(209, 2598.4092,1060.1460,10.8125,269.1349);
	CreateDynamicActor(209, 2538.8323,2137.2725,10.8203,93.7216);
	CreateDynamicActor(209, 2029.4380,985.6383,10.8203,330.9406);
	CreateDynamicActor(209, 2243.4553,572.4129,7.7802,227.5396);
	CreateDynamicActor(209, -105.8033,-310.1197,1.4297,271.2830);
	CreateDynamicActor(209, 1380.0839,-1804.9448,13.5469,274.1391);
	CreateDynamicActor(209, 194.8985,-272.4871,1.5703,178.3508);
	CreateDynamicActor(209, -2692.3674,385.2352,4.3750,224.5);
	CreateDynamicActor(209, 1521.3981,-1023.9045,23.8500,207.1534);
	CreateDynamicActor(209, 2823.7583,1290.6710,10.7631,271.5448);
	CreateDynamicActor(209, 1976.1801, -1981.1899, 13.5469, 0.0000);
	CreateDynamicActor(209, -63.1272, 1209.9116, 19.6733, 180.0);
	CreateDynamicActor(59, -1658.3551, 1208.2866, 7.2500, 12.6507);
	CreateDynamicActor(24, 2535.1130, -1474.6288, 24.0039, 3.9796);
	CreateDynamicActor(50, 2530.6060, -1475.0999, 23.9788, 353.7612);
	CreateDynamicActor(5, 2507.7012, -1471.6755, 24.0371, 284.2320);
	CreateDynamicActor(33, -142.1979, -222.0515, 1.4219, 359.0683);
	
	CreateDynamicActor(185, 2464.3484, 2244.9761, 10.8203, 123.0654);
	CreateDynamicActor(17, -2053.0842, 460.5180, 35.1719, 304.3948);
	CreateDynamicActor(133, 1929.2721, 167.4322, 37.2813, 342.0440);
	CreateDynamicActor(159, 1910.5865, 169.5010, 37.1945, 288.3735);
	CreateDynamicActor(132, 1012.7135, -285.9390, 73.9930, 216.3445);
	
	/*Halloween*/
	CreateDynamicActor(221, -1105.8250, -953.2480, 138.7770, 90.0000);
	CreateDynamicActor(285, 1757.7350, 2711.5200, 10.2520, 80.0000);
	CreateDynamicActor(285, 1760.4230, 2709.6250, 10.2510, 30.0000);
	CreateDynamicActor(285, 1755.5810, 2707.4360, 10.4020, 190.0000);
	CreateDynamicActor(285, 1753.3130, 2710.4880, 10.2530, 85.0000);
	
	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(225, -413.8500, 684.7383, 1601.9966, 359.4595), E_STREAMER_WORLD_ID, {500});
	
	/*Auto-Invite*/

	CreateDynamicActor(165, -82.8856, 1209.2118, 19.7422, 3.0223);
	CreateDynamicActor(165, -1995.5789,137.5688,27.6875,271.3924);
	CreateDynamicActor(165, 1773.8164,-1900.8397,13.5502,89.1664);
   	CreateDynamicActor(165, 2823.8813,1295.2294,10.7633,268.1656);
	CreateDynamicActor(165, 1157.5122,-1748.6414,13.5703,178.6602);

	return printf("[Filterscript] All Loaded Actors =~ %d/unlimited", Streamer_CountItems(STREAMER_TYPE_ACTOR, 0));
}

stock Create3DTextLabels()
{    
    CreateDynamic3DTextLabel("Visu serverio daiktu sarasas: {ffffff}/finditem\n{ffff00}Norint nusipirkti bet kuri daikta/skin/automobili, iveskite: {ffffff}/adonate", 0xffff00ff, 1129.8002,-1423.6177,15.7737, 20.0);
		
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Mercedes-AMG A-45 {ffffff}]", 0xFFFFFFFF, -509.7102, 2556.0251, 53.4344, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Audi R8 {ffffff}]", 0xFFFFFFFF, -528.1900, 2561.1067, 53.1021, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Audi e-tron {ffffff}]", 0xFFFFFFFF, -509.2930, 2575.5195, 53.1602, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Toyota GR {ffffff}]", 0xFFFFFFFF, -519.9877, 2571.9153, 53.4955, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Mercedes-Benz EQC 400 {ffffff}]", 0xFFFFFFFF, -509.0570, 2580.3159, 53.1569, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Volkswagen Scirocco {ffffff}]", 0xFFFFFFFF, -519.8986, 2577.0737, 53.4955, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Land Rover Defender {ffffff}]", 0xFFFFFFFF, -539.8932, 2565.9385, 53.2990, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Nissan Qashqai {ffffff}]", 0xFFFFFFFF, -519.8388, 2582.2017, 53.4954, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Renault Twizy {ffffff}]", 0xFFFFFFFF, -528.8347, 2576.5244, 53.1588, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Range Rover Velar {ffffff}]", 0xFFFFFFFF, -539.9667, 2570.6614, 53.4409, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Jaguar I-PACE {ffffff}]", 0xFFFFFFFF, -528.6356, 2581.6206, 53.1587, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Ford Mustang Mach {ffffff}]", 0xFFFFFFFF, -540.1338, 2575.5728, 53.4346, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Lamborghini Countach {ffffff}]", 0xFFFFFFFF, -519.4117, 2607.4075, 53.4962, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}BMW M1 {ffffff}]", 0xFFFFFFFF, -519.2571, 2612.4426, 53.4970, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Lexus LX600 {ffffff}]", 0xFFFFFFFF, -527.8905, 2617.0945, 53.4954, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}KIA K7 {ffffff}]", 0xFFFFFFFF, -527.7982, 2622.3313, 53.4955, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Polestar 2 {ffffff}]", 0xFFFFFFFF, -538.3220, 2615.8096, 53.1598, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Koenigsegg Gemera {ffffff}]", 0xFFFFFFFF, -527.6416, 2627.4417, 53.4955, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Mercedes GT63 Brabus {ffffff}]", 0xFFFFFFFF, -528.0220, 2604.1719, 53.3365, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Mercedes-Benz GLE Brabus {ffffff}]", 0xFFFFFFFF, -507.8730, 2603.5845, 53.2862, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Lamborghini Gallardo {ffffff}]", 0xFFFFFFFF, -539.6310, 2603.7622, 53.1296, 6.0000);
	CreateDynamic3DTextLabel("{ffffff}Vieta automobiliui\n[ {FA5858}Dodge RAM 3500 {ffffff}]", 0xFFFFFFFF, -528.6229, 2568.8315, 53.3574, 6.0000);
	
	CreateDynamic3DTextLabel(!"Autosalonas {FA5858}Luxe-klases\n\n{ffffff}Informacija\n{cccccc}[ paspauskite ALT ]", 0xFFFFFFFF, -505.0940, 2597.6277, 53.5557, 5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}2 korpusas (Apsauga)\n{FFFFFF}ALT",COLOR_BLUENEW,39.1284,1910.0469,17.8962,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}2 korpusas (Apsauga)\n{FFFFFF}ALT",COLOR_BLUENEW,-15.6253,1957.1833,18.1981,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}1 korpusas (Apsauga)\n{FFFFFF}ALT",COLOR_BLUENEW,32.8925,1851.2185,18.2480,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}Iejimas i kalejima\n{FFFFFF}ALT",COLOR_BLUENEW,-12.2581,1883.1897,17.6982,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}1 korpusas\n{FFFFFF}ALT",COLOR_BLUENEW,313.7311,2460.5391,1500.9797,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}Isejimas i lauka (Apsauga)\n{FFFFFF}ALT",COLOR_BLUENEW,337.4621,2461.2009,1500.9797,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}Isejimas i lauka (Apsauga)\n{FFFFFF}ALT",COLOR_BLUENEW,321.5936,2483.2593,1500.9797,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}2 korpusas\n{FFFFFF}ALT",COLOR_BLUENEW,-103.0808,2337.4805,1500.9497,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}Isejimas i lauka\n{FFFFFF}ALT",COLOR_BLUENEW,-100.1502,2402.9199,1500.9697,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}Isejimas i lauka (Centrinis isejimas)\n{FFFFFF}ALT",COLOR_BLUENEW,-97.4013,2347.1445,1500.9497,5.0);
	CreateDynamic3DTextLabel(!"{A19D9D}Isejimas i lauka (Apsauga)\n{FFFFFF}ALT",COLOR_BLUENEW,-102.9486,2400.0579,1500.9697,5.0);
	CreateDynamic3DTextLabel(!"Palikti kalejima\n{FFFFFF}ALT",COLOR_GREY,-103.9012,2351.7346,1500.9497,5.0);
	CreateDynamic3DTextLabel(!"Kalejimo suolelis\n{FFFFFF}ALT",COLOR_GREY,318.6648,2429.7112,1500.9797,5.0);
	CreateDynamic3DTextLabel(!"Busena postu\n{FFFFFF}ALT",COLOR_GREY,-97.6769,2344.7224,1507.0781,3.0);
	CreateDynamic3DTextLabel(!"{34eb40}Tapti dalyviu - {FFFFFF}N", COLOR_WHITE, 14.2867,1811.2552,17.7232,2.0);
	CreateDynamic3DTextLabel("Pradeti {99CC00}nemokama {FFFFFF}gydyma.\nPaspauskite: ALT", COLOR_WHITE, 343.3261,2430.3489,1500.9797, 3.0);
	CreateDynamic3DTextLabel("[ Varzybu ringas ]\n\n{34eb40}Ringas laisvas", COLOR_WHITE, 9.7257,1811.5306,18.5784, 8.0);
	CreateDynamic3DTextLabel("Svarbi informacija!\n{FFFF00}ALT", COLOR_WHITE, 2315.9089,72.5739,1501.9962+1, 3.0);
	CreateDynamic3DTextLabel("Svarbi informacija!\n{FFFF00}ALT", COLOR_WHITE, 2310.7771,72.5220,1501.9962+1, 3.0);
	CreateDynamic3DTextLabel("Skambuciai is uzsienio {9ACD32}Kalejimo.\nPasiekiamas telefonas ir bendravimas su lankytojais.", COLOR_WHITE, 328.2492,2474.3428,1500.9797+1, 3.0);
	CreateDynamic3DTextLabel(!"{73B461}Benas ( Detaliu pardavejas, skirtas tuningui )\n{FFFFFF}Noredami paziureti prekes, paspauskite ALT",-1, 1090.0826,1525.7831,1716.0868,5.0);
	CreateDynamic3DTextLabel("{F5DEB3}[{FFFFFF} Skaicius ir Herbas {F5DEB3}]{FFFFFF}\n{AFAFAF}/herbas [ID] [suma]\n\t{FFFFFF}arba\n{AFAFAF}/skaicius [ID] [suma]{FFFFFF}",-1,506.1710,-69.5010,999.6721,10.0);
	CreateDynamic3DTextLabel("{F5DEB3}[{FFFFFF} Skaicius ir Herbas {F5DEB3}]{FFFFFF}\n{AFAFAF}/herbas [ID] [suma]\n\t{FFFFFF}arba\n{AFAFAF}/skaicius [ID] [suma]{FFFFFF}",-1,-2652.9382,1410.2617,906.2734,10.0);
	CreateDynamic3DTextLabel("Garazas/Tuning priekabu\n{FF9966} [ {FFFFFF}ALT {FF9966}]",-1,-2106.0000,-2418.8154,30.6250,5.0); // Salon trailerov, 3D tekst vo dvore
	CreateDynamic3DTextLabel("{faac58}Priekabu salonas\n\n{ffffff}Stokite ant Pickup, kad ieiti/iseiti",-1,-2071.5891,-2445.5686,30.7183,5.0); // Salon trailerov, 3D tekst
	CreateDynamic3DTextLabel("{faac58}Isejimas\n\n{ffffff}Stokite ant Pickup, kad ieiti/iseiti",-1,2360.0332,2847.5222,1500.9688,5.0); // Salon trailerov, 3D tekst
	CreateDynamic3DTextLabel("{ffffff}Priekabu pirkimas\n{FF9966} [ {FFFFFF}ALT {FF9966}]",-1,2354.2744,2829.4934,1500.9688,5.0); // Salon trailerov, 3D tekst
	CreateDynamic3DTextLabel("Priekaba {FF9966}¹1\n{ffffff}Mazas {FF9966}|{ffffff} $200000\n\n{FF9966}[{ffffff} Ieiti - ALT {FF9966}]",-1,2352.2026,2841.7737,1501.2664,5.0);
	CreateDynamic3DTextLabel("Iseiti\n{FAAC58}[{FFFFFF} ALT {FAAC58}]",-1,1334.1860,1261.1288,1501.0850,5.0);
	CreateDynamic3DTextLabel("Iseiti\n{FAAC58}[{FFFFFF} ALT {FAAC58}]",-1,1313.6605,1262.3265,1501.0850,5.0);
	CreateDynamic3DTextLabel("Iseiti\n{FAAC58}[{FFFFFF} ALT {FAAC58}]",-1,1290.3165,1260.6007,1501.4446,5.0);
	CreateDynamic3DTextLabel("Priekaba {FF9966}¹2\n{ffffff}Vidutinis {FF9966}|{ffffff} $400000\n\n{FF9966}[{ffffff} Ieiti - ALT {FF9966}]",-1,2346.8303,2859.3630,1501.1156,5.0);
	CreateDynamic3DTextLabel("{958989}Parduotuve 24/7\n{FFFFFF}Paspauskite: N pirkimui",-1,2580.1340,1424.8770,1800.9688, 10.0);
	CreateDynamic3DTextLabel("Casino: {73B461}4 Dragons\n{FFFFFF}Iejimui reikia 500$\nPaspauskite:{73B461} ALT",-1,2019.32,1007.7,10.8203,9.0);
	CreateDynamic3DTextLabel("Priekaba {FF9966}¹3\n{ffffff}Didelis {FF9966}|{ffffff} $800000\n\n{FF9966}[{ffffff} Ieiti - ALT {FF9966}]",-1,2352.3911,2855.1179,1501.0981,5.0); //Salon trailerov, 3D tekst
	CreateDynamic3DTextLabel("Atlikti pirkimus\n{cccccc}Paspauskite ALT", 0xFFFFFFFF, -1064.6395, -1201.0970, 1729.8284, 8.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, -1, 3);
	CreateDynamic3DTextLabel("Abraham ( Prekeivis SAG-Coins )\n{FFFFFF}Noredami pasikalbeti, paspauskite ALT", COLOR_VALIK, 1110.7767, -1423.8966, 15.7969, 15.0);
	CreateDynamic3DTextLabel("[ Bendro naudojimo kurybos stalvirsis ]\n\n{AFAFAF}Kad naudotumete darbo stala\nPaspauskite ALT", COLOR_VALIK, 1108.0330,-1427.3765,15.7969, 10.0);
	CreateDynamic3DTextLabel("[ Bendro naudojimo kurybos stalvirsis ]\n\n{AFAFAF}KAd naudotumete darbo stala\nPaspauskite ALT", COLOR_VALIK, 1108.0726,-1430.3044,15.7969, 10.0);
	CreateDynamic3DTextLabel("Atidaryti dirbtuviu paslaugas\n\n[ALT]", 0xAFAFAFFF, 1541.3546, 1644.3098, 11.4203, 3.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 7);
	CreateDynamic3DTextLabel(" Rubine \n Darbas: {F9AD43}Masinistas elektro traukinio\n{ffffff}[ ALT ] ", 0xFFFFFFFF, -2092.8953, 505.5473, 1487.6927, 4.0000);
	CreateDynamic3DTextLabel(" Stovas \n {F9AD43}Registracija i skrydi\n{ffffff}[ ALT ] ", 0xFFFFFFFF, -2102.2109, 506.9873, 1487.6927, 7.0000);
	CreateDynamic3DTextLabel(" Stovas \n {F9AD43}Registracija i skrydi\n{ffffff}[ ALT ] ", 0xFFFFFFFF, -2102.2109, 512.9057, 1487.6927, 7.0000);
	CreateDynamic3DTextLabel("Pitagoras ( Salono pardavejas ''Mobiliojo rysio sistema'' )\n{FFFFFF}Noredami pasikalbeti, paspauskite ALT",COLOR_VALIK,1739.8818,-246.6380,1701.0857+1,5.0);
	CreateDynamic3DTextLabel("Naudokite ''{73B461}/sellcard{FFFFFF}'',\nnoredami parduoti SIM-kortele",-1,1741.7079,-246.6643,1701.0857,5.0);
	CreateDynamic3DTextLabel("Noredami naudotis darbo stalu\n{FFFFFF}Paspauskite ALT", 0x73B461FF, 2637.8193, 1169.8242, 1038.1185, 10.0000); //
	CreateDynamic3DTextLabel("Isejimas\n\n{cccccc}[ Paspauskite ALT ]", 0xFFFFFFFFFFFF00FF, 2628.3110, 1182.9056, 1041.5614, 5.0000); // is verstako
	CreateDynamic3DTextLabel("Iejimas\n\n{cccccc}[ Paspauskite ALT ]", 0xFFFFFFFFFFFF00FF, 1385.7400, -1.6083, 1000.9371, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1, 2);
	CreateDynamic3DTextLabel("Informacija apie butus\n\n{cccccc}[ Paspauskite ALT ]", 0xFFFFFFFFFFFF00FF, 1793.6145, -1303.1317, 13.6498, 5.0000);
	CreateDynamic3DTextLabel("Iejimas\n\n{cccccc}[ Paspauskite ALT ]", 0xFFFFFFFFFFFF00FF, 1412.5050, -20.0327, 1000.9316, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2, 2);
	CreateDynamic3DTextLabel("Informacija apie butus\n\n{cccccc}[ Paspauskite ALT ]", 0xFFFFFFFFFFFF00FF, 280.4361, -1607.8396, 33.1133, 5.0);
    CreateDynamic3DTextLabel("Isejimas: ALT", -1, -575.709, 2594.2, 1705.09, 15.0);
   	CreateDynamic3DTextLabel("Richi\n{73B461}Pasikalbeti: {FFFFFF}ALT", -1, 1771.5164,424.0565,20.1436,5.0);
	CreateDynamic3DTextLabel("Apleisti konteineriai (11.00 - 22.00)\nNoredami pasiimti deze,\n naudokite klavisa: {FFFFFF}ALT\n{FFFFFF}Dezes pasirodo kas 1-20 minuciu!", 0xFFFFFFFFFAAC58FF, 132.9289, -260.8550, 4.4104, 25.0000);
	CreateDynamic3DTextLabel("Naftos baze\n{FFFFFF}ALT", 0xFFFFFFFFAFAFAFFF, -2082.9087, 1343.1514, 8.0990, 10.0);
	CreateDynamic3DTextLabel("Naftos baze SAN-FIERRO\n\nSupirkimas {FF7C00}naftos{FFFFFF} is privaciu\nVerslininkai pagal kaina:\n{FF7C00}180{FFFFFF}$ uz {FF7C00}1{FFFFFF} litra. Naudokite\nklavisa ALT , kad parduoti\nbarelis su nafta.", 0xFFFFFFFFFFFFFFFF, -2072.3931, 1363.2417, 9.2016, 15.00);
	CreateDynamic3DTextLabel("Dirbtuves numeriu montavimui\nNumerio montavimo kaina: {26A6D0}5000$ .\nJei gavote leidima irengti numerius, tada:\n{26A6D0}Paspauskite ALT tesimui.", -1, 217.2211, -228.2586, 1.7786, 3.0);
	CreateDynamic3DTextLabel("Kad iskrautumete dezes:\n{FFFFFF}Paspauskite ALT", COLOR_GREEN, 1830.3701, 416.7932, 20.1436, 5.0);
	CreateDynamic3DTextLabel("Kad pakrautumete dezes su maisto atsargomis:\n{FFFFFF}Paspauskite ALT", COLOR_GREEN, -1733.3938, 187.7363, 3.5547, 5.0);
	CreateDynamic3DTextLabel("{c78904}Suvenyru krautuvele\n\n{ffffff}Perziureti prekes", COLOR_GREEN, -1108.2000, -953.4350, 139.0000, 5.0); // HALLOWEEN
	CreateDynamic3DTextLabel("{c07e03}Albertas\n\n{ffffff}Quest Personazas", COLOR_GREEN, -1118.9000, -953.1030, 139.3540, 5.0); // HALLOWEEN

	/* MAINING FERMA */
	CreateDynamic3DTextLabel(!"[ Isejimas ]\nPaspauskite ALT", 0xAFAFAFFF, -1662.1874, -246.4930, 14.1484, 20.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	CreateDynamic3DTextLabel(!"[ Vaizdo ploksciu valdymas ]\nPaspauskite ALT", 0xAFAFAFFF, -1658.4623, -244.2459, 14.1484, 2.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	CreateDynamic3DTextLabel(!"[ Vaizdo ploksciu valdymas ]\nPaspauskite ALT", 0xAFAFAFFF, -1656.4078, -244.2418, 14.1484, 2.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	CreateDynamic3DTextLabel(!"[ Vaizdo ploksciu valdymas ]\nPaspauskite ALT", 0xAFAFAFFF, -1654.4594, -244.2415, 14.1484, 2.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	CreateDynamic3DTextLabel(!"[ Vaizdo ploksciu valdymas ]\nPaspauskite ALT", 0xAFAFAFFF, -1652.4283, -244.2435, 14.1484, 2.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	CreateDynamic3DTextLabel(!"[ Vaizdo ploksciu valdymas ]\nPaspauskite ALT", 0xAFAFAFFF, -1650.4478, -244.2418, 14.1484, 2.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	CreateDynamic3DTextLabel(!"[ Visu vaizdo ploksciu apziura ]\nPaspauskite ALT", 0xAFAFAFFF, -1649.3934, -246.4758, 14.1484, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	CreateDynamic3DTextLabel(!"Noredami pagerinti vaizdo plokste,\nnaudojant stala\nper inventoriu", 0xAFAFAFFF, -1653.0421, -249.0098, 14.1484, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 231);
	/* MAINING FERMA */
	
	CreateDynamic3DTextLabel("Mokamas isejimas is psichiatrijos ligonines.\nNaudokite klavisa: {99CC00}ALT!", 0xFFFFFFFF, -802.7033, 2828.3662, 1501.9896, 10.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 6, 6);

	CreateDynamic3DTextLabel("Liftas {99CC00}Savivaldybes{FFFFFF}\nPaspauskite: {99CC00}ALT",-1,1489.7209,-1259.8041,113.8044, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2, 0);
	CreateDynamic3DTextLabel("Liftas {99CC00}Savivaldybes{FFFFFF}\nPaspauskite: {99CC00}ALT",-1,1509.3090,1088.1688,1033.8420, 5.0);
	CreateDynamic3DTextLabel("Liftas {99CC00}Savivaldybes{FFFFFF}\nPaspauskite: {99CC00}ALT",-1,1999.9302,1121.5923,1038.6824, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2, 2);
    CreateDynamic3DTextLabel("{FFFFFF}Stokie ant Pickup, kad uzeiti/iseiti", COLOR_GREY, -809.5127, 2799.1362, 1501.9896, 3.0);
    CreateDynamic3DTextLabel("Laukas\n{9EFA93}Paspauskite ALT, kad atidaryti vartus",COLOR_WHITE,-2052.71, -106.53, 36.00,4.0);
    CreateDynamic3DTextLabel("Vairavimo mokyklos kiemas\n{9EFA93}Paspauskite ALT, kad atidaryti vartus",COLOR_WHITE,-2052.90, -98.77, 36.00,4.0);
	CreateDynamic3DTextLabel("Ausines, reikia uzsideti pries saudyma!\n{4DB33D}Paspauskite: {FFFFFF}ALT", COLOR_GREY, 286.1845, -24.4473, 1001.5156, 3.0);
	CreateDynamic3DTextLabel("Isejimas is saudymo vietos\n{D0C857}Paspauskite: ALT", -1, 286.08, -29.09, 1001.52, 3.0);
	CreateDynamic3DTextLabel("Saudykla\nIejimo kaina be leidimo i tira: {4DB33D}500${FFFFFF}\n[{D0C857}Ginklus galima isigyti viduje!{FFFFFF}]\n{4DB33D}Paspauskite: {FFFFFF}ALT", -1, 286.17, -30.55, 1001.52, 3.0);
	CreateDynamic3DTextLabel("Numeriu gavimas\nPaspauskite: ALT.\nKaina: {DA5D40}nuo 5 000$.", -1, -463.0094, 2214.2625, 1601.0859, 3.0);
	CreateDynamic3DTextLabel("Komercijos skyrius\n{FFFFFF}ALT",COLOR_GREEN,363.6908,153.9987,1025.7964,3.0);
	CreateDynamic3DTextLabel("Nekilnomojo turto skyrius\n{FFFFFF}ALT",COLOR_GREEN,354.0459,170.0928,1025.7964,3.0);
    CreateDynamic3DTextLabel("Renginiu valdymas\n{FFFFFF}ALT",COLOR_GREEN,-569.7514,2567.4849,1702.5029,3.0);
	CreateDynamic3DTextLabel("Aksesuaru parduotuve\n{FFFFFF}ALT",COLOR_GREEN,-398.3770,2229.9397,1801.0859,3.0);
	CreateDynamic3DTextLabel("Automatas su nemokamu maistu\n{FFFFFF}ALT",COLOR_GREEN,-1349.3528,493.8062,11.1953,3.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,1764.0288,-1949.8785,14.1096,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,1735.7333,-1949.3246,14.1172,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,1706.7789,-1949.6328,14.1172,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,2860.3655,1319.2699,11.4040,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,2860.4666,1287.9838,11.4040,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,2860.2236,1256.3748,11.4040,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,-1951.4111,107.9894,26.2813,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,-1950.6516,134.5126,26.2813,20.0);
    CreateDynamic3DTextLabel("Gelezinkelio platforma\n{FFFFFF}Kad ilipti i traukini spauskite 'G'",COLOR_OLDRED,-1949.6737,165.9387,26.2813,20.0);
	CreateDynamic3DTextLabel(!"Walter\n{FFFFFF}Noredami pasikalbeti paspauskite ALT",COLOR_VALIK,-38.4478,1180.5905,19.3594,10.0);
	CreateDynamic3DTextLabel("Darvin\nKaukoliu kolekcioneris\n{FFFFFF}Pasikalbeti: ALT\nParduotuve moto-prekiu: Spauskite ALT!", COLOR_VALIK, -2201.2429,-2340.7310,30.6250,5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0,0, -1, -1);
	CreateDynamic3DTextLabel("Martin\n( Renginys: Rinkejai )\nSpauskite: {ffffff}ALT",COLOR_VALIK,-2263.4514,177.9965,35.3056,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, -1, -1);
	CreateDynamic3DTextLabel("Larry\n{73B461}Pasikalbeti: {FFFFFF}ALT", -1, 523.8312, 848.2282, -42.9189, 5.0);
	CreateDynamic3DTextLabel("Emilio\n{73B461}Pasikalbeti: {FFFFFF}ALT", -1, -256.7696, -1362.8536, 9.4421, 5.0);
    CreateDynamic3DTextLabel("Nathon\n{73B461}Paspauskite: {FFFFFF}ALT\nSeimos gidas", -1, 1800.4841, 409.9243, 20.2294, 5.0);
	CreateDynamic3DTextLabel("Michael\n{FFFFFF}Noredami pasikalbeti spauskite ALT\n\n{94B0C1}Quest Personazas",COLOR_VALIK,1324.0098,287.2829,20.0452,10.0);
	CreateDynamic3DTextLabel("Mikrofonas\n{FFFFFF}[Ijungtas]",COLOR_VALIK,-575.7592,2568.7976,1702.5029,5.0);
	CreateDynamic3DTextLabel("Edward ( Dovanu pardavejas )\n( Pilieciu kuponu supirkejas )\n{FFFFFF}Noredami pasikalbeti paspauskite ALT",COLOR_VALIK,1420.4176,-1685.8624,13.5469,15.0);
	CreateDynamic3DTextLabel(!"Mindaugas ( padejejas )\n{FFFFFF}Noredami pasikalbeti paspauskite ALT", COLOR_VALIK, 1544.0896, 1272.6919, 10.8475, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 5, 240);
	CreateDynamic3DTextLabel("DEMORGAN: - Kalejimas sukciams ir RP proceso pazeidejams.\nKad is jos isetumete, laukite, kol laikas pasibaigs.\nUz siuos pazeidimus jus gali uzblokuoti.\n{E66E6E}Jusu pase prideta nauja pastaba.", COLOR_GREY, -803.2662, 2833.1062, 1501.9896, 25.0);
	CreateDynamic3DTextLabel("Tomas\n{FFFFFF}Noredami pasikalbeti paspauskite ALT\n\n{94B0C1}Quest Personazas",COLOR_VALIK,1773.6903,-1891.7493,13.5504,15.0);
	CreateDynamic3DTextLabel("Federiko\n{FFFFFF}Noredami pasikalbeti paspauskite ALT\n\n{94B0C1}Quest Personazas",COLOR_VALIK,1163.6832,-1754.9606,13.6180,15.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,154.3891,1903.3417,18.7570,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,141.1707,1875.4081,17.8434,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,115.3891,1875.2244,17.8359,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,117.9125,1871.2745,17.8359,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,137.3782,1879.5315,17.8359,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,202.5459,1861.9189,13.1406,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,193.3672,1931.5112,17.6406,3.0);
    CreateDynamic3DTextLabel("Nemokama licencija",COLOR_GREY,-2034.2344,-114.1020,1035.1719,4.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,-1325.6866,476.3579,7.8498,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,-1294.9114,491.5177,11.1953,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,-1291.1442,501.8154,11.1953,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,-1397.9807,502.8033,11.3047,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,2798.11, -2393.91, 13.96,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,2743.82, -2453.84, 13.86,3.0);
    CreateDynamic3DTextLabel("Ingridientu sandelis\n[ALT]",COLOR_GREY,2782.68, -2372.74, 13.63,3.0);
	
	
	CreateDynamic3DTextLabel("Skelbimu redagavimo kompiuteris\n{73B461}[ALT]",-1, 1505.3684, 1952.8701, 1026.0831,2.0);
	CreateDynamic3DTextLabel("Skelbimu redagavimo kompiuteris\n{73B461}[ALT]",-1, 1504.3041, 1956.0002, 1026.0831,2.0);
	CreateDynamic3DTextLabel("Skelbimu redagavimo kompiuteris\n{73B461}[ALT]",-1, 1507.5175, 1959.9749, 1026.0831,2.0);
	CreateDynamic3DTextLabel("Skelbimu redagavimo kompiuteris\n{73B461}[ALT]",-1, 1504.7140, 1963.3849, 1026.0831,2.0);
	CreateDynamic3DTextLabel("Skelbimu redagavimo kompiuteris\n{73B461}[ALT]",-1, 1498.5887, 1962.5647, 1026.0851,2.0);
	CreateDynamic3DTextLabel("Skelbimu redagavimo kompiuteris\n{73B461}[ALT]",-1, 1495.9590, 1965.6743, 1026.0851,2.0);
	
	CreateDynamic3DTextLabel("INFO",-1,-38.9923,173.5192,2.4297,7.0);
	CreateDynamic3DTextLabel("INFO",-1,-83.2843,-302.1633,2.7646,7.0);
	CreateDynamic3DTextLabel("INFO",-1,1969.3076,-1981.4128,13.5469,7.0);
	CreateDynamic3DTextLabel("INFO",-1,1460.8505,-1743.3596,13.5469,7.0);
	CreateDynamic3DTextLabel("Gavimas banko-korteles\n{B03131}Reikia tureti 1 000$",-1,494.7682,1318.9098,774.4839,4.0);
	CreateDynamic3DTextLabel("Gavimas banko-korteles\n{B03131}Reikia tureti 1 500$",-1,951.6823,2451.9871,1601.9871,4.0);
    CreateDynamic3DTextLabel("Skolininkai",-1,-2657.75, 808.67, 1500.97,7.0);

	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1520.6713,1274.9663,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1520.6670,1272.5221,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1517.1656,1272.4816,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1517.1669,1275.0220,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1517.1661,1278.5099,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1517.1660,1281.0385,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1520.6711,1280.9509,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Pradeti laikyti vairavimo egzamina\n{F9AD43}ALT", COLOR_WHITE, 1520.6713,1278.5593,10.8455, 4.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	//Create3DTextLabel("{C5FF46}Ëó÷øèå ñîòðóäíèêè:{FFFFFF}\n- Robert_Werner\n Nikita_Bogdanovich\n Domenic_Clemence\n Leonardo_Nelson\n Philip_Morris\n\n{C5FF46}Ëó÷øèå ñîòðóäíèêè ñåãîäíÿ:{FFFFFF}\n- Domenic_Clemence\n Robert_Werner\n Philip_Morris\n Nikita_Bogdanovich\n Leonardo_Nelson\n", 0xFFFFFFFF, 1539.8573, 1282.6978, 11.8475, 9.0000, 0, 1);
    CreateDynamic3DTextLabel("Labdaros fondas\n[ALT]",COLOR_GOLD,2096.8794,797.0545,1027.1211,4.0);
	CreateDynamic3DTextLabel("Eiti i pokalbi\n[ALT]",COLOR_GOLD,-2033.4341,-117.5292,1035.1719,4.0);
	CreateDynamic3DTextLabel("Sugedes televizorius.\nJei jis veiktu, galetumete perskaityti pagrindine piloto teorija.",COLOR_GREY,-2026.7957,-114.3428,1035.1719,4.0);
	CreateDynamic3DTextLabel("Press Alt",COLOR_BLUENEW,-2512.0083,-649.9902,1331.6420,2.0);
    CreateDynamic3DTextLabel("Baznycia\nNoredami susituokti, jums reikia savivaldybes darbuotojo\nReikia isigyti ziedus /gps - Svarbios vietos - Ziedu pirkimas\nIssiskirimui iveskite [/unwedding (4 000$!)]",COLOR_GOLD,2363.9543,-1958.5900,1601.0859,10.0);
    CreateDynamic3DTextLabel("Generalinis biuras\nMokesciu tarnyba",COLOR_BLUENEW,1530.7826,-1074.1027,25.0625,10.0);
	CreateDynamic3DTextLabel(!"Rubine\nALT",COLOR_BLUENEW,200.7409,-244.7211,1.5713,8.0);
	CreateDynamic3DTextLabel(!"Rubine\nALT",COLOR_BLUENEW,-312.7885,1191.2400,19.7613,8.0);
    CreateDynamic3DTextLabel("Atlyginimas\n{FFFFFF}ALT",COLOR_ORANGE, 26.1645, 2233.7747, 1501.6503, 8.0);
	CreateDynamic3DTextLabel("Rubine\n{FFFFFF}ALT",COLOR_ORANGE,33.8607,2232.1184,1501.6503,8.0);
    CreateDynamic3DTextLabel("Darbo rinkimas",COLOR_BLUENEW,208.4846,-225.6056,1.7749,8.0);
    CreateDynamic3DTextLabel("Darbo rinkimas",COLOR_BLUENEW,2111.5618,894.6057,10.9149,8.0);
	CreateDynamic3DTextLabel("Rubine\nALT",COLOR_BLUENEW,770.8220,-77.3209,1000.6563,8.0);
	CreateDynamic3DTextLabel("Rubine\nALT",COLOR_BLUENEW,681.4680,-1652.4188,871.2896,8.0);
	CreateDynamic3DTextLabel("Paspauskite N",COLOR_BLUENEW,2042.6489,-1958.4153,14.3989,2.0);
	CreateDynamic3DTextLabel("Paspauskite N",COLOR_BLUENEW,2033.5723,-1958.2524,14.3989,2.0);
    CreateDynamic3DTextLabel("KET\n{73B461}Paspauskite ALT, kad perskaityti.",COLOR_WHITE, 1514.1516, 1276.8065, 10.8455 , 5.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel("Vestuviu ziedu\npirkimas",COLOR_GOLD,2520.0012,918.5114,11.0234,5.0);
	CreateDynamic3DTextLabel("Pradeti {99CC00}nemokama {FFFFFF}gydyma.\nPaspauskite: ALT", COLOR_WHITE, 1152.1946,-1303.6064,1019.4307, 3.0);
	CreateDynamic3DTextLabel("Isidarbinimas\ni darba\n{FF6347}ukininko!", -1, -77.9217,90.3327,3.1172+0.5, 3.0);
	CreateDynamic3DTextLabel("Mokymo kursas\n{FFFFFF}ALT",COLOR_GREEN,1773.2142, -1888.9938, 13.5513,3.0);
	CreateDynamic3DTextLabel("Mokymo kursas\n{FFFFFF}ALT",COLOR_GREEN,2210.1968,-1149.0828,25.7458, 3.0);
	CreateDynamic3DTextLabel("Mokymo kursas\n{FFFFFF}ALT",COLOR_GREEN,1144.9585,-1751.9170,13.5861, 3.0);
	CreateDynamic3DTextLabel("Pradeti {99CC00}nemokama {FFFFFF}gydyma.\nPaspauskite: ALT!", COLOR_WHITE, -1324.4010, 9.3590, 1601.0859 + 0.7, 3.0);
	CreateDynamic3DTextLabel("Pasikelti i 2 auksta\n{73B461}Naudokite: {FFFFFF}ALT", COLOR_WHITE, -1769.3776, -2019.0920, 1500.7853 + 1.0, 3.0);
	CreateDynamic3DTextLabel("Nusileisti i 1 auksta\n{73B461}Naudokite: {FFFFFF}ALT", COLOR_WHITE, -1312.6182, 20.8936, 1597.6073 + 1.0, 3.0);
	CreateDynamic3DTextLabel("Laiptai i {99CC00}1 {FFFFFF}auksta.", COLOR_WHITE, -1317.3761, 12.1050, 1601.0859 + 2.2, 3.0);
	
	CreateDynamic3DTextLabel("Informacija {99CC00}lankytojams {FFFFFF}ligonineje.\nPaspauskite: ALT", COLOR_WHITE, 1152.1932,-1305.5453,1019.4307, 3.0);
	CreateDynamic3DTextLabel(!"Praeiti kursa {99CC00}greitos{FFFFFF} reabilitacijos\nPaspauskite: ALT!", 0xFFFFFFFF, 1148.6715, -1308.8401, 1019.4266, 4.0000);
	CreateDynamic3DTextLabel(!"[ Informacija apie salono darba ]\n{cccccc}Paspauskite ALT", 0xFFFFFFFF, 2571.3157, 978.1287, 10.9932, 7.5000);

	CreateDynamic3DTextLabel("Siuoliai su parasiutu\n{FFFFFF}ALT", COLOR_GREY, 1451.6128, -2285.0105, 13.5469, 5.0);
	CreateDynamic3DTextLabel("Siuoliai su parasiutu\n{FFFFFF}ALT", COLOR_GREY, 1673.0103, 1447.5935, 10.7867, 5.0);
	CreateDynamic3DTextLabel("Siuoliai su parasiutu\n{FFFFFF}ALT", COLOR_GREY, -1409.4084, -298.2005, 14.1484, 5.0);
	CreateDynamic3DTextLabel("Studija: 'SAG SHOW'\n{FFFFFF}ALT", COLOR_GREY, 2154.7354, 1493.4109, 10.8203, 5.0);
	CreateDynamic3DTextLabel("Amunicija\nNaudokite: ALT", -1, 295.20001220703, -38.299999237061, 1001.5, 10.0);
	CreateDynamic3DTextLabel("Geliu {99CC00}pirkimas\n{FFFFFF}Kaina: {99CC00}1200$", -1, 2350.7820,-1961.5228,1601.0859, 10.0);
	CreateDynamic3DTextLabel("Kasa\n{FFFFFF}ALT", COLOR_VALIK, 665.9590, -567.7969, 1700.7394, 10.0);
	CreateDynamic3DTextLabel("Ieiti namo\n{FFFFFF}ALT", COLOR_GREY, 1079.0709, 937.4053, 1604.8663, 5.0);
	CreateDynamic3DTextLabel("Norint naudotis stalu\n{FFFFFF}Paspauskite ALT", COLOR_VALIK, 1089.8132,949.3330,1600.9935, 10.0);
	CreateDynamic3DTextLabel("Ekonomikos valdymas.\n{FFFFFF}ALT", COLOR_GREEN, 2000.4484, 1139.0625, 1039.6882, 3.0);
	CreateDynamic3DTextLabel("Avarinis isejimas\n{FFFFFF}ALT", COLOR_GREY, 954.2499,1054.3884,1059.8274+1.0, 5.0);
	CreateDynamic3DTextLabel("Avarinis iejimas\n{FFFFFF}ALT", COLOR_GREY, -2064.8579,2709.9797,1500.9766+1.0, 5.0);
	CreateDynamic3DTextLabel(" Baras",COLOR_WHITE,784.6830, 2514.6926, 1501.9751,7.0);
	CreateDynamic3DTextLabel(" Baras",COLOR_WHITE,461.3756,209.5736,3194.6460,7.0);
	CreateDynamic3DTextLabel(" Baras",COLOR_WHITE,-2653.8188,1407.3539,906.2734,20.0);
	CreateDynamic3DTextLabel(" Baras",COLOR_WHITE,499.7772,-20.6834,1000.6797,20.0);
	CreateDynamic3DTextLabel(" Baras",COLOR_WHITE,497.4280,-75.7883,998.7578,20.0);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,-2683.9232, 807.4161, 1500.9094,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,-2676.5600, 807.4161, 1500.9094,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,-2669.0400, 807.4161, 1500.9094,5);
    CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,-2666.4729, 805.8691, 1500.9094,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,-2666.4665, 799.2879, 1500.9094,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,495.2409,1305.6490,774.4839,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,495.2459,1307.4744,774.4839,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,495.2454,1309.2797,774.4839,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,495.2461,1311.0074,774.4839,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,495.2460,1312.8225,774.4839,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,951.8005,2458.6746,1601.9771,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,954.9710,2463.5288,1601.9771,5);
	CreateDynamic3DTextLabel("{73B461}Kasa\n{FFFFFF}N",COLOR_GREY,946.6893,2456.3723,1601.9771,5);

	CreateDynamic3DTextLabel(!"Atrakinti\n\n{FFFFFF}H", COLOR_ORANGE, 1543.5601,1295.8645,10.8475, 3.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel(!"Atrakinti\n\n{FFFFFF}H", COLOR_ORANGE, 1538.9166,1297.3892,10.8475, 3.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel(!"Atrakinti\n\n{FFFFFF}H", COLOR_ORANGE, 1535.6758,1273.4945,10.8475, 3.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);
	CreateDynamic3DTextLabel(!"Atrakinti\n\n{FFFFFF}H", COLOR_ORANGE, 1526.1323,1273.5967,10.8455, 3.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 5, 240);

	CreateDynamic3DTextLabel(!"{FFFFFF}Anthony\n{73B461}Paspauskite: {FFFFFF}ALT{73B461}\n{FFFFFF}parduotuves darbuotojas", 0x73B461FF, 822.1429, 3.1134, 1004.1797, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 3, 3); // Bot lotyreika
	CreateDynamic3DTextLabel(!"Laimetojai {99CC00}praeito{FFFFFF} burto:\n\n\n-\n-\n-\n-\n-", 0xFFFFFFFF, 822.0134, 6.8913, 1005.1797, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 3, 3);
	
	CreateDynamic3DTextLabel(" Uzkandine \n\n{9ACD32}Stokite prie CheckPoint, kad uzkastumete", COLOR_WHITE, 1082.0736, 992.7753, 1600.9989, 20.0);
	CreateDynamic3DTextLabel("Maisto automatas",COLOR_WHITE,-171.1462,1334.3427,1500.9788,20.0);
	CreateDynamic3DTextLabel("Maisto automatas",COLOR_WHITE,1484.8135,-1771.4929,18.7929,20.0);
	CreateDynamic3DTextLabel("Maisto automatas", COLOR_WHITE, -1322.6569, 20.1318, 1601.0859, 20.0);
	CreateDynamic3DTextLabel("Maisto automatas",COLOR_WHITE,1484.8135,-1771.4929,18.7929,20.0);
	CreateDynamic3DTextLabel("Bufetas", COLOR_WHITE, -2039.4053,2673.7039,1500.9670,20.0);
	CreateDynamic3DTextLabel("Maisto automatas", COLOR_WHITE, -2581.7578, -1370.5360, 1501, 20.0);
	CreateDynamic3DTextLabel("Bufetas", COLOR_WHITE, 1146.9917,-1543.7808,1010.2957,20.0);
	CreateDynamic3DTextLabel("Maisto automatas", 0xFFFFFFFF, -461.4114, 2207.2622, 1600.3859, 5.0);
	CreateDynamic3DTextLabel(!"Maisto automatas", 0xFFFFFFFF, 1544.7767, 1287.2882, 10.8475, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 5, 240);
	CreateDynamic3DTextLabel("Ligonines {9ACD32}Valgykla\n{FFFFFF}Paspauskite: {9ACD32}ALT",COLOR_WHITE,1120.5518,-1311.0817,1019.4119, 5.0);
	CreateDynamic3DTextLabel("Isejimas i {9ACD32}Ligonine\n{FFFFFF}Paspauskite: {9ACD32}ALT",COLOR_WHITE,1123.9635,-1533.5908,1010.2963, 5.0);
	CreateDynamic3DTextLabel("Bankas Los Santos {33AA33}[Atrakintas]\n{FFFFFF}Stokite ant Pickup, kad uzeitumete",COLOR_WHITE,1481.055,-1772.040,18.796, 5.0);
	CreateDynamic3DTextLabel("Stokite ant Pickup, kad iseitumete", COLOR_WHITE, -2168.3958,-928.2313,1701.0859, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	CreateDynamic3DTextLabel(" Picos atsiemimo punktas ",0xD05050FF,670.8947,-1575.9595,14.2514,4.0);
	CreateDynamic3DTextLabel(" Picos atsiemimo punktas ",0xD05050FF,1752.4005,2214.5081,10.8203,4.0);
	CreateDynamic3DTextLabel(" Isidarbinimas \n Darbas: Picos Pristatytojas\n[ALT] ",COLOR_WHITE,1746.6765,2246.2012,10.8203,4.0);
	CreateDynamic3DTextLabel(" Isidarbinimas \n Darbas: Picos Pristatytojas\n[ALT] ",COLOR_WHITE,665.9875,-1576.6426,14.4777,4.0);
	CreateDynamic3DTextLabel(" Rubine \n Darbas: Picos Pristatytojas\n[ALT] ",COLOR_WHITE,1749.0339,2246.2012,10.8203,4.0);
	CreateDynamic3DTextLabel(" Rubine \n Darbas: Picos Pristatytojas\n[ALT] ",COLOR_WHITE,668.0192,-1576.7659,14.4074,4.0);
	CreateDynamic3DTextLabel(" Rubine \n\n{FFFFFF}Stokite ant Pickup, kad persirenkti", COLOR_LIME, 2568.0,-1281.5,1044.12, 7.0);
	CreateDynamic3DTextLabel("Valgykla\nALT",COLOR_WHITE,589.6020,1420.4148,1900.7980,4.0);
	CreateDynamic3DTextLabel(" Rubine \n\n{FFFFFF}Inkasuotojo darbas",COLOR_LIME,-2678.46851, 796.50763, 1501.0,7.0);
	CreateDynamic3DTextLabel(" Rubine \n\n{FFFFFF}Inkasuotojo darbas",COLOR_LIME,498.1447,1318.5439,774.4839,3.0);
	CreateDynamic3DTextLabel(" Rubine \n\n{FFFFFF}Inkasuotojo darbas",COLOR_LIME,948.5161,2447.8325,1601.9871,3.0);
	CreateDynamic3DTextLabel("Nuteistuju sarasas",COLOR_WHITE,1550.7634,-1681.3251,13.5540,5.0);
	CreateDynamic3DTextLabel("Isidarbinimas\n{FFFFFF}Paspauskite: ALT",COLOR_VALIK, 2093.2317,797.1243,1027.1211,5.0);
	CreateDynamic3DTextLabel("{AFAFAF}Suspaustas transportas\nPaspauskite ALT metalo iskrovimui!", COLOR_GREY, 2224.5222, -2461.0154, 13.4466, 20.0);
	CreateDynamic3DTextLabel("Suspaustas transportas\nPaspauskite ALT metalo iskrovimui!", COLOR_WHITE, 1124.2776,1962.4742,10.8203, 20.0);
	CreateDynamic3DTextLabel(" Rubine \n[ALT] ",COLOR_WHITE,1907.0087,153.0604,17.5156,10.0);
	CreateDynamic3DTextLabel(" Rubine \n[ALT] ",COLOR_WHITE,1980.1283,-1968.4868,13.5825,4.0);
    CreateDynamic3DTextLabel(" Isidarbinimas \n Darbas: Krovejas\n[ALT] ",COLOR_WHITE,1979.9426,-1971.1410,13.5825,4.0);
    CreateDynamic3DTextLabel("Prisipazinimas",COLOR_WHITE,-463.8202, 2216.9792, 1601.0859,5.0);
	CreateDynamic3DTextLabel("Prisipazinimas",-1, -955.6700,-2358.0708,1701.0859, 5.0);
	CreateDynamic3DTextLabel(!"Saldytuvas {9ACD32}Stabo bustine{FFFFFF} seimos.\nPaspauskite: ALT!",COLOR_WHITE,-1505.3368,2718.4871,1500.9674,3.0);
    CreateDynamic3DTextLabel(!"Pradeti dalijimasi {9ACD32}skurdu gyvenantiems\n{FFFFFF}Paspauskite: {9ACD32}ALT",COLOR_WHITE,2108.4653,789.9943,1027.1191,3.0);
	CreateDynamic3DTextLabel("Siukslynas Las-Venturas", COLOR_GREY,111.0156,1073.1621,13.6094, 20.0);
	CreateDynamic3DTextLabel("Siukslynas Los Santos", COLOR_GREY,2180.7395,-1990.5044,13.5469, 20.0);
	CreateDynamic3DTextLabel("Siukslynas San Fierro", COLOR_GREY,-1867.2306,-1669.6919,21.7500, 20.0);
	CreateDynamic3DTextLabel("Apsauga\nPaspauskite: {FFFFFF}ALT",COLOR_VALIK,644.0786,-1365.4963,13.6142,10.0);
	CreateDynamic3DTextLabel("Magnus ( Menedzeris )\n{FFFFFF}Noredami pasikalbeti paspauskite ALT",COLOR_VALIK,-1746.7738,156.5982,3.5547,10.0);
	CreateDynamic3DTextLabel("Rage ( Sokiu treneris )\n{FFFFFF}Noredami pasikalbeti paspauskite ALT",COLOR_VALIK,1756.8765,-315.1113,1654.5055, 5.0);
	CreateDynamic3DTextLabel("Sokiu mokykla\n{FFFFFF}ALT",0xAFAFAFFF,1754.9205,-316.1614,1654.5055+1, 5.0);
	CreateDynamic3DTextLabel(!"Rubine\n{0c9ea8}[ {FFFFFF}ALT{0c9ea8} ]",-1,-2362.8149,1256.1603,1505.3315,5.0);
	CreateDynamic3DTextLabel("Sandelis\n[ 99999 detaliu ]\n\n{0c9ea8}[ {FFFFFF}ALT{0c9ea8} ]",0xFFFFFFFF,-2370.1978,1259.9980,1500.9833, 5.0);
	CreateDynamic3DTextLabel("Sandelis\n[ 99999 detaliu ]\n\n{0c9ea8}[ {FFFFFF}ALT{0c9ea8} ]",0xFFFFFFFF,-2391.0803,1259.9084,1500.9833, 5.0);
	CreateDynamic3DTextLabel("Parasyti skunda\n{FFFFFF}ALT",COLOR_GREY,1479.8547,-1272.7500,113.8064+1, 2.5);
	CreateDynamic3DTextLabel("Statybine {9ACD32}informacija{FFFFFF}\nPaspauskite: {9ACD32}ALT", -1, 1471.9293, -1268.2134, 114.8103, 6.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel(!"[ {ffffff}Ukio konsultantas{31B404}]\n{cccccc}Paspauskite ALT", 0x31B404FF, 1471.7279, -1271.7294, 113.8103, 4.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Perplanavimas\n[ALT]",COLOR_GREY,1478.9402,-1266.6340,113.8103+1, 2.5);
	CreateDynamic3DTextLabel(!"{FF0000}|{FFFFFF} Skaicius ir Herbas {FF0000}|\n\n{FFFFFF}/herbas [ID] [suma]\n\narba\n\n{FFFFFF}/skaicius [ID] [suma]",COLOR_GREY,493.8146,-17.6045,1001.1519,25.0);
	CreateDynamic3DTextLabel(!"Nusipirkti vaizdo plokste\n\n{cccccc}Paspauskite ALT", 0xFFFF00FF, 1384.2760, -21.8199, 1000.9229, 10.0);
	CreateDynamic3DTextLabel(!"Pasirinkti transporta Test-Drive\n\n{ffffff}[ Paspauskite ALT ]", 0x73B461FF, -1658.7089, 1210.1034, 7.2500, 10.0000,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	
	CreateDynamic3DTextLabel(!"Maksim ( Baldu pardavejas )\n{FFFFFF}Norint perziureti asortimenta paspauskite ALT", COLOR_VALIK, -413.8500, 684.7383, 1601.9966, 20.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 152); // x

	CreateDynamic3DTextLabel(!"Guramas\nNeteiseto supirkejas\n{FFFFFF}Noredami pasikalbeti, paspauskite ALT", 0x73B461FF, 2530.6060, -1475.0999, 23.9788, 15.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	CreateDynamic3DTextLabel(!"Vladislav\nAndrejo draugas\nQuest Personazas\n{FFFFFF}Noredami pasikalbeti, paspauskite ALT", 0x73B461FF, 2507.7012, -1471.6755, 24.0371, 15.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	CreateDynamic3DTextLabel(!"Juodasis turgus\n\n{ffffff}[ ALT ]", 0xFA5858FF, 2534.8040, -1472.6917, 24.0019, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	CreateDynamic3DTextLabel(!"Dede Edgar\n\n{ffffff}Noredami parduoti preke, paspauskite ALT", 0x31B404FF, -142.1987, -219.7431, 1.4219, 8.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);

	CreateDynamic3DTextLabel(!"[ {ffffff}Isejimas{31B404}]\n{cccccc}Paspauskite ALT", 0x31B404FF, 728.5142, 1799.5854, 1602.0048, 4.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 1);
	CreateDynamic3DTextLabel(!"[ {ffffff}Darbas ukyje{31B404}]\n{cccccc}ALT", 0x31B404FF, 731.2545, 1799.9625, 1602.0048, 4.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 1);
	CreateDynamic3DTextLabel(!"[ {ffffff}Ukio valdymas{31B404}]\n{cccccc}ALT", 0x31B404FF, 733.0480, 1796.6510, 1602.0048, 4.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 1);
	CreateDynamic3DTextLabel(!"{ffffff}Maisto automatas\n{FE9A2E}[ {ffffff}ALT {FE9A2E}]", 0xFFFFFFFF, 729.0327, 1804.6787, 1601.3596, 4.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 1);
	
	CreateDynamic3DTextLabel(!"Valdymas Second-Hand\n{cccccc}(savininkams)\n\n{ffffff}[ Paspauskite ALT ]", 0x73B461FF, 1529.6951, 1576.1597, 10.9252, 3.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 30);
	
	CreateDynamic3DTextLabel(!"Liftas\n\n{cccccc}[ Paspauskite ALT ]", -1, 1539.0739,1964.0602,1020.9574, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 158);
	CreateDynamic3DTextLabel(!"Liftas\n\n{cccccc}[ Paspauskite ALT ]", -1, 2131.1404,2495.9873,1024.9802, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 157);
	CreateDynamic3DTextLabel(!"Pateikti skelbima\n{73B461}Naudokite: /ad", COLOR_WHITE, 1538.2813,1951.8353,1020.9574, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 158);
	
	CreateDynamic3DTextLabel(!"{FFFFFF}Daniel\n{73B461}Paspauskite: {FFFFFF}ALT{73B461}\n{FFFFFF}Seimos gidas", 0x73B461FF, 2464.3484, 2244.9761, 10.8203, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	CreateDynamic3DTextLabel(!"{FFFFFF}Edvin\n{73B461}Paspauskite: {FFFFFF}ALT{73B461}\n{FFFFFF}Seimos gidas", 0x73B461FF, -2053.0842, 460.5180, 35.1719, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	
	CreateDynamic3DTextLabel(!"[ Baras ]\nPaspauskite ALT", 0xAFAFAFFF, 333.5765, -1813.9194, 4.6678, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0); // AUKCION BARAS
	CreateDynamic3DTextLabel(!"[ Automobiliu aukcionas ]\nPaspauskite ALT", 0xAFAFAFFF, 334.1906, -1806.6876, 4.5385, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0); // AUKCIONAS

//	CreateDynamic3DTextLabel(!"Nemokamas pilnas licenciju komplektas!\n{FFFFFF}Norint naudoti, paspauskite: {42B02C}ALT", 0x42B02CFF, 1777.5724,-1889.3271,13.3875, 15.0);
//	CreateDynamic3DTextLabel(!"Nemokamas pilnas licenciju komplektas!\n{FFFFFF}Norint naudoti, paspauskite: {42B02C}ALT", 0x42B02CFF, 2838.9500,1292.5120,11.3906, 15.0);
//	CreateDynamic3DTextLabel(!"Nemokamas pilnas licenciju komplektas!\n{FFFFFF}Norint naudoti, paspauskite: {42B02C}ALT", 0x42B02CFF, -1996.2001,122.2308,27.6875, 15.0);
//	CreateDynamic3DTextLabel(!"Nemokamas pilnas licenciju komplektas!\n{FFFFFF}Norint naudoti, paspauskite: {42B02C}ALT", 0x42B02CFF, 2227.5225,-1142.9734,25.7969, 15.0);
//	CreateDynamic3DTextLabel(!"Nemokamas pilnas licenciju komplektas!\n{FFFFFF}Norint naudoti, paspauskite: {42B02C}ALT", 0x42B02CFF, 1150.7325,-1747.3101,14.5705, 15.0);
	
	Streamer_SetArrayData(STREAMER_TYPE_3D_TEXT_LABEL, CreateDynamic3DTextLabel(!"Issamiai isnagrineti sistemaû:\n{FFFFFF}/help - Narkotiku sleptuves",COLOR_VALIK, 321.3961,1123.5383,1083.8828,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 5), E_STREAMER_WORLD_ID, {1,2,3,4,5});

	/*CASINO*/
	CreateDynamic3DTextLabel("Keitykla.\nZaidimu zetonu pirkimas.\n\nPaspauskite: {FFFFFF}ALT", 0x73B461FF, 2235.3030, -824.5659, 1407.1273, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Isejimas\nPaspauskite: {FFFFFF}ALT", COLOR_VALIK, 2263.5845, -871.3642, 1407.1273, 8.0);
	CreateDynamic3DTextLabel("Olivia ({F7D83F}1001{FFFFFF})\n\n\n\nNori zaisti kauliukus:\n{F7D83F}/dice 1001 statymas", 0xFFFFFFFF, 2232.5732, -819.6976, 1407.1273, 3.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Taisykles zaidimo {ff704d}«Durnius»\n{FFFFFF}[ ALT ]", 0xFFFFFFFF, 2232.2385, -829.7819, 1407.1273, 3.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("{FFD700}Fortunos ratas\n\n{FFD700}[{ffffff} Noredami sukti rata: ALT {FFD700}]\n\n{cccccc}Sukti fortunos rata galima karta per diena.\nKad sukti rata, reikia prabuti casino 20 minuciu.\n\nPasiekiama slinkimui", 0xFFFFFFFF, 2266.3584, -807.6035, 1407.6224, 10.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Baras", COLOR_WHITE, 2297.6724, -823.6151, 1407.1273, 7.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Stalas kauliuku zaidimams\n{B03131}/dice", 0xFFFFFFFF, 2258.4390, -853.8804, 1406.6176, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Stalas kauliuku zaidimams\n{B03131}/dice", 0xFFFFFFFF, 2272.1606, -846.1528, 1406.6176, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Stalas kauliuku zaidimams\n{B03131}/dice", 0xFFFFFFFF, 2260.5095, -846.1528, 1406.6176, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Stalas kauliuku zaidimams\n{B03131}/dice", 0xFFFFFFFF, 2274.2310, -853.8804, 1406.6176, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);
	CreateDynamic3DTextLabel("Automobilio burtas\n\n{FFFF00}[ {FFFFFF}Informacija: ALT{FFFF00} ]\n\n{cccccc}Automobilis keiciasi po burto", 0xFFFF00FF, 2266.3496, -831.1735, 1406.2732, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 215, -1);

	/*MERIA*/
	CreateDynamic3DTextLabel("Sukurti seima\n\n[ALT]", 0xFFFFFFFFAFAFAFFF, 1507.9591, 1310.1906, 10.9788, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1, 220);
	CreateDynamic3DTextLabel("Papildoma informacija\n{FFFFFF}ALT", 0xFFFFFFFFAFAFAFFF, 1505.8832, 1337.0432, 10.9788, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1, 220);
	CreateDynamic3DTextLabel("Paso gavimas\n{FFFFFF}Paspauskite ALT", 0x73B461FF, 1510.9579, 1360.7517, 10.9738, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1, 220);
	CreateDynamic3DTextLabel("Liftas {99CC00}Savivaldybes{FFFFFF}\nPaspauskite: {99CC00}ALT",-1,1527.5156, 1335.4166, 10.9787, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1, 220);

	/*JARMARKA*/
	CreateDynamic3DTextLabel("Isejimas\n{ffffff}[ ALT ]", 0xFFFFFFFFFFFF00FF, 1528.9264, 1294.5153, 10.9125, 10.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 3, 74);
//	CreateDynamic3DTextLabel("Iejimas i baracholka\n{ffffff}[ ALT ]", 0xFFFFFFFFFFFF00FF, 1952.0476, -2004.0192, 13.5469, 10.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	
	/*Lazybu bendrove*/
	Streamer_SetArrayData(STREAMER_TYPE_3D_TEXT_LABEL, CreateDynamic3DTextLabel(!"[ Lazybu bendrove ]\nPaspauskite ALT", COLOR_VALIK, 1527.8511, 1494.4564, 10.9316, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 5), E_STREAMER_WORLD_ID, {376});
	
	/*Oligarcho skrynia*/
	CreateDynamic3DTextLabel("{FFFF00}Imokos oligarchams\n\n{ffffff}Zaidejas, turintys bent 4 namus,\ngali karta per diena gauti ""Oligarcho skrynia""\n{cccccc}[ Paspauskite ALT ]", -1, -2682.5291, 795.5162, 1501.0259, 5.0); /*Skrynios tekstas*/
	CreateDynamic3DTextLabel("Banko statistika", -1, -2682.5281, 797.1201, 1501.0259, 5.0); /*Tekstas labdarai*/
	
	/*Naujas kaimas*/
	CreateDynamic3DTextLabel(!"Noredami perziureti informacija\npaspauskite ALT", 0x31B404FF, -777.3605, 1312.0341, 13.9709, 5.0000);
	
	/*Auto-Invite*/
	CreateDynamic3DTextLabel(!"{B03131}Auto-invite i organizacija\n{FFFFFF}Noredami saveikatu, paspauskite ALT", 0xFFFFFFFF, -82.8856, 1209.2118, 19.7422, 10.0000);
	CreateDynamic3DTextLabel(!"{B03131}Auto-invite i organizacija\n{FFFFFF}Noredami saveikatu, paspauskite ALT", 0xFFFFFFFF, -1995.5789, 137.5688, 27.6875, 10.0000);
	CreateDynamic3DTextLabel(!"{B03131}Auto-invite i organizacija\n{FFFFFF}Noredami saveikatu, paspauskite ALT", 0xFFFFFFFF, 1773.8164, -1900.8397, 13.5502, 10.0000);
	CreateDynamic3DTextLabel(!"{B03131}Auto-invite i organizacija\n{FFFFFF}Noredami saveikatu, paspauskite ALT", 0xFFFFFFFF, 2823.8813, 1295.2294, 10.7633, 10.0000);
	CreateDynamic3DTextLabel(!"{B03131}Auto-invite i organizacija\n{FFFFFF}Noredami saveikatu, paspauskite ALT", 0xFFFFFFFF, 1157.5122, -1748.6414, 13.5703, 10.0000);

	//sandeliai
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹1\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 2377.8894, -2016.7648, 14.8329, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹2\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 2350.1963, -2094.3875, 13.5469, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹3\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 2154.0161, -2150.4517, 13.5469, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹4\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 1997.0769, -2093.9473, 13.5469, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹5\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 122.8866, -306.2458, 1.5781, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹6\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, -2089.1396, -2262.8438, 30.6532, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹7\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 1706.9139, 1025.9686, 10.8203, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹8\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 1629.3411, 972.2988, 10.8203, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹9\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 1027.1880, 2243.4399, 10.8203, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);
	CreateDynamic3DTextLabel("{54b9d0}Sandelio patalpa ¹10\n\n{FFFFFF}Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 1054.4637, 2099.2351, 10.8203, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1);

	CreateDynamic3DTextLabel("Naudinga informacija", 0xFFFFFFFF, 1534.6024, 1287.8298, 10.9075, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 104, -1);
	CreateDynamic3DTextLabel("Paspauskite ALT, noredami uzeiti", 0xFFFFFFFF, 1534.4894, 1280.9431, 10.9075, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 104, -1);


	return printf("[Filterscript] All Loaded 3D Texts =~ %d/unlimited", Streamer_CountItems(STREAMER_TYPE_3D_TEXT_LABEL, 0));
}

stock CreatePickups()
{
	/*Naujas kaimas*/
	CreateDynamicPickup(1239, 23, -777.3605, 1312.0341, 13.9709, -1);
	
    /*Savivaldybe*/
	CreateDynamicPickup(1239, 23, 1505.8832, 1337.0432, 10.9788, 1, 220);
	CreateDynamicPickup(1581, 23, 1510.9579, 1360.7517, 10.9738, 1, 220);
	
	/*Oligarcho skrynia*/
	CreateDynamicPickup(1239, 1, -2682.5266, 795.5531, 1501.0259, -1); /*Skrynios PickUp*/
	CreateDynamicPickup(1239, 1, -2682.5281, 797.1201, 1501.0259, -1); /*PickUp labdarai*/
	
	CreateDynamicPickup(1239, 23, 1144.9585,-1751.9170,13.5861); // Obuchenyje na novom spavne
	
	CreateDynamicPickup(1239, 1, 333.5760, -1813.9194, 4.6678, 0, 0); // Aukcionas Baras
	CreateDynamicPickup(1239, 1, 334.1906, -1806.6876, 4.5385, 0, 0); // Aukcionas
	
	Streamer_SetArrayData(STREAMER_TYPE_PICKUP, CreateDynamicPickup(1239, 23, 1527.8511, 1494.4564, 10.9316), E_STREAMER_INTERIOR_ID, {200});

	CreateDynamicPickup(1274, 23, 1538.2813,1951.8353,1020.9574, -1, 158);
	
	CreateDynamicPickup(19132, 1, 1539.0739,1964.0602,1020.9574, -1, 158);
	CreateDynamicPickup(19132, 1, 2131.1404,2495.9873,1024.9802, -1, 157);
	
	CreateDynamicPickup(1239, 23, 1384.2760, -21.8199, 1000.9229, -1, 12);
	CreateDynamicPickup(1239, 23, -505.0940, 2597.6277, 53.5557, -1); // Luxe Auto
	CreateDynamicPickup(1239, 1,-97.6769,2344.7224,1507.0781, -1);
	CreateDynamicPickup(1247, 1,-103.9012,2351.7346,1500.9497, -1);
	CreateDynamicPickup(1314, 1,318.6648,2429.7112,1500.9797, -1);
	CreateDynamicPickup(1314, 1, 14.2867,1811.2552,17.7232, -1);
	CreateDynamicPickup(1241, 1, 343.3261,2430.3489,1500.9797, -1);
	CreateDynamicPickup(1239, 1, 2310.7771,72.5220,1501.9962, -1);
	CreateDynamicPickup(1239, 1, 2315.9089,72.5739,1501.9962, -1);
	CreateDynamicPickup(356, 1, -97.6750,2349.3613,1507.0781, -1);
	CreateDynamicPickup(1239, 1, -2106.0000,-2418.8154,30.6250, -1); // salon trailerov, pickup vo dvore
	CreateDynamicPickup(1239, 1, 2354.2742,2829.5762,1500.9688, -1); // Salon trailerov, pickup dlia pokupki
	CreateDynamicPickup(1318, 1, 2352.2026,2841.7737,1501.2664, -1); //Trailer 1 klasa, pickup vhoda
	CreateDynamicPickup(1318, 1, 1334.1860,1261.1288,1501.0850, -1); //Trailer 1 klasa, pickup vihoda
	CreateDynamicPickup(1318, 1, 2346.8303,2859.3630,1501.1156, -1); //Trailer 2 klasa, pickup vhoda
	CreateDynamicPickup(1318, 1, 1313.6605,1262.3265,1501.0850, -1); //Trailer 2 klasa, pickup vihoda
	CreateDynamicPickup(1318, 1, 2352.3911,2855.1179,1501.0981, -1); //Trailer 3 klasa, pickup vhoda
	CreateDynamicPickup(1318, 1, 1290.3165,1260.6007,1501.4446, -1); //Trailer 3 klasa, pickup vihoda
	CreateDynamicPickup(1277, 1, 1810.0848, 2652.6111, 1500.9688); // 5 zvaigzdes
	CreateDynamicPickup(1277, 1, -1029.7727, -641.8089, 1500.9688);
	CreateDynamicPickup(1277, 1, 2020.6329, 2672.6775, 1500.9493);
	CreateDynamicPickup(1274, 1, 2580.1340,1424.8770,1800.9688,-1);
    CreateDynamicPickup(19132,1,2019.32,1007.7,10.8203,-1);//2019.32,1007.7,10.8203
	CreateDynamicPickup(1274, 23, -1064.6395, -1201.0970, 1729.8284, -1, 3);
	CreateDynamicPickup(1314, 23, 1541.3546, 1644.3098, 10.8203, -1, 7);
	CreateDynamicPickup(1274, 23, -1108.2240, -953.4880, 139.0000, -1); // HALLOWEEN
	CreateDynamicPickup(1275, 23, -2092.8953, 505.5473, 1487.6927, -1);
	CreateDynamicPickup(1314, 23, -2102.2109, 506.9873, 1487.6927, -1);
	CreateDynamicPickup(1314, 23, -2102.2109, 512.9057, 1487.6927, -1);
	CreateDynamicPickup(19132, 23, 2628.3110, 1182.9056, 1041.5614, -1);
	CreateDynamicPickup(1239, 23, 1793.6145, -1303.1317, 13.6498, -1);
	CreateDynamicPickup(19132, 23, 1385.7400, -1.6083, 1000.9371, 1, 2); // iejimas is garazo
	CreateDynamicPickup(19132, 23, 1412.5050, -20.0327, 1000.9316, 2, 2);
	CreateDynamicPickup(1239, 23, 516.3721,853.9429,-41.6991, -1);
	CreateDynamicPickup(1239, 23, -250.1954,-1362.3237,9.3948, -1);
	CreateDynamicPickup(1239, 23, 648.5479,-1360.4949,13.5868, -1);
	CreateDynamicPickup(1239, 23, 1864.8735,-1391.1863,13.4907, -1);
    CreateDynamicPickup(1318, 23,649.3248,-1353.8834,13.5470,-1);
    CreateDynamicPickup(1318, 23,-575.709, 2594.2, 1705.09,-1);
    CreateDynamicPickup(1239, 23, 280.4361, -1607.8396, 33.1133, -1);
    CreateDynamicPickup(19902, 23, 1509.3090,1088.1688,1033.8420);
	CreateDynamicPickup(19902, 23, 1489.7209,-1259.8041,113.8044, 2, 0);
	CreateDynamicPickup(19902, 23, 1999.9302,1121.5923,1038.6824, 2, 2);
	CreateDynamicPickup(19132, 1, 1086.9647, 1521.3962, 1716.0868, -1);
	CreateDynamicPickup(1279, 1,-1691.2605,867.8833,1005.0170,-1);
	CreateDynamicPickup(1274, 23, -398.3770,2229.9397,1801.0859,-1);
	CreateDynamicPickup(1559, 1,-2052.71, -106.53, 35.06, -1); //Vairavimo mokykla
	CreateDynamicPickup(1559, 1,-2052.90, -98.77, 34.90, -1); //Vairavimo mokykla
	CreateDynamicPickup(19132, 1, 286.17, -30.55, 1001.52, -1); //tir
	CreateDynamicPickup(19132, 1, 286.08, -29.09, 1001.52, -1); //tir
	CreateDynamicPickup(19422, 1, 286.1845, -24.4473, 1001.5156, -1); //tir
	CreateDynamicPickup(1581, 1, -463.0094, 2214.2625, 1601.0859, -1);
    CreateDynamicPickup(1248, 23, -569.7514,2567.4849,1702.5029,-1);
	CreateDynamicPickup(1314, 23,-2033.4341,-117.5292,1035.1719, -1);
	CreateDynamicPickup(1239, 23,2096.8794,797.0545,1027.1211, -1);
    CreateDynamicPickup(1239, 1,-2657.75, 808.67, 1500.97, -1);
    CreateDynamicPickup(1277,1,951.6823,2451.9871,1601.9871,-1);
	CreateDynamicPickup(1277,1,494.7682,1318.9098,774.4839,-1);
	CreateDynamicPickup(2358,23,154.3891,1903.3417,18.7570, -1);
    CreateDynamicPickup(2358,23,141.1707,1875.4081,17.8434, -1);
    CreateDynamicPickup(2358,23,115.3891,1875.2244,17.8359, -1);
    CreateDynamicPickup(2358,23,117.9125,1871.2745,17.8359, -1);
    CreateDynamicPickup(2358,23,141.1704,1875.4607,17.8434, -1);
    CreateDynamicPickup(2358,23,137.3782,1879.5315,17.8359, -1);
    CreateDynamicPickup(2358,23,202.5459,1861.9189,13.1406, -1);
    CreateDynamicPickup(2358,23,193.3672,1931.5112,17.6406, -1);
 	CreateDynamicPickup(2358,23,2798.11, -2393.91, 13.96, -1);
    CreateDynamicPickup(2358,23,2743.82, -2453.84, 13.86, -1);
    CreateDynamicPickup(2358,23,2782.68, -2372.74, 13.63, -1);
    CreateDynamicPickup(2358,23,-1325.6866,476.3579,7.8498, -1);
    CreateDynamicPickup(2358,23,-1294.9114,491.5177,11.1953, -1);
    CreateDynamicPickup(2358,23,-1291.1442,501.8154,11.1953, -1);
    CreateDynamicPickup(2358,23,-1397.9807,502.8033,11.3047, -1);
	CreateDynamicPickup(1314, 1, -2512.0083,-649.9902,1331.6420,-1);
 	CreateDynamicPickup(1274,23,1979.9426,-1971.1410,13.5825, -1);
    CreateDynamicPickup(1240,1,2363.9543,-1958.5900,1601.0859,-1);
    CreateDynamicPickup(1275,23,200.7409,-244.7211,1.5713, -1);//sporto sale darbas
    CreateDynamicPickup(1275,23,-312.7885,1191.2400,19.7613, -1);//sporto sale darbas
	CreateDynamicPickup(1275,23,195.1261,-228.0334,1.7749, -1);
	CreateDynamicPickup(1550,23,26.1645,2233.7747,1501.6503,-1);
    CreateDynamicPickup(1275,23,33.8607,2232.1184,1501.6503, -1);
    CreateDynamicPickup(1239,23,208.4846,-225.6056,1.7749,-1);
    CreateDynamicPickup(1239,23,2111.5618,894.6057,10.9149,-1);
	CreateDynamicPickup(1275,23,770.8220,-77.3209,1000.6563,-1);
	CreateDynamicPickup(1275,23,681.4680,-1652.4188,871.2896,-1);
	CreateDynamicPickup(19132, 1, 1120.5518,-1311.0817,1019.4119, -1);
    CreateDynamicPickup(19132, 1, 1123.9635,-1533.5908,1010.2963, -1);
	CreateDynamicPickup(1241, 23, 1148.6715, -1308.8401, 1019.4266, -1);
	CreateDynamicPickup(1239, 23, 2571.3157, 978.1287, 10.9932, 0);
	CreateDynamicPickup(1274,23,665.9875,-1576.6426,14.4777,-1);
	CreateDynamicPickup(1274,23,1746.6765,2246.2012,10.8203,-1);
	CreateDynamicPickup(1275, 23, 668.0192,-1576.7659,14.4074, -1);
	CreateDynamicPickup(1275, 23, 1749.0339,2246.2012,10.8203, -1);
	CreateDynamicPickup(2663, 1, 589.6020,1420.4148,1900.7980,-1);
	CreateDynamicPickup(2663, 1, 485.50, 867.03, 1500.96,-1);
	CreateDynamicPickup(2663, 1, -1349.3669,493.8840,11.1953,-1);
	CreateDynamicPickup(1581, 23, -2063.68359, 2663.70068, 1498.62634,-1);
	CreateDynamicPickup(1581, 1,2093.2317,797.1243,1027.1211,-1);
	CreateDynamicPickup(1275, 23, 1907.0087,153.0604,17.5156,-1);
	CreateDynamicPickup(1275, 23, 1980.1283,-1968.4868,13.5825,-1);
	CreateDynamicPickup(1239,23,1754.9205,-316.1614,1654.5055,-1);
	CreateDynamicPickup(1275,23,-2362.8149,1256.1603,1505.3315,-1);
	CreateDynamicPickup(1239,23,-2370.1978,1259.9980,1500.9833,-1);
	CreateDynamicPickup(1239,23,-2391.0803,1259.9084,1500.9833,-1);
	CreateDynamicPickup(1239,23,1479.8547,-1272.7500,113.8064,2);
	CreateDynamicPickup(1314,23,1478.9402,-1266.6340,113.8103,2);
	CreateDynamicPickup(19524, 23, 1471.9293, -1268.2134, 113.8103, 2);
	CreateDynamicPickup(1239, 23, 1471.7279, -1271.7294, 113.8103, 2);
	CreateDynamicPickup(1239,23, 1514.1516, 1276.8065, 10.8455, 5);
	CreateDynamicPickup(1239, 23, -1658.7089, 1210.1034, 7.2500, -1); // pickup nuoma
	CreateDynamicPickup(19197, 1, 861.7285, 678.9048, 11.8915, -1);
	CreateDynamicPickup(1240, 1, 728.4927, 1796.4106, 1602.0048, -1, 1);
	CreateDynamicPickup(1239, 23, 733.0480, 1796.6510, 1602.0048, -1, 1);
	CreateDynamicPickup(1239, 23, 731.2545, 1799.9625, 1602.0048, -1, 1);
	
	CreateDynamicPickup(1239, 23, 1529.6951, 1576.1597, 10.9252, -1, 30); // second
	
	// Avantaz
	CreateDynamicPickup(19133, 23, 1487.6162, 1519.0647, 1601.0859, 10, 207);
	CreateDynamicPickup(19133, 23, 1487.5302, 1519.0012, 1604.6797, 10, 207);
	CreateDynamicPickup(19133, 23, 1487.4905, 1519.0012, 1608.2207, 10, 207);
	CreateDynamicPickup(19133, 23, 1487.4507, 1519.0012, 1611.7803, 10, 207);
	//207,10
	
	// Nemokamas pasas
	CreateDynamicPickup(1581, 23, 1777.5724,-1889.3271,13.3875);
	CreateDynamicPickup(1581, 23, 2838.9500,1292.5120,11.3906);
	CreateDynamicPickup(1581, 23, -1996.2001,122.2308,27.6875);
	CreateDynamicPickup(1581, 23, 2227.5225,-1142.9734,25.7969);
	CreateDynamicPickup(1581, 23, 1150.7325,-1747.3101,13.5705);

	// CP CP Cp
	CreateDynamicCP(199.1063, -128.3574, 1003.5152, 1.0, -1, -1, -1, 10.0);

	//Casino
	CreateDynamicPickup(1239, 23, 2266.3496, -831.1735, 1406.2732, 3, 215);
	CreateDynamicPickup(1274, 23, 2235.3030, -824.5659, 1407.1273, 3, 215);
	CreateDynamicPickup(1239, 23, 2232.2385, -829.7819, 1407.1273, 3, 215);
	CreateDynamicPickup(19132, 1, 2263.5845, -871.3642, 1407.1273, 3, 215);

	return printf("[SEMENENKO Base] Is viso buvo ikelta %d/Unlimited Ïèêàïîâ.", Streamer_CountItems(STREAMER_TYPE_PICKUP, 0));
}

stock CreateMapIcons()
{
	CreateDynamicMapIcon(649.3248,-1353.8834,13.5470, 11, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2019.32,1007.7,10.8203, 44, 0, -1, -1, -1, 300.0);//2019.32,1007.7,10.8203
	CreateDynamicMapIcon(649.3248,-1353.8834,13.5470, 12, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1742.9917,-1943.5721,13.5698, 56, 0); // depo poezd
	CreateDynamicMapIcon(-25.4502, 1859.0801, 17.7132, 11, 0); // tsr
	CreateDynamicMapIcon(42.3079, 1919.1981, 17.6992, 19, 0); // tsr
	CreateDynamicMapIcon(1793.6145, -1303.1317, 13.6498, 38, 0, -1, -1, -1, 300.0); // nauji butai
	CreateDynamicMapIcon(2497.0403,-1670.8518,12.9654, 62, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2786.0085,-1616.5608,10.5467, 60, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2181.1194,-1799.4424,12.9900, 58, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2520.6709,-2010.6217,13.1715, 61, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2352.7537, -2333.7805, 14.6157, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1533.7008,-1014.1130,24.0538, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1199.32, -918.586, 43.1194, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(810.979, -1616.12, 13.5466, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1567.9766,-1897.5547,13.5608, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1367.5504,248.2412,19.5669, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(928.2542,-1352.9023,13.3438, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(611.0340,-585.7634,17.2266, 30, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2103.7222,-1804.7616,13.5547, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1038.2175,-1340.7327,13.7420, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2045.0459,-1908.0321,13.5469, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2456.1079,503.9311,30.0781, 30, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1592.1372,715.8721,-5.2422, 30, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2447.9407,-1962.9333,13.5469, 37, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1177.9343,-1323.6394,14.0952, 22, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1530.7826,-1074.1027,25.0625, 25, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(875.805541, -1565.014892, 13.533462, 6, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(875.805541, -1565.014892, 13.533462, 6, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1495.4197,-1282.6329,14.5525, 19, 0, -1, -1, -1, 300.0);
    CreateDynamicMapIcon(1119.98, -1492.96, 15.80, 56, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2240.7681,577.8632,35.1719, 37, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1879.1533,-860.3239,32.0234, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2143.0383,-930.0509,32.0234, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1545.2085,451.3773,7.0315, 46, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1814.4722,-1995.8588,13.5544, 23, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2286.6912,-2012.8440,13.5447, 23, 0, -1, -1, -1, 300.0);
 	CreateDynamicMapIcon(2333.4478,-1922.6251,12.2991, 23, 0, -1, -1, -1, 300.0);
 	CreateDynamicMapIcon(2175.9934,-1503.9364,23.9520, 23, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1967.2424,296.3922,35.2325, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2579.4302,310.0845,5.1797, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2455.7710,799.5222,35.1797, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1757.8055,964.1265,24.8906, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2487.1482,369.5434,35.1219, 16, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1941.4008,459.7771,35.1719, 12, 0, -1, -1, -1, 300.0);
    CreateDynamicMapIcon(2473.1699,-1422.2638,28.8397, 39, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2335.8118,-166.6666,35.5547, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1816.6819,617.5771,35.1719, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1721.5256,1359.8145,7.1853, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2356.4548,1008.1873,50.8984, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2443.8538,755.4180,35.1719, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2767.5112,788.7203,52.7813, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2672.2603,258.4307,4.6328, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1808.6821,945.9444,24.8906, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2155.2847,-2460.1235,30.8516, 10, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1694.5833,951.9144,24.8906, 45, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2718.4712,50.4521,4.3359, 45, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2241.7515,123.0408,35.3203, 45, 0, -1, -1, -1, 300.0);
	//CreateDynamicMapIcon(1309.8182,-1371.0112,13.5826, 18, 0, -1, -1, -1, 300.0); // pometka
	CreateDynamicMapIcon(667.8604, -1571.3179, 15.2623, 29, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1746.7703, 2227.1057, 11.2029, 29, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2102.4863,2257.4006,11.0234, 45, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2802.8872,2430.6565,11.0625, 45, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(172.3484,1177.6282,14.7578, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2884.5476,2454.0398,11.0690, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2638.3013,1671.8616,11.0234, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2101.8923,2228.8093,11.0234, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1879.1917,2339.5007,10.9799, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1872.2565,2071.7385,11.0625, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-858.0142,1535.3987,22.5870, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1213.7981,1830.3331,41.9297, 14, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2200.9714,1393.5470,10.8203, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2049.5845,2486.0862,11.0781, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1731.8141,1888.1255,10.8203, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2240.7698,2047.4966,11.0625, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-35.9494,1172.1107,19.4280, 55	, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-69.1524,92.9972,3.1172, 11, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2478.1455,-1476.8624,23.7989, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(906.2801,-1221.0192,16.9766, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1614.1479,2320.8289,10.8203, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1976.6429,-2029.5635,13.5469, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1054.8196,2134.8713,10.8203, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1708.7831,1606.9760,9.8767, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(150.9107,-1812.6412,3.7416, 9, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(387.7626, 2539.7524, 16.9433, 36, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2427.6968,1662.9028,10.8203, 36, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2485.4040527344,2506.73046875,10.8203125, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2375.5674,2306.3022,8.1406, 52, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(253.2157,1838.9449,17.6568, 46, 0, -1, -1, -1, 600.0);
	CreateDynamicMapIcon(2637.8018,1185.2871,10.8203, 12, 0, -1, -1, -1, 600.0);
	CreateDynamicMapIcon(2287.0254,2432.3618,10.8203, 30, 0, -1, -1, -1, 600.0);
	CreateDynamicMapIcon(2735.6653,-2448.3457,13.6432, 46, 0, -1, -1, -1, 600.0);
	CreateDynamicMapIcon(2092.6499,2493.1968,14.8390, 54, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1168.6149,1364.8787,10.8125, 19, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1839.62, 138.98, 15.20, 19, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1607.4197,1815.2408,10.8203, 22, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2111.5618,894.6057,10.9149, 27, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(178.4099,1101.4073,16.4498, 11, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(276.6597,1396.0018,10.4786, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2823.4900,914.6848,10.6434, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2258.0461,2765.0706,10.7141, 16, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2201.7358,-2226.7476,13.4103, 16, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2861.2329,1279.8409,11.4040, 38, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1762.3525,-1898.5516,13.4879, 38, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2229.3896,-1159.9827,25.8025, 38, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1971.0687,140.6956,27.6873, 38, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(180.7734, -108.8047, 0.6484, 38, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(206.5538,-231.0065,1.7749, 27, 0, -1, -1, -1, 300.0);
	//CreateDynamicMapIcon(2225.6599,-1724.1580,13.5621, 54, 0, -1, -1, -1, 300.0); // pometka
	CreateDynamicMapIcon(321.3462,-29.1380,1.5781, 19, 0, -1, -1, -1, 300.0);
  	CreateDynamicMapIcon(2180.7395,-1990.5044,13.5469, 11, 0, -1, -1, -1, 300.0);
    CreateDynamicMapIcon(-1864.7662,-1668.6857,21.7500, 11, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1481.1355,-1769.7352,18.7958, 52, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1542.5132,-1675.6295,13.5546, 30, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(876.8422,-1567.4388,13.5391, 18, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2169.4517,-1675.1003,15.0859, 23, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2245.0801,-1662.6428,15.4690, 45, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2040.3796,-114.5223,35.2579, 36, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2668.8684,640.1640,14.4531, 22, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2756.1284,375.9151,4.3338, 19, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-220.9060,-234.7779,1.4219, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2136.0205,-77.7463,35.3203, 40, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1289.0641,-1271.5160,13.5400, 19, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1988.3429,-1984.5186,13.6663, 11, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(457.6003,-1501.4500,31.0383, 45, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(694.5242,-498.0038,16.3359, 45, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1654.3445,-1657.2205,22.5156, 12, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1802.6573, 407.1559, 20.2294, 12, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-256.7696, -1362.8536, 9.4421, 56, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(523.8312, 848.2282, -42.9189, 56, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2192.7070, 993.6327, 80.0000, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2154.3425,644.6054,52.3672, 37, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1449.6135, -2284.7063, 13.5469, 5, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1409.4084, -298.2005, 14.1484, 5, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1673.0103, 1447.5935, 10.7867, 5, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1866.0593, -1394.1477, 13.4955, 55, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2154.7354, 1493.4109, 10.8203, 33, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2956.5833, -1971.8005, 3.5868, 9, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-71.1408, 1223.8297, 19.6863, 38, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2463.4805, 131.7678, 35.1719, 43, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2491.4995,918.3869,11.0234, 21, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-2071.5891,-2445.5686,30.7183, 51, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1703.9647,785.6906,25.7360, 52, 0, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(2805.6460,-2398.9001,13.6293, 35, 0, -1, -1, -1, 300.0); //buyconteiner
	CreateDynamicMapIcon(562.1118, -1506.6832, 14.5493, 42, 0, -1, -1, -1, 300.0); // salon sviazi

	return printf("[SEMENENKO Base] Is viso buvo ikelta %d/Unlimited MapIcon.", Streamer_CountItems(STREAMER_TYPE_MAP_ICON, 0));
}

stock CreateObjcets()
{
	new tmpobjid;
	
	/* fix casino */
	CreateObject(19382, 2264.062500, -867.797302, 1406.037231, 0.000000, -90.000000, 0.0);
	/* fix casino */

	/*Pol konnyh stavok*/
	tmpobjid = CreateObject(2938, -229.272705, 880.934937, 1502.451538, -0.000007, 0.000007, -89.999947, 100.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4682, "dtbuil1_lan2", "LAInside_Tracksign2", 0);
	tmpobjid = CreateObject(19550, -238.304565, 963.747253, 1500.010010, 0.000000, 0.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14488, "dogsgym", "ah_yelplnks", 0xFFFFFFFF);
	/*Pol konnyh stavok*/

	/*Pol Bank LS*/
	tmpobjid = CreateObject(6959, -2638.788086, 798.036133, 1500.004028, 0.000000, 0.000000, 0.000000, 0.0);
	SetObjectMaterial(tmpobjid, 0, 14387, "dr_gsnew", "la_flair1", 0xFFFFFFFF);
	tmpobjid = CreateObject(6959, -2679.429443, 793.759277, 1500.000000, 0.000000, 0.000000, 0.000000, 0.0);
	SetObjectMaterial(tmpobjid, 0, 14387, "dr_gsnew", "la_flair1", 0xFFFFFFFF);
	tmpobjid = CreateObject(6959, -2679.004639, 833.176697, 1500.001953, 0.000000, 0.000000, 0.000000, 300.0);
	SetObjectMaterial(tmpobjid, 0, 14387, "dr_gsnew", "la_flair1", 0xFFFFFFFF);
	/*Ïîë Áàíê ã. Ëîñ-Ñàíòîñ*/

	/*Pol Ligonine LS 2 aukstas*/
	tmpobjid = CreateObject(19377, 1167.697632, -1316.016235, 1018.330017, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1167.697632, -1306.384033, 1018.330017, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1146.698853, -1316.016235, 1018.328003, 0.000000, 90.000015, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1146.698853, -1306.384033, 1018.328003, 0.000000, 90.000015, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1160.708984, -1296.754517, 1018.328003, 0.000000, 90.000008, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1169.929199, -1334.534424, 1018.333862, 0.000000, 90.000008, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1169.437866, -1287.176025, 1018.325806, 0.000000, 90.000008, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1125.698608, -1311.195679, 1018.325989, 0.000000, 90.000015, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1127.990112, -1534.374512, 1009.199646, 0.000000, 90.000015, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 1148.989380, -1543.994263, 1009.209717, 0.000000, 90.000015, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	/*Pol Ligonine LS 1 aukstas*/

	/*Pol Ligonine 2 aukstas*/
	tmpobjid = CreateObject(19377, 641.531006, -1238.108032, 1023.305847, 0.000000, 90.000015, 0.000000, 0.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 621.740417, -1263.011108, 1023.305298, -0.000007, 90.000023, 0.000000, 0.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 4101, "stapl", "sl_laexpowall1", 0);
	tmpobjid = CreateObject(19377, 665.350647, -1242.668335, 1023.321960, 0.000000, 90.000015, 0.000000, 0.0); // 1
	SetDynamicObjectMaterial(tmpobjid, 0, 14537, "pdomebar", "club_floor2_sfwTEST", 0);
	/*Pol Ligonine 2 aukstas*/

	/*Pol Parduotuve 24/7*/
	tmpobjid = CreateObject(6959, 2573.745117, 1418.964233, 1800.000000, 0.000000, 0.000000, 0.000000, 300.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14537, "pdomebar", "club_floor2_sfwTEST", 0);
	/*Pol Parduotuve 24/7*/

	/*Pol Degaline*/
	tmpobjid = CreateObject(19378, 672.783630, -578.324524, 1699.649536, 0.000000, 90.000000, 0.000000, 300.0); // 1
	SetObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicfloor", 0);
	tmpobjid = CreateObject(18765, 664.657593, -569.745667, 1697.239380, 0.000000, 0.000000, 0.000000, 300.0); // 1
	SetObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicfloor", 0xFFFFFFFF);
	/*Pol Degaline*/

	/*Pol Automasterskaja*/
	tmpobjid = CreateObject(19375, -2374.758789, 1250.461670, 1499.897339, 0.000000, 90.000000, 90.000000, 300.0); // 1
	SetObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicfloor", 0xFFFFFFFF);
	tmpobjid = CreateObject(19375, -2384.375000, 1252.231567, 1499.897339, 0.000000, 90.000000, 90.000000, 300.0); // 1
	SetObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicfloor", 0xFFFFFFFF);
	tmpobjid = CreateObject(19377, -2403.847656, 1256.891357, 1500.056885, 0.000000, 90.000000, 90.000000, 400.0); // 1
	SetObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicfloor", 0);
	tmpobjid = CreateObject(19375, -2393.994873, 1252.231567, 1499.897339, 0.000000, 90.000000, 90.000000, 300.0); // 1
	SetObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicfloor", 0xFFFFFFFF);
	/*Pol automasterskaja*/

	/*Pol Sokiu mokykla*/
	CreateObject(6959, 1756.006958, -308.060669, 1653.529907, 0.000000, 0.000000, 0.000000, 0.0); // 0
	/*Pol Sokiu mokykla*/

	/*Pol LSPD*/
	CreateObject(6959, -456.196747, 2167.161377, 1600.092163, 0.000000, 0.000000, 0.000000, 0.0); // 0
	CreateObject(6959, -456.129761, 2211.642334, 1600.092163, 0.000000, 0.000000, 0.000000, 0.0); // 0
	/*Pol LSPD*/

	/*Pol SMI LS*/
	tmpobjid = CreateObject(19377, 2132.739502, 2500.053711, 1023.894226, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 15048, "labigsave", "AH_flroortile1", 0);
	tmpobjid = CreateObject(19377, 1540.315186, 1964.160645, 1019.862488, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 15048, "labigsave", "AH_flroortile1", 0);
	tmpobjid = CreateObject(19377, 1540.315186, 1935.270874, 1019.859497, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 15048, "labigsave", "AH_flroortile1", 0);
	/*Pol SMI*/

	/*Pol Vaizdo ploksciu parduotuve*/
	tmpobjid = CreateObject(18783, 1390.672607, -5.847630, 997.419128, 0.000000, 0.000014, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 1, 4101, "stapl", "sl_laexpowall1", 0xAFFFFFFF);
	tmpobjid = CreateObject(18783, 1370.673218, -5.847630, 997.419128, 0.000000, 0.000014, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 1, 4101, "stapl", "sl_laexpowall1", 0xAFFFFFFF);
    /*Pol Vaizdo ploksciu parduotuve*/

	/*Pol Registracijos acc*/
	tmpobjid = CreateObject(19445, 1871.637573, 2228.270020, 1035.234497, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 18009, "genintrestrest1", "rest_wall5", 0);
	/*pol registracii acc*/

	/*pol Woolfes*/
	tmpobjid = CreateObject(19378, -581.882996, 125.709999, 1500.000000, 0.000000, 90.000000, 0.000000, 50.0); // 1
	SetObjectMaterial(tmpobjid, 0, 1407, "break_f_w", "CJ_SLATEDWOOD", 0);
	tmpobjid = CreateObject(19379, -597.961975, 129.311005, 1500.004028, 0.000000, 90.000000, 0.000000, 50.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14387, "dr_gsnew", "mp_marble", 0);
	/*Pol Woolfes*/

	/*pol Rifa*/
	tmpobjid = CreateObject(6959, -563.885254, 2248.947021, 1500.000000, 0.000000, 0.000000, 0.000000, 260.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14443, "ganghoos", "ah_CRAKPLNK", 0xFFFFFFFF);
	/*pol Rifa*/

	/*pol Groove*/
	tmpobjid = CreateObject(6959, -570.720642, 2414.346924, 1500.000000, 0.000000, 0.000000, 90.000000, 260.0); // 1
	SetObjectMaterial(tmpobjid, 0, 3063, "col_wall1x", "ab_wood1", 0xFFFFFFFF);
	/*pol Groove*/

	/*pol Vagos*/
	tmpobjid = CreateObject(6959, -418.642242, 2413.378174, 1500.000000, 0.000000, 0.000000, 0.000000, 260.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14443, "ganghoos", "ah_CRAKPLNK", 0xFFFFFFFF);
	tmpobjid = CreateObject(6959, -418.642212, 2413.378174, 1503.344116, 0.000000, 180.000000, 0.000000, 260.0); // 1
	SetObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	/*pol Vagos*/

	/*pol Aztecas*/
	tmpobjid = CreateObject(19071, -717.520508, 2250.010010, 1498.974487, 0.000000, 180.000000, 90.000000, 260.0); // 1
	SetObjectMaterial(tmpobjid, 0, 3063, "col_wall1x", "ab_wood1", 0xFFFFFFFF);
	/*pol Aztecas*/

	/*pol Ballas*/
	tmpobjid = CreateObject(6959, -724.743774, 2415.508057, 1500.001343, 0.000000, 0.000000, 0.000000, 260.0); // 5
	SetObjectMaterial(tmpobjid, 0, 14709, "lamidint2", "mp_apt1_floor", 0xFFFFFFFF);
	SetObjectMaterial(tmpobjid, 1, 14794, "ab_vegasgymmain", "mp_CJ_SHEET2", 0);
	SetObjectMaterial(tmpobjid, 2, 14794, "ab_vegasgymmain", "mp_CJ_SHEET2", 0);
	SetObjectMaterial(tmpobjid, 3, 14794, "ab_vegasgymmain", "mp_CJ_SHEET2", 0);
	SetObjectMaterial(tmpobjid, 4, 1736, "cj_ammo", "CJ_CANVAS2", 0);
	/*pol Ballas*/

	/*Pol naujas Ukis*/
	tmpobjid = CreateObject(19376, 729.813171, 1795.607666, 1600.918823, 0.000000, 90.000000, 0.000000, 290.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14832, "lee_stripclub", "Strip_wood_floor", 0);
	/*Pol naujas ukis*/

	/*Ïîëû SecondHand*/
	tmpobjid = CreateObject(10575, 1539.070068, 1502.015991, 11.702817, 0.000000, 0.000000, 90.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0);
	/*pol SecondHand*/

 	/*pol SampBet*/
	tmpobjid = CreateObject(10575, 1539.070068, 1502.015991, 11.702817, 0.000000, 0.000000, 90.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0);
	/*pol SampBet*/

	/*Pol bank LS*/
	tmpobjid = CreateObject(7914, 1479.914917, -1689.026733, 19.557898, 0.000000, 0.000007, 0.000000, 200.0); // 1
	SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateObject(19538, 1492.169434, -1719.407593, 12.355388, 0.000007, 0.000000, 179.999969, 500.0); // 1
	SetObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0);
	tmpobjid = CreateObject(3980, 1481.310059, -1785.069946, 22.379999, 360.000000, 0.000000, 0.079000, 850.0); // 1
	SetObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0);
	tmpobjid = CreateObject(4013, 1654.589966, -1637.739990, 28.640600, 0.000000, 0.000000, 0.000000, 800.0); // 3
	SetObjectMaterial(tmpobjid, 2, 18029, "genintintsmallrest", "GB_restaursmll03", 0);
	SetObjectMaterial(tmpobjid, 3, 14847, "mp_policesf", "mp_cop_vinyl", 0);
	SetObjectMaterial(tmpobjid, 4, 14537, "pdomebar", "club_floor2_sfwTEST", 0);
	/*Pol bank LS*/

 	/*Pol Aksioma*/
	tmpobjid = CreateObject(19376, 2787.521240, 739.426392, 1499.032715, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	/*Pol aksioma*/

    /*Pol neizvestno*/
	tmpobjid = CreateObject(19071, -1503.948486, 2719.041992, 1498.967407, 0.000000, 180.000000, 0.000000, 0.0); // 3
	SetObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0xFFFFFFFF);
	SetObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0);
	SetObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "ferry_build14", 0);
	/*Pol neizvestno*/

	/*Pol neizvestno*/
	tmpobjid = CreateObject(6959, 1888.981934, 742.835693, 1499.177124, 0.000000, 0.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14760, "sfhosemed2", "ah_poshwdflr1", 0xFFFFFFFF);
	/*Pol neizvestno*/

	/*Pol avantaz*/
	tmpobjid = CreateObject(19377, 1442.098389, -1064.010620, 1600.906006, 0.000000, 90.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 3063, "col_wall1x", "ab_wood1", 0xFFFFFFFF);
	CreateObject(8661, 1488.267944, 1524.759766, 1600.085083, 0.000000, 0.000000, 0.000000, 0.0); // 0
	/*Pol avantaz*/

	/*Pol Ultra*/
	tmpobjid = CreateObject(6959, -1217.453735, 2370.032959, 1499.997925, 0.000000, 0.000000, 0.000000, 0.0); // 1
	SetObjectMaterial(tmpobjid, 0, 14387, "dr_gsnew", "la_flair1", 0xFFFFFFFF);
	/*POL ultra*/

	return printf("[SEMENENKO Base] Is viso buvo ikelta %d/Unlimited (NoDynamic)", GetCountObjects());
}

stock CreateVehicles()
{
	RinokCars[0] = AddStaticVehicleEx(15565, 1103.129, -1482.955, 15.864, 322.16259765625, random(255), random(255), -1);
	RinokCars[1] = AddStaticVehicleEx(15568, 1103.579, -1493.541, 15.990, 330.29528808594, random(255), random(255), -1);
	RinokCars[2] = AddStaticVehicleEx(15569, 1153.550, -1493.896, 15.925, 36.457401275635, random(255), random(255), -1);
	RinokCars[3] = AddStaticVehicleEx(15572, 1153.545, -1483.384, 16.128, 36.457401275635, random(255), random(255), -1);
}

/*stock load_PawnShop()
{
	// PawnShop`s Pickups
	Streamer_SetArrayData(STREAMER_TYPE_PICKUP, CreateDynamicPickup(19132, 23, 1525.2045, 1436.7594, 10.9674), E_STREAMER_INTERIOR_ID, {82});
	Streamer_SetArrayData(STREAMER_TYPE_PICKUP, CreateDynamicPickup(19132, 23, 1525.1495, 1439.1144, 10.9674), E_STREAMER_INTERIOR_ID, {82});
	Streamer_SetArrayData(STREAMER_TYPE_PICKUP, CreateDynamicPickup(1239, 23, 1531.1866, 1437.1147, 10.9674), E_STREAMER_INTERIOR_ID, {82});
	Streamer_SetArrayData(STREAMER_TYPE_PICKUP, CreateDynamicPickup(1239, 23, 1527.7731, 1437.1156, 10.9674), E_STREAMER_INTERIOR_ID, {82});
	Streamer_SetArrayData(STREAMER_TYPE_PICKUP, CreateDynamicPickup(1239, 23, 1531.2493, 1445.7972, 10.9674), E_STREAMER_INTERIOR_ID, {82});
	
	// PawnShops`s Actors
	Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(98, 1527.6757, 1439.2396, 10.9674, 180.6382), E_STREAMER_WORLD_ID, {406});
    Streamer_SetArrayData(STREAMER_TYPE_ACTOR, CreateDynamicActor(46, 1531.2693, 1439.2466, 10.9674, 179.2389), E_STREAMER_WORLD_ID, {406});
	
	// PawnShop`s 3DText
	Streamer_SetArrayData(STREAMER_TYPE_3D_TEXT_LABEL, CreateDynamic3DTextLabel("Lombardo valdymas\n\n{FFFF00}Paspauskite ALT", -1, 1531.2493, 1445.7972, 10.9674, 5.0), E_STREAMER_INTERIOR_ID, {82});
	Streamer_SetArrayData(STREAMER_TYPE_3D_TEXT_LABEL, CreateDynamic3DTextLabel("ALT", COLOR_GREY, 1525.2045, 1436.7594, 10.9674, 5.0), E_STREAMER_INTERIOR_ID, {82});
	Streamer_SetArrayData(STREAMER_TYPE_3D_TEXT_LABEL, CreateDynamic3DTextLabel("ALT", COLOR_GREY, 1525.1495, 1439.1144, 10.9674, 5.0), E_STREAMER_INTERIOR_ID, {82});
	Streamer_SetArrayData(STREAMER_TYPE_3D_TEXT_LABEL, CreateDynamic3DTextLabel("Daiktu ispardavimas\n\n\n{cccccc}Noredami perziureti sarasa\nPaspauskite ALT", 0x67DAFFFF, 1527.7731, 1437.1156, 10.9674, 7.0000), E_STREAMER_INTERIOR_ID, {82});

	return print(" PawnShop`s: loaded.");
}*/

stock GetCountObjects()
{
	new count;
	for new i; i < 1000; i++ do
	{
		if IsValidObject(i) *then count ++;
	}
	return count;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if vehicleid == RinokCars[0] || vehicleid == RinokCars[1] || vehicleid == RinokCars[2] || vehicleid == RinokCars[3] *then
  		ClearAnimations(playerid);
}

public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	if EDIT_RESPONSE_FINAL == response *then
		printf(" case %d: SetPlayerAttachedObject (playerid, slot, setobject, %d, %f,%f,%f, %f,%f,%f, %f,%f,%f); // %d", GetPlayerSkin(playerid), boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, modelid);
}

stock GetPlayerLauncher(playerid)
{
	GetPlayerVersion(playerid, str, 24);
	return (GetString(str, "SAG PC") || GetString(str, "SAG-mobile") ? 1:0);
}

#if !defined isnull
	#define isnull(%0)  ((!(%0[0])) || (((%0[0]) == '\1') && (!(%0[1]))))
#endif

new const Owner[][] = {
	{"Milancholi"},
	{"Wiliams"},
	{"-"}
};

public: @CheckOsnovatel(playerId, accountId) {

    GetPlayerName(playerId, NickName, MAX_PLAYER_NAME);

	for new i; i < sizeof Owner; i++ do {
		if GetString(Owner[i], NickName) *then return true;
	}

	return false;
}

stock CR_rinok()
{
	
	CreateDynamicPickup(1239, 23, 1118.0151, -1432.4603, 15.7969, 0);
	CreateDynamic3DTextLabel(!"Perziureti vidutines prekiu kainas\n\n{ffffff}[ ALT ]", 0x73B461FF, 1118.0151, -1432.4603, 15.7969, 5.0000, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 0);

	return false;
}

new const ItemStory[][] =
{
	!"{ffffff}Informacijos apie si daikta nera.",
	!"{ffffff}Galima isigyti drabuziu parduotuveje, Centrineje Rinkoje {FFD700}gold {FFFFFF}ruletes\nNaudojama personazo isvaizdai keisti.\nGalima uzsideti.",
	!"{ffffff}Isduodama registruojantis serveryje. Negalima parduoti, ismesti ar {FDCF28}keisti{ffffff}.\nGalima atidaryti kas 10 zaidimo minuciu Online. Atidarius galite gauti\naukso, sidabro arba bronzes rulete, kurias galima sukti tiesiog zaidime.",
	!"{ffffff}Galima isigyti detaliu parduotuveje, pas kolekcininkus,\nsurinkti savo namo rusyje arba Centrineje Rinkoje.\nNaudodama kaip aksesuaras montuojant i jusu automobili.",
	!"{ffffff}Galima gauti {FFCB2C}tik naudojant stakles\narba nusipirkti rinkoje.{FFFFFF}",
	!"{ffffff}Galima isigyti sventiniu suvenyru parduotuveje uz ivairia valiuta (auksines zuvytes, laiminga zole,\narba centrineje rinkoje. Naudojama personazo\nisvaizdai keisti. Galima uzsideti, perduoti ir parduoti.",
	!"{ffffff}Galima sukurti {FDCF28}rusyje{FFFFFF},\narba nusipirkti centrineje rinkoje.\nGalima uzsideti.",
	!"{ffffff}Galima isigyti parduotuveje {FDCF28}24/7{FFFFFF},\narba centrineje rinkoje.",
	!"{ffffff}Galima gauti {FDCF28}donate{FFFFFF},\narba nusipirkti centrineje rinkoje.\nGalima uzsideti.",
	!"{ffffff}Galima gauti gaminant rusyje\nsavo namuose arba centrineje rinkoje.\n({FDCF28} Is dalies apsaugo nuo koronaviruso{FFFFFF} )\nSveikatos apsaugos ministerija {FDCF28}rekomenduoja\n{FFFFFF}Galima uzsideti kaip aksesuara.",
	!"{ffffff}Galima isigyti donate\narba centrineje rinkoje.\nNaudojasi kaip aktyvus aksesuaras\nSuteikia galimybe judeti oro balionu.",
	!"{ffffff}Galima isigyti donate arba\ncentrineje rinkoje. Padidina jusu \naksesuaru tobulinimo tikimybe 2 kartus drabuziu dirbtuvese \n({FF332C}/GPS - Artimiausia drabuziu dirbtuve{FFFFFF})",
	!"{ffffff}Naudojama kriptovaliutu mineningui,\nnamu rusyje su ventiliacija.\nNoredami idiegti vaizdo plokste, naudokite\nja per inventoriu namu rusyje\nsu ventiliacija, prie specialaus stovo.\nKiekviena vaizdo plokste turi nasumo lygi,\nis viso yra 10 lygiu. Kuo aukstesnis lygis,\ntuo daugiau bitcoinu kasybos metu generuoja vaizdo plokste.\n\nGalima nusipirkti vaizdo ploksciu parduotuveje(/gps)\narba centrineje rinkoje.\n\nGalima perdavineti, ismetineti ir pardavineti.",
	!"{ffffff}Naudojama vaizdo ploksciu\nnasumui pagerinti.\nKuo aukstesnis nasumo lygis,\ntuo daugiau bitcoinu vaizdo plokste generuoja kasybos metu.\n\nGalima sukurti namu rusyje\narba nusipirkti centrineje rinkoje.\n\nGalima perdavineti, ismetineti ir pardavineti.",
	!"{ffffff}Galima gauti dalyvaujant renginyje: 'Baisusis rumas', \nlaimeti zaidime 'Nu palauk!', isigyti donate arba\ncentrineje rinkoje. Naudojama jusu aksesuaru tobulinimui \ndrabuziu dirbtuvese ({FF332C}/GPS - Artimiausia drabuziu dirbtuve{FFFFFF})",
	!"{ffffff}Galima isigyti banke arba\ncentrineje rinkoje. Reikalingas pinigu\nlaikymui valiuta. Euro kursa galima\nsuzinotu paskambinus i numeri 8828 arba prie isejimo is banko.\nPirkimo ir pardavimo kaina keiciasi karta\nper diena.",
	!"{ffffff}Galima gauti kasdien ieinant i zaidima,\narba nusipirkti centrineje rinkoje.\nNaudojama{FFD700} atsitiktiniam{FFFFFF}prekiu pasirinkimui\nis sios ruletes prieinamo prekiu saraso.",
	!"{ffffff}Galima gauti meniu parduotuveje {FDCF28}aksesuaru{FFFFFF},\narba nusipirkti centrineje rinkoje.\nGalima uzsideti.",
	!"{ffffff}Galima isigyti {FDCF28}donate{FFFFFF} arba\n{FDCF28}centrineje rinkoje{FFFFFF}. Naudojama kaip\npramogu daiktas, suteikiantis galimybe\njudeti mazaja:\nmasina/tanka/oro transporta.",
	!"{ffffff}Galima isigyti bet kuriame \"{FDCF28}Mobiliosios rysio salone{FFFFFF}\"\narba centrineje rinkoje.\nTuri standartiniu telefono funkciju rinkini.\nGreitas prisijungimas: {FDCF28}/phone",
	!"{ffffff}Galima gauti sventiniuose Eventuose arba\ncentrineje rinkoje.\nNaudojama valstybes nekilnomojo turto pirkimui arba\ntransporta uz zaidiminius $ ir duoda akcija {FDCF28}50{FFFFFF} procentu pirkdami.",
	!"{ffffff}Gaunate kiekviena PayDay naudodami\nlaucnher {FDCF28}SAG LAUNCHER{FFFFFF}. Atsiusti galima\nserverio site: {FDCF28}None{FFFFFF}\nNaudojama keistis i vertingus daiktus pas\nprekeivi Edwarda prie Centrinio Banko aikstes.",
	!"{ffffff}Daiktas, kuris reikalingas zaidimui {FDCF28}kauliukai{FFFFFF}, {FDCF28}durnius{FFFFFF} ir\nâ {FDCF28}losimo automatuose{FFFFFF}.\nGalima nusipirkti kasoje casino {FDCF28}4{FFFFFF} Dragons.",
	!"{ffffff}Galima gauti dirbant valstybes darbuose uzimtumo centre,\npas krovikus arba atlikus uzduotis.\nNaudojant suteiks galimybe gauti\nõ4 SAG-coins, papildzius saskaita site.",
	!"{ffffff}Bitcoinas - vienas is virtualiosios valiutos tipu,\ndar vadinamas ''kriptovaliuta''.\nJi galima minenint savo namu rusyje,\nparduoti ir pirkti banke, taip pat\nperduoti kitiems per mainus,\natsiskaitant uz tam tikra preke.\n\nNorint minenint (kurti naujus bitcoinus),\nreikia pastatyti namu rusi su ventiliacija.\nTada reikia nusipirkti vaizdo plokstes vaizdo ploksciu parduotuveje (/gps),\nir idiegti jas rusyje i specialias stovas.\nVaizdo plokstes turi ausinimo sistemos busena,\nnepamirskite papildyti ausinimo skyscio,\nkitaip ji nustos veikti.\n\n{cccccc}Bitcoin galima minenint, kol nepasieks limito: {ffff00}6300000.000000 BTC{cccccc}.\nDabar is viso bitcoinu sistemoje: {ffff00}5893.856445 BTC{cccccc}.\nKiekviena menesio pirma diena limitas padideja 100 000 BTC.\n\n{ffffff}Gali buti laikoma tik inventoriuje (kaip virtuali valiuta)\nGalima ismesti, pardavineti centrineje rinkoje,\ndeti i bagazine, namo spinta ir t.t.",
	!"{ffffff}Atidarius sia skrynia, be pagrindiniu daiktu,\ngalima gauti {FDCF28}super-retus {ffffff}daiktus, tokius kaip:\n\n{cccccc}- Mercedes-Benz GLS 2020\n- Mercedes G65 AMG\n- Range Rover SVA\n- Tesla Model X\n- Nissan Silvia S15\n- Mercedes-Benz S600\n\n\n{ffffff}Taip pat galimybe laimeti:\n{cccccc}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Tokia skrynia galima isigyti {FDCF28}donate parduotuveje,\n{ffffff}arba pas zaidejui centrineje rinkoje.\n\n{ffffff}Galima naudoti, perdavineti ir pardavineti.",
	!"{ffffff}Daikta galima perdavineti, ismetineti.\nNaudojant duoda +1 SAG-Coin",
	!"{ffffff}Galima isigyti donate parduotuveje\narba centrineje rinkoje.\nNaudojasi, kaip aktyvus aksesuaras\nsuteikia galimybe judeti dviraciu.",
	!"{ffffff}Naudojama 50% ausinimo\nsistemos atkurimui vaizdo ploksteje.\nJei vaizdo plokstes ausinimo sistemos bukle\nnukrenta iki 0%, vaizdo plokstes darbas\nsustoja, kol ji bus atkurta.\nNorint atkurti, reiikia uzpilti\nsi skysti i vaizdo plokste.\n\nGalima sukurti namu rusyje\narba nusipirkti centrineje rinkoje.\n\nGalima perdavineti, ismetineti ir pardavineti.",
 	!"{ffffff}Naudojama personazo savybems gerinti, tokioms kaip:\napsauga, regeneracija, pazeidimas, sekme, maks. HP.\n\nGalima gauti sukurus rusyje savo namuose\narba centrineje rinkoje pasinaudoti bendru stanklemis.\nTaip pat galima nusipirkti centrineje rinkoje is kitu zaidejui.\n\nIssiuvinejimus galima tobulinti drabuziu dirbtuvese, tam\nreikalingas slifavimo amuletas.\nIssiuvinejima galima tobulinti iki 3 lygio (maksimalus).\nKuo aukstesnis issiuvinejimo lygis, tuo jis itakingesnis.\n\nNoredami prisegti issiuvinejima ant aksesuaro, atidarykite inventoriu,\nspaustelekite issiuvinejimo daikta, pasirinkite [IDIEGTI/INSTALL],\ntada spaustelekite aksesuara, ant kuri3o norite prisegti\nissiuvinejima.\nAtkreipkite demesi! Po to, kai prisegsite issiuvinejima ant aksesuaro,\nniekas negales jo nuimti nuo aksesuaro!\n\nIssiuvinejimas galima perdavineti, pardavineti ir ismetineti.",
	!"{ffffff}Galima gauti is {FDCF28}kontrabandos, zudima bandito capte{FFFFFF}\nGalima nusipirkti centrineje rinkoje.\nNaudojama kuriant unkalius nusikalteliu\nir mafijos dalyviu skinus su {FDCF28}maza{FFFFFF} tikimybe.",
 	!"{ffffff}Isduodama iskasant lobi, taip pat galima\nnusipirkti centrineje rinkoje is kitu zaideju.\n\nLeidzia suzinoti, ar serveryje siuo metu yra lobiu,\ntaip pat, suzinoti ju tikslu buvimo vieta No-pe%.",
 	!"{ffffff}Tai nekeicia VIP paskyros, o papildo ja.\nPerkdami isduodasi papildymo daiktas.\nNoredami ji aktyvuoti - reikia ji isnaudoti per inventoriu.\nIki aktyvacijos daikta galima pardavineti, perdavineti, supirkineti.\nPo aktyvacijos papildymas galiuos lygiai 1 menesi.\n\n\n{ffff00}Papildymo pagerinimai:{cccccc}\n1. Jums nereikia maisto.\n2. Nera atvesto laiko report siuntimui.\n3. Nemokamas skelbimo siuntimas i ziniasklaida (nemokamai karta per 30 minuciu).\n4. Nemokami skambuciai ir SMS.\n5. Nemokama suoleliu nuoma Centrineje Rinkoje.\n6. Nemokamas iejimas i casino ir barus.\n7. Visur komisija uz pervedimus ir pinigu perdavimus yra 2 kartus mazesne.\n8. Daiktu tobulinimo tikimybe padidinta 2 kartus.\n9. Kiekviena PayDay gausite 6 SAG-Coins.\n10. Per 30 minuciu galima pervezti 26 statines dirbant naftos platformose.\n11. Per /pay galima perdavineti suma iki 1 000.000$.\n12. Gydymas ligonineje vyksta 5 kartus greiciau.\n13. Nepamesite ginklo patekus i ligonine.\n14. Kaukes veiksmas padidintas ant 10 minuciu.\n15. Per armijos apiplesima gausite 4 ingredientus vietoj 2.\n16. Atsiranda galimybe gauti platinum rulete.\n17. Naudojant antibiotikus, narkomanija sumazeja 10 vienetu daugiau.\n18. 6 reputacijos taskai jusu seimai kiekviena PayDay.\n19. Atliekant automobilio lukstinima /breakcar, atrakta nebus sugadinta.\n20. Padidintas sansas gauti kalejimo atraktoriu vykdant uzduotis MSK.\n21. KD dezes su ruletemis sumazintas iki 60 minuciu.\n22. Vykdant seimos uzduotis bus isduodama du kartus daugiau seimos talonu.\n23. Galima ikelti iki 5 automobiliu.\n24. Galima moketi mokescius be 40 minuciu zaidimo.\n25. KD pirkimui Concept Car Luxury 2 dezuciu yra 10 sekundziu.\n26. Galite patekti bet kur, budami nevakcinuoti.\n27. Nera bendro KD VIP chatui.\n28. Galimybe moketi mokescius per Online-bankininkyste telefone.\n29. Prisijungus prie zaidimo, yra galimybe pasirinkti spawno vieta/paskutine iseities vieta.",
    !"{ffffff}Aksesuaras pasiekiamas tik zaidziant su launcheriu SAG LAUNCHER arba SAG MOBILE!",
	!"{ffffff}Galima isigyti donate parduotuveje\narba centrinije rinkoje.\nSu siuo USB raktu galite bet kur\npradeti/sustapdyti bitcoinu gamyba\nnaudojant jusu vaizdo plokstes, taip pat paimti\nbitcoinu pelna is vaizdo ploksciu.\nGalima naudoti, perdavineti ir pardavineti.",
	!"{ffffff}Naudojama pirkimams admin-parduotuveje.\nGalima gauti kaip zaideju padeka (/thanks).\nTaip pat galima gauti atsakius i reporta ir per PayDay.\nGalima perduoti ir parduoti.\n\nIssamesne informacija galite rasti /help > Administracijos padeka.",
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{ff0000}Skrynioje Rare Box RED:\n{a7a5a5}- Bentley Continental\n- Audi RS6\n- Mercedes E63s AMG (2020)\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 36. Rare Box Red
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{e4e45b}Skrynioje Rare Box YELLOW:\n{a7a5a5}- Mercedes GT63\n- BMW M8\n- Lamborghini Urus\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 37. Rare Box Yellow
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{004bfc}Skrynioje Rare Box BLUE:\n{a7a5a5}- Mercedes G63AMG\n- Mercedes S63\n- Volkswagen Touareg\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 38. Rare Box Blue
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- BMW Z4\n- Mercedes Benz S600\n- BMW X5 E53\n- Nissan GT-R\n- Rolls Royce Cullinan\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 39. Super Car Box
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Ducati Diavel\n- Ducati Panigale\n- Ducati Ducnaked\n- Kawasaki Ninja ZX-10RR\n- Western\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 40. Super Moto Box
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Lamborghini Aventador SVJ\n- Bugatti Divo\n- Bugatti Chiron\n- Buckingham\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 41. Skrynia Super Car Box
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Mercedes-Benz GLE 63\n- Mercedes-Benz CLS 53\n- Audi RS5\n- Cadillac Escalade 2020\n- Cyber Truck\n- Audi S4\n- Cadillac Escalade 2007\n- Toyota Chaser\n- Mitsubishi Lancer\n- Impala 64\n- Impala 67\n- Subaru WRX\n- Rolls-Royce Phantom\n- McLaren MP4\n- BMW 4 Series\n- Mercedes-Benz GLE 63S\n- Tesla Model 3\n- Lamborghini Murcielago\n- Ferrari F40\n- Chevrolet Tahoe\n- Toyota Tundra\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 42. Organizacijos skrynia
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Batmobile\n- Zombiemobile\n- Devil\n- Police Apocalypse\n- Chum Bucket\n- Hellway\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 43. Skrynia Halloween 2022
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- 3D akiniai\n- Kaukole ant krutines\n- Kaukole ant peties\n- Respiratorius\n- Plaktukas ant nugaros\n- Kastuvas ant nugaros\n- Mountain\n- Perlejancios akiniai\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 44. Lobiu ieskotojo skrynia
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Mercedes-Benz 1620\n- Mercedes-Benz 1113\n- Volkswagen Constellation\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 45. Maisto prekeivio skrynia
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Luxor Deluxe\n- Nimbus\n- Vestra\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 46. Lakuno skrynia
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Toyota Land Cruiser Prado\n- Toyota Land Cruiser VXR V8 4\n- Mercedes E-63 AMG\n- Audi Q7\n- BMW M6 2020\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 47. Skrynia Crafter
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Skin: Dzaks\n- Skin: Liu Keng\n- Skin: Nub Saibot\n- Skin: Sonia Bleid\n- Skin: Sangas Cungas\n- Skin: Raidenas\n- Skin: Scorpion\n- Skin: Sub Ziro\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 48. Skrynia Mortal Kombat
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Laivas Nagasaki\n- Laivas Lampadati Toro\n- Laivas Predator\n- Laivas Longfin\n- Laivas Wellcraft\n- Laivas Yacht\n- Laivas Boates\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 49. Zvejo skrynia
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Akiniai «Balenciaga»\n- Panama kepure «Balenciaga»\n- Akiniai sirdies formos «Balenciaga»\n- Panama kepure su kanape\n- Kepure «Gucci»\n- Juros velnias\n- Kauke «Haganezuki»\n- Kauke Oni\n- Samuraju salmas\n- Salmas zmogaus skruzdeles\n- Kepure «Stone Island»\n- Bionine pirstine (desine)\n- Bionine pirstine (kaire)\n- Rugstine rankine\n- Rankine su smegenimis\n- Ledinis kardas ant nugaros\n- Vaivorykstes UZI ant nugaros\n- Kuprine «Bananu patranka»\n- Kuprine «Neonine granata»\n- Salmas «Geleziniai sparnai»\n- Akiniai «Doleris»\n- Deimantinis nimbas\n- Zaislinis Delorean\n- Zvaigzdinis nimbas\n{f6ff09}- Riedlente\n{f6ff09}- Mesos maisas\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 50. Skrynia custom aksesuaru
	!"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- BMW 760li\n- Aston Martin One-77\n- Bentley Balacar\n- Bentley Bentayga\n- Mercedes-Benz S500 4Matic\n- Mercedes-Benz SLR McLaren\n- Ferrari J50\n- Ferrari Spider\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 51. Oligarcho skrynia
    !"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Volvo Truck\n- Mercedes-Benz Actros\n- Mercedes-Benz Arocs 4163\n- Iveco Stralis\n- MAN TGS\n- Volvo 460\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 52. Sunkvezimio vairuotojo skrynia
    !"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Holding Bus Company\n- Los-Santos Inter Bus C\n- Mercedes-Benz Tourismo\n- Mercedes-Benz Coach\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 53. Autobuso vairuotojo skrynia
    !"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Mercedes-AMG Project One R50\n- BUGATTI Bolide\n- Yacota K5\n- Ferrari Monza SP2\n- Mercedes-AMG G63\n- Hotwheels\n- Hummer HX\n- Ferrari F70\n- BMW M5 CS\n- Quadra Turbo-R V-Tech\n- Mercedes-Benz VISION AVTR\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 54. Skrynia Concept Car Luxury
    !"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir {f6ff09}automobilius Vice City{ffffff}, tokiu kaip:\n\n{a7a5a5}- VC - Bloodring\n- VC - Deluxo\n- VC - FBI Rancher\n- VC - Banshee\n- VC - Idaho\n- VC - Infernus\n- VC - Sentinel\n- VC - Stinger\n- VC - Stretch\n- VC - Angel\n- VC - BF Injection\n- VC - Blista\n- VC - Burrito\n- VC - FBI Car\n- VC - Hotring B\n- VC - Sabre\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 55. Skrynia Vice City
    !"{ffffff}Atidarius si skrynia, be pagrindiniu daiktu,\ngalima gauti ir itin retu daiktu, tokiu kaip:\n\n{a7a5a5}- Audi 80 Universal\n- BMW E34\n- Mercedes E63 w221\n- Mercedes G63 AMG\n- BMW M8\n- BMW 850i\n- Bentley Continental\n- Volkswagen Touareg\n- Lamborghini Urus\n- Mercedes GT63\n\n\n{ffffff}Taip pat yra galimybe laimeti:\n{a7a5a5}- Bronzines ruletes\n- Sidabrines ruletes\n- Seimos talonai\n- Piliecio talonai\n- Galastuvas\n- Nauji skinai\n- Pinigai\n\n{ffffff}Si skrynia galima naudoti, perdavineti ir pardavineti", // 56. Kripto valiutos skrynia
    !"{ffffff}Atidarius si skrynia, galima gauti daiktus, tokius kaip:\n\n-{c924df} Talonas +1 SAG Coins (100 vnt.)\n{ffffff}-{c924df} Atsitiktine skrynia (35 vnt.)\n{ffffff}-{c924df} Atsitiktinis transporto sertifikatas (1 vnt.){ffffff} - {ebe014} 10%\n{ffffff}-{c924df} Uzantspauduotas transporto sertifikatas (1 vnt.){ffffff} - {ebe014} 5%\n\n{ffffff}Galima naudoti\n\nGalima isigyti adonate arba is zaideju." // 57. Auksine skrynia
};

stock GetPosInMassive(itemId)
{
	switch itemId do
	{
        case 1591:
	        return 57;

        case 1895:
	        return 56;

        case 2217:
	        return 55;

        case 1899:
	        return 54;

        case 2207:
	        return 53;

        case 2208:
	        return 52;

        case 2209:
	        return 51;

        case 2210:
	        return 50;

        case 2211:
	        return 49;

        case 2212:
	        return 48;

        case 2213:
	        return 47;

        case 2214:
	        return 46;

        case 2215:
	        return 45;

        case 2216:
	        return 44;

        case 2285:
	        return 43;

        case 2286:
	        return 42;

        case 1247:
	        return 40;

        case 1246:
	        return 39;

        case 1244:
	        return 41;

        case 1250:
	        return 38;

        case 1248:
            return 37;

        case 1249:
	        return 36;
	        
	    case 2467:
	        return 35;
	        
	    case 2284:
	        return 34;
	        
	    case 1621..1627,1801..1894,1900..1968,2272..2278,2279,2280,2281..2283,2287..2300:
	        return 33;
	        
		case 1896..1897:
		    return 32;

		case 1558..1560:
		    return 31;

	    case 1511..1550:
	        return 30;

	    case 1506..1510:
	        return 29;

		case 1505:
			return 28;

		case 1463:
			return 27;

		case 538:
			return 26;

		case 1245:
			return 25;

		case 1461:
			return 24;

		case 590:
			return 23;

		case 316:
			return 22;

		case 1251:
			return 21;

		case 952:
			return 20;

		case 551, 422, 329, 382..389, 1473..1501:
			return 19;

		case 953..957:
			return 18;

		case 408..419, 605:
			return 17;

		case 322..324:
			return 16;

		case 615:
			return 15;

		case 1130:
			return 14;

		case 1502..1504:
			return 11 + itemId - 1502;

		case 1..312, 1172..1241:
			return 1;

		case 313:
			return 2;

		case 686..950:
			return 3;

		case 988..1120:
			return 4;

		case 969..971, 979, 980, 982..987, 1121:
			return 5;

		case 334, 336..338, 340..345, 349, 350..361, 366, 620..664, 674..682:
			return 6;

		case 314, 315, 317, 319, 320, 321, 325, 328, 330:
			return 7;

		case 390..395, 599, 602, 1551..1555:
			return 8;

		case 617, 665..673:
			return 9;

		case 606..612:
			return 10;
	}

	return 0;
}

public: @GetItemStory(playerid, itemId) {
	SetPVarString(playerid, "GetItemStory", ItemStory[GetPosInMassive(itemId)]);
	return true;
}
