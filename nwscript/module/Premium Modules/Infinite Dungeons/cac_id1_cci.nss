#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // weapon frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_WEAPON_PERCENTAGE);
    sString += "Weapons have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // armor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_ARMOR_PERCENTAGE);
    sString += "Armor has a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_ACCESSORY_PERCENTAGE);
    sString += "Accessories have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // consumable frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_CONSUMABLE_PERCENTAGE);
    sString += "Consumables have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // miscellaneous frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_MISCELLANEOUS_PERCENTAGE);
    sString += "Miscellaneous items have a proportional chance of " + IntToString(nTemp) + ".";

    SetCustomToken(5100, sString);
}
