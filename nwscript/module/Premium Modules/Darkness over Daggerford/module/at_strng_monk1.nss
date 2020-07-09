// monk item in the stronghold

void RemoveBlessEffect(object oPC)
{
    SetLocalInt(oPC, "nStrongholdCustomEffect", 0);
}

void ApplyBlessEffect(object oPC)
{
    float fDur = 120.0;
    effect eVfx = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    effect eBoost = EffectAbilityIncrease(ABILITY_WISDOM, 3);
    if (GetLocalInt(oPC, "nStrongholdCustomEffect") == 0)
    {
        SetLocalInt(oPC, "nStrongholdCustomEffect", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBoost, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVfx, oPC, fDur);
        FloatingTextStringOnCreature("... Wisdom Increase ...", oPC);
        DelayCommand(fDur, RemoveBlessEffect(oPC));
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 4.0));
    DelayCommand(4.5, ApplyBlessEffect(oPC));
}
