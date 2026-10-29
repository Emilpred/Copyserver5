// ======================================================================
//  losimu_biuras.inc  (v3)  -  Losimu biuras ("7 is 42" statymu sistema)
//  Portuota is LSG (github.com/vsbenas/LSG, Activities/losimai.inc).
//  Pritaikyta Arizona gamemode: GiveMoney / PI[pMoney].
//
//  Galimybes:
//   - Tikras interjeras (SA-MP arkliu statymo salonas, interjeras 3), kaip LSG.
//   - Iejimas/isejimas paspaudus ALT (markeriai su uzrasais).
//   - Priejus prie kasos meniu atsidaro automatiskai; taip pat /losimai.
//   - /losimubiuras - teleportas i biura.
//   - /losimaistats - administratoriams: laimeta/pralaimeta (siandien + visa laika),
//     issaugoma faile, islieka po restarto.
//
//  INTEGRACIJA (3 kabliukai):
//   1) Failo APACIOJE pridek:  #include "losimu_biuras.inc"
//   2) OnGameModeInit() viduje: Losimu_Init();
//   3) OnDialogResponse(...) is karto po "{":
//        if(Losimu_OnDialog(playerid, dialogid, response, listitem, inputtext)) return 1;
//      ^ BE SIOS EILUTES meniu atsidaro, bet pasirinkimai neveikia!
//   4) OnPlayerKeyStateChange(...) viduje: Losimu_OnKey(playerid, newkeys, oldkeys);
//      ^ be sitos eilutes ALT iejimas neveiks.
// ======================================================================

#if defined _losimu_biuras_included
    #endinput
#endif
#define _losimu_biuras_included

// =========================== KONFIGURACIJA ============================
//  --- interjeras (kur vyksta statymai) ---
#define LB_INTERIOR         (3)            // SA-MP arkliu statymo interjeras
#define LB_WORLD            (7042)         // atskiras virtualus pasaulis biurui
#define LB_X                (822.2601)     // kasos (statymu) tasko koordinates
#define LB_Y                (2.1007)
#define LB_Z                (1004.1797)
#define LB_RADIUS           (12.0)         // atstumas, kuriuo dar galima statyti

//  --- vieta, kur zmogus atsiranda VIDUJE (ta pati vieta kaip isejimas) ---
#define LB_SPAWN_X          (833.2373)
#define LB_SPAWN_Y          (7.0598)
#define LB_SPAWN_Z          (1004.1797)
#define LB_SPAWN_A          (180.0)

//  --- isejimo (duru) taskas VIDUJE ---
#define LB_EXIT_X           (833.2373)
#define LB_EXIT_Y           (7.0598)
#define LB_EXIT_Z           (1004.1797)

//  --- IEJIMAS LAUKE (ieinama/iseinama paspaudus ALT) ---
#define LB_ENTER_X          (1234.8070)    // <--- cia keisk iejimo vieta
#define LB_ENTER_Y          (-1158.1020)
#define LB_ENTER_Z          (23.1280)
#define LB_ENTER_A          (0.0)
#define LB_ENTER_RADIUS     (3.0)          // kokiu atstumu nuo tasko veikia ALT

//  --- statymu ribos ir daznis ---
#define LB_MIN_STAT         (100)          // min. statymo suma
#define LB_MAX_STAT         (100000)       // max. statymo suma
#define LB_FREQUENCY        (60)           // sekundziu tarp losimu

//  --- dialogu ID (nekeisk, jei nera konflikto) ---
#define LBD_MAIN            (31500)
#define LBD_CAT             (31501)
#define LBD_INPUT           (31502)
#define LBD_SUMA            (31503)
#define LBD_CONFIRM         (31504)

//  --- spalvos ---
#define LB_C_WIN            (0x2E9AFEFF)
#define LB_C_RED            (0xBE3A3AFF)
#define LB_C_RECEIPT        (0xC2A2DAFF)
#define LB_C_INFO           (0x33CCFFFF)

//  --- statistika / administravimas ---
#define LB_STATS_FILE       "losimu_biuras.ini"   // issaugoma scriptfiles/ kataloge
#define LB_ADMIN_LVL        (1)                    // min. admino lygis /losimaistats komandai
// ======================================================================


// --------------------------- BET DUOMENYS -----------------------------
enum eLosimai
{
    l_kategorija,
    l_statymas[128],
    Float:l_koef,
    l_pav[128]
};

new const lb_kat[][] =
{
    {"Skaiciai"},
    {"Juodu/geltonu kamuoliuku kiekis"},
    {"Iskritusiu kamuoliuku skaiciu suma"},
    {"Iskritusiu kamuoliuku kiekis"},
    {"Lyginis/Nelyginis"},
    {"Juodas/Geltonas"}
};

