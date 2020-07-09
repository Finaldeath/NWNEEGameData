//::///////////////////////////////////////////////
//::
//:: a3_oc_smithchest
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Close script for placeable.
//::
//:: Smith upgrades gear if he hasn't done so.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/8/2005
//::
//:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void PopLid(object oChest);

void main()
{
    string q = GetLocalString(GetModule(), "QUOTE");

    object oCloser = GetLastClosedBy();
    object oSmith = GetNearestObjectByTag("bw_smith");

    if (GetLocalInt(GetModule(), "nIH_RestoredStone") == 0)
    {
        return;
    }

    if (GetLocalInt(oCloser, "nIH_SmithWorked") == 0)
    {
        object oItem = GetFirstItemInInventory();

        if (GetIsObjectValid(oItem))
        {
            int nBaseItem = GetBaseItemType(oItem);

            if (GetWeaponRanged(oItem) ||
                IPGetIsMeleeWeapon(oItem) ||
                (nBaseItem == BASE_ITEM_ARMOR) ||
                (nBaseItem == BASE_ITEM_LARGESHIELD) ||
                (nBaseItem == BASE_ITEM_SMALLSHIELD) ||
                (nBaseItem == BASE_ITEM_TOWERSHIELD))
            {
                if (GetLocalInt(oItem, "nIH_SmithWorked") == 1)
                {
                    AssignCommand(oSmith, SpeakString(q+"I can do no more for you... Goodbye..."+q));
                    AssignCommand(oSmith, ClearAllActions());
                    AssignCommand(oSmith, ActionDoCommand(ExecuteScript("c4_xs_bw_smith3", oSmith)));  // vanish
                }
                else if (GetIsObjectValid(GetLocalObject(oSmith, "oWorkItem")))
                {
                    AssignCommand(oSmith, SpeakString(q+"I am busy right now, you must wait..."+q));
                }
                else
                {
                    AssignCommand(oSmith, SpeakString(q+"I shall do what I can for you..."+q));

                    object oSelf = OBJECT_SELF;
                    SetLocalObject(oSmith, "oWorkItem", oItem);

                    if (IsInConversation(oSmith))
                    {
                        return;
                    }

                    AssignCommand(oSmith, ClearAllActions(TRUE));

                    AssignCommand(oSmith, ActionForceMoveToObject(oSelf, FALSE, 1.0, 7.0));
                    AssignCommand(oSmith, ActionDoCommand(PopLid(oSelf)));
                    AssignCommand(oSmith, ActionTakeItem(oItem, oSelf));
                    AssignCommand(oSmith, ActionDoCommand(SetPickpocketableFlag(oItem, FALSE)));
                    AssignCommand(oSmith, ActionWait(1.0f));
                    AssignCommand(oSmith, ActionDoCommand(ExecuteScript("c4_xs_bw_smith", oSmith)));
                }
            }
            else
            {
                AssignCommand(oSmith, SpeakString(q+"I cannot work on that item..."+q));
            }
        }
    }
    else
    {
        AssignCommand(oSmith, SpeakString(q+"I can do no more for you... Goodbye..."+q));
        AssignCommand(oSmith, ClearAllActions());
        AssignCommand(oSmith, ActionDoCommand(ExecuteScript("c4_xs_bw_smith3", oSmith)));  // vanish
    }
}

void PopLid(object oChest)
{
    AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
    DelayCommand(1.0f, AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
}
