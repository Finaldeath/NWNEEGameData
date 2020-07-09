//:://////////////////////////////////////////////////////////////
//:: inc_id1_clean                                              //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    EDIT
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: September 2005                                 //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_flags"


//////////////////////////////////////////////////////////////////
// Function Prototypes                                          //
//////////////////////////////////////////////////////////////////

void CleanMap(object oPC, object oMap = OBJECT_INVALID);


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void CleanMap(object oPC, object oMap = OBJECT_INVALID)
{
    DebugMessage("Cleaning map.");

    // if no map was specified, get the player's
    if (oMap == OBJECT_INVALID)
    {
        DebugMessage("  Map was invalid.");

        oMap = GetItemPossessedBy(oPC, "itm_id1_map");
    }

    SetLocalInt(oPC, "bMapActive", FALSE);

//    SendMessageToPC(oPC, "Destroying map.");

    // destroy map
    string sMapTag = GetLocalString(oMap, "sMapTag");

    DebugMessage("  sMapTag = " + sMapTag);

    if (sMapTag != "")
    {
//        SendMessageToPC(oPC, "Map tag: " + sMapTag);

        object oMapStart = GetObjectByTag(sMapTag);

        if (oMapStart != OBJECT_INVALID)
        {
            DebugMessage("oMapStart exists.");

            object oMapCPU = GetObjectByTag(sMapTag + "CPU1");

            if (oMapCPU == OBJECT_INVALID)
            {
                DebugMessage("oMapCPU does not exist.");
            } else
            {
                DebugMessage("oMapCPU exists.");
            }

            // so this doesn't repeat
            SetLocalString(oMap, "sMapTag", "");

            SetLocalInt(oMapStart, "bDestroyed", TRUE);

            SetLocalInt(oMapStart, "nCurrentY", 1);

            //destroy the map in 0.01 seconds (arbitrary)
            ExecuteScript("exe_id1_maperase", oMapCPU);
        } else
        {
            DebugMessage("oMapStart does not exist.");
        }
    }
}

