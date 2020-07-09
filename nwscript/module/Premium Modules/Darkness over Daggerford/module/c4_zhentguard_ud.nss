// zhent guards are really bored

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void heartbeat()
{
    if (GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        return;
    }

    if (d4()==1)
    {
        SpeakString("*Yawn*");
    }

    // playing a new animation will halt waypointing, so don't do it too often
    if (d10()==1)
    {
        PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
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
    }
    else if (nUser == EVENT_HEARTBEAT)
    {
        if (!GetIsInCombat(OBJECT_SELF) && !IsInConversation(OBJECT_SELF))
        {
            heartbeat();
        }
    }
}

