// player prays at the altar in the stronghold
// .. receive a minor blessing for a short duration

void RemoveBlessEffect(object oPC)
{
    SetLocalInt(oPC, "nStrongholdCustomEffect", 0);
}

void ApplyBlessEffect(object oPC)
{
    float fDur = 120.0;
    effect eVfx = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    effect eBoost = EffectSavingThrowIncrease(SAVING_THROW_ALL, 5);
    if (GetLocalInt(oPC, "nStrongholdCustomEffect") == 0)
    {
        SetLocalInt(oPC, "nStrongholdCustomEffect", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBoost, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVfx, oPC, fDur);
        FloatingTextStringOnCreature("... Saving Throw Bonus ...", oPC);
        DelayCommand(fDur, RemoveBlessEffect(oPC));
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 4.0));
    DelayCommand(4.5, ApplyBlessEffect(oPC));
}
