#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // get damage difficulty selection
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_SELECTION) == ID1_TRAP_DAMAGE_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_SELECTION);
        sString += "Trap base saving throw difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap base saving throw difficulty is based on player level.";
    }
    sString = AddLineBreak(sString);

    // get damage difficulty number
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_NUMBER) == ID1_TRAP_DAMAGE_NUMBER_RANDOM)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_NUMBER);
        sString += "Trap saving throw difficulty varies within +/-" + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap saving throw difficulty is fixed.";
    }

    SetCustomToken(5100, sString);

    return TRUE;
}
