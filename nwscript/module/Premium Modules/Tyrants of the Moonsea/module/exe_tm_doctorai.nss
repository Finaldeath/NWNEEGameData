//AI script for goblin 'doctor' in Kur-Tharsu

#include "nw_i0_generic"
#include "nw_i0_spells"
#include "x2_inc_switches"

void TakeAction(object oIntruder)
{
    int nActionTaken = 0;

    //Heal the wounded gnoll as a priority
    if(GetLocalInt(OBJECT_SELF, "nHealedPatient") == 0)
    {
        object oPatient = GetNearestObjectByTag("KTPatient");

        SetLocalInt(OBJECT_SELF, "nHealedPatient", 1);

        if(GetIsObjectValid(oPatient) &&!GetIsDead(oPatient))
        {
            nActionTaken = 1;
            SetFacingPoint(GetPosition(oPatient));
            SpeakString("You needz get better right now!");
            ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, oPatient, METAMAGIC_ANY, TRUE);
            ActionWait(1.5);
            ActionDoCommand(RemoveSpecificEffect(EFFECT_TYPE_SLEEP, oPatient));
        }
    }

    if(!nActionTaken && d2() == 1)
    {
         nActionTaken = TalentSpellAttack(oIntruder);
    }

    if(!nActionTaken && d2() == 1)
    {
        nActionTaken = TalentEnhanceOthers();
    }

    if(!nActionTaken && d2() == 1)
    {
        nActionTaken = TalentUseProtectionOthers();
    }

    if(!nActionTaken && d2() == 1)
    {
        nActionTaken = TalentHealingSelf();
    }

    if(!nActionTaken)
    {
        ActionAttack(oIntruder);
    }
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

    TakeAction(oIntruder);

    __TurnCombatRoundOn(FALSE);
    return;
}
