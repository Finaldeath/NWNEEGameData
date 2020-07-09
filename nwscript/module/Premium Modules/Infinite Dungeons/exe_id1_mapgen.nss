//:://////////////////////////////////////////////////////////////
//:: exe_id1_mapgen                                             //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script spawns in a single Y row of the map on the ground
    around the PC. The tiles spawned in reflect the configuration
    of the dungeon level the player is on.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_gen"
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");
    DebugMessage("Map generation.");

    object oPC = GetLocalObject(OBJECT_SELF, "oCreator");
    int nPCArea = GetLocalInt(OBJECT_SELF, "nPCArea");
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");

    if (oPC != OBJECT_INVALID)
    {
        object oDungeon = GetLocalObject(OBJECT_SELF, "oDungeon");
        if (oDungeon != OBJECT_INVALID)
        {
            DebugMessage("  Dungeon exists for map generation.");

            // get dungeon extents
            int nMaxX = GetLocalInt(oDungeon, "nMaxX");
            int nMaxY = GetLocalInt(oDungeon, "nMaxY");
            SetLocalInt(OBJECT_SELF, "nChild", nMaxY);

            // create and run children for each Y row
            int nCurrentY = 1;
            object oChild;
            while (nCurrentY <= nMaxY)
            {
                // create child
                oChild = CreateObject(OBJECT_TYPE_PLACEABLE, "CPU", GetLocation(OBJECT_SELF), FALSE, "ChildCPU");
                SetLocalObject(oChild, "oCreator", oPC);
                SetLocalObject(oChild, "oCenter", OBJECT_SELF);
                SetLocalInt(oChild, "nCurrentY", nCurrentY);
                SetLocalInt(oChild, "nMaxX", nMaxX);
                SetLocalInt(oChild, "nPCArea", nPCArea);
                SetLocalInt(oChild, "nLevel", nLevel);
                SetLocalObject(oChild, "oDungeon", oDungeon);

                SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nCurrentY), oChild);
                DebugMessage("  Creating oChild" + IntToString(nCurrentY));

                // run map generation script
                DelayCommand(0.01, ExecuteScript("exe_id1_mapgenc", oChild));

                nCurrentY++;
            }
        } else
        {
            DebugMessage("Dungeon does not exist for map generator.");

            DestroyObject(OBJECT_SELF);
        }
    } else
    {
        DebugMessage("Player does not exist for map generator.");

        DestroyObject(OBJECT_SELF);
    }
}
