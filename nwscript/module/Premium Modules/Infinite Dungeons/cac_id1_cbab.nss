#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

void main()
{
    int nListType = 133;
    SetLocalInt(OBJECT_SELF, "nListType", nListType);

    // the minimum value of the list
    int nMin = 1;
    SetLocalInt(OBJECT_SELF, "nMin", nMin);

    // the maximum value of the list
    object oDungeon = GetCurrentDungeon();
    int nMax = GetLocalInt(GetModule(), "nBossAreas");
    SetLocalInt(OBJECT_SELF, "nMax", nMax);

    // the current value in the list
    int nCurrentValue = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
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
