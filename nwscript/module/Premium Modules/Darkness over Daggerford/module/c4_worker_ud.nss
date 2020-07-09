#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF) && GetLocalInt(OBJECT_SELF,"UNDEAD") == 0)
    {
        ClearAllActions();
        float fDur = 3.0 + Random(3);
        int nAction = d10();
        if (nAction == 1)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        }
        else if (nAction == 2)
        {
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, fDur);
        }
        else if (nAction == 3)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
        }
        else
        {
            if (GetLocalInt(OBJECT_SELF, "HF_ATTR_LAZY") == 0)
            {
                ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fDur);
            }
            else
            {
                if (GetLocalInt(OBJECT_SELF, "nSit") == 0)
                {
                    SetLocalInt(OBJECT_SELF, "nSit", 1);
                    ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 6.0);
                }
                else
                {
                    SetLocalInt(OBJECT_SELF, "nSit", 0);
                    ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
                }
            }
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
        // need to be raisable for the succubae
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        //SetIsDestroyable(FALSE, TRUE, TRUE);
        SetIsDestroyable(FALSE, TRUE, FALSE);
    }
}
