#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 116) || (nListType == 117))
    {
        string sString = "";
        int nTemp;

        // secret encounter
        nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_DOOR_FREQUENCY);
        sString += "The chance of a door being locked is " + IntToString(nTemp) + "%.";
        sString = AddLineBreak(sString);

        // secret treasure
        nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_CHEST_FREQUENCY);
        sString += "The chance of a treasure chest being locked is " + IntToString(nTemp) + "%.";
        sString = AddLineBreak(sString);

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
