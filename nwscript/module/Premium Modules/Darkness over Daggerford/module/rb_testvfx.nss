void main()
{
    if(GetLocalInt(OBJECT_SELF, "iFavourable") == 0)
    {
        object oPC = GetLastUsedBy();
        effect eFavor = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

        FloatingTextStringOnCreature("This merchant now views you as a favored customer!", oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFavor, oPC);
        //SetLocalInt(OBJECT_SELF, "iFavourable", 1);
    }
}
