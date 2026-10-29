#include <a_samp>
#include <zcmd>

#define DIALOG_CARSINFO_MAIN     32100
#define DIALOG_CARSINFO_SEARCH   32101
#define DIALOG_CARSINFO_RESULTS  32102
#define DIALOG_CARSINFO_PAGE1    32111
#define DIALOG_CARSINFO_PAGE2    32112
#define DIALOG_CARSINFO_PAGE3    32113
#define DIALOG_CARSINFO_PAGE4    32114
#define DIALOG_CARSINFO_PAGE5    32115
#define DIALOG_CARSINFO_PAGE6    32116
#define DIALOG_CARSINFO_PAGE7    32117
#define DIALOG_CARSINFO_PAGE8    32118
#define DIALOG_CARSINFO_PAGE9    32119
#define DIALOG_CARSINFO_PAGE10   32120

forward OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

new const CarNames[][] = {
    // Puslapis 1
    "[1] Mercedes GT63 [612]", "[2] Mercedes G63 [613]", "[3] Audi RS6 [614]", "[4] BMW X5m [662]", "[5] Chevrolet Corvette [663]", "[6] Chevrolet Cruze [665]", "[7] Lexus LX570 [666]", "[8] Porsche 911 [667]", "[9] Porsche Cayenne S [668]", "[10] Bentley Continental [699]",
    "[11] BMW M8 [793]", "[12] Mercedes E63s AMG [794]", "[13] Mercedes S63 Coupe AMG [909]", "[14] Volkswagen Touareg [965]", "[15] Lamborghini Urus [1194]", "[16] Audi Q8 [1195]", "[17] Dodge Challenger SRT [1196]", "[18] Acura NSX [1197]", "[19] Volvo V60 [1198]", "[20] Range Rover Evoque [1199]",
    "[21] Honda Civic Type-R [1200]", "[22] Lexus Sport-S [1201]", "[23] Ford Mustang GT [1202]", "[24] Volvo XC90 [1203]", "[25] Jaguar F-pace [1204]", "[26] Kia Optima [1205]", "[27] BMW Z4 40i [3155]", "[28] Mercedes-Benz S600 W124 [3156]", "[29] BMW X5 E53 [3157]", "[30] Nissan Skyline R34 [3158]",
    "[31] Ducati Diavel [3194]", "[32] Ducati Panigale [3195]", "[33] Ducati Ducnaked [3196]", "[34] Kawasaki Ninja ZX-10RR [3197]", "[35] Western [3198]", "[36] Rolls-Royce Cullinan [3199]", "[37] Volkswagen Beetle [3200]", "[38] Bugatti Divo Sport [3201]", "[39] Bugatti Chiron [3202]", "[40] Fiat 500 [3203]",
    "[41] Mercedes-Benz GLS 2020 [3204]", "[42] Mercedes G65 AMG [3205]", "[43] Lamborghini Aventador SVJ [3206]", "[44] Range Rover SVA [3207]", "[45] BMW 530i E39 [3208]", "[46] Mercedes-Benz S600 [3209]", "[47] Tesla Model X [3210]", "[48] Nissan LEAF [3211]", "[49] Nissan Silvia S15 [3212]", "[50] Subaru Forester XT [3213]",
    // Puslapis 2
    "[51] Subaru Legacy 1989 [3215]", "[52] Hyundai Sonata [3216]", "[53] BMW 750i E38 [3217]", "[54] Mercedes-Benz E55 AMG [3218]", "[55] Mercedes-Benz E500 [3219]", "[56] Jackson Storm [3220]", "[57] Lightning McQueen [3222]", "[58] Sir Tow Mater [3223]", "[59] Buckingham [3224]", "[60] Infiniti FX 50 [3232]",
    "[61] Lexus RX 450h [3233]", "[62] Kia Sportage [3234]", "[63] Volkswagen Golf R [3235]", "[64] Audi R8 [3236]", "[65] Toyota Camry XV40 [3237]", "[66] Toyota Camry XV70 [3238]", "[67] BMW M5 E60 [3239]", "[68] BMW M5 F90 [3240]", "[69] Mercedes Maybach S650 [3245]", "[70] Mercedes-Benz AMG GT [3247]",
    "[71] Porsche Panamera Turbo [3248]", "[72] Volkswagen Passat [3251]", "[73] Chevrolet Corvette 1980 [3254]", "[74] Dodge Ram [3266]", "[75] Ford Mustang Shelby GT500 [3348]", "[76] Aston Martin DB5 [3974]", "[77] BMW M3 GTR [4542]", "[78] Chevrolet Camaro [4543]", "[79] Mazda RX7 Veilside FD [4544]", "[80] Mazda RX8 [4545]",
    "[81] Mitsubishi Eclipse [4546]", "[82] Ford Mustang 289 [4547]", "[83] Nissan 350Z [4548]", "[84] BMW 760li [4774]", "[85] Aston Martin One-77 [4775]", "[86] Bentley Bacalar [4776]", "[87] Bentley Bentayga [4777]", "[88] BMW M4 G82 [4778]", "[89] BMW i8 [4779]", "[90] Genesis G90 [4780]",
    "[91] Honda Integra Type-R [4781]", "[92] BMW M3 G20 [4782]", "[93] Mercedes-Benz S500 4Matic [4783]", "[94] Ford Raptor F150 [4784]", "[95] Ferrari J50 [4785]", "[96] Mercedes-Benz SLR McLaren [4786]", "[97] Subaru BRZ [4787]", "[98] Lada Vesta SW Cross [4788]", "[99] Porsche Taycan [4789]", "[100] Ferrari Enzo [4790]",
    // Puslapis 3
    "[101] UAZ Patriot [4791]", "[102] Volga [4792]", "[103] Mercedes-Benz X Class [4793]", "[104] Jaguar XF [4794]", "[105] RC Shutle [4795]", "[106] Dodge Grand Caravan [4796]", "[107] Ford Explorer [4798]", "[108] Ford F150 [4799]", "[109] Deltaplane [4800]", "[110] Sea Shark [4801]",
    "[111] Lamborghini Aventador LP700 [4802]", "[112] Ferrari 812 Superfast [4803]", "[113] Audi A6 [6604]", "[114] Audi Q7 [6605]", "[115] BMW M6 2020 [6606]", "[116] BMW M6 1990 [6607]", "[117] Mercedes CLA 45 AMG [6608]", "[118] Mercedes CLS 63 AMG [6609]", "[119] Haval H6 2.0 GDIT [6610]", "[120] Toyota Land Cruiser VXR V8 4 [6611]",
    "[121] Lincoln Continental [6612]", "[122] Porsche Macan Turbo [6613]", "[123] Daewoo Matiz [6614]", "[124] Mercedes-AMG G63 6x6 [6615]", "[125] Mercedes E-63 AMG [6616]", "[126] Monster Mutt [6617]", "[127] Monster Indonesia [6618]", "[128] Monster E1 Toro [6619]", "[129] Monster Grave Digger [6620]", "[130] Toyota Land Cruiser Prado [6621]",
    "[131] Toyota RAV4 [6622]", "[132] Toyota Supra A90", "[133] UAZ [6624]", "[134] Volvo XC90 2012 [6625]", "[135] Mercedes-Benz GLE 63 [12713]", "[136] Renault Laguna [12714]", "[137] Mercedes-Benz CLS 53 [12715]", "[138] Audi RS5 [12716]", "[139] Cadillac Escalade 2020 [12717]", "[140] Cyber Truck [12718]",
    "[141] Tesla Model S [12719]", "[142] Ford GT [12720]", "[143] Dodge Viper [12721]", "[144] Volkswagen Polo [12722]", "[145] Mitsubishi Lancer Old [12723]", "[146] Audi TT RS [12724]", "[147] Mercedes-Benz Actros [12725]", "[148] Audi S4 [12726]", "[149] BMW 4-Series [12727]", "[150] Cadillac Escalade 2007 [12728]",
    // Puslapis 4
    "[151] Toyota Chaser [12729]", "[152] Dacia 1300 [12730]", "[153] Mitsubishi Lancer [12731]", "[154] Impala 64 [12732]", "[155] Impala 67 [12733]", "[156] Coca-Cola Truck [12734]", "[157] Coca-Cola Trailer [12735]", "[158] McLaren MP4 [12736]", "[159] Ford Mustang Mach 1 [12737]", "[160] Rolls-Royce Phantom [12738]",
    "[161] Pickup Truck [12739]", "[162] Volvo Truck [12740]", "[163] Subaru WRX [12741]", "[164] Sherp [12742]", "[165] Christma [12743]", "[166] Audi A6 (delimobil) [14119]", "[167] Toyota Camry (delimobil) [14120]", "[168] Kia Sportage (delimobil) [14121]", "[169] Tesla Model X (delimobil) [14122]", "[170] Toyota RAV4 (delimobil) [14123]",
    "[171] Nissan GTR 2017 [14124]", "[172] Mercedes-AMG Project One R50 [14767]", "[173] Aston Martin Valhalla [14768]", "[174] Chevrorlet Aveo [14769]", "[175] Bugatti Bolide [14857]", "[176] Yacota K5 [14884]", "[177] Renault Duster [14899]", "[178] Ferrari Monza SP2 [14904]", "[179] Mercedes-AMG G63 [14905]", "[180] Hotwheels [14906]",
    "[181] Hummer HX [14907]", "[182] Ferrari F70 [14908]", "[183] BMW M5 CS [14909]", "[184] Lada Priora [14910]", "[185] Quadra Turbo-R V-Tech [14911]", "[186] Mercedes-Benz Vision AVTR [14913]", "[187] Specialized Stumpjumper [14914]", "[188] Santa Cruz Tallboy [14915]", "[189] Spooky Metalhead [14916]", "[190] Turner Burner [14917]",
    "[191] Holding Bus Company [14918]", "[192] Los Santos Inter Bus C [14919]", "[193] Dodge Charger [15085]", "[194] BMW M1 [15098]", "[195] Lamborghini Countach [15099]", "[196] Nagasaki [15100]", "[197] Koenigsegg Gemera [15101]", "[198] Kia K7 [15102]", "[199] Lampadati Toro [15103]", "[200] Lexus LX600 [15104]",
    // Puslapis 5
    "[201] Nissan Qashqai [15105]", "[202] Predator [15106]", "[203] Volkswagen Scirocco [15107]", "[204] Longfin [15108]", "[205] Toyota GR [15109]", "[206] Wellcraft [15110]", "[207] Yacht [15111]", "[208] Boates [15112]", "[209] Mercedes-AMG A-45 [15113]", "[210] Toyota AE86 [15114]",
    "[211] Land Rover Defender [15115]", "[212] Ford Mustang Mach [15116]", "[213] Mazda 6 [15117]", "[214] Audi R8S [15118]", "[215] Hyundai Santa Fe [15119]", "[216] Range Rover Velar [15295]", "[217] Mercedes-Benz 1620 [15326]", "[218] Mercedes-Benz 1113 [15327]", "[219] Volkswagen Constellation [15328]", "[220] Luxor Deluxe [15329]",
    "[221] Nimbus [15330]", "[222] Vestra [15331]", "[223] Mercedes-Benz Arocs 4163 [15332]", "[224] Iveco Stralis [15333]", "[225] MAN TGS [15334]", "[226] Volvo 460 [15335]", "[227] VC - Ambulance [15416]", "[228] VC - Banshee [15417]", "[229] VC - Benson [15418]", "[230] VC - Bloodring [15419]",
    "[231] VC - Bus [15420]", "[232] VC - Cabbie [15421]", "[233] VC - Police [15422]", "[234] VC - Deluxo [15423]", "[235] VC - FBI Rancher [15424]", "[236] VC - Flatbed [15425]", "[237] VC - Idaho [15426]", "[238] VC - Infernus [15427]", "[239] VC - Love Fist [15428]", "[240] VC - Patriot [15429]",
    "[241] VC - Pizzaboy [15430]", "[242] VC - Securica [15431]", "[243] VC - Sentinel [15432]", "[244] VC - Stinger [15433]", "[245] VC - Stretch [15434]", "[246] VC - Taxi [15435]", "[247] VC - Trashmaster [15436]", "[248] VC - Angel [15485]", "[249] VC - BF Injection [15486]", "[250] VC - Blista [15487]",
    // Puslapis 6
    "[251] VC - Burrito [15488]", "[252] VC - FBI Car [15489]", "[253] VC - Hotring B [15490]", "[254] VC - Sabre Turbo [15491]", "[255] VC - Sanchez [15492]", "[256] Tesla S - Ambulance [15493]", "[257] Tesla X Ambulance [15494]", "[258] BMW IX [15495]", "[259] Mercedes-Benz EQC 400 [15496]", "[260] Audi E-tron [15497]",
    "[261] Jaguar I-PACE [15498]", "[262] Tesla S - police [15499]", "[263] Tesla X - police [15500]", "[264] Renault Twizy [15501]", "[265] Polestar 2 [15502]", "[266] Arctics Trailer [15720]", "[267] Mercedes-Benz GLE 63S [15721]", "[268] Tesla Model 3 [15722]", "[269] Lamborghini Murcielago [15723]", "[270] Xoomer Petrol [15724]",
    "[271] Delorean [15725]", "[272] Mercedes-Benz G163 [15626]", "[273] BMW 7 [15627]", "[274] MB v250 [15628]", "[275] Mercedes-Benz C63 [15629]", "[276] MB C63s Coupe [15630]", "[277] Audi RS7 [15631]", "[278] BMW X7 [15746]", "[279] BMW X6 [15747]", "[280] Jeep Gladiator [15748]",
    "[281] BMW M8 GRAN Coupe [15749]", "[282] Volkswagen Tourage [15750]", "[283] Range Rover 2022 [15751]", "[284] Mercedes-Benz S63 [15752]", "[285] Mercedes-Benz C63S [15858]", "[286] BMW F10 [15859]", "[287] BMW E30 [15860]", "[288] Volkswagen Transporter [15861]", "[289] Mercedes-Benz Vito [15862]", "[290] Open Vivaro [15863]",
    "[291] Skate [15882]", "[292] Surfboard [15883]", "[293] Audi R80 Universal [15902]", "[294] C63 Coupe [15903]", "[295] BMW E34 [15904]", "[296] Mercedes-Benz E63 W221 [15905]", "[297] BMW X5 F85 [15906]", "[298] Lamborghini Gallardo [15907]", "[299] Mercedes-Benz GLE 63 2016 [15908]", "[300] BMW 850i [15909]",
    // Puslapis 7
    "[301] Audi RS6 Quattro [15910]", "[302] Mercedes GT63 Brabus [15960]", "[303] Mercedes-Benz GLE Brabus [15961]", "[304] McLaren 720S [15962]", "[305] Dodge RAM 3500 [15963]", "[306] AT-99 Scorpion [15964]", "[307] MOP [15965]", "[308] Batmobile [16793]", "[309] Zombiemobile [16794", "[310] Devil [16795]",
    "[311] Police Apocalypse [16796]", "[312] Chum Bucket [16797]", "[313] Hellway [16798]", "[314] Brabus Adventure [16892]", "[315] Brabus 850 [16893]", "[316] Mansory Stallone [16894]", "[317] Bentley Bentayga Mansory [16895]", "[318] Brabus 700 [16896]", "[319] Mercedes-AMG G63 Mansory [16897]", "[320] Brabus GLS 2020 [16898]",
    "[321] Rolls-Royce Cullinan Mansory [16899]", "[322] Lamborghini Urus Mansory [16900]", "[323] Bobcat [New Year] [16903]", "[324] Hotknife [New Year] [16904]", "[325] Snowboard [16920]", "[326] Chevrolet Corvette [16951]", "[327] Porsche Carrera [16952]", "[328] Scramjet [16953]", "[329] Dodge Charger SLT [16954]", "[330] Ferrari F40 [16955]",
    "[331] Canis [16956]", "[332] Chevrolet Tahoe [16957]", "[333] Tampa GT310 [16958]", "[334] Toyota Tundra [16959]", "[335] Scooter 1 [16994]", "[336] Scooter 2 [16995]", "[337] Scooter 3 [16996]", "[338] Cheetah [V] [18164]", "[339] Huntley S [V] [18165]", "[340] Obey [V] [18166]",
    "[341] Infernus Pegassi [V] [18167]", "[342] BMW I7 [18152]", "[343] Shelby Cobra [18153]", "[344] Ford Fusion [18154]", "[345] Toyota Mark II [18155]", "[346] Daewoo Nexia [18156]", "[347] Volkswagen Passat B [18157]", "[348] Infiniti QX80 [18158]", "[349] Mercedes-Benz SL 65 AMG [18159]", "[350] Nissan Titan [18160]",
    // Puslapis 8
    "[351] Ford Victoria [18161]", "[352] Renault Arcana [16800]", "[353] Daewoo Lanos [16879]", "[354] Lada Kalina [16964]", "[355] Lada 112 [16969]", "[356] GAZ 20 [16970]", "[357] Lada 4x4 [16971]", "[358] Lada 4x4 Urban [16972]", "[359] UAZ Hunter [15438]", "[360] Banshee 900R [15439]",
    "[361] Schlagen GT [15442]", "[362] Jeep Grand Cherokee [15443]", "[363] Patriot Mil-Spec [15444]", "[364] Hennessey Velociraptor 6x6 [15445]", "[365] Zentorno [15446]", "[366] Mitsubishi ASX [6710]", "[367] BMW E34 Alpina [6711]", "[368] BMW X5 E70 [6712]", "[369] Honda Accord [6713]", "[370] Lamborghini Huracan 2022 [6714]",
    "[371] Toyota Land Cruiser 100 [6715]", "[372] Daewoo Lanox 6x6 [6716]", "[373] Mercedes-Benz S600 W221 [6717]", "[374] Nissan Silvia S14 [6718]", "[375] Mitsubishi Outlander 2008 [6741]", "[376] Phantom [6742]", "[377] Nissan Silvia S13 [6743]", "[378] Toyota Supra A80 [6744]", "[379] Tank 300 Wey [6745]", "[380] Bentley Ultratank [6746]",
    "[381] Pagani Codalunga [14131]", "[382] Mercedes-Benz Big Foot [14132]", "[383] BMW Big Foot [14133]", "[384] Audi R8 Big Foot [6650]", "[385] Mercedes-Benz Coach [14134]", "[386] Mercedes-Benz Transpen [14135]", "[387] Mercedes-Benz Tourismo [14137]", "[388] Volvo FH 12 [14138]", "[389] Mack Anthem [14139]", "[390] Tesla Semi [14140]",
    "[391] Western Star [14141]", "[392] Business Jet [14142]", "[393] Learjet 60 [14143]", "[394] Spaceflight [14145]", "[395] Audi R8 Darius [14193]", "[396] Dodge Charger Angie [14194]", "[397] Ford Mustang Razor [14195]", "[398] Airship [14338]", "[399] RC Mavic [14355]", "[400] BMW M5 F90 STINGRAY [15877]",
	// Puslapis 9
    "[401] Honda S 2000 [15875]", "[402] Dunbar [15874]", "[403] Mercedes GLC 63S [15873]", "[404] Ford Bronco [15872]", "[405] Renault Arkana (Taksi) [15878]", "[406] Mercedes E63S (Taksi) [15879]", "[407] Ford Fusion (Taksi) [15880]", "[408] Mercedes S500 4Matic (Taksi) [15881]", "[409] Lotus Esprit [15553]", "[410] Mercedes Vito (Fire) [15554]",
    "[411] Naran Hyper Coupe [15555]", "[412] Nissan Silvia S15 [15556]", "[413] Mazda RX7 [15558]", "[414] Nissan GTR [15559]", "[415] Ford Motor (Fire) [15560]", "[416] Madcar [15605]", "[417] Peterblit Track 'Advance' [15618]", "[418] Porsche 911 Turbo S Brabus [15619]", "[419] Madtrain [15620]", "[420] Volvo 460 'Diamond' [15621]",
    "[421] Chevrolet C10 [15635]", "[422] Chevrolet C10 Apocalypse [15653]", "[423] GAZ 21 [15669]", "[424] Corvette C1 [15708]", "[425] Corvette C1 (Barbie) [15710]", "[426] Datsun 280z [15711]", "[427] GMC Savanna [15713]", "[428] Honda NSX 1990 [15733]", "[429] Mystery [15734]", "[430] Nissan 240z [15742]",
    "[431] Skullbike [15743]", "[432] Vaz 2109 [15870]", "[433] Dunbar Track [15874]", "[434] Kamaz [15934]", "[435] Optimus Prime Track [15935]", "[436] Twisted Metal [15937]", "[437] Hell Hot Rod [15942]", "[438] Hulk Hot Rod [15943]", "[439] Ford Explorer 20 [16909]", "[440] AutoDelete",
    "[441] Hummer (Gun) [15730]", "[442] Impala (Gun) [15731]", "[443] Bike Apocalypse [15743]", "[444] Vanda Dendrobium [15561]", "[445] Whiplash [15562]", "[446] Bus Halloween [15563]", "[447] Opel Delivery [15564]", "[448] Audi Q8 Mansory [15565]", "[449] Martini Racing [15566]", "[450] Porsche 911 GT3 [15568]",
    // Puslapis 10
    "[451] BMW XM Mansory [15569]", "[452] Rolls Royce Spectre Mansory [15572]", "[453] Lorus Emira [15457]", "[454] Lixiang L7 [15456]", "[455] Hot Rod Flying [15455]", "[456] Kia EV9 [15454]", "[457] Porsche Cayenne Turbo GT [15453]", "[458] BMW R nineT [15452]", "[459] BMW M4 [15451]", "[460] Volkswagen Amarok [15449]",
    "[461] Nissan Fairlady Z [15742]", "[462] Tuscia [0]", "[463] Tuscia [0]", "[464] Tuscia [0]", "[465] Tuscia [0]", "[466] Tuscia [0]", "[467] Tuscia [0]", "[468] Tuscia [0]", "[469] Tuscia [0]", "[470] Tuscia [0]",
    "[471] Tuscia [0]", "[472] Tuscia [0]", "[473] Tuscia [0]", "[474] Tuscia [0]", "[475] Tuscia [0]", "[476] Tuscia [0]", "[477] Tuscia [0]", "[478] Tuscia [0]", "[479] Tuscia [0]", "[480] Tuscia [0]",
	"[481] Tuscia [0]", "[482] Tuscia [0]", "[483] Tuscia [0]", "[484] Tuscia [0]", "[485] Tuscia [0]", "[486] Tuscia [0]", "[487] Tuscia [0]", "[488] Tuscia [0]", "[489] Tuscia [0]", "[490] Tuscia [0]",
    "[491] Tuscia [0]", "[492] Tuscia [0]", "[493] Tuscia [0]", "[494] Tuscia [0]", "[495] Tuscia [0]", "[496] Tuscia [0]", "[497] Tuscia [0]", "[498] Tuscia [0]", "[499] Tuscia [0]", "[500] Tuscia [0]"

};

