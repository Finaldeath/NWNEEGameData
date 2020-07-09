//AI script for sentry in Kur-Tharsu

#include "nw_i0_generic"
#include "nw_i0_spells"
#include "x2_inc_switches"

void TakeAction(object oIntruder)
{
    int nActionTaken = 0;

    //Strike the gong to sound the alert
    if(GetLocalInt(OBJECT_SELF, "nGong") == 0)
    {
        object oGong = GetNearestObjectByTag("KTGong");

        SetFacingPoint(GetPosition(oGong));
        ActionAttack(oGong);
        SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
        SpeakString("Intruderz!");
        SetLocalInt(OBJECT_SELF, "nGong", 1);
        DelayCommand(RoundsToSeconds(2), ClearAllActions(TRUE));
    }
    else
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
