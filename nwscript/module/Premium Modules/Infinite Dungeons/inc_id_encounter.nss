//::///////////////////////////////////////////////
//:: Name: Encounter Generation Include
//:: FileName: inc_encounter
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This include file handles the generation of encounters.
Because of the masive workload of the system only 1 enounter per area will be allowed.

All functions in this file are meant to called by an area.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: May 11,2005
//:://////////////////////////////////////////////
#include "inc_id1_debug"
#include "inc_id_misctools"

// ----------------------- BEGIN PROTOTYPES ----------------------

// This function will create an encounter.
// This encounter can range from a safe area to a fight from a semi random theme.
// The themes available are the one picked by the PC. Dragons, if party is above level 12.
// No Theme creatures if the party is below level 20. Lastly theme all to throw a curve ball.
//
// I expect part of this functionality to be moved to the area on enter at a later date.
//
// oPC is supplied for encounter scaling.
// nEL allows you to set the encoutner level.
// oWP allows you to set where the encounter will be.
void GenerateEncounter(object oPC, int nEL = -1, object oWP = OBJECT_INVALID);

// Subfunction of GenerateEncounter
// NOT TO BE USED EXTERNALLY!
void GenerateMonsters(int nTheme,int nEL,int nMulti,location lLoc);

// Returns a value based on nNum and nMulti.
int GetNumberOfCreatures(int nMulti,int nNum = 1);

// This function will cache monster line numbers in the id_encounter 2da
// by theme.
// Sub function of GenerateMonsters.
// Not meant for external use.
// WARNING THIS IS A VERY EXPENSIVE FUNCTION USE SPARINGLY!
int CacheTheme(int nTheme = -1);

// Sub function of GenerateMonsters.
// Not meant for external use.
int GetCacheTheme(int nTheme, int nEL);

// Returns a random waypoint tagged "Monster" within oArea.
object GetRandomSpawnPoint(object oArea = OBJECT_SELF);

// Returns a column from the ENCOUNTER_2DA.
// nTheme must be a valid THEME_*
string GetThemeColumn(int nTheme);

// Wrapper function to set the Theme of the dungeon.
// This value can be retrieved using GetTheme.
void SetTheme(int nTheme);

// Returns the value set by SetTheme.
int GetTheme();

// Subfuntion of GenerateEncounter.
// NOT INTENDED FOR EXTERNAL USE!
// Returns a modified d100 Roll based on the difficulty slider.
// If the slider is set to Very Easy this roll maxes at 70.
// If slider is set to Easy the roll maxes at 80.
// If slider is set to Normal the roll maxes at 90.
// Otherwise returns a standard d100 roll.
int GetDifficultyScaledD100Roll();

// Subfunction of Generate Encounter.
// NOT INTENDED FOR EXTERNAL USE!
// Returns the EL of the encounter based on nRoll 1 - 100.
// If nMultiReturn is set to TRUE it will return the number appearing multiplier INSTEAD.
int GetAreaEncounterDifficulty(int nRoll, int nAveragePartyLevelLevel,int nMultiReturn = FALSE);

// Subfunction of Generate Encounter.
// NOT INTENDED FOR EXTERNAL USE!
// Adjusts the number appearing multiplier.
// The adjustment is based on an average party size of 4 to 6.
int AdjustMultiplierByNumberInParty(object oPC,int nMulti);

