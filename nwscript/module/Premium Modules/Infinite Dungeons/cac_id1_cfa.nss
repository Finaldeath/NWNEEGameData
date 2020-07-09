#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // get damage difficulty selection
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_SELECTION) == ID1_TRAP_DAMAGE_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_SELECTION);
        sString += "Trap base damage difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap base damage difficulty is based on player level.";
    }
    sString = AddLineBreak(sString);

    // get damage difficulty number
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_NUMBER) == ID1_TRAP_DAMAGE_NUMBER_RANDOM)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_NUMBER);
        sString += "Trap damage difficulty varies within +/-" + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap damage difficulty is fixed.";
    }

    SetCustomToken(5100, sString);
}
