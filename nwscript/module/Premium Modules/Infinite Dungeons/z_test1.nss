#include "inc_id1_debug"

void main()
{
    DebugMessage("");
    DebugMessage("Testing journal list function.");

    // the variable being set
    int nListType = -1;
    SetLocalInt(OBJECT_SELF, "nListType", nListType);
    DebugMessage("  nListType is " + IntToString(nListType));

    // the minimum value of the list
    int nMin = 0;
    SetLocalInt(OBJECT_SELF, "nMin", nMin);
    DebugMessage("  nMin is " + IntToString(nMin));

    // the maximum value of the list
    int nMax = 41;
    SetLocalInt(OBJECT_SELF, "nMax", nMax);
    DebugMessage("  nMax is " + IntToString(nMax));

    // the current value in the list
    int nCurrentValue = 23;
    if (nCurrentValue < nMin)
    {
        nCurrentValue = nMin;
    }
    if (nCurrentValue > nMax)
    {
        nCurrentValue = nMax;
    }
    SetLocalInt(OBJECT_SELF, "nCurrentValue", nCurrentValue);
    DebugMessage("  nCurrentValue is " + IntToString(nCurrentValue));

    // the current page in the list
    int nCurrentPage = 1;
    while (nCurrentValue >= nCurrentPage * 10)
    {
        DebugMessage("  Value of " + IntToString(nCurrentValue) + " is greater than " + IntToString(nCurrentPage * 10));
        nCurrentPage++;
    }
    SetLocalInt(OBJECT_SELF, "nCurrentPage", nCurrentPage);
    DebugMessage("  nCurrentPage is " + IntToString(nCurrentPage));
}
