void main()
{
    object oPC=GetPCSpeaker();
    AdjustAlignment(oPC,ALIGNMENT_EVIL,2);
    if(!GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)==0)
    {
        FloatingTextStringOnCreature("Blackguard behavior.",oPC);
        GiveXPToCreature(oPC,50);
    }
}
