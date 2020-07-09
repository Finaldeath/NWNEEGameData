//:://////////////////////////////////////////////////////////////
//:: phb_id1_map                                                //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This is the heartbeat script for the map object. It detects
    when the player has moved a certain distance from the map and
    uses that as a signal to destroy itself. If the player has
    moved, it executes the cleanup script on the first map CPU
    object.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


#include "inc_id1_debug"
#include "inc_id1_flags"

void DestroyMap();

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");
    DebugMessage("Map heartbeat.");

    // determine creator
    object oPC = GetLocalObject(OBJECT_SELF, "oCreator");

    // if player is in different area
    object oPCArea = GetArea(oPC);
    object oMapArea = GetArea(OBJECT_SELF);
    if (oMapArea != oPCArea)
    {
        DebugMessage("Player is in a different area.");

        // destroy
        DestroyMap();
    } else
    {
        DebugMessage("Player is in the same area.");

        // if this map is the active one
        object oActiveMap = GetLocalObject(oPC, "oActiveMap");
        if (oActiveMap == OBJECT_SELF)
        {
            DebugMessage("This map is the active one.");

            // check autocleanup flag
            if (GetModuleFlag(ID1_FLAG_MAP_AUTOCLEANUP) == ID1_ACTIVE)
            {
                DebugMessage("Autocleanup enabled.");

                // get distance
                float fDistance = GetDistanceBetween(oPC, OBJECT_SELF);
                object oDungeon = GetLocalObject(OBJECT_SELF, "oDungeon");
                int nMaxX = GetLocalInt(oDungeon, "nMaxX");
                int nMaxY = GetLocalInt(oDungeon, "nMaxY");
                if (nMaxY > nMaxX)
                {
                    nMaxX = nMaxY;
                }
                DebugMessage("Distance is " + FloatToString(fDistance) + " vs " + IntToString(nMaxX));

                // if a reasonable distance away
                if (fDistance > (nMaxX * 1.5))
                {
                    DebugMessage("Map is too far away. Destroying.");

                    // destroy
                    DestroyMap();
                }
            }
        } else // if not the active one
        {
            DebugMessage("This map is not the active one. Destroying.");

            // destroy
            DestroyMap();
        }
    }
}

void DestroyMap()
{
    int nChildNum = GetLocalInt(OBJECT_SELF, "nChild");
    int nChild = 1;
    object oChild;
    while (nChild <= nChildNum)
    {
        oChild = GetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChild));
        DelayCommand(0.01, ExecuteScript("exe_id1_maperase", oChild));

        nChild++;
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}

