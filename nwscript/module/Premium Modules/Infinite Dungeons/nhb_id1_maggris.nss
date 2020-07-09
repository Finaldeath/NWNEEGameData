//::////////////////////////////////////////////////////////////////////////////
//:: nhb_id1_maggris
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Heartbeat Event script for Maggris. Cycles players in the area to
    determine if they're near enough a cocoon to activate it.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 10, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_maggris"

void main()
{
    // Check for the maximum number of bugs.
    object oThis = OBJECT_SELF;

    if (GetLocalInt(oThis, MINION_COUNTER) >= MAX_MINIONS)
    {
        // Default AI
        ExecuteScript("nw_c2_default1", OBJECT_SELF);

        return;
    }

    // Cycle through all players in the area.
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ActivateNearbyCocoons());

        oPC = GetNextPC();
    }

    // Default AI
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
