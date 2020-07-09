#include "inc_id1_utility"

int GetIsBadEffect(effect eEffect);

void main()
{
    ActionPauseConversation();

    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 2.0);

    // completely rest player
    object oPC = GetPCSpeaker();
    DebugMessage("Clearing actions. Point 1.");
    AssignCommand(oPC, ClearAllActions());
    ForceRest(oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_X), oPC);

    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect) == TRUE)
    {
        if (GetIsBadEffect(eEffect) == TRUE)
        {
            RemoveEffect(oPC, eEffect);

            eEffect = GetFirstEffect(oPC);
        } else
        {
            eEffect = GetNextEffect(oPC);
        }
    }

    int nCount = 1;
    object oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, nCount);
    while (oAssociate != OBJECT_INVALID)
    {
        ForceRest(oAssociate);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_X), oAssociate);

        nCount++;
        oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, nCount);

        eEffect = GetFirstEffect(oAssociate);
        while (GetIsEffectValid(eEffect) == TRUE)
        {
            if (GetIsBadEffect(eEffect) == TRUE)
            {
                RemoveEffect(oAssociate, eEffect);

                eEffect = GetFirstEffect(oAssociate);
            } else
            {
                eEffect = GetNextEffect(oAssociate);
            }
        }
    }

    nCount = 1;
    oAssociate = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC, nCount);
    while (oAssociate != OBJECT_INVALID)
    {
        ForceRest(oAssociate);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_X), oAssociate);

        nCount++;
        oAssociate = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC, nCount);

        eEffect = GetFirstEffect(oAssociate);
        while (GetIsEffectValid(eEffect) == TRUE)
        {
            if (GetIsBadEffect(eEffect) == TRUE)
            {
                RemoveEffect(oAssociate, eEffect);

                eEffect = GetFirstEffect(oAssociate);
            } else
            {
                eEffect = GetNextEffect(oAssociate);
            }
        }
    }

    nCount = 1;
    oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, nCount);
    while (oAssociate != OBJECT_INVALID)
    {
        ForceRest(oAssociate);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_X), oAssociate);

        nCount++;
        oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, nCount);

        eEffect = GetFirstEffect(oAssociate);
        while (GetIsEffectValid(eEffect) == TRUE)
        {
            if (GetIsBadEffect(eEffect) == TRUE)
            {
                RemoveEffect(oAssociate, eEffect);

                eEffect = GetFirstEffect(oAssociate);
            } else
            {
                eEffect = GetNextEffect(oAssociate);
            }
        }
    }

    nCount = 1;
    oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nCount);
    while (oAssociate != OBJECT_INVALID)
    {
        ForceRest(oAssociate);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_X), oAssociate);

        nCount++;
        oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nCount);

        eEffect = GetFirstEffect(oAssociate);
        while (GetIsEffectValid(eEffect) == TRUE)
        {
            if (GetIsBadEffect(eEffect) == TRUE)
            {
                RemoveEffect(oAssociate, eEffect);

                eEffect = GetFirstEffect(oAssociate);
            } else
            {
                eEffect = GetNextEffect(oAssociate);
            }
        }
    }

    nCount = 1;
    oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, nCount);
    while (oAssociate != OBJECT_INVALID)
    {
        ForceRest(oAssociate);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_X), oAssociate);

        nCount++;
        oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, nCount);

        eEffect = GetFirstEffect(oAssociate);
        while (GetIsEffectValid(eEffect) == TRUE)
        {
            if (GetIsBadEffect(eEffect) == TRUE)
            {
                RemoveEffect(oAssociate, eEffect);

                eEffect = GetFirstEffect(oAssociate);
            } else
            {
                eEffect = GetNextEffect(oAssociate);
            }
        }
    }

    DelayCommand(2.0, ActionResumeConversation());
}

int GetIsBadEffect(effect eEffect)
{
    int nEffectType = GetEffectType(eEffect);

    if (nEffectType == EFFECT_TYPE_ABILITY_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_AC_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_ATTACK_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_BLINDNESS)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_CHARMED)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_CONFUSED)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_CURSE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_DAMAGE_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_DARKNESS)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_DAZED)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_DEAF)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_DISEASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_DOMINATED)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_ENEMY_ATTACK_BONUS)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_ENTANGLE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_FRIGHTENED)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_MISS_CHANCE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_NEGATIVELEVEL)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_PARALYZE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_PETRIFY)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_POISON)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_POLYMORPH)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_SAVING_THROW_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_SILENCE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_SKILL_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_SLEEP)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_SLOW)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_STUNNED)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_SWARM)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_TURN_RESISTANCE_DECREASE)
    {
        return TRUE;
    }
    if (nEffectType == EFFECT_TYPE_TURNED)
    {
        return TRUE;
    }

    return FALSE;
}
