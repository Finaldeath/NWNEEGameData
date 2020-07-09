// dla_ai_pfvamps.nss
// May 14 2006
// Robert Faber
// force vamps to either attack nearest intruder, or return to guard door

#include "nw_i0_generic"
#include "x2_inc_switches"
void main()
{
    //return;
    //The following two lines should not be touched
    object oIntruder = GetCreatureOverrideAIScriptTarget();


    ClearCreatureOverrideAIScriptTarget();
    SetCreatureOverrideAIScriptFinished();


    if(GetAssociateState(NW_ASC_IS_BUSY))
    {
        return;
    }

    if(BashDoorCheck(oIntruder)) {return;}

    // * BK: stop fighting if something bizarre that shouldn't happen, happens
    if (bkEvaluationSanityCheck(oIntruder, GetFollowDistance()) == TRUE)
        return;

    if (GetIsObjectValid(oIntruder) == FALSE)
        oIntruder = bkAcquireTarget();

    if (GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }
    if (GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetLastAttacker();
    }
    if (GetIsObjectValid(oIntruder) && GetIsDead(oIntruder) == TRUE)
    {
        return;
    }
    if (__InCombatRound() == TRUE)
    {
        return;
    }
    __TurnCombatRoundOn(TRUE);

    if(TalentMeleeAttack())
    {
        return;
    }
    else
    {
        __TurnCombatRoundOn(FALSE);
        ClearAllActions(TRUE);
        SetLocalObject(OBJECT_SELF, "NW_GENERIC_LAST_ATTACK_TARGET", OBJECT_INVALID);
        ActionMoveToLocation(GetLocation(GetWaypointByTag("WP_vampstation")));
    }
}
