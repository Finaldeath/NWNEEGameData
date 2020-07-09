//variable rewards scheme for the wedding of Lula and Sieronius Dethick
void main()
{
    object oPC=GetPCSpeaker();
    if(GetLocalInt(OBJECT_SELF, "iEvilXPGiven") == 0)
    {
        if(!GetLevelByClass(CLASS_TYPE_PALADIN,oPC)==0)
        {
            FloatingTextStringOnCreature("Your God has forsaken you!",oPC);
            AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
        }
        if(!GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)==0)
        {
            FloatingTextStringOnCreature("Your God is delighted by your actions!",oPC);
            GiveXPToCreature(oPC,2500);
            AdjustAlignment(oPC,ALIGNMENT_EVIL,20);
        }
        else
        {
            GiveXPToCreature(oPC,1500);
            AdjustAlignment(oPC,ALIGNMENT_EVIL,20);
        }
        SetLocalInt(OBJECT_SELF, "iEvilXPGiven", 1);
    }
    object oLula=GetObjectByTag("db_lula");
    effect eZap=EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eZap,oLula);
}
