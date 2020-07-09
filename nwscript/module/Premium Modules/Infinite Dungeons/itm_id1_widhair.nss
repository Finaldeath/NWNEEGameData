//::////////////////////////////////////////////////////////////////////////////
//:: itm_id1_widhair
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Item Event handler for the Widow Hagatha's hair item. When activated the
    item forces one creature to become the player's follower.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 20, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"
#include "x2_inc_switches"
#include "x0_i0_henchman"

const string CONTROLLED_CREATURE = "oControlled";

void main()
{
//    int nEvent = GetUserDefinedEventNumber();

    // item activated.
//    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
//    {
        // Gather the user, used item and target.
        object oUser = GetItemActivator();
        object oTarget = GetItemActivatedTarget();
        object oItem = GetItemActivated();

        // Ensure that the player doesn't already have a creature controlled by
        // this item.
        object oControlled = GetLocalObject(oItem, CONTROLLED_CREATURE);

        if (GetIsObjectValid(oControlled))
        {
            SendMessageToPC(oUser, "There is already a thrall under the power of this artifact.");
            return;
        }

        // Determine the target's size.
        int nSize = GetCreatureSize(oTarget);
        int bSuccess = TRUE;

        // DEBUG
        DebugMessage("itm_id1_widhair::main()");

        // Ensure a valid size. If the target is not a valid size jump out.
        switch (nSize)
        {
            case CREATURE_SIZE_MEDIUM:
            case CREATURE_SIZE_SMALL:
            case CREATURE_SIZE_TINY: // Appropriate sizes.
            {
                break;
            }

            default: // inappropriate size.
            {
                DebugMessage("^ The target is of an inappropriate size.");
                bSuccess = FALSE;
                break;
            }
        } // end switch.

        // The player can't charm little Timmy or any of the bosses.
        string sTag = GetTag(oTarget);

        if (sTag == "id1_littletimmy") bSuccess = FALSE;
        if (sTag == GZHORB_TAG) bSuccess = FALSE;
        if (sTag == HALASTER_TAG) bSuccess = FALSE;
        if (sTag == HARAT_TAG) bSuccess = FALSE;
        if (sTag == ANTOINE_TAG) bSuccess = FALSE;
        if (sTag == MAGGRIS_TAG) bSuccess = FALSE;
        if (sTag == MASTERIUS_TAG) bSuccess = FALSE;
        if (sTag == HAGATHA_TAG) bSuccess = FALSE;

        // Ensure that the target is not a player or a player's follower.
        if (GetIsPC(oTarget))
        {
            bSuccess = FALSE;
        }
        else
        {
            object oMaster = GetMaster(oTarget);

            if (GetIsPC(oMaster)) bSuccess = FALSE;
        }

/*
        // If successful so far have the creature make a saving throw.
        if (bSuccess)
        {
            //string sTag = GetTag(oItem);
            //int nLength = GetStringLength(sTag);
            //int nLevel = StringToInt(GetSubString(sTag, (nLength - 2), 2));
            int nLevel = GetHitDice(oUser);
            int nSaveDC = nLevel + 20;
            int nSave = WillSave(oTarget, nSaveDC, SAVING_THROW_TYPE_MIND_SPELLS, oUser);

            // DEBUG
            DebugMessage("^ Item Level = " + IntToString(nLevel));

            // Saving throw is against 10 + item level.
            if (nSave)
            {
                DebugMessage("^ Target saving throw succeded.");
                bSuccess = FALSE;
            }
        }
        else
        {
            SendMessageToPC(oUser, "This item cannot be used on " + GetName(oTarget) + ".");
        }
*/

        effect eVFX;

        // If the item is successful set the target as a minion.
        if (bSuccess)
        {
            // Clear the target's action queue; it could be an enemy.
            DebugMessage("Clearing actions. Point 20.");
            AssignCommand(oTarget, ClearAllActions(TRUE));

            // Add the target as a henchman and set the follower variable used by
            // the default event hanlding scripts.
            AddHenchman(oUser, oTarget);
            SetAssociateState(NW_ASC_DISTANCE_2_METERS, TRUE, oTarget);
            SetLocalInt(oTarget, "bFollower", TRUE);
            AssignCommand(oTarget, SetIsDestroyable(FALSE));

            // Display a charm visual effect.
            eVFX = EffectVisualEffect(VFX_IMP_CHARM);

            //DEBUG
            DebugMessage("^ SUCCESS");
        }
        else // The creature made the saving throw or was too large.
        {
            eVFX = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);

            SendMessageToPC(oUser, "This item cannot be used on " + GetName(oTarget) + ".");
            // DEBUG
            DebugMessage("^ FAILURE");
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
//    } // X2_ITEM_EVENT_ACTIVATE
//    else
//    {
//        DebugMessage("itm_id1_widhair::main() nEvent != X2_ITEM_EVENT_ACTIVATE");
//    }
}
