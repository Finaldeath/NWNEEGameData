// bard item in the stronghold

void RemoveBlessEffect(object oPC)
{
    SetLocalInt(oPC, "nStrongholdCustomEffect", 0);
}

void ApplyBlessEffect(object oPC)
{
    float fDur = 120.0;
    effect eVfx = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    effect eBoost = EffectSkillIncrease(SKILL_PERFORM, 5);
    if (GetLocalInt(oPC, "nStrongholdCustomEffect") == 0)
    {
        SetLocalInt(oPC, "nStrongholdCustomEffect", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBoost, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVfx, oPC, fDur);
        FloatingTextStringOnCreature("... Perform Skill Increase ...", oPC);
        DelayCommand(fDur, RemoveBlessEffect(oPC));
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, PlaySound("as_cv_lute1"));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), oPC, 4.0);
    DelayCommand(4.5, ApplyBlessEffect(oPC));
}
