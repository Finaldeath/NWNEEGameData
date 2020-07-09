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

    // head back to home
    location lHome = GetLocalLocation(OBJECT_SELF, "lHome");
    location lSelf = GetLocation(OBJECT_SELF);
    if (GetDistanceBetweenLocations(lHome, lSelf) > 4.0)
    {
        int nCount = GetLocalInt(OBJECT_SELF, "nMoveCounter");
        if (nCount >= 3)
        {
            SetLocalInt(OBJECT_SELF, "nMoveCounter", 0);
            ClearAllActions();
            JumpToLocation(lHome);
        }
        ActionMoveToLocation(lHome);
        SetLocalInt(OBJECT_SELF, "nMoveCounter", ++nCount);
    }
    else
    {
        PlayImmobileAmbientAnimations();
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
        SetLocalLocation(OBJECT_SELF, "lHome", GetLocation(OBJECT_SELF));
    }
}
