#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";

    int nValue = GetModuleFlagValue(ID1_FLAG_DECOR_FREQUENCY);
    sString += "Each decor waypoint in an area has a " + IntToString(nValue) + "% chance of being active.";

    SetCustomToken(5100, sString);
}
