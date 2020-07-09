void main()
{
    effect eSkill = EffectSkillIncrease(SKILL_SEARCH, 10);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSkill, GetPCSpeaker(), 600.0f);
}