// Subfunction of generate encounter.
// NOT INTENDED FOR EXTERNAL USE!
// Makes sure nMulti stays in range:
// MULTI_THIRD to MULTI_QUAD
int VerifyMultiInRange(int nMulti);
// ----------------------- BEGIN FUNCTIONS ----------------------
void GenerateEncounter(object oPC, int nEL, object oWP)
{
    // Determine the location of the encounter.
    if (!GetIsObjectValid(oWP))
    {
        oWP = GetRandomSpawnPoint();
        if (!GetIsObjectValid(oWP))
        {
            return; // No valid spawn point found abort encounter generation.
        }
    }
    location lLoc = GetLocation(oWP);

    // Determine other properties required to generate this encounter.
    int nTheme = GetTheme();
    int nAvgLevel = GetAveragePartyLevel(oPC);
    int nMulti,nLoop;
    object oNPC;

    // Scale the possible encounter dificulty to Game Difficulty.
    int nRoll = GetDifficultyScaledD100Roll();

    // Determine the encounter difficulty and number of creatures appearing modifier.
    if (nEL == -1)
    {
        // A EL was not assigned so create one.
        nEL = GetAreaEncounterDifficulty(nRoll,nAvgLevel);
        nMulti = GetAreaEncounterDifficulty(nRoll,nAvgLevel,TRUE);
    }
    else
    {
        // An EL was supplied. Calculate  nMulti.
        nMulti = nAvgLevel - nEL;
        nMulti = VerifyMultiInRange(nMulti);
    }

    // Modify the Multi by the number of party members (This counts PC's and Henchmen).
    nMulti = AdjustMultiplierByNumberInParty(oPC,nMulti);

    // Determine Encounter Type
    nRoll = d100();
    if (nRoll <= 5 && nEL >= 12)// Don't allow random dragons til El 12.
    {
        // Generate a dragon.
        GenerateMonsters(THEME_DRAGON,nEL,nMulti,lLoc);
    }
    else if (nRoll <= 15)
    {
        // Safe area. May include a puzzle.
        WriteTimestampedLogEntry("Safe Area");
        return;
    }
    else if (nRoll <= 25)
    {
        // "Neutral" NPC may join party or give aid.
        // Generate a Theme based Monster Encounter.
        // Party must defeat the encounter to get benefits of NPC.
        // Add a NPC spawning function.
        WriteTimestampedLogEntry("NPC");

        // Generate a normal Theme encounter
        GenerateMonsters(nTheme,nEL,nMulti,lLoc);
        // Add NPC Generation HERE!
        return;
    }
    else if (nRoll <= 35)
    {
        // Generate an Encounter from a Random Theme
        GenerateMonsters(THEME_ALL,nEL,nMulti,lLoc);

    }
    else if (nRoll <= 60 && nEL <= 20 ) // These are pretty much limited to non epic.
    {
        // Generate Misc Dungeon Creature.
        GenerateMonsters(THEME_NONE,nEL,nMulti,lLoc);
    }
    else if (nRoll <= 100)
    {
        // Generate a normal Theme encounter
        GenerateMonsters(nTheme,nEL,nMulti,lLoc);
    }
}



