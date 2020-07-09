#include "inc_id1_flags"
#include "inc_id1_text"

void main()
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
    sString = AddLineBreak(sString);

    // secret encounter
    nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_DOOR_FREQUENCY);
    sString += "The chance of a door being locked is " + IntToString(nTemp) + "%.";
    sString = AddLineBreak(sString);

    // secret treasure
    nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_CHEST_FREQUENCY);
    sString += "The chance of a treasure chest being locked is " + IntToString(nTemp) + "%.";

    SetCustomToken(5100, sString);
}
