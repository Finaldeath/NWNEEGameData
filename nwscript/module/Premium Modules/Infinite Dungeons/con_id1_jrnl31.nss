#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // store frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_FREQUENCY);
    sString += "A Merchant will appear in camp " + IntToString(nTemp) + "% of the time.";
    sString = AddLineBreak(sString);

    // gold amount
    if (GetModuleFlag(ID1_FLAG_CAMP_NODE_STORE_GOLD) == ID1_CAMP_NODE_STORE_GOLD_LIMITED)
    {
        sString += "Merchants have limited gold, based on character level.";
    } else
    {
        sString += "Merchants have unlimited gold.";
    }
    sString = AddLineBreak(sString);

    // markup
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKUP);
    sString += "Merchants will sell items at " + IntToString(nTemp) + "% of their value.";
    sString = AddLineBreak(sString);

    // markdown
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKDOWN);
    sString += "Merchants will buy items at " + IntToString(nTemp) + "% of their value.";

    SetCustomToken(5100, sString);

    return TRUE;
}
