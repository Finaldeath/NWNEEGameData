#include "inc_id1_flags"
#include "inc_id1_text"
#include "inc_id1_utility"

void main()
{
    string sString = "";
    int nTemp;

    // counter display
    nTemp = GetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_COUNTER);
    if (nTemp == ID1_ACTIVE)
    {
        sString += "Display of the number of a given feat you have accomplished is Active.";
    } else
    {
        sString += "Display of the number of a given feat you have accomplished is Inactive.";
    }
    sString = AddLineBreak(sString);

    // award display
    nTemp = GetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_AWARD);
    if (nTemp == ID1_ACTIVE)
    {
        sString += "Display of the number of points you have been awarded is Active.";
    } else
    {
        sString += "Display of the number of points you have been awarded is Inactive.";
    }
    sString = AddLineBreak(sString);

    // total display
    nTemp = GetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_TOTAL);
    if (nTemp == ID1_ACTIVE)
    {
        sString += "Display of the number of your point total is Active.";
    } else
    {
        sString += "Display of the number of your point total is Inactive.";
    }

    SetCustomToken(5100, sString);
}
