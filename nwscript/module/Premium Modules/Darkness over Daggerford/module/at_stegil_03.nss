// stegil offers to heal player's party

void RemoveEffects(object oTarget)
{
    effect eBad = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eBad))
    {
        int nEffectType = GetEffectType(eBad);
        if (nEffectType == EFFECT_TYPE_ABILITY_DECREASE ||
            nEffectType == EFFECT_TYPE_AC_DECREASE ||
            nEffectType == EFFECT_TYPE_ARCANE_SPELL_FAILURE ||
            nEffectType == EFFECT_TYPE_ATTACK_DECREASE ||
            nEffectType == EFFECT_TYPE_BLINDNESS ||
            nEffectType == EFFECT_TYPE_CHARMED ||
            nEffectType == EFFECT_TYPE_CONFUSED ||
            nEffectType == EFFECT_TYPE_CURSE ||
            nEffectType == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            nEffectType == EFFECT_TYPE_DAMAGE_DECREASE ||
            nEffectType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            nEffectType == EFFECT_TYPE_DAZED ||
            nEffectType == EFFECT_TYPE_DEAF ||
            nEffectType == EFFECT_TYPE_DISEASE ||
            nEffectType == EFFECT_TYPE_DOMINATED ||
            nEffectType == EFFECT_TYPE_ENTANGLE ||
            nEffectType == EFFECT_TYPE_FRIGHTENED ||
            nEffectType == EFFECT_TYPE_NEGATIVELEVEL ||
            nEffectType == EFFECT_TYPE_PARALYZE ||
            nEffectType == EFFECT_TYPE_PETRIFY ||
            nEffectType == EFFECT_TYPE_POISON ||
            nEffectType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            nEffectType == EFFECT_TYPE_SILENCE ||
            nEffectType == EFFECT_TYPE_SKILL_DECREASE ||
            nEffectType == EFFECT_TYPE_SLEEP ||
            nEffectType == EFFECT_TYPE_SLOW ||
            nEffectType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            nEffectType == EFFECT_TYPE_STUNNED)
        {
            RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
}

void HealObject(object oTarget)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_L), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(d10(10)+10), oTarget);
    RemoveEffects(oTarget);
}

void main()
{
    object oPC = GetPCSpeaker();

    // heal all party members
    object oParty = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        HealObject(oParty);
        oParty = GetNextFactionMember(oPC, TRUE);
    }

    // heal all non-party members such as familiars
    oParty = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        HealObject(oParty);
        oParty = GetNextFactionMember(oPC, FALSE);
    }

    // heal the player
    HealObject(oPC);
}
