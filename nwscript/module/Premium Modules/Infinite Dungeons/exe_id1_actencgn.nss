#include "inc_id1_debug"
#include "inc_id1_creature"
#include "inc_id1_flags"
#include "inc_id1_utility"

void main()
{
    DebugMessage("");
    DebugMessage("Generating encounter waypoints.");

    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get tileset
    string sTileset = GetTilesetResRef(oArea);
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    int nMicroNum;
    string sWaypoint;
    object oMicroCPU;

    int nEncounterPercentage = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_FREQUENCY);
    DebugMessage("  Encounter frequency is " + IntToString(nEncounterPercentage));

    // get party level and size
    int nPartyLevel = GetPartyLevel(oPC, FALSE);
    DebugMessage("  Party level is " + IntToString(nPartyLevel));

    int nPartySize = GetPartySize(oPC, FALSE);
    DebugMessage("  Party size is " + IntToString(nPartySize));

    nPartyLevel = GetPartyLevelSize(nPartyLevel, nPartySize);

    int nDifficulty = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);
    DebugMessage("  Encounter difficulty adjustment is " + IntToString(nDifficulty));
    nPartyLevel += nDifficulty;
    DebugMessage("    Party level adjusted for difficulty is " + IntToString(nPartyLevel));

    // for each waypoint
    int nWaypointNum = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointEncounter");
    int nWaypoint = 1;
    DebugMessage("  Generating encounter for " + IntToString(nWaypointNum) + " waypoints.");
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU40");
        SetLocalString(oMicroCPU, "sVariable", sWaypoint);
        SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
        SetLocalInt(oMicroCPU, "bHold", TRUE);
        SetLocalInt(oMicroCPU, "nBaseLevel", nPartyLevel);
        SetLocalInt(oMicroCPU, "nBaseSize", nPartySize);
        SetLocalInt(oMicroCPU, "nPercentage", nEncounterPercentage);
        SetLocalInt(oMicroCPU, "bBoss", FALSE);
        SetLocalInt(oMicroCPU, "nTileset", nTileset);
        SetLocalInt(oMicroCPU, "nTheme", -1);

        // increment number of active microprocessors
        nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
        nMicroNum++;
        SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

        DelayCommand(0.01, ExecuteScript("exe_id1_micenc", oMicroCPU));

        // increment to next waypoint
        nWaypoint++;
    }

    // enter holding pattern
    DebugMessage("Entering holding pattern.");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

