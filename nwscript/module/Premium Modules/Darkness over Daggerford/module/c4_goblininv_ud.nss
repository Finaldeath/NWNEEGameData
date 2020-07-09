// ambient script for invisible goblin in AR1500
// .. just laughs until the player talks to him
// .. the goblin can't actually laugh because the player can't hear
// .. invisible creatures talking so the goblin creates a voice object
// .. which does the talking.

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        object oVoice = GetLocalObject(OBJECT_SELF, "HF_VOICE");
        AssignCommand(oVoice, SpeakString("Hihihihi!"));
        AssignCommand(oVoice, PlaySound("vs_nx2deekm_haha"));
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0);
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0 ||
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
        object oVoice = CreateObject(OBJECT_TYPE_PLACEABLE, "pm_voice", GetLocation(OBJECT_SELF), FALSE, "_ar1500_voice");
        SetLocalObject(OBJECT_SELF, "HF_VOICE", oVoice);
    }
}
