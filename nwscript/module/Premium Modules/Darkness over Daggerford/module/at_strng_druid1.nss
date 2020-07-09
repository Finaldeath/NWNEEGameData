// player prays at the grove in the stronghold
// .. receive a minor blessing for a short duration

void RemoveBlessEffect(object oPC)
{
    SetLocalInt(oPC, "nStrongholdCustomEffect", 0);
}

void ApplyBlessEffect(object oPC)
{
    float fDur = 120.0;
    effect eVfx = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    if (GetLocalInt(oPC, "nStrongholdCustomEffect") == 0)
    {
        SetLocalInt(oPC, "nStrongholdCustomEffect", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVfx, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, 5), oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_HIDE, 5), oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_MOVE_SILENTLY, 5), oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SET_TRAP, 5), oPC, fDur);
        FloatingTextStringOnCreature("... One With The Land ...", oPC);
        DelayCommand(fDur, RemoveBlessEffect(oPC));
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 4.0));
    DelayCommand(4.5, ApplyBlessEffect(oPC));
}
