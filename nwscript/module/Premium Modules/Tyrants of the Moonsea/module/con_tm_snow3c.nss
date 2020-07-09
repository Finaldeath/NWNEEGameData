// returns true if player has a healing spell memorized

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS, oPC) > 0) return TRUE;
    if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, oPC) > 0) return TRUE;
    if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS, oPC) > 0) return TRUE;
    if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS, oPC) > 0) return TRUE;
    if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS, oPC) > 0) return TRUE;
    if (GetHasSpell(SPELL_HEAL, oPC) > 0) return TRUE;
    return FALSE;
}
