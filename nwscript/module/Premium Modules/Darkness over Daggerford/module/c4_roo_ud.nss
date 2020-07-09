// user-defined event for roo the rat
// .. he squeeks a lot to make sure the player sees him

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// make some annoying rat sounds
void PlayAmbientSounds()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        string sSnd;
        int n = d3();
        sSnd = "as_an_ratsqueak" + IntToString(n);
        PlaySound(sSnd);
        SpeakString("*squeak*");
    }
}

void Heartbeat()
{
    ClearAllActions();
    PlayAmbientSounds();
    DelayCommand(3.0, PlayAmbientSounds());
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
