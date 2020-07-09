// user-defined event for seagulls in AR2100

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// the flock should go hostile if a non-druid player is nearby
int GetIsFishThiefNear()
{
    if (GetLocalInt(OBJECT_SELF, "nHostile") == 0)
    {
        object oPC = GetFirstPC();
        float fDist = GetDistanceToObject(oPC);
        if (fDist <= 10.0)
        {
            if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) <= 0 &&
                GetLevelByClass(CLASS_TYPE_DRUID, oPC)  <=0)
            {
                // flock goes hostile
                int i = 1;
                string sTag = GetTag(OBJECT_SELF);
                object oBird = GetNearestObjectByTag(sTag, oPC, i);
                while (GetIsObjectValid(oBird))
                {
                    ChangeToStandardFaction(oBird, STANDARD_FACTION_HOSTILE);
                    SetLocalInt(oBird, "nHostile", 1);
                    oBird = GetNearestObjectByTag(sTag, oPC, ++i);
                }
                return(TRUE);
            }
        }
    }
    return(FALSE);
}

// make some bird sounds during the day
void PlayAmbientSounds()
{
    if (GetIsDawn() || GetIsDay())
    {
        string sSnd;
        int n = d2();
        if      (n == 1) sSnd = "as_an_gull1";
        else if (n == 2) sSnd = "as_an_gull2";
        PlaySound(sSnd);
    }
}

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        ClearAllActions();

        // we go hostile if a player is trying to steal our fish
        if (GetIsFishThiefNear())
        {
            return;
        }

        // ambient actions
        int n = d4();
        if (n == 1)
        {
            PlayAmbientSounds();
        }
        else if (n == 2)
        {
            ActionRandomWalk();
        }
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

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