void GenerateMonsters(int nTheme,int nEL,int nMulti,location lLoc)
{
    // Create a Theme Cache in needed.
    // Find a random creature entry from 2da.
    int nEntry = GetCacheTheme(nTheme,nEL);

    // Make sure this is a valid 2da entry.
    if (nEntry > -1)
    {
        int n,nCR,nNum,nMax,nRandom,nResRefOverRide;
        object oCreature;
        object oMod = GetModule();
        string s2da,sTemp;
        // Get creature data from 2da.
        string sResRef = Get2DAString(ENCOUNTER_2DA,ENCOUNTER2DA_COLUMN_RESREF,nEntry);
        string sCR = Get2DAString(ENCOUNTER_2DA,ENCOUNTER2DA_COLUMN_CR,nEntry);
        if (sCR == "1/8")
        {
            nMulti += MULTI_OCTO;
        }
        else if (sCR == "1/4")
        {
            nMulti += MULTI_QUAD;
        }
        else if (sCR == "1/3")
        {
            nMulti += MULTI_TRIPLE;
        }
        else if (sCR == "1/2")
        {
            nMulti += MULTI_DOUBLE;
        }
        nMulti = VerifyMultiInRange(nMulti);

        // Determine number in encounter.
        nNum = GetNumberOfCreatures(nMulti);

        if (GetStringLeft(sResRef,12) == NAME_CON_2DA_RACIAL_CLASS)
        {
            nResRefOverRide = TRUE;
        }

        SendMessageToPC(GetFirstPC(), "Number : " +IntToString(nNum));
        s2da = sResRef;
        // Generate the monsters
        for (n = 1; n <= nNum; n += 1)
        {
            // Must use a Race/Class based resref from another 2da.
            if (nResRefOverRide)
            {
                // Get a racial based Class ResRef.
                // The old resref is used to ref the new 2da.
                nMax = GetLocalInt(oMod,s2da);
                if (!nMax)
                {
                    // This 2da max entry has not been cached do so now.
                    // The resref from id_encounter.2da is now used to reference the new 2da.
                    sTemp = Get2DAString(s2da,ENCOUNTER2DA_COLUMN_RESREF,nMax+=1);
                    if (sTemp != "")
                    {
                        while(sTemp != "")
                        {
                            sTemp = Get2DAString(s2da,ENCOUNTER2DA_COLUMN_RESREF,nMax+=1);
                        }
                    nMax -= 1;
                    SetLocalInt(oMod,s2da,nMax);
                    }
                }
                // Find a random ResRef
                sResRef = Get2DAString(s2da,ENCOUNTER2DA_COLUMN_RESREF,Random(nMax)+1);
            }
            // Create the creature.
            oCreature = CreateObject(OBJECT_TYPE_CREATURE,sResRef,lLoc);

            if (!GetIsObjectValid(oCreature))
            {
                //No creature was spawned due to an illegal template.
                DebugMessage("Illegal Template used in Generate Monsters,inc_id_encounter");
                break;
            }
            // Set the level up data on the creature.
            SetLocalInt(oCreature,CREATURE_2DA_ENTRY,nEntry);
            SetLocalInt(oCreature,CREATURE_EL,nEL); // Set level for creature to level up too.
        }

    }
    else
    {
    //ERROR! THIS SHOULD NEVER HAPPEN!
    DebugMessage("GetCacheTheme returned an invalid result. inc_id_encounter,GenerateMonsters");
    }
}

int GetNumberOfCreatures(int nMulti,int nNum)
{
    // Verify nMulti within limits.
    nMulti = VerifyMultiInRange(nMulti);
    // Modify the number appearing by nMulti
    switch(nMulti)
    {
        case MULTI_THIRD:           {nNum = nNum/3;break;}
        case MULTI_HALF:            {nNum = nNum/2;break;}
        case MULTI_TWO_THIRDS:      {nNum = nNum*2/3;break;}
        case MULTI_NONE:            {break;}
        case MULTI_THREE_HALVES:    {nNum = nNum*3/2;break;}
        case MULTI_DOUBLE:          {nNum = nNum*2;break;}
        case MULTI_TRIPLE:          {nNum = nNum*3;break;}
        case MULTI_QUAD:            {nNum = nNum*4;break;}
        case MULTI_OCTO:            {nNum = nNum*8;break;}
    }
    if (nNum < 1)
    {
        nNum = 1;
    }
    return nNum;
}

