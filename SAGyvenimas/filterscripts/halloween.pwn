#include <a_samp>

// --- KONFIGURACIJA ---
#define NPC_COORD -1118.9000, -953.1030, 138.7640
#define DIALOG_QUESTS 32700 // Unikalus ID
#define MAX_QUEST_MOLIUGI 5

// --- Kintamieji ---
new HalloweenProgress[MAX_PLAYERS];
new QuestStatus[MAX_PLAYERS];      // 0 - nepradeta, 1 - vykdoma, 2 - galima baigti
new Surinkta[MAX_PLAYERS];
new MoliugoObjektas[MAX_PLAYERS];
new ManoMoliugai[MAX_PLAYERS][MAX_QUEST_MOLIUGI];

// Moliugu vietos (X, Y, Z)
new Float:MoliuguPos[][] = {
    {-1110.0, -960.0, 129.0},
    {-1080.5, -920.1, 128.5},
    {-1050.2, -900.5, 129.0},
    {-1140.8, -910.2, 130.0},
    {-1160.0, -950.0, 130.5},
    {-1020.0, -910.0, 128.0},
    {-980.0, -950.0, 129.0},
    {-1050.0, -1000.0, 129.0}
};

// --- PAGALBINES FUNKCIJOS ---

forward AddItem(playerid, itemid);
public AddItem(playerid, itemid)
{
    // Jei tavo GM turi AddItem, ši funkcija nieko negadins
    return 1;
}

stock SukurtiMoliuga(playerid, locID)
{
    if(MoliugoObjektas[playerid] != INVALID_OBJECT_ID) DestroyPlayerObject(playerid, MoliugoObjektas[playerid]);

    MoliugoObjektas[playerid] = CreatePlayerObject(playerid, 19339, MoliuguPos[locID][0], MoliuguPos[locID][1], MoliuguPos[locID][2]-0.9, 0, 0, 0);
    SetPlayerCheckpoint(playerid, MoliuguPos[locID][0], MoliuguPos[locID][1], MoliuguPos[locID][2], 3.0);
    return 1;
}

stock RodytiQuestDialoga(playerid)
{
    new str[1000], busena[64], pavadinimas[32];
    format(str, sizeof(str), "Užduotis\tBusena\n");

    for(new i = 1; i <= 10; i++)
    {
        if(HalloweenProgress[playerid] >= i) format(busena, sizeof(busena), "{33AA33}Atlikta");
        else if(HalloweenProgress[playerid] == i - 1)
        {
            if(QuestStatus[playerid] == 0) format(busena, sizeof(busena), "{FFFF00}Nepradeta");
            else if(QuestStatus[playerid] == 1) format(busena, sizeof(busena), "{FF9900}Vykdoma (%d/%d)", Surinkta[playerid], MAX_QUEST_MOLIUGI);
            else format(busena, sizeof(busena), "{00FFEE}Galima baigti");
        }
        else format(busena, sizeof(busena), "{FF0000}Užrakinta");

        if(i == 1) pavadinimas = "Moliugu rinkimas";
        else format(pavadinimas, sizeof(pavadinimas), "Užduotis %d", i);

        format(str, sizeof(str), "%s%d. %s\t%s\n", str, i, pavadinimas, busena);
    }
    ShowPlayerDialog(playerid, DIALOG_QUESTS, DIALOG_STYLE_TABLIST_HEADERS, "Helovyno Užduotys", str, "Pasirinkti", "Uždaryti");
    return 1;
}

// --- PAGRINDINIAI IVYKIAI ---

public OnFilterScriptInit()
{
    print("--------------------------------------");
    print(" Helovyno sistema pajungta!           ");
    print(" Komanda testavimui: /helo            ");
    print("--------------------------------------");
    Create3DTextLabel("{FF9900}Helovyno Personazas\n{FFFFFF}Paspauskite {FFFF00}ALT {FFFFFF}pasikalbeti", -1, NPC_COORD, 20.0, 0, 1);
    return 1;
}

public OnPlayerConnect(playerid)
{
    HalloweenProgress[playerid] = 0;
    QuestStatus[playerid] = 0;
    Surinkta[playerid] = 0;
    MoliugoObjektas[playerid] = INVALID_OBJECT_ID;
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/helo", true))
    {
        RodytiQuestDialoga(playerid);
        return 1;
    }
    return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    // ALT paspaudimas prie NPC
    if((newkeys & KEY_WALK) && IsPlayerInRangeOfPoint(playerid, 3.0, NPC_COORD))
    {
        RodytiQuestDialoga(playerid);
        return 1;
    }

    // ALT paspaudimas renkant moliugus
    if((newkeys & KEY_WALK) && QuestStatus[playerid] == 1 && HalloweenProgress[playerid] == 0)
    {
        new locID = ManoMoliugai[playerid][Surinkta[playerid]];
        if(IsPlayerInRangeOfPoint(playerid, 3.0, MoliuguPos[locID][0], MoliuguPos[locID][1], MoliuguPos[locID][2]))
        {
            Surinkta[playerid]++;
            if(MoliugoObjektas[playerid] != INVALID_OBJECT_ID)
            {
                DestroyPlayerObject(playerid, MoliugoObjektas[playerid]);
                MoliugoObjektas[playerid] = INVALID_OBJECT_ID;
            }

            if(Surinkta[playerid] < MAX_QUEST_MOLIUGI)
            {
                SendClientMessage(playerid, -1, "{FF9900}[QUEST] {FFFFFF}Moliugas paimtas! Ieškok kito.");
                SukurtiMoliuga(playerid, ManoMoliugai[playerid][Surinkta[playerid]]);
            }
            else
            {
                SendClientMessage(playerid, -1, "{33AA33}[QUEST] {FFFFFF}Visi surinkti! Grižk pas NPC.");
                QuestStatus[playerid] = 2;
                SetPlayerCheckpoint(playerid, NPC_COORD, 3.0);
            }
            return 1;
        }
    }
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_QUESTS)
    {
        if(!response) return 1;

        new qID = listitem + 1;

        if(qID == 1) // Pirmas Questas
        {
            if(HalloweenProgress[playerid] >= 1) return SendClientMessage(playerid, -1, "{FF0000}Užduotis jau atlikta!");

            if(QuestStatus[playerid] == 0) // Pradedam
            {
                SendClientMessage(playerid, -1, "{FF9900}Personažas: {FFFFFF}Sveikas! Padek man surinkti moliugus.");
                SendClientMessage(playerid, 0xFFFF00FF, "UŽDUOTIS: Surink 5 moliugus LS mieste.");

                for(new i = 0; i < MAX_QUEST_MOLIUGI; i++) ManoMoliugai[playerid][i] = random(sizeof(MoliuguPos));

                QuestStatus[playerid] = 1;
                Surinkta[playerid] = 0;
                SukurtiMoliuga(playerid, ManoMoliugai[playerid][0]);
            }
            else if(QuestStatus[playerid] == 2) // Baigiam
            {
                AddItem(playerid, 2222);
                SendClientMessage(playerid, 0x33AA33FF, "Personažas: {FFFFFF}Aciu! Štai tavo atlygis.");

                HalloweenProgress[playerid] = 1;
                QuestStatus[playerid] = 0;
                DisablePlayerCheckpoint(playerid);
            }
            else SendClientMessage(playerid, -1, "{FF9900}Užduotis jau vykdoma!");
            return 1;
        }
        return 1;
    }
    return 0;
}
