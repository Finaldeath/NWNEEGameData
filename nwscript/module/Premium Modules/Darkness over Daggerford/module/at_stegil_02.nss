// player asks stegil for malar's blessing
// ... make sure that only one blessing is active at a time!

void DoBlessing(object oPC)
{
    float fDur = 360.0;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_STRENGTH, 4), oPC, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHaste(), oPC, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectUltravision(), oPC, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR), oPC, fDur);
    DelayCommand(fDur, DeleteLocalInt(oPC, "nMalarsBlessingActive"));
}

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "nMalarsBlessingActive") == 0)
    {
        SetLocalInt(oPC, "nMalarsBlessingActive", 1);
        FloatingTextStringOnCreature("... Malar's Blessing ...", oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oPC);
        DelayCommand(0.5, DoBlessing(oPC));
    } else {
        FloatingTextStringOnCreature("... You already have Malar's Blessing ...", oPC);
    }
}
