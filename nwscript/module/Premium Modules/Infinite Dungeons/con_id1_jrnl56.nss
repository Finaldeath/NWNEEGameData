#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // encounter frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_FREQUENCY);
    sString += "The chance of an active encounter waypoint is " + IntToString(nTemp) + "%.";
    sString = AddLineBreak(sString);

    // encounter difficulty
    nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);
    sString += "Encounter difficulty is " + IntToString(nTemp) + " levels ";
    if (nTemp < 0)
    {
        sString += " lower than character level.";
    } else
    {
        sString += " higher than character level.";
    }
    sString = AddLineBreak(sString);

    // encounter size
    nTemp = GetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE);
    if (nTemp == ID1_ENCOUNTER_SIZE_SINGLE)
    {
        sString += "Encounter size is single creatures only.";
    } else if (nTemp == ID1_ENCOUNTER_SIZE_LARGE)
    {
        sString += "Encounter size is large (approximately 2-3 times party size).";
    } else if (nTemp == ID1_ENCOUNTER_SIZE_HORDE)
    {
        sString += "Encounter size is very large (approximately 4-6 times party size).";
    } else
    {
        sString += "Encounter size is normal (approximately equal to party size).";
    }
    sString = AddLineBreak(sString);

    // encounter treasure frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);
    sString += "Creature treasure frequency is " + IntToString(nTemp) + "% at ";

    // encounter treasure value
    nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE);
    sString += IntToString(nTemp) + "% of normal treasure value.";
    sString = AddLineBreak(sString);

    // encounter corpses
    nTemp = GetModuleFlag(ID1_FLAG_ENCOUNTER_CORPSE);
    if (nTemp == ID1_ENCOUNTER_CORPSE_FADE)
    {
        sString += "Creature corpses will fade once they have been looted.";
    } else
    {
        sString += "Creature corpses will remain even after they have been looted.";
    }
    sString = AddLineBreak(sString);

    // encounter type
    object oDungeon = GetCurrentDungeon();
    nTemp = GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE);
    if (nTemp == ID1_ENCOUNTER_TYPE_CREATURE)
    {
        sString += "Encounter creatures are always ";

        // get plural creature string
        int nCreature = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
        string sCreature = GetLocalString(GetModule(), "sCreature" + IntToString(nCreature) + "NamePlural");
        sString += sCreature + ".";
    } else if (nTemp == ID1_ENCOUNTER_TYPE_THEME)
    {
        sString += "Encounter creatures are always from ";

        // get theme string
        int nTheme = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
        string sTheme = GetLocalString(GetModule(), "sTheme" + IntToString(nTheme) + "Name");
        sString += sTheme + ".";
    } else if (nTemp == ID1_ENCOUNTER_TYPE_RANDOM)
    {
        sString += "Encounter creatures are entirely random.";
    } else
    {
        sString += "Encounter creatures are based on the dungeon theme.";
    }
    sString = AddLineBreak(sString);

    nTemp = GetModuleFlagValue(ID1_FLAG_COMBAT_ONELINER_FREQUENCY);
    sString += "Creatures have a " + IntToString(nTemp) + "% chance of saying a combat one-liner each round.";

    SetCustomToken(5100, sString);

    return TRUE;
}
