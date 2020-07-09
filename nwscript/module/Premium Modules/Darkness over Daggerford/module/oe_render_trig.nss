void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC))
    {
        FloatingTextStringOnCreature("The render does not appear to be hostile...", oPC);
    }
}
