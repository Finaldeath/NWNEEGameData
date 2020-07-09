// user-defined event for skully
// .. basically just a few ambient animations

#include "nw_i0_generic"
#include "hf_in_plot"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// get a random phrase
string GetRandomSaying()
{
    string sQuote = GetLocalString(GetModule(), "QUOTE");
    string s;
    int n = d4();
    if      (n == 1) s = "*cough*";
    else if (n == 2) s = "I'm bored. Do something.";
    else if (n == 3) s = "*sigh*";
    else if (n == 4) s = "Are we having fun yet? No? Just checking.";
    return(sQuote+s+sQuote);
}

// ambient animations for skully in the tower
void Heartbeat()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
        return;

    if (IsInConversation(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF))
        return;

    if (PlotLevelGet("ks_skully") < 1)
        return;

    // first time after spawn, move to home location in the area
    int nHome = GetLocalInt(OBJECT_SELF, "HF_AT_HOME");
    if (nHome == 0)
    {
        object oHome = GetNearestObjectByTag("WP_SKULLY_HOME", OBJECT_SELF);
        if (GetIsObjectValid(oHome))
        {
            ActionMoveToObject(oHome, FALSE, 0.0);
            ActionDoCommand(SetFacing(GetFacing(oHome)));
        }
        SetLocalInt(OBJECT_SELF, "HF_AT_HOME", 1);
        return;
    }

    // choose a random ambient animation
    ClearAllActions();
    int nAction = d6();
    if (nAction == 1)
    {
        // spin around and act like a fool
        float fDir = 0.0 + Random(359);
        ActionDoCommand(SetFacing(fDir));
        ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_DAZED_S), OBJECT_SELF));
        string sQuote = GetLocalString(GetModule(), "QUOTE");
        ActionSpeakString(sQuote+"Woah! Made myself dizzy!"+sQuote);
    }
    else if (nAction == 2)
    {
        // say something dumb
        ActionSpeakString(GetRandomSaying());
    }
}

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    if (nEvent == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nEvent == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
