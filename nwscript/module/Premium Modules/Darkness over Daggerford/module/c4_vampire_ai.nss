/*
Vampires can Summon Undead friends once during combat
*/

#include "nw_i0_generic"
#include "x0_i0_spells"
#include "x2_inc_switches"
#include "hf_in_graphics"

// buff myself at the start of combat
void BuffSelf(object oSelf)
{
    float fDur = 120.0;
    DrawLineVert(GetLocation(oSelf), VFX_IMP_HEAD_ODD);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageShield(4, DAMAGE_BONUS_1d4, DAMAGE_TYPE_NEGATIVE), oSelf, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_DEATH_ARMOR), oSelf, fDur);
}

void main()
{
    object oIntruder = GetCreatureOverrideAIScriptTarget();

    ClearCreatureOverrideAIScriptTarget();
    SetCreatureOverrideAIScriptFinished();

    if (GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }

    if (GetIsObjectValid(oIntruder) && GetIsDead(oIntruder) == TRUE)
    {
        return;
    }

    if (!GetIsEnemy(oIntruder))
    {
        return;
    }

    if (__InCombatRound() == TRUE)
    {
        return;
    }

    __TurnCombatRoundOn(TRUE);

    if(GetIsObjectValid(oIntruder))
    {
        // buff self at start of combat
        if(GetLocalInt(OBJECT_SELF, "nBuffed") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nBuffed", 1);
            ActionCastSpellAtObject(SPELL_GREASE, oIntruder, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
            BuffSelf(OBJECT_SELF);
            __TurnCombatRoundOn(FALSE);
            return;
        }

        // 25% chance of casting a spell
        if (d4() == 1)
        {
            int nSpell = 0;
            if      (GetHasSpell(SPELL_BLADE_BARRIER)) nSpell = SPELL_BLADE_BARRIER;
            else if (GetHasSpell(SPELL_DARKNESS))      nSpell = SPELL_DARKNESS;
            else if (GetHasSpell(SPELL_BESTOW_CURSE))  nSpell = SPELL_BESTOW_CURSE;
            else if (GetHasSpell(SPELL_SILENCE))       nSpell = SPELL_SILENCE;
            else if (GetHasSpell(SPELL_HARM))          nSpell = SPELL_HARM;

            if (nSpell != 0)
            {
                ActionCastSpellAtObject(nSpell, oIntruder);
                __TurnCombatRoundOn(FALSE);
                return;
            }
        }

        // just attack the enemy
        ActionAttack(oIntruder);
    }
     __TurnCombatRoundOn(FALSE);
}
