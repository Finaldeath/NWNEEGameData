#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // gold amount
    if (GetModuleFlag(ID1_FLAG_CAMP_NODE_STORE_GOLD) == ID1_CAMP_NODE_STORE_GOLD_LIMITED)
    {
        sString += "Merchants have limited gold, based on character level.";
    } else
    {
        sString += "Merchants have unlimited gold.";
    }

    SetCustomToken(5100, sString);
}
