//Heartbeat script for Moon Mote
void MoonMoteRestoration(object oTarget)
{
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    effect eBad = GetFirstEffect(oTarget);

    //Search for and remove negative effects
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
            {
                RemoveEffect(oTarget, eBad);
            }
        eBad = GetNextEffect(oTarget);
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

void MoonMoteHeal(object oTarget)
{
    int nDamage;

    effect eHeal;

    if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        nDamage = d8(8) + 15;
        //Set the heal effect
        eHeal = EffectHeal(nDamage);

        //Apply heal effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}

void main()
{
    object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");

    ClearAllActions();
    //Move close to target and then apply restoration and heal
    if(GetIsObjectValid(oTarget) && GetLocalInt(OBJECT_SELF, "nDone") == 0)
    {
        float fDistance = GetDistanceBetween(OBJECT_SELF, oTarget);
        if(fDistance < 3.0)
        {
            ActionDoCommand(MoonMoteRestoration(oTarget));
            ActionDoCommand(MoonMoteHeal(oTarget));
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "nDone", 1));
            ActionDoCommand(DestroyObject(OBJECT_SELF, 2.0));
        }
        else
        {
            ActionForceMoveToObject(oTarget, TRUE, 1.0, 10.0);
        }
    }
    else
    {
        DestroyObject(OBJECT_SELF);
    }
}
