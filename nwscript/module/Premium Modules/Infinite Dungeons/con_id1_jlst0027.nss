#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 27) || (nListType == 28))
    {
        string sString = "";
        int nTemp;

        // markup
        nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKUP);
        sString += "Merchants will sell items at " + IntToString(nTemp) + "% of their value.";
        sString = AddLineBreak(sString);

        // markdown
        nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKDOWN);
        sString += "Merchants will buy items at " + IntToString(nTemp) + "% of their value.";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