new const lb_stat[][eLosimai] =
{
    {1,"Iskris pasirinktas kamuoliukas Nr.1,...,42",5.70,"Iveskite kamuoliuko numeri.\nPvz.:{FFFFFF} 1"},
    {1,"Neiskris pasirinktas kamuoliukas Nr. 1,...,42",1.14,"Iveskite kamuoliuko numeri.\nPvz.:{FFFFFF} 1"},
    {1,"Iskris du pasirinkti kamuoliukai Nr. 1,...,42",32.00,"Iveskite kamuoliuku numerius.\nPvz.:{FFFFFF} 1 2"},
    {1,"Iskris trys pasirinkti kamuoliukai Nr. 1,...,42",225.00,"Iveskite kamuoliuku numerius.\nPvz.:{FFFFFF} 1 2 3"},
    {1,"Iskris keturi pasirinkti kamuoliukai Nr. 1,...,42",2000.00,"Iveskite kamuoliuku numerius.\nPvz.:{FFFFFF} 1 2 3 4"},
    {1,"Is septyniu pasirinktu skaiciu neiskris nei vienas",3.50,"Iveskite pasirinktus skaicius.\nPvz.:{FFFFFF} 1 2 3 4 5 6 7"},
    {1,"Is septyniu pasirinktu skaiciu iskris bent vienas pasirinktas skaicius",1.25,"Iveskite pasirinktus skaicius. Pvz.:{FFFFFF} 1 2 3 4 5 6 7"},
    {1,"Is septyniu pasirinktu skaiciu iskris bent du pasirinkti skaiciai",2.85,"Iveskite pasirinktus skaicius. Pvz.:{FFFFFF} 1 2 3 4 5 6 7"},
    {1,"Is septyniu pasirinktu skaiciu iskris bent trys pasirinkti skaiciai",12.00,"Iveskite pasirinktus skaicius. Pvz.:{FFFFFF} 1 2 3 4 5 6 7"},
    {1,"Is septyniu pasirinktu skaiciu iskris bent keturi pasirinkti skaiciai",100.00,"Iveskite pasirinktus skaicius. Pvz.:{FFFFFF} 1 2 3 4 5 6 7"},
    {1,"Is septyniu pasirinktu skaiciu iskris bent penki pasirinkti skaiciai",1800.00,"Iveskite pasirinktus skaicius. Pvz.:{FFFFFF} 1 2 3 4 5 6 7"},
    {2,"Iskritusiu geltonu kamuoliuku skaiciu suma bus mazesne nei 73,5",1.90,""},
    {2,"Iskritusiu geltonu kamuoliuku skaiciu suma bus didesne nei 73,5",1.90,""},
    {2,"Iskritusiu juodu kamuoliuku skaiciu suma bus mazesne nei 73,5",1.90,""},
    {2,"Iskritusiu juodu kamuoliuku skaiciu suma bus didesne nei 73,5",1.90,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus mazesne nei 100,5",19.00,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus mazesne nei 125,5",4.60,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus didesne nei 125,5",1.17,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus mazesne nei 150,5",1.90,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus didesne nei 150,5",1.90,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus mazesne nei 175,5",1.17,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus didesne nei 175,5",4.60,""},
    {3,"Iskritusiu kamuoliuku skaiciu suma bus didesne nei 200,5",19.00,""},
    {4,"Geltonos spalvos kamuoliuku iskris maziau nei 3,5",1.90,""},
    {4,"Geltonos spalvos kamuoliuku iskris daugiau nei 3,5",1.90,""},
    {4,"Geltonos spalvos kamuoliuku iskris maziau nei 2,5",4.55,""},
    {4,"Geltonos spalvos kamuoliuku iskris daugiau nei 2,5",1.17,""},
    {4,"Geltonos spalvos kamuoliuku iskris maziau nei 1,5",20.00,""},
    {4,"Geltonos spalvos kamuoliuku iskris daugiau nei 1,5",1.01,""},
    {4,"Neiskris geltonos spalvos kamuoliukas",200.00,""},
    {4,"Juodos spalvos kamuoliuku iskris maziau nei 3,5",1.90,""},
    {4,"Juodos spalvos kamuoliuku iskris daugiau nei 3,5",1.90,""},
    {4,"Juodos spalvos kamuoliuku iskris maziau nei 2,5",4.55,""},
    {4,"Juodos spalvos kamuoliuku iskris daugiau nei 2,5",1.17,""},
    {4,"Juodos spalvos kamuoliuku iskris maziau nei 1,5",20.00,""},
    {4,"Juodos spalvos kamuoliuku iskris daugiau nei 1,5",1.01,""},
    {4,"Neiskris juodos spalvos kamuoliukas",200.00,""},
    {4,"Iskris septyni geltonos spalvos kamuoliukai",200.00,""},
    {4,"Iskris lygiai sesi geltonos spalvos kamuoliukai",22.00,""},
    {4,"Iskris lygiai penki geltonos spalvos kamuoliukai",5.90,""},
    {4,"Iskris lygiai keturi geltonos spalvos kamuoliukai",3.00,""},
    {4,"Iskris lygiai trys geltonos spalvos kamuoliukai",3.00,""},
    {4,"Iskris lygiai du geltonos spalvos kamuoliukai",5.90,""},
    {4,"Iskris lygiai vienas geltonos spalvos kamuoliukas",22.00,""},
    {4,"Iskris septyni juodos spalvos kamuoliukai",200.00,""},
    {4,"Iskris lygiai sesi juodos spalvos kamuoliukai",22.00,""},
    {4,"Iskris lygiai penki juodos spalvos kamuoliukai",5.90,""},
    {4,"Iskris lygiai keturi juodos spalvos kamuoliukai",3.00,""},
    {4,"Iskris lygiai trys juodos spalvos kamuoliukai",3.00,""},
    {4,"Iskris lygiai du juodos spalvos kamuoliukai",5.90,""},
    {4,"Iskris lygiai vienas juodos spalvos kamuoliukas",22.00,""},
    {5,"Iskris daugiau kamuoliuku su nelyginiais skaiciais",1.90,""},
    {5,"Iskris daugiau kamuoliuku su lyginiais skaiciais",1.90,""},
    {5,"Iskritusiu kamuoliuku skaiciu suma - nelyginis skaicius",1.90,""},
    {5,"Iskritusiu kamuoliuku skaiciu suma - lyginis skaicius",1.90,""},
    {5,"Pirmo iskritusio kamuoliuko skaicius - nelyginis",1.90,""},
    {5,"Pirmo iskritusio kamuoliuko skaicius - lyginis",1.90,""},
    {5,"Paskutinio iskritusio kamuoliuko skaicius - nelyginis",1.90,""},
    {5,"Paskutinio iskritusio kamuoliuko skaicius - lyginis",1.90,""},
    {5,"Pirmu dvieju iskritusiu kamuoliuku skaiciai - nelyginiai",3.90,""},
    {5,"Pirmu dvieju iskritusiu kamuoliuku skaiciai - lyginiai",3.90,""},
    {5,"Pirmo iskritusio kamuoliuko skaicius - nelyginis, antro - lyginis",3.70,""},
    {5,"Pirmo iskritusio kamuoliuko skaicius - lyginis, antro - nelyginis",3.70,""},
    {5,"Pirmo kamuoliuko skaicius - nelyginis, paskutinio - lyginis",3.70,""},
    {5,"Pirmo kamuoliuko skaicius - lyginis, paskutinio - nelyginis",3.70,""},
    {6,"Pirmas iskrites kamuoliukas bus geltonos spalvos",1.90,""},
    {6,"Pirmas iskrites kamuoliukas bus juodos spalvos",1.90,""},
    {6,"Paskutinis iskrites kamuoliukas bus geltonos spalvos",1.90,""},
    {6,"Paskutinis iskrites kamuoliukas bus juodos spalvos",1.90,""},
    {6,"Iskris daugiau geltonos spalvos kamuoliuku",1.90,""},
    {6,"Iskris daugiau juodos spalvos kamuoliuku",1.90,""},
    {6,"Antras iskrites kamuoliukas bus tos pacios spalvos kaip ir pirmas",1.95,""},
    {6,"Antruoju iskrites kamuoliukas bus kitos spalvos nei pirmasis",1.85,""}
};
// ----------------------------------------------------------------------


// ----------------------------- BUSENA ---------------------------------
new LB_Laikas       = LB_FREQUENCY;
new LB_Ridenta      = 0;
new LB_LAR[7];
new LB_Losejai      = 0;
new Text3D:LB_Label = Text3D:-1;
new LB_Row[MAX_PLAYERS][80];

// statistika (issaugoma faile, islieka po restarto)
new LB_StWonTotal  = 0;   // kiek zaidejai laimejo is viso
new LB_StLostTotal = 0;   // kiek zaidejai pralaimejo is viso
new LB_StWonDay    = 0;   // kiek laimejo sia diena
new LB_StLostDay   = 0;   // kiek pralaimejo sia diena
new LB_StDay       = 0;   // diena (YYYYMMDD), kad zinotume kada nulinti dienos stats
// ----------------------------------------------------------------------


// ---------------------------- HELPERIAI -------------------------------
stock LB_FmtNum(num, dest[], destlen = sizeof(dest))
{
    new tmp[24], neg = (num < 0);
    if(neg) num = -num;
    format(tmp, sizeof(tmp), "%d", num);
    new l = strlen(tmp), o = 0;
    dest[0] = 0;
    if(neg && o < destlen - 1) dest[o++] = '-';
    for(new i = 0; i < l; i++)
    {
        if(o >= destlen - 1) break;
        dest[o++] = tmp[i];
        new rem = l - 1 - i;
        if(rem > 0 && (rem % 3) == 0 && o < destlen - 1) dest[o++] = '.';
    }
    dest[o] = 0;
}

stock LB_IsNumeric(const str[])
{
    if(str[0] == 0) return 0;
    for(new i = 0; str[i] != 0; i++)
        if(str[i] < '0' || str[i] > '9') return 0;
    return 1;
}

stock LB_PlaySound(soundid, Float:x, Float:y, Float:z, Float:range)
{
    foreach(new i : Player)
        if(IsPlayerInRangeOfPoint(i, range, x, y, z))
            PlayerPlaySound(i, soundid, x, y, z);
}

stock LB_GaliStatyti()
{
    return (LB_Laikas > 0);
}

// ---- statistikos pagalbininkai ----
stock LB_Today()
{
    new y, m, d;
    getdate(y, m, d);
    return y * 10000 + m * 100 + d;
}

stock LB_SaveStats()
{
    new File:hFile = fopen(LB_STATS_FILE, io_write);
    if(!hFile) return 0;
    new line[160];
    format(line, sizeof(line), "%d %d %d %d %d", LB_StWonTotal, LB_StLostTotal, LB_StWonDay, LB_StLostDay, LB_StDay);
    fwrite(hFile, line);
    fclose(hFile);
    return 1;
}

stock LB_CheckDay()
{
    new t = LB_Today();
    if(LB_StDay != t)
    {
        LB_StDay = t;
        LB_StWonDay = 0;
        LB_StLostDay = 0;
        LB_SaveStats();
    }
}

stock LB_LoadStats()
{
    new File:hFile = fopen(LB_STATS_FILE, io_read);
    if(hFile)
    {
        new line[160];
        fread(hFile, line);
        fclose(hFile);
        sscanf(line, "p< >ddddd", LB_StWonTotal, LB_StLostTotal, LB_StWonDay, LB_StLostDay, LB_StDay);
    }
    LB_CheckDay();
    return 1;
}

stock LB_CanBet(playerid)
{
    if(GetPlayerInterior(playerid) != LB_INTERIOR) return 0;
    if(GetPlayerVirtualWorld(playerid) != LB_WORLD) return 0;
    if(!IsPlayerInRangeOfPoint(playerid, LB_RADIUS, LB_X, LB_Y, LB_Z)) return 0;
    return 1;
}

stock LB_NearXY(playerid, Float:x, Float:y, Float:r)
{
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    return (((px - x) * (px - x)) + ((py - y) * (py - y))) <= (r * r);
}

stock LB_EnterBiuras(playerid)
{
    SetPVarInt(playerid, "lb_retvw", GetPlayerVirtualWorld(playerid)); // isisaugom is kur atejo
    SetPlayerInterior(playerid, LB_INTERIOR);
    SetPlayerVirtualWorld(playerid, LB_WORLD);
    SetPlayerPos(playerid, LB_SPAWN_X, LB_SPAWN_Y, LB_SPAWN_Z);
    SetPlayerFacingAngle(playerid, LB_SPAWN_A);
    SetCameraBehindPlayer(playerid);
    SetPVarInt(playerid, "lb_inside", 1);
}

stock LB_ExitBiuras(playerid)
{
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "lb_retvw"));
    SetPlayerPos(playerid, LB_ENTER_X, LB_ENTER_Y, LB_ENTER_Z);
    SetPlayerFacingAngle(playerid, LB_ENTER_A);
    SetCameraBehindPlayer(playerid);
    SetPVarInt(playerid, "lb_inside", 0);
}
// ----------------------------------------------------------------------


