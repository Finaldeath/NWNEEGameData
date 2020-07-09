// the slaves in AR1900 do a few ambient animations to look pathetic

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        int nAction = d8();
        if      (nAction == 1)
        {
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 5.0);
        }
        else if (nAction == 2)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
        }
        else if (nAction == 3)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT);
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
        }
        else if (nAction == 4)
        {
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 5.0);
        }
        else if (nAction == 5)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        }
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM")   != 0 ||
        GetLocalInt(OBJECT_SELF, "HF_EXIT_STARTED") != 0)
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