string GetThemeColumn(int nTheme)
    {
    string sTheme;
    switch(nTheme)
        {
        case THEME_NONE:            {sTheme = ENCOUNTER2DA_COLUMN_THEME_NONE;break;}
        case THEME_ALL:             {sTheme = ENCOUNTER2DA_COLUMN_THEME_ALL;break;}
        case THEME_BANDIT:          {sTheme = ENCOUNTER2DA_COLUMN_THEME_BANDIT;break;}
        case THEME_BEHOLDER:        {sTheme = ENCOUNTER2DA_COLUMN_THEME_BEHOLDER;break;}
        case THEME_CONSTRUCT:       {sTheme = ENCOUNTER2DA_COLUMN_THEME_CONSTRUCT;break;}
        case THEME_CULTIST:         {sTheme = ENCOUNTER2DA_COLUMN_THEME_CULTIST;break;}
        case THEME_DARKFEY:         {sTheme = ENCOUNTER2DA_COLUMN_THEME_DARKFEY;break;}
        case THEME_DEMON:           {sTheme = ENCOUNTER2DA_COLUMN_THEME_DEMON;break;}
        case THEME_DRAGON:          {sTheme = ENCOUNTER2DA_COLUMN_THEME_DRAGON;break;}
        case THEME_GIANTS:          {sTheme = ENCOUNTER2DA_COLUMN_THEME_GIANTS;break;}
        case THEME_HUMANOIDS:       {sTheme = ENCOUNTER2DA_COLUMN_THEME_HUMANOIDS;break;}
        case THEME_ILLUSION:        {sTheme = ENCOUNTER2DA_COLUMN_THEME_ILLUSION;break;}
        case THEME_VERMIN:          {sTheme = ENCOUNTER2DA_COLUMN_THEME_VERMIN;break;} //Note the misspelling.
        case THEME_SHAPECHANGER:    {sTheme = ENCOUNTER2DA_COLUMN_THEME_SHAPECHANGER;break;}
        case THEME_REPTILES:        {sTheme = ENCOUNTER2DA_COLUMN_THEME_REPTILES;break;}
        case THEME_UNDEAD_SKEL:     {sTheme = ENCOUNTER2DA_COLUMN_THEME_UNDEAD_SKEL;break;}
        case THEME_UNDEAD_FLESH:    {sTheme = ENCOUNTER2DA_COLUMN_THEME_UNDEAD_FLESH;break;}
        case THEME_UNDERDWELLERS:   {sTheme = ENCOUNTER2DA_COLUMN_THEME_UNDERDWELLERS;break;}
        };
    return sTheme;
    }


int CacheTheme(int nTheme)
    {
    string sTheme,sThemeMonster;
    int nRow = 0;
    int nThemeMax,iChance;
    sTheme = GetThemeColumn(nTheme);
    // Determine the number of entries in the id_encounter 2da.
    int nMaxEntry = GetLocalInt(GetModule(),CACHE_ENCOUNTER2DA_MAX_ENTRY);
    if (!nMaxEntry)
        {// Find out the number of entries in id_encounter.
        // This is only ever done once.
        sThemeMonster = Get2DAString(ENCOUNTER_2DA,ENCOUNTER2DA_COLUMN_NAME,nRow);
        while(sThemeMonster != "")
            {
            sThemeMonster = Get2DAString(ENCOUNTER_2DA,ENCOUNTER2DA_COLUMN_NAME,nRow += 1);
            }
        nMaxEntry = nRow - 1;
        SetLocalInt(GetModule(),CACHE_ENCOUNTER2DA_MAX_ENTRY,nMaxEntry);
        }
    // Find out which entries match the theme.
    for (nRow = 1; nRow <= nMaxEntry; nRow += 1)
        {
        sThemeMonster = Get2DAString(ENCOUNTER_2DA,sTheme,nRow);
        iChance = StringToInt(sThemeMonster);
        if (iChance > 0)
            {
            // Set and store the max range for this entry to appear.
            nThemeMax += iChance;
            SetLocalInt(GetModule(),TEMPORARY_THEME+Convert3Digit(nTheme)+Convert3Digit(nThemeMax),nRow);
            }
        }
    // Set the maximum number to be used in randomizing using this theme.
    SetLocalInt(GetModule(),CACHE_THEME+Convert3Digit(nTheme),nThemeMax);
    return nThemeMax;
    }

