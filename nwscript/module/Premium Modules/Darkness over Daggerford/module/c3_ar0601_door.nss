// make sure that the player levels up before leaving falias' wagon

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetHitDice(oClicker) >= 8)
    {
        AssignCommand(oClicker, JumpToObject(oTarget));
    }
    else
    {
        AssignCommand(oClicker, ActionStartConversation(oClicker, "ks_ar0601_error", FALSE, FALSE));
    }
}