// ---------------------------- INICIALIZACIJA --------------------------
stock Losimu_Init()
{
    LB_LoadStats();

    if(LB_Label == Text3D:-1)
        LB_Label = CreateDynamic3DTextLabel("{33CCFF}7 is 42\n\n\n{FFFFFF}Iki kito losimo liko {00864b}01:00",
            -1, LB_X, LB_Y, LB_Z + 0.9, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, LB_WORLD, LB_INTERIOR);

    // IEJIMAS lauke - uzrasas + markeris (ieinama paspaudus ALT)
    CreateDynamic3DTextLabel("{FFFFFF}Losimu biuras\n{A19D9D}Paspausk {FFFFFF}ALT {A19D9D}noredamas ieiti",
        -1, LB_ENTER_X, LB_ENTER_Y, LB_ENTER_Z + 0.6, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
    CreateDynamicPickup(1239, 1, LB_ENTER_X, LB_ENTER_Y, LB_ENTER_Z, 0, 0);

    // ISEJIMAS viduje - uzrasas + markeris (iseinama paspaudus ALT)
    CreateDynamic3DTextLabel("{FFFFFF}Isejimas\n{A19D9D}Paspausk {FFFFFF}ALT",
        -1, LB_EXIT_X, LB_EXIT_Y, LB_EXIT_Z + 0.6, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, LB_WORLD, LB_INTERIOR);
    CreateDynamicPickup(1318, 1, LB_EXIT_X, LB_EXIT_Y, LB_EXIT_Z, LB_WORLD, LB_INTERIOR);

    // KASA (statymai) - markeris
    CreateDynamicPickup(1274, 1, LB_X, LB_Y, LB_Z, LB_WORLD, LB_INTERIOR);

    SetTimer("Losimu_Update", 1000, true);
    return 1;
}

// Kviesk is OnPlayerKeyStateChange:  Losimu_OnKey(playerid, newkeys, oldkeys);
//  ALT (KEY_WALK) - toks pat klavisas kaip iejimui i namus. Y (KEY_YES) -
//  atsarginis klavisas, jei ALT kokiu nors klientu neveiktu.
stock Losimu_OnKey(playerid, newkeys, oldkeys)
{
    new bool:pressed = (((newkeys & KEY_WALK) && !(oldkeys & KEY_WALK)) ||
                        ((newkeys & KEY_YES)  && !(oldkeys & KEY_YES)));
    if(!pressed) return 0;

    if(!GetPVarInt(playerid, "lb_inside"))
    {
        // LAUKE: netikrinam virtualaus pasaulio (kaip ir namu durys), tik interjera + atstuma (be Z)
        if(GetPlayerInterior(playerid) == 0 && LB_NearXY(playerid, LB_ENTER_X, LB_ENTER_Y, LB_ENTER_RADIUS))
        {
            LB_EnterBiuras(playerid);
            SetPVarInt(playerid, "lb_armCounter", 0);
        }
    }
    else
    {
        // VIDUJE: prie duru - iseiti
        if(LB_NearXY(playerid, LB_EXIT_X, LB_EXIT_Y, LB_ENTER_RADIUS))
            LB_ExitBiuras(playerid);
    }
    return 1;
}
// ----------------------------------------------------------------------


// ----------------------------- ZAIDIMO CIKLAS -------------------------
forward Losimu_Update();
public Losimu_Update()
{
    // ----- (1) losimo skaitliukas / ridenimas -----
    LB_Laikas--;
    if(LB_Laikas > 0)
    {
        new msg[128], minutes = LB_Laikas / 60, sekundes = LB_Laikas % 60;
        format(msg, sizeof(msg), "{33CCFF}7 is 42\n\n\n{FFFFFF}Iki kito losimo liko {00ff7f}0%i:%s%i",
            minutes, ((sekundes < 10) ? ("0") : ("")), sekundes);
        UpdateDynamic3DTextLabelText(LB_Label, -1, msg);
    }
    else if(LB_Laikas == 0)
    {
        LB_Ridenta = 0;
        UpdateDynamic3DTextLabelText(LB_Label, -1, "{33CCFF}7 is 42\n\n\n{FFFFFF}Pradedamas ridenimas!");
        LB_PlaySound(5408 + random(3), LB_X, LB_Y, LB_Z, 30.0);
    }
    else
    {
        if(!LB_Ridenta)
        {
            new Kamuoliukai[42];
            for(new i; i < 42; i++) Kamuoliukai[i] = i + 1;
            for(new z; z < 3; z++)
                for(new i = 0; i < 42; i++)
                {
                    new x = random(42), temp = Kamuoliukai[x];
                    Kamuoliukai[x] = Kamuoliukai[i];
                    Kamuoliukai[i] = temp;
                }
            new startpos = random(30);
            for(new i; i < 7; i++) LB_LAR[i] = Kamuoliukai[startpos + i];
            LB_Ridenta = 1;
        }
        new showcount = (-LB_Laikas) / 3, show = (-LB_Laikas) % 3;
        if(showcount < 8)
        {
            if(show == 0)
            {
                new msg[512];
                format(msg, sizeof(msg), "{33CCFF}7 is 42\n\n\n{FFFFFF}Iskrite kamuoliukai:\n");
                for(new i; i < showcount; i++)
                {
                    new color[12];
                    if(LB_LAR[i] % 2 == 0) color = "{919191}"; else color = "{ffff00}";
                    format(msg, sizeof(msg), "%s%s%i   ", msg, color, LB_LAR[i]);
                }
                LB_AnounceBalls(showcount);
                UpdateDynamic3DTextLabelText(LB_Label, -1, msg);
            }
        }
        else if(showcount == 8)
        {
            LB_Nugaletojai();
            LB_Laikas = LB_FREQUENCY + 1;
            LB_PlaySound(5400 + random(2), LB_X, LB_Y, LB_Z, 30.0);
        }
    }

    // ----- (2) dienos statistikos nulinimas + auto-meniu prie kasos -----
    LB_CheckDay();
    foreach(new i : Player)
    {
        if(!GetPVarInt(i, "lb_inside")) continue;
        // priejus prie kasos - meniu atsidaro automatiskai (viena karta)
        if(IsPlayerInRangeOfPoint(i, 1.5, LB_X, LB_Y, LB_Z))
        {
            if(GetPVarInt(i, "lb_armCounter"))
            {
                SetPVarInt(i, "lb_armCounter", 0);
                if(!GetPVarInt(i, "lb_active") && LB_GaliStatyti())
                {
                    if(!GetPVarInt(i, "lb_suma")) SetPVarInt(i, "lb_suma", LB_MIN_STAT);
                    Losimu_ShowMain(i);
                }
            }
        }
        else SetPVarInt(i, "lb_armCounter", 1);
    }
    return 1;
}

stock LB_AnounceBalls(showcount)
{
    new msg[512];
    format(msg, sizeof(msg), "{33CCFF}[7 is 42]{FFFFFF} Iskrite kamuoliukai: ");
    for(new i; i < showcount; i++)
    {
        new color[12];
        if(LB_LAR[i] % 2 == 0) color = "{919191}"; else color = "{ffff00}";
        format(msg, sizeof(msg), "%s%s%i  ", msg, color, LB_LAR[i]);
    }
    foreach(new i : Player)
    {
        if(IsPlayerInRangeOfPoint(i, LB_RADIUS, LB_X, LB_Y, LB_Z) || GetPVarInt(i, "lb_active"))
        {
            PlayerPlaySound(i, 1138, 0.0, 0.0, 0.0);
            SendClientMessage(i, -1, msg);
        }
    }
}

stock LB_Nugaletojai()
{
    if(!LB_Losejai) return;
    LB_Losejai = 0;
    foreach(new i : Player)
    {
        if(GetPVarInt(i, "lb_active"))
        {
            LB_CheckWinner(i, GetPVarInt(i, "lb_betid"));
            SetPVarInt(i, "lb_active", 0);
        }
    }
}
// ----------------------------------------------------------------------


// ---------------------------- LAIMEJIMO TIKRINIMAS --------------------
stock LB_CheckWinner(playerid, statymoid)
{
    new winner = 0;
    if(statymoid < 11)
    {
        new numbers[7];
        for(new i; i < 7; i++)
        {
            new temp[24];
            format(temp, sizeof(temp), "lb_num%i", i);
            numbers[i] = GetPVarInt(playerid, temp);
        }
        switch(statymoid)
        {
            case 0:
            {
                for(new i; i < 7; i++)
                    if(LB_LAR[i] == numbers[0]) winner = 1;
            }
            case 1:
            {
                winner = 1;
                for(new i; i < 7; i++)
                    if(LB_LAR[i] == numbers[0]) winner = 0;
            }
            case 2:
            {
                new count = 0;
                for(new i; i < 7; i++)
                    if(LB_LAR[i] == numbers[0] || LB_LAR[i] == numbers[1]) count++;
                if(count >= 2) winner = 1;
            }
            case 3:
            {
                new count = 0;
                for(new i; i < 7; i++)
                    if(LB_LAR[i] == numbers[0] || LB_LAR[i] == numbers[1] || LB_LAR[i] == numbers[2]) count++;
                if(count >= 3) winner = 1;
            }
            case 4:
            {
                new count = 0;
                for(new i; i < 7; i++)
                    if(LB_LAR[i] == numbers[0] || LB_LAR[i] == numbers[1] || LB_LAR[i] == numbers[2] || LB_LAR[i] == numbers[3]) count++;
                if(count >= 4) winner = 1;
            }
            case 5:
            {
                winner = 1;
                for(new i; i < 7; i++)
                    for(new x; x < 7; x++)
                        if(LB_LAR[i] == numbers[x]) winner = 0;
            }
            case 6:
            {
                for(new i; i < 7; i++)
                    for(new x; x < 7; x++)
                        if(LB_LAR[i] == numbers[x]) winner = 1;
            }
            case 7:
            {
                new count = 0;
                for(new i; i < 7; i++)
                    for(new x; x < 7; x++)
                        if(LB_LAR[i] == numbers[x]) count++;
                if(count >= 2) winner = 1;
            }
            case 8:
            {
                new count = 0;
                for(new i; i < 7; i++)
                    for(new x; x < 7; x++)
                        if(LB_LAR[i] == numbers[x]) count++;
                if(count >= 3) winner = 1;
            }
            case 9:
            {
                new count = 0;
                for(new i; i < 7; i++)
                    for(new x; x < 7; x++)
                        if(LB_LAR[i] == numbers[x]) count++;
                if(count >= 4) winner = 1;
            }
            case 10:
            {
                new count = 0;
                for(new i; i < 7; i++)
                    for(new x; x < 7; x++)
                        if(LB_LAR[i] == numbers[x]) count++;
                if(count >= 5) winner = 1;
            }
        }
    }
    new geltonusum = 0, juodusum = 0, juodu = 0, geltonu = 0;
    for(new i; i < 7; i++)
    {
        if(LB_LAR[i] % 2 == 0) { juodusum += LB_LAR[i]; juodu++; }
        else { geltonu++; geltonusum += LB_LAR[i]; }
    }
    new lyginiu = juodu, nelyginiu = geltonu, sum = geltonusum + juodusum;
    switch(statymoid)
    {
        case 11: if(geltonusum < 73.5) winner = 1;
        case 12: if(geltonusum > 73.5) winner = 1;
        case 13: if(juodusum < 73.5) winner = 1;
        case 14: if(juodusum > 73.5) winner = 1;
        case 15: if(sum < 100.5) winner = 1;
        case 16: if(sum < 125.5) winner = 1;
        case 17: if(sum > 125.5) winner = 1;
        case 18: if(sum < 150.5) winner = 1;
        case 19: if(sum > 150.5) winner = 1;
        case 20: if(sum < 175.5) winner = 1;
        case 21: if(sum > 175.5) winner = 1;
        case 22: if(sum > 200.5) winner = 1;
        case 23: if(geltonu < 3.5) winner = 1;
        case 24: if(geltonu > 3.5) winner = 1;
        case 25: if(geltonu < 2.5) winner = 1;
        case 26: if(geltonu > 2.5) winner = 1;
        case 27: if(geltonu < 1.5) winner = 1;
        case 28: if(geltonu > 1.5) winner = 1;
        case 29: if(geltonu == 0) winner = 1;
        case 30: if(juodu < 3.5) winner = 1;
        case 31: if(juodu > 3.5) winner = 1;
        case 32: if(juodu < 2.5) winner = 1;
        case 33: if(juodu > 2.5) winner = 1;
        case 34: if(juodu < 1.5) winner = 1;
        case 35: if(juodu > 1.5) winner = 1;
        case 36: if(juodu == 0) winner = 1;
        case 37: if(geltonu == 7) winner = 1;
        case 38: if(geltonu == 6) winner = 1;
        case 39: if(geltonu == 5) winner = 1;
        case 40: if(geltonu == 4) winner = 1;
        case 41: if(geltonu == 3) winner = 1;
        case 42: if(geltonu == 2) winner = 1;
        case 43: if(geltonu == 1) winner = 1;
        case 44: if(juodu == 7) winner = 1;
        case 45: if(juodu == 6) winner = 1;
        case 46: if(juodu == 5) winner = 1;
        case 47: if(juodu == 4) winner = 1;
        case 48: if(juodu == 3) winner = 1;
        case 49: if(juodu == 2) winner = 1;
        case 50: if(juodu == 1) winner = 1;
        case 51: if(nelyginiu > lyginiu) winner = 1;
        case 52: if(lyginiu > nelyginiu) winner = 1;
        case 53: if(sum % 2 == 1) winner = 1;
        case 54: if(sum % 2 == 0) winner = 1;
        case 55: if(LB_LAR[0] % 2 == 1) winner = 1;
        case 56: if(LB_LAR[0] % 2 == 0) winner = 1;
        case 57: if(LB_LAR[6] % 2 == 1) winner = 1;
        case 58: if(LB_LAR[6] % 2 == 0) winner = 1;
        case 59: if(LB_LAR[0] % 2 == 1 && LB_LAR[1] % 2 == 1) winner = 1;
        case 60: if(LB_LAR[0] % 2 == 0 && LB_LAR[1] % 2 == 0) winner = 1;
        case 61: if(LB_LAR[0] % 2 == 1 && LB_LAR[1] % 2 == 0) winner = 1;
        case 62: if(LB_LAR[0] % 2 == 0 && LB_LAR[1] % 2 == 1) winner = 1;
        case 63: if(LB_LAR[0] % 2 == 1 && LB_LAR[6] % 2 == 0) winner = 1;
        case 64: if(LB_LAR[0] % 2 == 0 && LB_LAR[6] % 2 == 1) winner = 1;
        case 65: if(LB_LAR[0] % 2 == 1) winner = 1;
        case 66: if(LB_LAR[0] % 2 == 0) winner = 1;
        case 67: if(LB_LAR[6] % 2 == 1) winner = 1;
        case 68: if(LB_LAR[6] % 2 == 0) winner = 1;
        case 69: if(geltonu > juodu) winner = 1;
        case 70: if(juodu > geltonu) winner = 1;
        case 71: if((LB_LAR[0] % 2) == (LB_LAR[1] % 2)) winner = 1;
        case 72: if((LB_LAR[0] % 2) != (LB_LAR[1] % 2)) winner = 1;
    }
    if(winner) LB_IsWinner(playerid, statymoid);
    else LB_IsLoser(playerid);
    return winner;
}

stock LB_IsWinner(playerid, statymoid)
{
    new suma = floatround(GetPVarInt(playerid, "lb_stake") * lb_stat[statymoid][l_koef]);
    new sbuf[24], msg[128];
    LB_FmtNum(suma, sbuf);
    format(msg, sizeof(msg), " * Laimejai {FFFFFF}%s EUR!", sbuf);
    SendClientMessage(playerid, LB_C_WIN, msg);
    GiveMoney(playerid, suma);
    // statistika
    LB_StWonTotal += suma;
    LB_StWonDay   += suma;
    LB_SaveStats();
}

stock LB_IsLoser(playerid)
{
    new stake = GetPVarInt(playerid, "lb_stake");
    SendClientMessage(playerid, LB_C_WIN, " * Siakart nepasiseke. Pabandyk kita karta!");
    // statistika
    LB_StLostTotal += stake;
    LB_StLostDay   += stake;
    LB_SaveStats();
}
// ----------------------------------------------------------------------


// ---------------------------------- UI --------------------------------
stock Losimu_ShowMain(playerid)
{
    new str[512], line[128], sbuf[24];
    LB_FmtNum(GetPVarInt(playerid, "lb_suma"), sbuf);
    format(line, sizeof(line), "Statymo suma: {00ff7f}%s EUR\n", sbuf);
    strcat(str, line);
    for(new i; i < sizeof(lb_kat); i++)
    {
        format(line, sizeof(line), "%s\n", lb_kat[i]);
        strcat(str, line);
    }
    ShowPlayerDialog(playerid, LBD_MAIN, DIALOG_STYLE_LIST, "7 is 42", str, "Rinktis", "Iseiti");
}

stock LB_ShowCat(playerid, kat)
{
    new str[3072], line[200], row = 0;
    strcat(str, "Statymas\tKoeficientas\n");
    for(new i; i < sizeof(lb_stat); i++)
    {
        if(lb_stat[i][l_kategorija] == kat)
        {
            format(line, sizeof(line), "%s\t{00ff7f}%.2f\n", lb_stat[i][l_statymas], lb_stat[i][l_koef]);
            strcat(str, line);
            if(row < sizeof(LB_Row[])) LB_Row[playerid][row] = i;
            row++;
        }
    }
    ShowPlayerDialog(playerid, LBD_CAT, DIALOG_STYLE_TABLIST_HEADERS, lb_kat[kat-1], str, "Rinktis", "Atgal");
}

stock LB_LoadStatymas(playerid, statymoid)
{
    SetPVarInt(playerid, "lb_id", statymoid);
    if(strlen(lb_stat[statymoid][l_pav]) == 0)
    {
        LB_Verify(playerid, statymoid, "");
    }
    else
    {
        new msg[512];
        format(msg, sizeof(msg), "Norite atlikti si statyma:\n{FFFFFF}%s\n\n{A9C4E4}%s",
            lb_stat[statymoid][l_statymas], lb_stat[statymoid][l_pav]);
        ShowPlayerDialog(playerid, LBD_INPUT, DIALOG_STYLE_INPUT, "Statymas", msg, "Gerai", "Atsaukti");
    }
}

stock LB_Verify(playerid, statymoid, statymelis[])
{
    new taip = 0, numbers[7], statymux[48];
    if(statymoid > 10)
    {
        taip = 1;
        SetPVarString(playerid, "lb_pick", "Taip");
    }
    else
    {
        switch(statymoid + 1)
        {
            case 1, 2:
            {
                if(sscanf(statymelis, "d", numbers[0]))
                {
                    SendClientMessage(playerid, LB_C_RED, " * Netinkamas formatas!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                if(numbers[0] < 1 || numbers[0] > 42)
                {
                    SendClientMessage(playerid, LB_C_RED, " * Turite ivesti skaiciu nuo 1 iki 42!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
            }
            case 3:
            {
                if(sscanf(statymelis, "dd", numbers[0], numbers[1]))
                {
                    SendClientMessage(playerid, LB_C_RED, " * Netinkamas formatas!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                if(numbers[0] == numbers[1])
                {
                    SendClientMessage(playerid, LB_C_RED, " * Turite ivesti skirtingus skaicius!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                if(numbers[0] < 1 || numbers[0] > 42 || numbers[1] < 1 || numbers[1] > 42)
                {
                    SendClientMessage(playerid, LB_C_RED, " * Turite ivesti du skaicius nuo 1 iki 42!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
            }
            case 4:
            {
                if(sscanf(statymelis, "ddd", numbers[0], numbers[1], numbers[2]))
                {
                    SendClientMessage(playerid, LB_C_RED, " * Netinkamas formatas!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                if(numbers[0] == numbers[1] || numbers[1] == numbers[2] || numbers[0] == numbers[2])
                {
                    SendClientMessage(playerid, LB_C_RED, " * Turite ivesti skirtingus skaicius!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                if(numbers[0] < 1 || numbers[0] > 42 || numbers[1] < 1 || numbers[1] > 42 || numbers[2] < 1 || numbers[2] > 42)
                {
                    SendClientMessage(playerid, LB_C_RED, " * Turite ivesti tris skaicius nuo 1 iki 42!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
            }
            case 5:
            {
                if(sscanf(statymelis, "dddd", numbers[0], numbers[1], numbers[2], numbers[3]))
                {
                    SendClientMessage(playerid, LB_C_RED, " * Netinkamas formatas!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                if(numbers[0] == numbers[1] || numbers[1] == numbers[2] || numbers[2] == numbers[3] ||
                   numbers[0] == numbers[2] || numbers[0] == numbers[3] || numbers[1] == numbers[3])
                {
                    SendClientMessage(playerid, LB_C_RED, " * Turite ivesti skirtingus skaicius!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                if(numbers[0] < 1 || numbers[0] > 42 || numbers[1] < 1 || numbers[1] > 42 ||
                   numbers[2] < 1 || numbers[2] > 42 || numbers[3] < 1 || numbers[3] > 42)
                {
                    SendClientMessage(playerid, LB_C_RED, " * Turite ivesti keturis skaicius nuo 1 iki 42!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
            }
            case 6 .. 11:
            {
                if(sscanf(statymelis, "ddddddd", numbers[0], numbers[1], numbers[2], numbers[3], numbers[4], numbers[5], numbers[6]))
                {
                    SendClientMessage(playerid, LB_C_RED, " * Netinkamas formatas!");
                    LB_LoadStatymas(playerid, statymoid);
                    return 0;
                }
                for(new i; i < 7; i++)
                {
                    if(numbers[i] < 1 || numbers[i] > 42)
                    {
                        SendClientMessage(playerid, LB_C_RED, " * Turite ivesti septynis skaicius nuo 1 iki 42!");
                        LB_LoadStatymas(playerid, statymoid);
                        return 0;
                    }
                    for(new x = i + 1; x < 7; x++)
                        if(numbers[x] == numbers[i])
                        {
                            SendClientMessage(playerid, LB_C_RED, " * Turite ivesti skirtingus skaicius!");
                            LB_LoadStatymas(playerid, statymoid);
                            return 0;
                        }
                }
            }
        }
        for(new i; i < 7; i++)
        {
            new pvar[24];
            format(pvar, sizeof(pvar), "lb_num%i", i);
            if(numbers[i] > 0)
            {
                format(statymux, sizeof(statymux), "%s%i ", statymux, numbers[i]);
                SetPVarInt(playerid, pvar, numbers[i]);
            }
            else SetPVarInt(playerid, pvar, 0);
        }
        SetPVarString(playerid, "lb_pick", statymux);
    }
    SetPVarInt(playerid, "lb_id", statymoid);
    new statymosuma = GetPVarInt(playerid, "lb_suma");
    new laimejimas = floatround(statymosuma * lb_stat[statymoid][l_koef]);
    new sbuf1[24], sbuf2[24], pickbuf[48], msg[700];
    LB_FmtNum(statymosuma, sbuf1);
    LB_FmtNum(laimejimas, sbuf2);
    GetPVarString(playerid, "lb_pick", pickbuf, sizeof(pickbuf));
    format(msg, sizeof(msg),
        "Norite atlikti si statyma:\n{FFFFFF}%s\n\n{A9C4E4}Jusu pasirinkimas: {00ff7f}%s\n{A9C4E4}Statoma suma: {00ff7f}%s EUR\n{A9C4E4}Koeficientas: {00ff7f}%.2f\n{A9C4E4}Galimas laimejimas: {00ff7f}%s EUR\n\n\n{FFFFFF}Ar norite atlikti si statyma?",
        lb_stat[statymoid][l_statymas], ((taip) ? ("Taip") : (pickbuf)), sbuf1, lb_stat[statymoid][l_koef], sbuf2);
    ShowPlayerDialog(playerid, LBD_CONFIRM, DIALOG_STYLE_MSGBOX, "Statymas", msg, "Atlikti", "Atsaukti");
    return 1;
}

stock LB_Make(playerid)
{
    if(GetPVarInt(playerid, "lb_active"))
        return SendClientMessage(playerid, LB_C_RED, " * Tu jau padarei statyma!");
    if(!LB_GaliStatyti())
        return SendClientMessage(playerid, LB_C_RED, " * Losimas jau vyksta! Palauk kito zaidimo.");
    if(!LB_CanBet(playerid))
        return SendClientMessage(playerid, LB_C_RED, " * Turi buti losimu biuro viduje!");
    new suma = GetPVarInt(playerid, "lb_suma");
    if(PI[playerid][pMoney] < suma)
        return SendClientMessage(playerid, LB_C_RED, " * Neturi pakankamai pinigu!");

    new statymoid = GetPVarInt(playerid, "lb_id");
    SetPVarInt(playerid, "lb_active", 1);
    SetPVarInt(playerid, "lb_stake", suma);
    SetPVarInt(playerid, "lb_betid", statymoid);
    GiveMoney(playerid, -suma);

    new laimejimas = floatround(suma * lb_stat[statymoid][l_koef]);
    new sbuf1[24], sbuf2[24], pickbuf[48], msg[256];
    LB_FmtNum(suma, sbuf1);
    LB_FmtNum(laimejimas, sbuf2);
    GetPVarString(playerid, "lb_pick", pickbuf, sizeof(pickbuf));

    SendClientMessage(playerid, LB_C_RECEIPT, "* ======= STATYMO KVITAS =======");
    format(msg, sizeof(msg), "* Statymas: {FFFFFF}%s", lb_stat[statymoid][l_statymas]);
    SendClientMessage(playerid, LB_C_RECEIPT, msg);
    format(msg, sizeof(msg), "* Pasirinkimas: {FFFFFF}%s", pickbuf);
    SendClientMessage(playerid, LB_C_RECEIPT, msg);
    format(msg, sizeof(msg), "* Statoma suma: {FFFFFF}%s EUR", sbuf1);
    SendClientMessage(playerid, LB_C_RECEIPT, msg);
    format(msg, sizeof(msg), "* Galimas laimejimas: {FFFFFF}%s EUR", sbuf2);
    SendClientMessage(playerid, LB_C_RECEIPT, msg);
    SendClientMessage(playerid, -1, "* Dabar laukite, kol bus isridenti kamuoliukai.");
    LB_Losejai++;
    return 1;
}
// ----------------------------------------------------------------------


// --------------------------- DIALOGU DISPECERIS -----------------------
//  Kviesk is OnDialogResponse (is karto po "{"):
//    if(Losimu_OnDialog(playerid, dialogid, response, listitem, inputtext)) return 1;
stock Losimu_OnDialog(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case LBD_MAIN:
        {
            if(!response) return 1;
            if(listitem == 0)
            {
                new msg[256];
                format(msg, sizeof(msg), "Iveskite, kokia suma norite statyti.\nSuma turi buti nuo %d EUR iki %d EUR.", LB_MIN_STAT, LB_MAX_STAT);
                ShowPlayerDialog(playerid, LBD_SUMA, DIALOG_STYLE_INPUT, "Statymo suma", msg, "Gerai", "Atsaukti");
                return 1;
            }
            LB_ShowCat(playerid, listitem);
            return 1;
        }
        case LBD_SUMA:
        {
            if(!response) { Losimu_ShowMain(playerid); return 1; }
            new msg[256];
            if(!LB_IsNumeric(inputtext))
            {
                format(msg, sizeof(msg), "{FF0000}Iveskite tik skaicius!{FFFFFF}\nSuma turi buti nuo %d iki %d EUR.", LB_MIN_STAT, LB_MAX_STAT);
                ShowPlayerDialog(playerid, LBD_SUMA, DIALOG_STYLE_INPUT, "Statymo suma", msg, "Gerai", "Atsaukti");
                return 1;
            }
            new suma = strval(inputtext);
            if(suma < LB_MIN_STAT || suma > LB_MAX_STAT)
            {
                format(msg, sizeof(msg), "{FF0000}Netinkama suma!{FFFFFF}\nSuma turi buti nuo %d iki %d EUR.", LB_MIN_STAT, LB_MAX_STAT);
                ShowPlayerDialog(playerid, LBD_SUMA, DIALOG_STYLE_INPUT, "Statymo suma", msg, "Gerai", "Atsaukti");
                return 1;
            }
            if(PI[playerid][pMoney] < suma)
            {
                ShowPlayerDialog(playerid, LBD_SUMA, DIALOG_STYLE_INPUT, "Statymo suma", "{FF0000}Tu neturi tiek pinigu!{FFFFFF}\nIveskite kita suma.", "Gerai", "Atsaukti");
                return 1;
            }
            SetPVarInt(playerid, "lb_suma", suma);
            Losimu_ShowMain(playerid);
            return 1;
        }
        case LBD_CAT:
        {
            if(!response) { Losimu_ShowMain(playerid); return 1; }
            if(listitem < 0 || listitem >= sizeof(LB_Row[])) return 1;
            LB_LoadStatymas(playerid, LB_Row[playerid][listitem]);
            return 1;
        }
        case LBD_INPUT:
        {
            if(!response) { Losimu_ShowMain(playerid); return 1; }
            LB_Verify(playerid, GetPVarInt(playerid, "lb_id"), inputtext);
            return 1;
        }
        case LBD_CONFIRM:
        {
            if(!response) { Losimu_ShowMain(playerid); return 1; }
            LB_Make(playerid);
            return 1;
        }
    }
    return 0;
}
// ----------------------------------------------------------------------


// ------------------------------- KOMANDOS -----------------------------
//  /losimubiuras - teleportuoja i losimu biura (jei nenori eiti per iejima).
//  Jei nori, kad komanda butu tik administratoriams, apsaugok ja savo
//  admino tikrinimu (pvz. if(PI[playerid][pAdmin] < 1) return ...).
CMD:losimubiuras(playerid, params[])
{
    #pragma unused params
    LB_EnterBiuras(playerid);
    SetPVarInt(playerid, "lb_armExit", 0);
    SetPVarInt(playerid, "lb_armCounter", 0);
    SendClientMessage(playerid, LB_C_WIN, " * Teleportuota i losimu biura. Prieik prie kasos arba rasyk /losimai.");
    return 1;
}

//  /losimaistats - administratoriams: kiek zaidejai laimejo/pralaimejo
//  biure sia diena ir per visa laika.
CMD:losimaistats(playerid, params[])
{
    #pragma unused params
    if(PI[playerid][pAdmin] < LB_ADMIN_LVL)
        return SendClientMessage(playerid, LB_C_RED, " * Si komanda tik administratoriams!");
    LB_CheckDay();
    new sb1[24], sb2[24], sb3[24], msg[200];
    SendClientMessage(playerid, LB_C_INFO, "* ======= LOSIMU BIURO STATISTIKA =======");

    LB_FmtNum(LB_StWonDay, sb1);
    LB_FmtNum(LB_StLostDay, sb2);
    LB_FmtNum(LB_StLostDay - LB_StWonDay, sb3);
    format(msg, sizeof(msg), "* Siandien: zaidejai laimejo {FFFFFF}%s EUR{C2A2DA}, pralaimejo {FFFFFF}%s EUR{C2A2DA}, biuro pelnas: {FFFFFF}%s EUR", sb1, sb2, sb3);
    SendClientMessage(playerid, LB_C_RECEIPT, msg);

    LB_FmtNum(LB_StWonTotal, sb1);
    LB_FmtNum(LB_StLostTotal, sb2);
    LB_FmtNum(LB_StLostTotal - LB_StWonTotal, sb3);
    format(msg, sizeof(msg), "* Per visa laika: zaidejai laimejo {FFFFFF}%s EUR{C2A2DA}, pralaimejo {FFFFFF}%s EUR{C2A2DA}, biuro pelnas: {FFFFFF}%s EUR", sb1, sb2, sb3);
    SendClientMessage(playerid, LB_C_RECEIPT, msg);
    return 1;
}

//  /losimai - atidaro statymu meniu (veikia tik biuro viduje).
CMD:losimai(playerid, params[])
{
    #pragma unused params
    if(!LB_CanBet(playerid))
        return SendClientMessage(playerid, LB_C_RED, " * Tu nesi losimu biuro viduje! Naudok /losimubiuras.");
    if(GetPVarInt(playerid, "lb_active"))
        return SendClientMessage(playerid, LB_C_RED, " * Tu jau padarei statyma. Palauk zaidimo pabaigos.");
    if(!LB_GaliStatyti())
        return SendClientMessage(playerid, LB_C_RED, " * Losimas jau vyksta! Palauk zaidimo pabaigos.");
    if(!GetPVarInt(playerid, "lb_suma"))
        SetPVarInt(playerid, "lb_suma", LB_MIN_STAT);
    Losimu_ShowMain(playerid);
    return 1;
}
// ======================================================================
