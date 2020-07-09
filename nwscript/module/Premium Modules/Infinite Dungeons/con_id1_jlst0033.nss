#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 33) || (nListType == 78) || (nListType == 93) || (nListType == 102) || (nListType == 108))
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

        return TRUE;
    } else
    {
        return FALSE;
    }
}
