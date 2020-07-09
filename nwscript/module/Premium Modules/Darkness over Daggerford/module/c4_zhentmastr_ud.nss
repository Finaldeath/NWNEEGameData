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

    // say something funny
    string q = GetLocalString(GetModule(), "QUOTE");
    string s;
    int n = d4();
    if      (n == 1) s = q+"Work faster, you filthy dogs!"+q;
    else if (n == 2) s = q+"Captain Dratharion wants this passage cleared now!"+q;
    else if (n == 3) s = q+"Come on! Dig! Faster!"+q;
    else if (n == 4) s = q+"Ha! Work faster, fools!"+q;

    SpeakString(s);
    PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0);
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

