// player is about to craft a trap in the stronghold
// .. receive a minor skill boost for a short duration

void RemoveBlessEffect(object oPC)
{
    SetLocalInt(oPC, "nStrongholdCustomEffect", 0);
}

void ApplyBlessEffect(object oPC)
{
    float fDur = 30.0;
    effect eBoost1 = EffectSkillIncrease(SKILL_CRAFT_TRAP, 5);
    if (GetLocalInt(oPC, "nStrongholdCustomEffect") == 0)
    {
        SetLocalInt(oPC, "nStrongholdCustomEffect", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBoost1, oPC, fDur);
        FloatingTextStringOnCreature("... Crafting Skill Increased ...", oPC);
        DelayCommand(fDur, RemoveBlessEffect(oPC));
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 3.0));
    DelayCommand(3.1, ApplyBlessEffect(oPC));
}
