#include "inc_id1_debug"
#include "inc_id1_utility"

void GeneratePuzzleReward(object oWaypoint, object oPC);

void GeneratePuzzleReward(object oWaypoint, object oPC)
{
    // get waypoint number off puzzle point
    int nWaypoint = GetLocalInt(oWaypoint, "nNumber");
    DebugMessage("  Waypoint is number " + IntToString(nWaypoint) + " in this area.");

    // get area identifier
    int nAreaIdentifier = GetLocalInt(GetArea(oWaypoint), "nAreaIdentifier");
    DebugMessage("  Area is identifier " + IntToString(nAreaIdentifier));

    // get current dungeon
    object oDungeon = GetCurrentDungeon();

    // get area number
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
    DebugMessage("  Area is dungeon area number " + IntToString(nAreaNum));

    // get current level
    int nLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    DebugMessage("  Current dungeon level is " + IntToString(nLevel));

    // get waypoint variable in area
    string sLevel = "Area" + IntToString(nAreaNum) + "WaypointPuzzle" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
    DebugMessage("  Waypoint variable is " + sLevel);

    // check what reward this puzzle should have
    int nReward = GetLocalInt(oDungeon, "n" + sLevel + "Reward");
    DebugMessage("  nReward is " + IntToString(nReward));
    if (nReward == 1) // secret area
    {
        SendMessageToPC(oPC, "A portal has been opened to a new area.");

        // spawn portals
        object oSecretEntrance = GetNearestObjectByTag("ID1_STATIC_WP_SECRET", oWaypoint);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_puzport", GetLocation(oSecretEntrance), FALSE, "PuzzleSecretEntrance");
        object oSecretExit = GetNearestObjectByTag("ID1_STATIC_WP_SECRET", oSecretEntrance);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_puzport", GetLocation(oSecretExit), FALSE, "PuzzleSecretExit");
    } else if (nReward == 2) // treasure
    {
        // check to see if the chest has been destroyed
        int bDead = GetLocalInt(oDungeon, "b" + sLevel + "Dead");
        if (bDead == FALSE)
        {
            // get container
            int nContainer = GetLocalInt(oDungeon, "n" + sLevel + "Container");
            string sContainer = GetLocalString(oDungeon, "sListContainer" + IntToString(nContainer) + "ResRef");

            DebugMessage("Container is " + IntToString(nContainer) + " with resref " + sContainer);

            // spawn container
            object oContainer = CreateObject(OBJECT_TYPE_PLACEABLE, sContainer, GetLocation(oWaypoint));

            if (oContainer != OBJECT_INVALID)
            {
                // get facing
                float fFacing = GetFacing(oWaypoint);
                fFacing += 180.0;

                DebugMessage("Waypoint facing: " + FloatToString(fFacing));

                DebugMessage("Container facing: " + FloatToString(GetFacing(oContainer)));

                // set facing
                AssignCommand(oContainer, SetFacing(fFacing));

                // set variables on the container
                SetLocalString(oContainer, "sVariable", sLevel);

                // make a microprocess to generate the container items
                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU113");
                SetLocalObject(oMicroCPU, "oContainer", oContainer);
                SetLocalString(oMicroCPU, "sLevel", sLevel);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bContainer", TRUE);

                if (oMicroCPU != OBJECT_INVALID)
                {
                    DebugMessage("Micro exists.");
                    DebugMessage("Tag of container is " + GetTag(GetLocalObject(oMicroCPU, "oContainer")));
                    DebugMessage("sLevel is " + GetLocalString(oMicroCPU, "sLevel"));

                    ExecuteScript("exe_id1_micloot", oMicroCPU);
                } else
                {
                    DebugMessage("Micro is invalid.");
                }
            } else
            {
                DebugMessage("Container object didn't exist yet.");
            }
        }
    } else // experience
    {
        int nExperience = GetLocalInt(oDungeon, "n" + sLevel + "Experience");
        GiveXPToCreature(oPC, nExperience);
    }
}

//void main(){}
