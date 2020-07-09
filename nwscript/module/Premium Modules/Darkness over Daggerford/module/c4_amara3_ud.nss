// amara's user-defined handler (this is only used in the 'amara'
// .. blueprint in AR0099). It makes her walk back to the wagons.

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Heartbeat()
{
    // if there are enemies around, keep fighting
    if (GetIsInCombat())
    {
        return;
    }
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    if (GetIsObjectValid(oTarget) && !GetIsDead(oTarget))
    {
        return;
    }

    // make sure I'm not busy talking
    if (IsInConversation(OBJECT_SELF))
    {
        return;
    }

    // has the cutscene ended?
    if (GetLocalInt(GetArea(OBJECT_SELF), "nSceneEnded") == 0)
    {
        return;
    }

    // drink a few potions after combat (assume infinite potions)
    if (GetCurrentHitPoints(OBJECT_SELF) < GetMaxHitPoints(OBJECT_SELF))
    {
        ClearAllActions();
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
        ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(100), OBJECT_SELF));
    }

    // head back to the wagons
    object oWP = GetNearestObjectByTag("WP_AR0600_ASTRIEL_END");
    if (GetDistanceToObject(oWP) > 2.0)
    {
        int nCount = GetLocalInt(OBJECT_SELF, "nMoveCounter");
        if (nCount >= 3)
        {
            SetLocalInt(OBJECT_SELF, "nMoveCounter", 0);
            ClearAllActions();
            JumpToObject(oWP);
        }
        ActionMoveToObject(oWP, TRUE);
        SetLocalInt(OBJECT_SELF, "nMoveCounter", ++nCount);
    }
}

void main()
{
    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
