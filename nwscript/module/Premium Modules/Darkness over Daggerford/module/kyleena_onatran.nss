void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

    if(GetLocalInt(GetModule(), "iKyleenaDeparted") == 1)
    {
        FloatingTextStringOnCreature("The tent's contents have been removed.", oClicker);
    }
    else
    {
        AssignCommand(oClicker, JumpToObject(oTarget));
    }
}
