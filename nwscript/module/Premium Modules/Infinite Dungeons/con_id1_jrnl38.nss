#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DART_PERCENTAGE);
    sString += "Darts have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HEAVYCROSSBOW_PERCENTAGE);
    sString += "Heavy crossbows have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTCROSSBOW_PERCENTAGE);
    sString += "Light crossbows have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LONGBOW_PERCENTAGE);
    sString += "Longbows have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHORTBOW_PERCENTAGE);
    sString += "Shortbows have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHURIKEN_PERCENTAGE);
    sString += "Shuriken have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SLING_PERCENTAGE);
    sString += "Slings have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_THROWINGAXE_PERCENTAGE);
    sString += "Throwing axes have a proportional chance of " + IntToString(nTemp) + ".";

    SetCustomToken(5100, sString);

    return TRUE;
}
