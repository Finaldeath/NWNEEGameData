//::////////////////////////////////////////////////////////////////////////////
//:: itm_id1_gzrbeye
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Item event handling script for the gzhorb's eyestalk item. When used a
    barrage of eyebeams are fired from the user to all creatures in a sphere
    around the target location.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov 3, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "x2_inc_switches"

void main()
{
//    int nEvent = GetUserDefinedEventNumber();

    // Item activated event.
//    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
//    {
        // Gather user, item and target location.
        object oUser = GetItemActivator();
        object oItem = GetItemActivated();
        location lTarget = GetItemActivatedTargetLocation();

        // Clear the user's action queue to avoid interruptions to the item's power.
        DebugMessage("Clearing actions. Point 18.");
        AssignCommand(oUser, ClearAllActions(TRUE));

        // The number of beams fired by the item is dependent on it's level.
        //string sTag = GetTag(oItem);
        //int nLength = GetStringLength(sTag);
        //int nLevel = StringToInt(GetSubString(sTag, (nLength - 2), 2));
        int nLevel = GetHitDice(oUser) + 3;

        float fDelay = 0.0;

        // Cast beholder eye-beam spells at all hostiles in a large sphere.
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE);

        int i, bTarget = FALSE;

        // 2-41 beams will be fired depending on the item's level.
        for (i = 0; i <= nLevel; ++i)
        {
             // If the target has become invalid either all targets in the area
             // have been iterated or there are none left.
            if (!GetIsObjectValid(oTarget))
            {
                // If no valid hostile target has been found at this point there
                // is no need to continue.
                if (!bTarget)
                {
                    return;
                }

                oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lTarget, TRUE);

                // Extra Sanity check to ensure that previously found targets
                // are not currently invalid for some reason.
                if (!GetIsObjectValid(oTarget))
                {
                    return;
                }
            }

            // Ensure the target is not a friend.
            if (!GetIsReactionTypeFriendly(oTarget, oUser))
            {
                DebugMessage("\n\n\n\n FIRING BEAM");

                // One of 4 possible beams will be fired.
                int nRand = Random(4);

                DelayCommand(fDelay, AssignCommand(oUser, ActionCastSpellAtObject(776 + nRand, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));

                fDelay += 0.3;

                //AssignCommand(oUser, ActionCastSpellAtObject(776 + nRand, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

                bTarget = TRUE; // At least one hostile target exists.
            }
            else // If the target is friendly save the beam for somone else.
            {
                i--;
            }

            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE);
        } // end for
//    } // X2_ITEM_EVENT_ACTIVATE
} // main
