//::////////////////////////////////////////////////////////////////////////////
//:: ncr_id1_maggris
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Combat Round End script for Maggris.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 28, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_maggris"

void main()
{
    object oThis = OBJECT_SELF;
    int nCounter = GetLocalInt(oThis, SUMMON_COUNTER);
    int nMinions = GetLocalInt(oThis, MINION_COUNTER);
    int nRand;

    if (nCounter == 0)
    {
        // Establish a new count down.
        nRand = Random(3) + 3;

        SetLocalInt(oThis, SUMMON_COUNTER, nRand);

        // If there are already enough minions don't summon more.
        if (nMinions != MAX_MINIONS)
        {
            // Clear actions and create a cocoon.
            ClearAllActions(TRUE);

            ActionCreateCocoon();

            // Ensure that no other actions overwrite for 2 seconds.
            DebugMessage("Clearing actions. Point 24.");
            DelayCommand(2.0, SetCommandable(TRUE));
            // DelayCommand(2.1, ExecuteScript("nw_c2_default3", OBJECT_SELF));
            DelayCommand(2.1, ActionAttack(GetLastHostileActor()));
            SetCommandable(FALSE);
        }
    }
    else // Decrement the count down and continue.
    {
        nCounter--;

        SetLocalInt(oThis, SUMMON_COUNTER, nCounter);
    }

    // Default handling.
    ExecuteScript("nw_c2_default3", OBJECT_SELF);
}
