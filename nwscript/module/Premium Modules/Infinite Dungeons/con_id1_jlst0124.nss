#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if (nListType == 124)
    {
        string sString = "";
        int nTemp;

        // get difficulty selection
        if (GetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_SELECTION) == ID1_TRAP_DIFFICULTY_SELECTION_SET)
        {
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_SELECTION);
            sString += "Trap base disarm difficulty is set to " + IntToString(nTemp) + ".";
        } else
        {
            sString += "Trap base disarm difficulty is based on player level.";
        }
        sString = AddLineBreak(sString);

        // get difficulty number
        if (GetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_NUMBER) == ID1_TRAP_DIFFICULTY_NUMBER_RANDOM)
        {
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_NUMBER);
            sString += "Trap disarm difficulty varies within +/-" + IntToString(nTemp) + ".";
        } else
        {
            sString += "Trap disarm difficulty is fixed.";
        }

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
