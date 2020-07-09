#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 34) || (nListType == 65) || (nListType == 74))
    {
        string sString = "";
        int nTemp;

        // melee weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_MELEE_PERCENTAGE);
        sString += "Melee weapons have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // ranged weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_RANGED_PERCENTAGE);
        sString += "Ranged weapons have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // ammunition frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_AMMUNITION_PERCENTAGE);
        sString += "Ammunition has a proportional chance of " + IntToString(nTemp) + ".";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
