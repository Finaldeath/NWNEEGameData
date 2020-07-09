#include "inc_id1_debug"
#include "inc_id1_flags"

void main()
{
    SetLocalInt(OBJECT_SELF, "nListType", 3);

    // the minimum value of the list
    int nMin = 1;
    SetLocalInt(OBJECT_SELF, "nMin", nMin);

    // the maximum value of the list
    int nMax = 5;
    SetLocalInt(OBJECT_SELF, "nMax", nMax);

    // the current value in the list
    int nCurrentValue = GetModuleFlagValue(ID1_FLAG_STAIRS_NUMBER);
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
