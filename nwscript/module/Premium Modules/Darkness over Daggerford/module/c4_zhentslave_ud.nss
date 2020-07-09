// zhent slaves are breaking-up rocks in illefarn

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void heartbeat()
{
    // don't work if we're in combat or convo
    if (GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        return;
    }

    // don't work if we're disabled
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") ||
        GetLocalInt(GetArea(OBJECT_SELF), "HF_DISABLE_AM"))
    {
        return;
    }

    // don't work if the master isn't around
    object oMaster = GetNearestObjectByTag("ks_zhentslaver");
    if (!GetIsObjectValid(oMaster) || GetIsDead(oMaster) || GetIsInCombat(oMaster))
    {
        if (d2() == 1)
        {
            PlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 4.0);
        }
        return;
    }

    // find the nearest rocks to bash
    object oRock = GetNearestObjectByTag("NW_PL_RUBBLE001");
    if (GetIsObjectValid(oRock))
    {
        if (GetIsPlaceableObjectActionPossible(oRock, PLACEABLE_ACTION_BASH))
        {
            DoPlaceableObjectAction(oRock, PLACEABLE_ACTION_BASH);
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 2.0);
            DoPlaceableObjectAction(oRock, PLACEABLE_ACTION_BASH);
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 2.0);
        } else {
            ActionAttack(oRock);
            DelayCommand(6.0, ClearAllActions());
            DelayCommand(6.1, SurrenderToEnemies());
        }
    }
}

// HUMAN = 6; GNOME = 2; HALFLING = 3
void RandomizeAppearance(object oSelf)
{
    int nType = GetLocalInt(OBJECT_SELF, "HF_APPEARANCE_TYPE");
    if (nType == 0)
    {
        int n = d3();
        if      (n == 1) nType = APPEARANCE_TYPE_GNOME;
        else if (n == 2) nType = APPEARANCE_TYPE_HUMAN;
        else if (n == 3) nType = APPEARANCE_TYPE_HALFLING;
    }
    SetCreatureAppearanceType(oSelf, nType);
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        RandomizeAppearance(OBJECT_SELF);
    }
    else if (nUser == EVENT_HEARTBEAT)
    {
        if (!GetIsInCombat(OBJECT_SELF) && !IsInConversation(OBJECT_SELF))
        {
            heartbeat();
        }
    }
}

