#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"
#include "inc_id1_creature"

void main()
{
    DebugMessage("");
    DebugMessage("Puzzle and camp spawning.");

    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
    DebugMessage("sArea" + IntToString(nAreaNum) + "Tileset is " + sTileset + " and nTileset is " + IntToString(nTileset));

    // get number of puzzle points
    int nPuzzleNum = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointPuzzle");

    int nPartyLevel = GetPartyLevel(oPC, FALSE);
    int nPartySize = GetPartySize(oPC, FALSE);
    int nPartySizeLevel = GetPartyLevelSize(nPartyLevel, nPartySize);
    int nPartyDifficultyLevel = nPartySizeLevel + GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);

    int nPuzzle = 1;
    int bPresent;
    string sPuzzle;
    object oPuzzle;
    object oCamp;
    object oCampNote;
    string sLevel;
    int nReward;
    object oMicroCPU;
    int nMicroNum;
    int nContainerNum;
    int nContainerRandom;
    int nContainer;
    object oSecretEntrance;
    object oSecretExit;
    object oSecretWaypoint;
    int nSecretWaypoint;
    string sSecretWaypoint;
    int bActive;
    float fDistance;
    float fValue;
    int nPuzzleScript;
    while (nPuzzle <= nPuzzleNum)
    {
        DebugMessage("  Checking puzzle " + IntToString(nPuzzle) + " of " + IntToString(nPuzzleNum));

        // check if used
        sLevel = "Area" + IntToString(nAreaNum) + "WaypointPuzzle" + IntToString(nPuzzle) + "Level" + IntToString(nCurrentLevel);
        bPresent = GetLocalInt(oDungeon, "b" + sLevel + "Used");
        DebugMessage("  b" + sLevel + "Used is " + IntToString(bPresent));
        if (bPresent == TRUE)
        {
            // if its a camp
            bPresent = GetLocalInt(oDungeon, "b" + sLevel + "Camp");
            if (bPresent == TRUE)
            {
                // get the camp waypoint
                oCamp = GetLocalObject(oArea, "oWaypointPuzzle" + IntToString(nPuzzle));
                CreateObject(OBJECT_TYPE_WAYPOINT, "map_camp", GetLocation(oCamp));

                // run the camp script on the puzzle point
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU47");
                SetLocalObject(oMicroCPU, "oWaypoint", oCamp);
                DelayCommand(0.01, ExecuteScript("exe_id1_camp", oMicroCPU));
            } else
            {
                // if used, get the puzzle script
                nPuzzleScript = GetLocalInt(oDungeon, "n" + sLevel + "Script");
                sPuzzle = GetLocalString(oDungeon, "sListPuzzle" + IntToString(nPuzzleScript) + "Script");
                DebugMessage("    Dungeon puzzle is " + IntToString(nPuzzleScript));
                DebugMessage("    sListPuzzle" + IntToString(nPuzzleScript) + "Script is " + sPuzzle);

                // get the puzzle waypoint
                oPuzzle = GetLocalObject(oArea, "oWaypointPuzzle" + IntToString(nPuzzle));
                CreateObject(OBJECT_TYPE_WAYPOINT, "map_puzzle", GetLocation(oPuzzle));

                if (GetLocalInt(oDungeon, "b" + sLevel + "Completed") == TRUE)
                {
                    nReward = GetLocalInt(oDungeon, "n" + sLevel + "Reward");
                    DebugMessage("  Puzzle reward type is " + IntToString(nReward) + " at level " + IntToString(nPartyLevel));
                    if (nReward == 1) // secret area
                    {
                        // spawn portals
                        oSecretEntrance = GetNearestObjectByTag("ID1_STATIC_WP_SECRET", oPuzzle);
                        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_puzport", GetLocation(oSecretEntrance));
                        oSecretExit = GetNearestObjectByTag("ID1_STATIC_WP_SECRET", oSecretEntrance);
                        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_puzport", GetLocation(oSecretExit));
                    } else if (nReward == 2)
                    {
                        // spawn chest and treasure
                        int nContainer = GetLocalInt(oDungeon, "n" + sLevel + "Container");
                        string sContainer = GetLocalString(oDungeon, "sListContainer" + IntToString(nContainer) + "ResRef");

                        DebugMessage("Container resref is " + sContainer);

                        // spawn container
                        object oContainer = CreateObject(OBJECT_TYPE_PLACEABLE, sContainer, GetLocation(oPuzzle));

                        if (oContainer != OBJECT_INVALID)
                        {
                            // get facing
                            float fFacing = GetFacing(oPuzzle);
                            fFacing += 180.0;

                            DebugMessage("Waypoint facing: " + FloatToString(fFacing));

                            DebugMessage("Container facing: " + FloatToString(GetFacing(oContainer)));

                            // set facing
                            AssignCommand(oContainer, SetFacing(fFacing));

                            // set variables on the container
                            SetLocalString(oContainer, "sVariable", sLevel);

                            // make a microprocess to generate the container items
                            oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU48");
                            SetLocalObject(oMicroCPU, "oContainer", oContainer);
                            SetLocalString(oMicroCPU, "sLevel", sLevel);
                            SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                            SetLocalInt(oMicroCPU, "bContainer", TRUE);

                            DelayCommand(0.01, ExecuteScript("exe_id1_micloot", oMicroCPU));
                        } else
                        {
                            DebugMessage("Container object didn't exist yet.");
                        }
                    }
                }

                // run the puzzle script on the puzzle point
                DelayCommand(0.01, ExecuteScript(sPuzzle, oPuzzle));
            }
        }

        nPuzzle++;
    }

    DebugMessage("Entering into holding pattern..");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

