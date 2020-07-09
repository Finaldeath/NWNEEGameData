#include "inc_id1_debug"
#include "inc_id1_flags"

void main()
{
    int bThemeSet;
    if (GetModuleFlag(ID1_FLAG_THEME_TYPE) == ID1_THEME_TYPE_THEMESET)
    {
        bThemeSet = TRUE;
    }

    int nListType;
    if (bThemeSet == TRUE)
    {
        nListType = 2;
    } else
    {
        nListType = 1;
    }
    SetLocalInt(OBJECT_SELF, "nListType", nListType);

    // the minimum value of the list
    int nMin = 1;
    SetLocalInt(OBJECT_SELF, "nMin", nMin);

    // the maximum value of the list
    int nMax;
    if (bThemeSet == TRUE)
    {
        nMax = GetLocalInt(GetModule(), "nThemeSet");
    } else
    {
        nMax = GetLocalInt(GetModule(), "nTheme");
    }
    SetLocalInt(OBJECT_SELF, "nMax", nMax);

    // the current value in the list
    int nCurrentValue = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);
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
