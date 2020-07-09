// heartbeat script for oubliette in AR0901
// ... feynemonee is trapped inside and calls for help

#include "hf_in_plot"

void CallForHelp(object oPC)
{
    string s;
    int n = d6();
    if      (n == 1) s = "Help! Help! Help!";
    else if (n == 2) s = "Someone! Please help me!";
    else if (n == 3) s = "Is anyone up there?";
    else if (n == 4) s = "Please! Help me!";
    else if (n == 5) s = "Help! I'm down here!";
    else if (n == 6) s = "Mercy! Save me!";
    ActionSpeakString(s);
}

void main()
{
    // do nothing if no PC in area
    object oPC = GetFirstPC();
    if (GetArea(oPC) != GetArea(OBJECT_SELF))
    {
        return;
    }

    // do nothing if PC is talking to us already
    if (IsInConversation(OBJECT_SELF))
    {
        return;
    }

    // do nothing if player hasn't found all the fowls yet
    if (PlotLevelGet("ks_druid_gull") < 7)
    {
        return;
    }

    // do nothing if stegil is still alive
    object oStegil = GetNearestObjectByTag("ks_stegil", oPC);
    if (GetIsObjectValid(oStegil))
    {
        if (!GetIsDead(oStegil))
        {
            return;
        }
    }

    // do nothing if we have been helped already
    if (PlotLevelGet("ks_oubliette_pl") >= 3)
    {
        return;
    }

    // call for help!
    CallForHelp(oPC);
}
