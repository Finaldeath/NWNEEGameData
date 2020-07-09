// secret: buried zhent: player casts cure spell

int GetCureSpell(object oPC)
{
    object oPC = GetPCSpeaker();
    if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS, oPC)) return SPELL_CURE_MINOR_WOUNDS;
    if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, oPC)) return SPELL_CURE_LIGHT_WOUNDS;
    if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS, oPC)) return SPELL_CURE_MODERATE_WOUNDS;
    if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS, oPC)) return SPELL_CURE_SERIOUS_WOUNDS;
    if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS, oPC)) return SPELL_CURE_CRITICAL_WOUNDS;
    if (GetHasSpell(SPELL_HEAL, oPC)) return SPELL_HEAL;
    return -1;
}

void main()
{
    object oPC = GetPCSpeaker();
    object oZhent = OBJECT_SELF;
    int nSpell = GetCureSpell(oPC);
    if (nSpell > 0)
    {
        effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oZhent);
    }
}
