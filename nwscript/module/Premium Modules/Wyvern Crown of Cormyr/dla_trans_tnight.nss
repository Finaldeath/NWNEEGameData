void main()
{
    object oPC = GetClickingObject();
    if(GetTimeHour()>17 || GetTimeHour()<8)
    {
        FloatingTextStringOnCreature("**The jousting ground is closed for the night**",oPC);
        return;
    }
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    AssignCommand(oPC,JumpToObject(oTarget));
}
