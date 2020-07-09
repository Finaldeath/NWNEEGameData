#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARROW_PERCENTAGE);
    sString += "Arrows have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BOLT_PERCENTAGE);
    sString += "Bolts have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BULLET_PERCENTAGE);
    sString += "Bullets have a proportional chance of " + IntToString(nTemp) + ".";

    SetCustomToken(5100, sString);
}