int GetCacheTheme(int nTheme, int nEL)
    {
    object oMod = GetModule();
    // recover theme cache data.
    int nMaxRandom = GetLocalInt(oMod,CACHE_THEME+Convert3Digit(nTheme));
    if (!nMaxRandom)
    {
        // No theme cache exists. Create one.
        nMaxRandom = CacheTheme(nTheme);
    }
    if (!nMaxRandom)
        {
        // THIS SHOULD NEVER HAPPEN!
        WriteTimestampedLogEntry("Cached theme max value was 0. GetCacheTheme,inc_id_encounter");
        return -1;
        }

    // Determine a random entry from the cache.
    int nRandom = Random(nMaxRandom)+1;
    int nEntry = GetLocalInt(oMod,TEMPORARY_THEME+Convert3Digit(nTheme)+Convert3Digit(nRandom));
    while (nEntry == 0)
    {
        // The randomizer hit an empty field increment the random number til a non-empty field is found.
        // This allows for a monster to have a value of greater than 1 in the theme.
        // Example: Setting Orcs to 5 and Worgs to 1 will results in orcs being generated 5 times more often than worgs.
        nEntry = GetLocalInt(oMod,TEMPORARY_THEME+Convert3Digit(nTheme)+Convert3Digit(nRandom+=1));
    }
    string sCR = Get2DAString(ENCOUNTER_2DA,ENCOUNTER2DA_COLUMN_CR,nEntry);
    int nCR = StringToInt(sCR);
    if (!nCR)
    {
        // Creature was a below 1 CR creature.
        nCR = 1;
    }

    //Reuse variable for Max CR.
    sCR = Get2DAString(ENCOUNTER_2DA,ENCOUNTER2DA_COLUMN_MAX_CR,nEntry);

    // Make sure entry is within parameters.
    if (nEL >= nCR && nEL <= StringToInt(sCR))
        {
        return nEntry;
        }
    else
        {
        // The creature reference returned does not work with this EL. Get another.
        return GetCacheTheme(nTheme,nEL);
        }
    return -1; // For compile reasons only this should NEVER happen.
    }

// PeterT - Modified version
object GetRandomSpawnPoint(object oArea)
{
    // determine current level
    int iLevel = GetLocalInt(GetModule(), "CurrentLevel");

    // get the number of waypoints in the area
    int iWaypointEncounter = GetLocalInt(oArea, "WaypointEncounter");

    // if there are recorded waypoints
    if (iWaypointEncounter > 0)
    {
        DebugMessage(IntToString(iWaypointEncounter) + " spawnpoints detected.");

        // pick a random one and store that number
        int iTemp = Random(iWaypointEncounter) + 1;

        DebugMessage("Starting at waypoint " + IntToString(iTemp));

        // remember the first waypoint
        int iStart = iTemp;

        // if not used, return it
        object oWaypoint = GetLocalObject(oArea, "WaypointEncounter" + IntToString(iTemp));

        // check to see if this waypoint is available
        if (GetLocalInt(oWaypoint, "Level" + IntToString(iLevel) + "Used") == FALSE)
        {
            DebugMessage("Waypoint valid.");

            return oWaypoint;
        } else
        {
            // if used, cycle through remainder, looping back to beginning if necessary
            iTemp++;
            if (iTemp > iWaypointEncounter)
            {
                iTemp = 1;
            }

            // start the loop
            while (iTemp != iStart)
            {
                DebugMessage("Checking waypoint " + IntToString(iTemp));

                // get the next waypoint
                oWaypoint = GetLocalObject(oArea, "WaypointEncounter" + IntToString(iTemp));

                // check to see if the waypoint is used
                if (GetLocalInt(oWaypoint, "Level" + IntToString(iLevel) + "Used") == FALSE)
                {
                    DebugMessage("Waypoint valid.");

                    return oWaypoint;
                }

                // cycle to the next waypoint in the list
                iTemp++;
                if (iTemp > iWaypointEncounter)
                {
                    iTemp = 1;
                }
            }
        }
    }

    // if all are used, return object invalid
    return OBJECT_INVALID;
}

void SetTheme(int nTheme)
    {
    SetLocalInt(GetModule(),TEMPORARY_THEME,nTheme);
    }

int GetTheme()
    {
    return GetLocalInt(GetModule(),TEMPORARY_THEME);
    }

int GetDifficultyScaledD100Roll()
{
    int nRoll;
    int nDiff = GetGameDifficulty();
    switch (nDiff)
    {
        case GAME_DIFFICULTY_VERY_EASY:
        {
            nRoll = Random(70) + 1;
            break;
        }
        case GAME_DIFFICULTY_EASY:
        {
            nRoll = Random(80) + 1;
            break;
        }
        case GAME_DIFFICULTY_NORMAL:
        {
            nRoll = Random(90) + 1;
            break;
        }
        case GAME_DIFFICULTY_DIFFICULT:
        case GAME_DIFFICULTY_CORE_RULES:
        {
            nRoll = d100();
            break;
        }
    };
    return nRoll;
}

