void AnimShakeHead(object oPC)
{
    int i;
    for (i=1; i<=4; i++)
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT,  1.0, 0.15));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.0, 0.15));
    }
}

void AnimLookAround(object oPC)
{
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75));
}

void AnimStrip(object oPC)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (GetIsObjectValid(oItem))
    {
        AssignCommand(oPC, ActionUnequipItem(oItem));
    }
}

void AnimScratchHead(object oPC)
{
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
}

// void main() { }
