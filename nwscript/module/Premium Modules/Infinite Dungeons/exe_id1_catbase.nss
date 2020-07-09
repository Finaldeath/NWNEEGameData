//:://////////////////////////////////////////////////////////////
//:: exe_id1_catbase                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script catalogs the initial entrance area and all
    dungeon entrances. It ignores everything except the staircases
    down.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: September 2005                                 //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////
#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("Checking for the dungeon entrance.");

    // grab the dungeon entrance area
    object oArea = GetObjectByTag("DungeonEntrance");

    // examine the dungeon entrance area
    if (GetIsObjectValid(oArea))
    {
        DebugMessage("  Found the dungeon entrance.");

/*        // reset the stairs counter
        int nStairsDown = 1;

        // get the first object in area
        object oObject = GetFirstObjectInArea(oArea);

        // object tag
        string sTag;

        // dungeon variable string
        string sDungeonObject;

        object oDungeon;

        // cycle through objects in the area
        while (oObject != OBJECT_INVALID)
        {
            // get the tag of the current object
            sTag = GetTag(oObject);

            // staircases down are dungeon entrance portals
            if (sTag == "ID1_STATIC_STAIRSDOWN")
            {
                DebugMessage("    Found a stair down. Assigning " + IntToString(nStairsDown));

                // update the total number of dungeon entrances found
//                SetLocalInt(GetModule(), "nDungeonNumber", nStairsDown);

                // link this dungeon entrance to the module
//                sDungeonObject = "oDungeonNumber" + IntToString(nStairsDown);
//                SetLocalObject(GetModule(), sDungeonObject, oObject);

                // assign the current dungeon entrance number to the entrance object
//                SetLocalInt(oObject, "nDungeonNumber", nStairsDown);

                // EDIT: testing
//                oDungeon = GetLocalObject(GetModule(), sDungeonObject);
//                DebugMessage("    Grabbed object " + sDungeonObject + " with tag " + GetTag(oDungeon));
                //

                nStairsDown++;
            }

            // get the next object in the area
            oObject = GetNextObjectInArea(oArea);
        }*/
    } else
    {
        DebugMessage("  No dungeon entrance area found.");
    }

    DebugMessage("  Passing to catalog script.");

    // return to catalog generation
    DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
}

