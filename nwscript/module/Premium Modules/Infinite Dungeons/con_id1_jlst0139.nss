#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 139) || (nListType == 147))
    {
        string sString = "";
        int nTemp;

        // plot frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_FREQUENCY);
        sString += "The chance of aplot waypoint being active is " + IntToString(nTemp) + "%.";
        sString = AddLineBreak(sString);

        // plot reward value
        nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE);
        sString += "Plot rewards are " + IntToString(nTemp) + "% of normal value.";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
