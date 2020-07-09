#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CLOTH_PERCENTAGE);
    sString += "Cloth armor has a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_PADDED_PERCENTAGE);
    sString += "Padded armor has a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_LEATHER_PERCENTAGE);
    sString += "Leather armor has a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HIDE_PERCENTAGE);
    sString += "Studded leather and hide armor have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_SCALE_PERCENTAGE);
    sString += "Chain shirts and scale mail have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CHAINMAIL_PERCENTAGE);
    sString += "Breastplates and chainmail have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_BANDED_PERCENTAGE);
    sString += "Splint mail and banded armor have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HALFPLATE_PERCENTAGE);
    sString += "Half-plate armor has a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // body armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_FULLPLATE_PERCENTAGE);
    sString += "Full-plate armor has a proportional chance of " + IntToString(nTemp) + ".";

    SetCustomToken(5100, sString);

    return TRUE;
}
