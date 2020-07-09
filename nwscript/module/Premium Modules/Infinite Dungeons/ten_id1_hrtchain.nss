//::////////////////////////////////////////////////////////////////////////////
//:: ten_id1_hrtchain
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Enter event script for the chain trigger in Harat's area. Adds entering
    objects to a list of objects stored on the trigger.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 4, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"

void main()
{
    // Gather the entering object and the trigger.
    object oTrigger = OBJECT_SELF;
    object oEntering = GetEnteringObject();

    // Debug information.
    DebugMessage("ten_id1_hrtchain::main() On Enter");

    // Error checking.
    if (!GetIsObjectValid(oEntering))
    {
        DebugMessage("ten_id1_hrtchain::main() oEntering is invalid.");
    }

    // Number of objects currently stored.
    int nObjects = GetLocalInt(oTrigger, CHAIN_TRIGGER_OBJECT_NUM);

    // Increment the number of objects stored and store the entering.
    nObjects++;

    SetLocalObject(oTrigger, CHAIN_TRIGGER_OBJECT_PRFX
        + IntToString(nObjects), oEntering);
    SetLocalInt(oTrigger, CHAIN_TRIGGER_OBJECT_NUM, nObjects);

    // When a player enters the imps should try to trap them.
    if (GetIsPC(oEntering))
    {
        object oLever = DB_GetNearestObjectByTag(CHAIN_LEVER_TAG);

        AssignCommand(oLever, ActionActivateChainTrap());
    }
}
