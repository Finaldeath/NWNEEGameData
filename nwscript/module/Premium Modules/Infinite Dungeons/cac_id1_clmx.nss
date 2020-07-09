#include "inc_id1_debug"
#include "inc_id1_flags"

void main()
{
    SetLocalInt(OBJECT_SELF, "nListType", 5);

    // the minimum value of the list
    int nY = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y);
    int nMin;
    if (nY >= 2)
    {
        nMin = 1;
    } else
    {
        nMin = 2;
    }
    SetLocalInt(OBJECT_SELF, "nMin", nMin);

    // the maximum value of the list
    int nMax = 20;
    SetLocalInt(OBJECT_SELF, "nMax", nMax);

    // the current value in the list
    int nCurrentValue = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X);
    if (nCurrentValue < nMin)
    {
        nCurrentValue = nMin;
    }
    if (nCurrentValue > nMax)
    {
        nCurrentValue = nMax;
    }
    SetLocalInt(OBJECT_SELF, "nCurrentValue", nCurrentValue);

    // the current page in the list
    int nCurrentPage = 1;
    while (nCurrentValue >= nCurrentPage * 10)
    {
        nCurrentPage++;
    }
    SetLocalInt(OBJECT_SELF, "nCurrentPage", nCurrentPage);
}
