// temp increase player's social skills

void buff(object oPC, int nSkill)
{
    effect e = EffectSkillIncrease(nSkill, 10);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oPC, 300.0f);
}

void main()
{
    object oPC = GetPCSpeaker();
    buff(oPC, SKILL_PERSUADE);
    buff(oPC, SKILL_INTIMIDATE);
    buff(oPC, SKILL_LISTEN);
    buff(oPC, SKILL_LORE);
    buff(oPC, SKILL_SEARCH);
}
