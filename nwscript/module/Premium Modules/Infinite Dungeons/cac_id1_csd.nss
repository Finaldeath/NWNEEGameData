#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // get difficulty selection
    if (GetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION) == ID1_SECRET_DOOR_DIFFICULTY_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION);
        sString += "Secret door detection difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Secret door detection difficulty is based on player level.";
    }
    sString = AddLineBreak(sString);

    // get difficulty number
    if (GetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER) == ID1_SECRET_DOOR_DIFFICULTY_NUMBER_RANDOM)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER);
        sString += "Secret door detection difficulty varies within +/-" + IntToString(nTemp) + ".";
    } else
    {
        sString += "Secret door detection difficulty is fixed.";
    }

    SetCustomToken(5100, sString);
}
