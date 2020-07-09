// smith checks for item to work on
// - brian watson

#include "x2_inc_itemprop"

void PopLid(object oChest);

void main()
{
    ClearAllActions(TRUE);

    object oWorkItem = GetLocalObject(OBJECT_SELF, "oWorkItem");

    if (GetIsObjectValid(oWorkItem))
    {
        if (GetItemPossessor(oWorkItem) == OBJECT_SELF)
        {
            object oChest = GetNearestObjectByTag("bw_smith_chest");

            if (GetLocalInt(oWorkItem, "nIH_SmithWorked") == 1)
            {
                ActionForceMoveToObject(oChest, FALSE, 1.0, 7.0);
                ActionDoCommand(PopLid(oChest));
                ActionGiveItem(oWorkItem, oChest);
                ActionDoCommand(SetPickpocketableFlag(oWorkItem, TRUE));
                ActionDoCommand(DeleteLocalObject(OBJECT_SELF, "oWorkItem"));
                return;
            }

            object oWP = GetNearestObjectByTag("bw_smith_walk1");
            ActionMoveToObject(oWP);

            object oAnvil = GetNearestObjectByTag("bw_smith_anvil");
            SetLocalInt(oAnvil, "nThumps", 0);
            ActionAttack(oAnvil);
        }
        else
        {
            DeleteLocalObject(OBJECT_SELF, "oWorkItem");
        }
    }
    else
    {
        DeleteLocalObject(OBJECT_SELF, "oWorkItem");
    }
}

void PopLid(object oChest)
{
    AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
    DelayCommand(1.0f, AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
}
