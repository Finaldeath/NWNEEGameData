#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if (nListType == 114)
    {
        string sString = "";
        int nTemp;

        // get difficulty selection
        if (GetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_SELECTION) == ID1_LOCK_DIFFICULTY_SELECTION_SET)
        {
            nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_SELECTION);
            sString += "Lock base unlock difficulty is set to " + IntToString(nTemp) + ".";
        } else
        {
            sString += "Lock base unlock difficulty is based on player level.";
        }
        sString = AddLineBreak(sString);

        // get difficulty number
        if (GetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_NUMBER) == ID1_LOCK_DIFFICULTY_NUMBER_RANDOM)
        {
            nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_NUMBER);
            sString += "Lock unlock difficulty varies within +/-" + IntToString(nTemp) + ".";
        } else
        {
            sString += "Lock unlock difficulty is fixed.";
        }

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
