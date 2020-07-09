// player studies at the mage's workbench in the stronghold
// .. receive a skill boost for a short duration

void RemoveBlessEffect(object oPC)
{
    SetLocalInt(oPC, "nStrongholdCustomEffect", 0);
}

void ApplyBlessEffect(object oPC)
{
    float fDur = 120.0;
    effect eVfx = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    effect eBoost = EffectSkillIncrease(SKILL_SPELLCRAFT, 10);
    if (GetLocalInt(oPC, "nStrongholdCustomEffect") == 0)
    {
        SetLocalInt(oPC, "nStrongholdCustomEffect", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBoost, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVfx, oPC, fDur);
        FloatingTextStringOnCreature("... Spellcraft Increased ...", oPC);
        DelayCommand(fDur, RemoveBlessEffect(oPC));
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
    DelayCommand(3.1, ApplyBlessEffect(oPC));
}
