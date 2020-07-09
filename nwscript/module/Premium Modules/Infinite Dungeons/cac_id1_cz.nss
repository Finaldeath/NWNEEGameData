#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // safe zone frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_FREQUENCY);
    sString += "Safe Zones have a " + IntToString(nTemp) + "% chance of being active.";
    sString = AddLineBreak(sString);

    // puzzle frequency
    nTemp = 100 - GetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY);
    sString += "An active Safe Zone has a " + IntToString(nTemp) + "% chance of being a puzzle.";
    sString = AddLineBreak(sString);

    // camp frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY);
    sString += "An active Safe Zone has a " + IntToString(nTemp) + "% chance of being an encampment.";

    SetCustomToken(5100, sString);
}
