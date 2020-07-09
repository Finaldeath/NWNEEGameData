#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 12) || (nListType == 13) || (nListType == 14))
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
        sString += "The chance of an active encounter waypoint in a secret area is " + IntToString(nTemp) + "%.";
        sString = AddLineBreak(sString);

        // secret treasure
        nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_TREASURE_FREQUENCY);
        sString += "The chance of a treasure chest being active in a secret area is " + IntToString(nTemp) + "%.";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
