void main()
{
    object oPC=GetPCSpeaker();
    //return Falias' money, get a Paladin like reward :)
    TakeGoldFromCreature(100,oPC,TRUE);
    AdjustAlignment(oPC,ALIGNMENT_LAWFUL,2);
    AdjustAlignment(oPC,ALIGNMENT_GOOD,2);
    if(!GetLevelByClass(CLASS_TYPE_PALADIN,oPC)==0)
    {
        FloatingTextStringOnCreature("Honoring the Paladin's code.",oPC);
    }
}
