// user-defined event for the Chest of the Wise
// .. basically just a few ambient animations

#include "nw_i0_generic"
#include "x0_i0_position"
#include "hf_in_plot"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// returns a random location very close to the current location
location GetRandomCloseLocation(object oSource)
{
    location lStart = GetLocation(oSource);
    float fAngle = 30.0 + Random(120);
    float fOrient = GetFacing(oSource);
    float fDist = 0.03 + 0.01 * Random(100);
    return GenerateNewLocationFromLocation(lStart, fDist, fAngle, fOrient);
}

// move in place a little bit and return to our starting location
void Wiggle()
{
    location lLoc;
    int nCount = GetLocalInt(OBJECT_SELF, "HF_WIGGLE_COUNT");
    if (nCount == 0)
    {
        lLoc = GetRandomCloseLocation(OBJECT_SELF);
        ActionMoveToLocation(lLoc);
        ActionDoCommand(SetFacing(DIRECTION_WEST));
        SetLocalInt(OBJECT_SELF, "HF_WIGGLE_COUNT", 1);
    }
    else
    {
        lLoc = GetLocalLocation(OBJECT_SELF, "HF_START_LOCATION");
        ActionMoveToLocation(lLoc);
        ActionDoCommand(SetFacing(DIRECTION_WEST));
        SetLocalInt(OBJECT_SELF, "HF_WIGGLE_COUNT", 0);
    }
}

void Heartbeat()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
        return;

    if (IsInConversation(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF))
        return;

    ClearAllActions();
    if (d4() == 1)
    {
        if (PlotLevelGet(GetTag(OBJECT_SELF)) < 2)
        {
            string sQuote = GetLocalString(GetModule(), "QUOTE");
            PlaySound("vs_nx0xanom_say");
            ActionSpeakString(sQuote+"Ahem!"+sQuote);
        }
        else
        {
            string sQuote = GetLocalString(GetModule(), "QUOTE");
            PlaySound("vs_nx0xanom_slct");
            ActionSpeakString(sQuote+"Mmph!"+sQuote);
        }
    }
    Wiggle();
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
        location lLoc = GetLocation(OBJECT_SELF);
        SetLocalLocation(OBJECT_SELF, "HF_START_LOCATION", lLoc);
    }
}
