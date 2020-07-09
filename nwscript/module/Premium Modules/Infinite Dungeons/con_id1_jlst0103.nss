#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType >= 103) && (nListType <= 107))
    {
        string sString = "";
        int nTemp;

        // consumable frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_GRENADE_PERCENTAGE);
        sString += "Grenades have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // consumable frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_WAND_PERCENTAGE);
        sString += "Wands have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // consumable frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_POTION_PERCENTAGE);
        sString += "Potions have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // consumable frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_SCROLL_PERCENTAGE);
        sString += "Scrolls have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // consumable frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_ROD_PERCENTAGE);
        sString += "Rods have a proportional chance of " + IntToString(nTemp) + ".";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
