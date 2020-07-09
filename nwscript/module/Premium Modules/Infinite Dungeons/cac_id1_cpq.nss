#include "inc_id1_flags"
#include "inc_id1_text"
#include "inc_id1_utility"

void main()
{
    string sString = "";
    int nTemp;

    // type 1 quest frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE1_FREQUENCY);
    sString += "The proportional chance of a quest to kill creatures is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // type 2 quest frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE2_FREQUENCY);
    sString += "The proportional chance of a quest to clear areas of enemies is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // type 3 quest frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE3_FREQUENCY);
    sString += "The proportional chance of a quest to find items on creatures is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // type 4 quest frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE4_FREQUENCY);
    sString += "The proportional chance of a quest to find items in chests is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // type 5 quest frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE5_FREQUENCY);
    sString += "The proportional chance of a quest to explore areas is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // type 6 quest frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE6_FREQUENCY);
    sString += "The proportional chance of a quest to find a specific creature is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // type 7 quest frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE7_FREQUENCY);
    sString += "The proportional chance of a quest to find a specific object is " + IntToString(nTemp) + ".";

    SetCustomToken(5100, sString);
}
