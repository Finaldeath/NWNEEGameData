#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType >= 75) && (nListType <= 77))
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

        return TRUE;
    } else
    {
        return FALSE;
    }
}
