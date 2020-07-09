#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // get detect difficulty selection
    if (GetModuleFlag(ID1_FLAG_TRAP_DETECT_SELECTION) == ID1_TRAP_DETECT_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_SELECTION);
        sString += "Trap base detect difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap base detect difficulty is based on player level.";
    }
    sString = AddLineBreak(sString);

    // get detect difficulty number
    if (GetModuleFlag(ID1_FLAG_TRAP_DETECT_NUMBER) == ID1_TRAP_DETECT_NUMBER_RANDOM)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_NUMBER);
        sString += "Trap detect difficulty varies within +/-" + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap detect difficulty is fixed.";
    }

    SetCustomToken(5100, sString);

    return TRUE;
}
