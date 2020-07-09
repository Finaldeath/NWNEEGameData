void main()
{
    object oPC=GetPCSpeaker();
    //return Hevesar's money, get a Paladin like reward :)
    TakeGoldFromCreature(700,oPC,TRUE);
    AdjustAlignment(oPC,ALIGNMENT_GOOD,4);
    if(!GetLevelByClass(CLASS_TYPE_PALADIN,oPC)==0)
    {
        FloatingTextStringOnCreature("Honoring the Paladin's code.",oPC);
        AdjustAlignment(oPC,ALIGNMENT_LAWFUL,4);
        GiveXPToCreature(oPC,150);
    }
}
