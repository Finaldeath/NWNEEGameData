//::////////////////////////////////////////////////////////////////////////////
//:: aen_id1_masterius
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Area On Enter script for Masterius's lair. This script sets up the area for
    the boss fight and gets things going.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 26, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_masteriu"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    object oEntering = GetEnteringObject();
    object oDungeon = GetCurrentDungeon();
    int bActivated = GetLocalInt(oDungeon, "bBossActivated");

    if (GetIsPC(oEntering) == TRUE)
    {
        DebugMessage("Player is entering area with identifier " + GetPCIdentifier(oEntering));

        if (bActivated == FALSE)
        {
            DebugMessage("  Area is not activated. Setting up.");

            // run setup
            Setup();
        } else
        {
            DebugMessage("  Area is already activated.");
        }
    }
}