CMD:carsinfo(playerid, params[])
{
    new options[128];
    format(options, sizeof(options), "Automobiliu paieska\nPilnas automobiliu sarasas");

    ShowPlayerDialog(playerid, DIALOG_CARSINFO_MAIN, DIALOG_STYLE_LIST, "Automobiliu paieska", options, "Isrinkti", "Atsaukti");
    return 1;
}

stock ShowPage(playerid, page)
{
    new result[2048];
    result[0] = '\0';

    new start = (page - 1) * 50;
    new end = start + 50;

    if(end > sizeof(CarNames)) end = sizeof(CarNames);

    for(new i = start; i < end; i++)
    {
        format(result, sizeof(result), "%s%s\n", result, CarNames[i]);
    }

    new title[64];
    format(title, sizeof(title), "Automobiliu sarasas | Puslapis %d/10", page);

    new button1[16], button2[16];
    if(page < 10) {
        format(button1, sizeof(button1), "Toliau");
    } else {
        format(button1, sizeof(button1), "Uzdaryti");
    }
    if(page > 1) {
        format(button2, sizeof(button2), "Atgal");
    } else {
        format(button2, sizeof(button2), "Uzdaryti");
    }

    ShowPlayerDialog(playerid, DIALOG_CARSINFO_PAGE1 + (page - 1), DIALOG_STYLE_MSGBOX, title, result, button1, button2);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_CARSINFO_RESULTS) return 1;
    if(dialogid == DIALOG_CARSINFO_MAIN) // Svarbiausias dialogas
    {
        if(response)
        {
            if(listitem == 0) // Automobiliu paieska
            {
                ShowPlayerDialog(playerid, DIALOG_CARSINFO_SEARCH, DIALOG_STYLE_INPUT, "Automobiliu paieska", "Iveskite trumpa pavadinima", "Paieska", "Atsaukti");
            }
            else if(listitem == 1) // Perziurejimas pilno saraso
            {
                ShowPage(playerid, 1); // Rodos pirmo puslapio sarasa
            }
        }
    }
    else if(dialogid == DIALOG_CARSINFO_SEARCH) // Automobiliu paieska
    {
        if(response && strlen(inputtext) > 0)
        {
            new result[2048];
            result[0] = '\0';

            // Automobilio paieska su musu tekstu
            new found = false;
            for(new i = 0; i < sizeof(CarNames); i++)
            {
                if(strfind(CarNames[i], inputtext) != -1) // Jeigu automobilio pavadinimas turi ivesta pavadinima
                {
                    format(result, sizeof(result), "%s%s\n", result, CarNames[i]);
                    found = true;
                }
            }

            if(!found)
            {
                format(result, sizeof(result), "Nerasta automobiliu pagal %s", inputtext);
            }

            ShowPlayerDialog(playerid, DIALOG_CARSINFO_RESULTS, DIALOG_STYLE_MSGBOX, "Paieskos rezultatai", result, "Uzdaryti", "");
        }
    }
    else if(dialogid >= DIALOG_CARSINFO_PAGE1 && dialogid <= DIALOG_CARSINFO_PAGE10) // Dialogas su automobiliais
    {
        new page = dialogid - DIALOG_CARSINFO_PAGE1 + 1;

        if(response) // Paspaude "Toliau"
        {
            if(page < 10) ShowPage(playerid, page + 1);
        }
        else // Paspaude "Atgal"
        {
            if(page > 1) ShowPage(playerid, page - 1);
        }
    }
    else return 0; // ne musu dialogas - perduodam gamemode'ui
    return 1;
}

