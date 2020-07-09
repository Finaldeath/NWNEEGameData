#include "inc_id1_debug"
#include "inc_id1_creature"
#include "inc_id1_flags"
#include "inc_id1_utility"

void main()
{
    DebugMessage("");
    DebugMessage("Generating boss waypoints.");

    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
    DebugMessage("  Tileset is " + sTileset + " which is number " + IntToString(nTileset));

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    int nThemeNum;
    int nTheme;
    int nEL;
    int nEncounterSize;
    int nTemp;
    int nCR;
    int nPlotNum;
    int nPlot;
    int nCreatureNum;
    int nCreature;
    int nPlotID;
    int nCreatureType;
    int nCreatureSubType;
    int nMicroNum;
    int bFound;
    int nGuardWaypoint;
    int nCount;

    string sWaypoint;
    string sCreature;
    string sPlot;
    string sGuardPrefix;
    string sGuardSuffix;
    string sGuardLevel;
    string sGuardCreature;

    object oMicroCPU;
    object oGuardWaypoint;
    object oWaypoint;

    int nPercentage;
    int nRandom;

    int bFinalBoss;

    // is this area the one with the final boss?
    string sTag = GetTag(oArea);
    string sSubTag = GetSubString(sTag, 0, 8);
    DebugMessage("Comparing are tag " + sTag + " and substring " + sSubTag);
    if (sSubTag == "BossArea")
    {
        bFinalBoss = TRUE;
    }

    int nBossPercentage;
    if (bFinalBoss == TRUE)
    {
        nBossPercentage = 100;
    } else
    {
        nBossPercentage = GetModuleFlagValue(ID1_FLAG_BOSS_MINIBOSS_FREQUENCY);
    }
    DebugMessage("Boss percentage is " + IntToString(nBossPercentage));

    int nGuardPercentage = GetModuleFlagValue(ID1_FLAG_BOSS_GUARD_FREQUENCY);
    DebugMessage("Guard frequency is " + IntToString(nGuardPercentage));

    // get party level and size
    int nPartyLevel;
    if (bFinalBoss == TRUE)
    {
        nPartyLevel = GetPartyLevel(oPC, TRUE);
        nPartyLevel += 2;
    } else
    {
        nPartyLevel = GetPartyLevel(oPC, FALSE);
    }
    DebugMessage("  Party level is " + IntToString(nPartyLevel));

    int nPartySize;
    if (bFinalBoss == TRUE)
    {
        nPartySize = GetPartySize(oPC, TRUE);
    } else
    {
        nPartySize = GetPartySize(oPC, FALSE);
    }
    DebugMessage("  Party size is " + IntToString(nPartySize));

    nPartyLevel = GetPartyLevelSize(nPartyLevel, nPartySize);

    int nDifficulty = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);
    DebugMessage("  Encounter difficulty adjustment is " + IntToString(nDifficulty));
    nPartyLevel += nDifficulty;
    DebugMessage("    Party level adjusted for difficulty is " + IntToString(nPartyLevel));

    // guard info
    sGuardPrefix = "Area" + IntToString(nAreaNum) + "WaypointBossGuard";
    sGuardSuffix = "Level" + IntToString(nCurrentLevel);
    DebugMessage("Guard prefix is " + sGuardPrefix + " and suffix is " + sGuardSuffix);

    // if there are boss waypoints in this area
    int nBossWaypointNum = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointBoss");
    DebugMessage("Generating encounter for " + IntToString(nBossWaypointNum) + " boss waypoints.");
    int nBossWaypoint = 1;
    while (nBossWaypoint <= nBossWaypointNum)
    {
        sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointBoss" + IntToString(nBossWaypoint) + "Level" + IntToString(nCurrentLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        oWaypoint = GetLocalObject(oArea, "oWaypointBoss" + IntToString(nBossWaypoint));

        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU38");
        SetLocalString(oMicroCPU, "sVariable", sWaypoint);
        SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
        SetLocalInt(oMicroCPU, "bHold", TRUE);
        SetLocalInt(oMicroCPU, "nBaseLevel", nPartyLevel);
        SetLocalInt(oMicroCPU, "nBaseSize", nPartySize);
        SetLocalInt(oMicroCPU, "nPercentage", nBossPercentage);
        SetLocalInt(oMicroCPU, "bBoss", TRUE);
        SetLocalInt(oMicroCPU, "nTileset", nTileset);
        SetLocalInt(oMicroCPU, "nTheme", -1);

        // guard info
        SetLocalObject(oMicroCPU, "oWaypoint", oWaypoint);
        SetLocalString(oMicroCPU, "sGuardPrefix", sGuardPrefix);
        SetLocalString(oMicroCPU, "sGuardSuffix", sGuardSuffix);
        SetLocalInt(oMicroCPU, "nGuardPercentage", nGuardPercentage);

        // increment number of active microprocessors
        nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
        nMicroNum++;
        SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

        DelayCommand(0.01, ExecuteScript("exe_id1_micenc", oMicroCPU));

        // increment to next waypoint
        nBossWaypoint++;
    }

    // enter holding pattern
    DebugMessage("Entering holding pattern.");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

