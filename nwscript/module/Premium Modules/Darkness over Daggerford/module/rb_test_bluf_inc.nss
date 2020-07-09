void main()
{
    effect eSkill = EffectSkillIncrease(SKILL_BLUFF, 10);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSkill, GetPCSpeaker(), 600.0f);
}
