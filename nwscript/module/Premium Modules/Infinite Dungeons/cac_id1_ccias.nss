#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // shield frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SMALLSHIELD_PERCENTAGE);
    sString += "Small shields have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // shield frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LARGESHIELD_PERCENTAGE);
    sString += "Large shields have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // shield frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_TOWERSHIELD_PERCENTAGE);
    sString += "Tower shields have a proportional chance of " + IntToString(nTemp) + ".";

    SetCustomToken(5100, sString);
}
