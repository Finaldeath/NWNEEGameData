#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 79) || (nListType == 89))
    {
        string sString = "";
        int nTemp;

        // body armor frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_BODY_PERCENTAGE);
        sString += "Body armor has a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // shield frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_SHIELD_PERCENTAGE);
        sString += "Shield have a proportional chance of " + IntToString(nTemp) + ".";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
