//::////////////////////////////////////////////////////////////////////////////
//:: mrt_id1_rest
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Rest event for the module. The player will be prevented from resting
    unless they are in the startng area or using a tent object.
    See pus_id1_resttent.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 12, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_debug"

const string NO_RESTING_MSG = "You cannot rest here.";

void main()
{
    if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
        object oPC = GetLastPCRested();
        object oArea = GetArea(oPC);

        // When the player is in an area other than the starting area.
        if (GetTag(oArea) != "DungeonEntrance")
        {
            // Check to see if the player has used a tent and is therefore
            // allowed to rest. If not cancel the rest and display feedback.
            if (!GetLocalInt(oPC, "bCanRest"))
            {
                FloatingTextStringOnCreature(NO_RESTING_MSG, oPC);
                DebugMessage("Clearing actions. Point 22.");
                AssignCommand(oPC, ClearAllActions());
            }
        }
    }
}


