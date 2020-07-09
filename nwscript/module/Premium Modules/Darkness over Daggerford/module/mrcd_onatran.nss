void main()
{
    object oClicker=GetClickingObject();
    object oKnight = GetNearestObjectByTag("ac_blancheflor");
    object oTarget=GetTransitionTarget(OBJECT_SELF);

    if(GetLocalInt(oKnight, "has_met_pc") == 0 && GetIsObjectValid(oKnight))
    {
        AssignCommand(oKnight, ActionStartConversation(oClicker));
    }
    else
    {
        AssignCommand(oClicker, JumpToObject(oTarget));
    }
}
