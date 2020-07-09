#include "inc_id1_flags"
#include "inc_id1_text"
#include "inc_id1_utility"

void main()
{
    string sString = "";
    int nTemp;

    // encounter type
    object oDungeon = GetCurrentDungeon();
    nTemp = GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE);
    if (nTemp == ID1_ENCOUNTER_TYPE_CREATURE)
    {
        sString += "Encounter creatures are always ";

        // get plural creature string
        int nCreature = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
        string sCreature = GetLocalString(oDungeon, "sCreature" + IntToString(nCreature) + "NamePlural");
        sString += sCreature + ".";
    } else if (nTemp == ID1_ENCOUNTER_TYPE_THEME)
    {
        sString += "Encounter creatures are always from ";

        // get theme string
        int nTheme = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
        string sTheme = GetLocalString(oDungeon, "sTheme" + IntToString(nTheme) + "Name");
        sString += sTheme + ".";
    } else if (nTemp == ID1_ENCOUNTER_TYPE_RANDOM)
    {
        sString += "Encounter creatures are entirely random.";
    } else
    {
        sString += "Encounter creatures are based on the dungeon theme.";
    }

    SetCustomToken(5100, sString);
}
