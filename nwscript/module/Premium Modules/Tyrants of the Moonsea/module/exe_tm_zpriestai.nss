#include "nw_i0_generic"
#include "x2_inc_switches"

void TakeAction(object oIntruder)
{
    int nActionTaken = 0;

    if(d4() == 1)
    {
         nActionTaken = TalentSpellAttack(oIntruder);
    }

    if(!nActionTaken && d4() == 1)
    {
        nActionTaken = TalentEnhanceOthers();
    }

    if(!nActionTaken && d4() == 1)
    {
        nActionTaken = TalentUseProtectionOthers();
    }

    if(!nActionTaken && d4() == 1)
    {
        nActionTaken = TalentAdvancedProtectSelf();
    }

    if(!nActionTaken)
    {
        ActionAttack(oIntruder);
    }
}

int CastHealingSpell()
{
    object oTarget;

    //Heal PC faction member if reputation is not hostile
    if(d2() == 1 && GetReputation(OBJECT_SELF, GetFirstPC()) > 10)
    {
        oTarget = GetFactionMostDamagedMember(GetFirstPC(), TRUE);
        if(GetCurrentHitPoints(oTarget) < GetMaxHitPoints(oTarget))
        {
            if(TalentHeal(FALSE, oTarget))
            {
                return TRUE;
            }
        }
    }

    //Heal own faction member
    oTarget = GetFactionMostDamagedMember(OBJECT_SELF, TRUE);

    if(GetCurrentHitPoints(oTarget) < GetMaxHitPoints(oTarget))
    {
        if(TalentHeal(FALSE, oTarget))
        {
            return TRUE;
        }
    }

    return FALSE;
}

void main()
{
    object oIntruder = GetCreatureOverrideAIScriptTarget();
    ClearCreatureOverrideAIScriptTarget();

    // do we have a valid target?
    SetLocalInt(OBJECT_SELF,"X2_SPECIAL_COMBAT_AI_SCRIPT_OK", 1);;

    // do we have a valid target?
    if (GetIsObjectValid(oIntruder) == FALSE)
        oIntruder = bkAcquireTarget();

    if(GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }

    if(GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetLastAttacker();
    }

    if (GetIsDead(oIntruder) == TRUE)
    {
        return;
    }
    if (!GetIsEnemy(oIntruder))
        return;
    if (__InCombatRound() == TRUE)
    {
        return;
    }
    __TurnCombatRoundOn(TRUE);

    // Chance of casting healing spell on either own or PC faction
    if(d2() == 1)
    {
        if(CastHealingSpell() == TRUE)
        {
            __TurnCombatRoundOn(FALSE);
            return;
        }
        else
        {
            TakeAction(oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
        }
    }
    else
    {
        TakeAction(oIntruder);
        __TurnCombatRoundOn(FALSE);
        return;
    }
}
