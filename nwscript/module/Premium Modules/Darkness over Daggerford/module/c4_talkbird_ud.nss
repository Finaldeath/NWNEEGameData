// birds ambient actions

#include "nw_i0_generic"
#include "hf_in_plot"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void PlayAmbientSounds()
{
    string sSnd = GetLocalString(OBJECT_SELF, "sSound");
    PlaySound(sSnd);
}

void SpeakAmbientText()
{
    string sText = GetLocalString(OBJECT_SELF, "sText");
    SpeakString(sText);
}

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        int nPlotLevel = PlotLevelGet(GetTag(OBJECT_SELF));

        ClearAllActions();
        int n = d4();
        if (n == 1)
        {
            PlayAmbientSounds();
        }
        else if (n == 2)
        {
            SpeakAmbientText();
        }
        else if (n == 3)
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
