//::////////////////////////////////////////////////////////////////////////////
//:: tex_id1_hrtchain
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Exit Event script for the chain trigger in harat's area. Creature's
    exiting the trigger are removed from the trigger's list of objects.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 4, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"

void main()
{
    // Gather the exiting object and trigger.
    object oTrigger = OBJECT_SELF;
    object oExiting = GetExitingObject();

    // Debug information.
    DebugMessage("tex_id1_hrtchain::main() On Exit.");

    // Error checking.
    if (!GetIsObjectValid(oExiting))
    {
        DebugMessage("tex_id1_hrtchain::main() Exiting object is invalid.");
    }

    // Find the object in the trigger's list.
    int nObjects = GetLocalInt(oTrigger, CHAIN_TRIGGER_OBJECT_NUM);
    int i;

    object oStored;
    object oTemp;

    // Cycle the entire list looking for a match.
    for (i = 1; i <= nObjects; ++i)
    {
        oStored = GetLocalObject(oTrigger, CHAIN_TRIGGER_OBJECT_PRFX
            + IntToString(i));

        // Error checking.
        if (!GetIsObjectValid(oStored))
        {
            DebugMessage("tex_id1_hrtchain::main() Invalid object stored on"
                + " chain trigger, index: " + IntToString(i));
        }

        // If this is the object we're looking for place the last object in the
        // list in this object's place.
        if (oStored == oExiting)
        {
            // Special case where there is only one object; just delete it.
            if (nObjects == 1)
            {
                SetLocalObject(oTrigger, CHAIN_TRIGGER_OBJECT_PRFX + "1",
                    OBJECT_INVALID);
            }
            else
            {
                // Grab the last object in the list.
                oTemp = GetLocalObject(oTrigger, CHAIN_TRIGGER_OBJECT_PRFX
                    + IntToString(nObjects));

                // Replace the exiting object with the last object.
                SetLocalObject(oTrigger, CHAIN_TRIGGER_OBJECT_PRFX
                    + IntToString(i), oTemp);

                // Void the last object.
                SetLocalObject(oTrigger, CHAIN_TRIGGER_OBJECT_PRFX
                    + IntToString(nObjects), OBJECT_INVALID);
            }

            // Update the counter.
            nObjects--;
            SetLocalInt(oTrigger, CHAIN_TRIGGER_OBJECT_NUM, nObjects);

            break; // No need to continue once the object is found.
        }
    } // end for.
}
