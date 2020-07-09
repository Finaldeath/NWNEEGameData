#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // secret door frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_FREQUENCY);
    sString += "Each secret area door has a " + IntToString(nTemp) + "% chance of being active.";
    sString = AddLineBreak(sString);

    // get difficulty selection
    if (GetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION) == ID1_SECRET_DOOR_DIFFICULTY_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION);
        sString += "Secret door base detection difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Secret door base detection difficulty is based on player level.";
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
    sString = AddLineBreak(sString);

    // secret encounter
    nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_ENCOUNTER_FREQUENCY);
    sString += "The chance of an active encounter in a secret area is " + IntToString(nTemp) + "%.";
    sString = AddLineBreak(sString);

    // secret treasure
    nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_TREASURE_FREQUENCY);
    sString += "The chance of a treasure chest being active in a secret area is " + IntToString(nTemp) + "%.";

    SetCustomToken(5100, sString);
}