int GetAreaEncounterDifficulty(int nRoll, int nLevel,int nMultiReturn)
{// Consider moving this to a 2da look up
    int nEL,nMulti;
    if (nRoll <= 5)
    {
        if (nLevel == 1)        {nEL = nLevel;}
        else if (nLevel <= 4)   {nEL = nLevel;      nMulti = MULTI_DOUBLE;}
        else if (nLevel <= 6)   {nEL = 2 ;          nMulti = MULTI_TRIPLE;}
        else                    {nEL = nLevel - 4;  nMulti = MULTI_QUAD;}
    }
    else if (nRoll <= 10)
    {
        if (nLevel == 1)        {nEL = nLevel;}
        else if (nLevel <= 4)   {nEL = nLevel; nMulti = nLevel ;}
        else                    {nEL = nLevel - 3 ; nMulti = MULTI_TRIPLE;}
    }
    else if(nRoll <= 20)
    {
        if (nLevel == 1)        {nEL = 1;}
        else if (nLevel == 2)   {nEL = 1; nMulti = MULTI_DOUBLE;}
        else if (nLevel == 3)   {nEL = 2; nMulti = MULTI_THREE_HALVES;}
        else                    {nEL = nLevel - 2; nMulti = MULTI_DOUBLE;}
    }
    else if (nRoll <= 30)
    {
        if (nLevel <= 2)        {nEL = nLevel;}
        else                    {nEL = nLevel - 1; nMulti = MULTI_THREE_HALVES;}
    }
    else if (nRoll <= 70)
    {
        nEL = nLevel;
    }
    else if (nRoll <= 80)
    {
        if (nLevel == 1)        {nEL = 2;           nMulti = MULTI_HALF;}
        else if (nLevel <= 38)  {nEL = nLevel + 1;  nMulti = MULTI_TWO_THIRDS;}
        else                    {nEL = nLevel;}
    }
    else if (nRoll <= 90)
    {
        if (nLevel == 1)        {nEL = 2;           nMulti = MULTI_HALF;}
        else if (nLevel <= 38)  {nEL = nLevel + 2;  nMulti = MULTI_HALF;}
        else if (nLevel == 39)  {nEL = 40;          nMulti = MULTI_TWO_THIRDS;}
        else /*40*/             {nEL = 40;}
    }
    else if (nRoll <= 100)
    {
        if (nLevel == 1)        {nEL = 3;           nMulti = MULTI_THIRD;}
        else if (nLevel <= 37)  {nEL = nLevel + 3;  nMulti = MULTI_THIRD;}
        else if (nLevel == 38)  {nEL = 40;          nMulti = MULTI_HALF;}
        else if (nLevel == 39)  {nEL = 40;          nMulti = MULTI_TWO_THIRDS;}
        else /*40*/             {nEL = 40;}
    }
    if (nMultiReturn)
    {
        return nMulti;
    }
    return nEL;
}

int AdjustMultiplierByNumberInParty(object oPC,int nMulti)
{
    // Scale nMulti to oPCs party size.
    int nNum = GetNumberInParty(oPC);
    if (nNum < 4)
    {
        nMulti -= (4 - nNum);
    }
    else if (nNum > 6)
    {
        nMulti += (nNum - 6);
    }
    nMulti = VerifyMultiInRange(nMulti);
    // Return the modified value.
    return nMulti;
}

int VerifyMultiInRange(int nMulti)
{
    // Make sure nMulti stays in legal limits.
    if (nMulti > MULTI_OCTO)
    {
        nMulti = MULTI_OCTO;
    }
    else if (nMulti < MULTI_THIRD)
    {
        nMulti = MULTI_THIRD;
    }
    return nMulti;
}

// void main () {} /* Placed for compile reasons only*/
