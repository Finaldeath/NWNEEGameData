// temp buff all player's abilities by 10

void buff(object oPC, int nAbility)
{
    effect e = EffectAbilityIncrease(nAbility, 10);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oPC, 300.0f);
}

void main()
{
    object oPC = GetPCSpeaker();
    buff(oPC, ABILITY_INTELLIGENCE);
    buff(oPC, ABILITY_WISDOM);
    buff(oPC, ABILITY_CHARISMA);
    buff(oPC, ABILITY_DEXTERITY);
    buff(oPC, ABILITY_STRENGTH);
    buff(oPC, ABILITY_CONSTITUTION);
}
