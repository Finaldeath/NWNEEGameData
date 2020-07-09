// mine slaves are breaking-up rocks in illefarn

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

    // don't work if we're disabled or free
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") ||
        GetLocalInt(GetArea(OBJECT_SELF), "HF_DISABLE_AM") ||
        GetLocalInt(GetModule(), "nIH_PrisonersFreed") == 1)
    {
        int nAnim = d3();
        if (nAnim == 1)
        {
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 6.0);
        }
        else if (nAnim == 2)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
        }
        return;
    }

    // find the nearest rocks to bash
    object oRock = GetNearestObjectByTag("ar2504_rocks");
    if (GetIsObjectValid(oRock))
    {
        if (d2() == 1)
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
        else
        {
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 6.0);
        }
    }
}

// randomize our appearance for some variety
void RandomizeAppearance(object oSelf)
{
    if (GetLocalInt(OBJECT_SELF, "HF_APPEARANCE_STATIC") == 0)
    {
        int nType = 0;
        int n = d3();
        if      (n == 1) nType = APPEARANCE_TYPE_GNOME;
        else if (n == 2) nType = APPEARANCE_TYPE_HUMAN;
        else if (n == 3) nType = APPEARANCE_TYPE_HALFLING;
        if (GetGender(OBJECT_SELF) == GENDER_MALE)
        {
            int n = d3();
            if      (n == 1) nType = APPEARANCE_TYPE_BEGGER;
            else if (n == 2) nType = APPEARANCE_TYPE_CONVICT;
        }
        SetCreatureAppearanceType(oSelf, nType);
    }
}

// if we aren't near any rocks, put away our tools and don't try to work
void LookForWork()
{
    object oRock = GetNearestObjectByTag("ar2504_rocks");
    float fDist = GetDistanceToObject(oRock);
    if (fDist < 0.0 || fDist > 10.0)
    {
        object oAxe = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
        if (GetIsObjectValid(oAxe))
        {
            ActionUnequipItem(oAxe);
        }
        SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 1);
    }
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
        LookForWork();
    }
    else if (nUser == EVENT_HEARTBEAT)
    {
        if (!GetIsInCombat(OBJECT_SELF) && !IsInConversation(OBJECT_SELF))
        {
            heartbeat();
        }
    }
}

