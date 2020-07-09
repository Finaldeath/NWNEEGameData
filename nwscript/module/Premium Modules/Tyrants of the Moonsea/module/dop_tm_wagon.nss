// make sure that the player levels up before leaving madoc's wagon

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetHitDice(oClicker) >= 12)
    {
        AssignCommand(oClicker, JumpToObject(oTarget));
    }
    else
    {
        AssignCommand(oClicker, ActionStartConversation(oClicker, "tm_wagon_error", FALSE, FALSE));
    }
}
