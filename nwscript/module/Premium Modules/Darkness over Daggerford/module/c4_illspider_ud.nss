// small spiders walk towards a destination and vanish

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void heartbeat()
{
    if (!GetIsInCombat())
    {
        object oDest = GetNearestObjectByTag("ks_ar2501d_spiderhole");
        if (GetIsObjectValid(oDest))
        {
            float fDist = GetDistanceToObject(oDest);
            if (fDist > 2.0)
            {
                ClearAllActions();
                ActionMoveToObject(oDest, TRUE, 1.0);
            }
            else
            {
                DestroyObject(OBJECT_SELF);
            }
        }
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
        SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);
    }
    else if (nUser == EVENT_HEARTBEAT)
    {
        if (!GetIsInCombat(OBJECT_SELF) && !IsInConversation(OBJECT_SELF))
        {
            heartbeat();
        }
    }
    else if (nUser == EVENT_ATTACKED)
    {
        object oArea = GetArea(OBJECT_SELF);
        if (GetLocalInt(oArea, "nLittleSpidersAttacked") == 0)
        {
            SetLocalInt(GetArea(OBJECT_SELF), "nLittleSpidersAttacked", 1);
            int i = 1;
            object oWP = GetNearestObjectByTag("WP_AR2501D_SPIDER", OBJECT_SELF, i);
            while (GetIsObjectValid(oWP))
            {
                CreateObject(OBJECT_TYPE_CREATURE, "nw_spidgiant", GetLocation(oWP), TRUE);
                oWP = GetNearestObjectByTag("WP_AR2501D_SPIDER", OBJECT_SELF, ++i);
            }
        }
    }
}

