#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // treasure level
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_LEVEL);
    sString += "Treasure is";
    if (nTemp != 0)
    {
        sString += " " + IntToString(abs(nTemp));
        if ((nTemp == 1) || (nTemp == -1))
        {
            sString += " level";
        } else
        {
            sString += " levels";
        }
        if (nTemp < 0)
        {
            sString += " lower than party level.";
        } else
        {
            sString += " higher than party level.";
        }
    } else
    {
        sString += " equal to party level.";
    }
    sString = AddLineBreak(sString);

    // treasure frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_FREQUENCY);
    sString += "Treasure chests have a " + IntToString(nTemp) + "% chance of being active with ";

    // treasure value
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE);
    sString += IntToString(nTemp) + "% treasure value.";
    sString = AddLineBreak(sString);

    // encounter frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);
    sString += "Creatures have a " + IntToString(nTemp) + "% chance of dropping treasure with ";

    // encounter value
    nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE);
    sString += IntToString(nTemp) + "% treasure value.";
    sString = AddLineBreak(sString);

    // boss frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY);
    sString += "Bosses have a " + IntToString(nTemp) + "% chance of dropping treasure with ";

    // boss value
    nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE);
    sString += IntToString(nTemp) + "% treasure value.";
    sString = AddLineBreak(sString);

    // specific item frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY);
    sString += "A treasure item has a " + IntToString(nTemp) + "% chance of being a specific item.";
    sString = AddLineBreak(sString);

    // gem frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_GEM_FREQUENCY);
    sString += "A treasure item has a " + IntToString(nTemp) + "% chance of being a recipe gem.";
    sString = AddLineBreak(sString);

    // recipe frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_RECIPE_FREQUENCY);
    sString += "A treasure item has a " + IntToString(nTemp) + "% chance of being a gem recipe.";

    SetCustomToken(5100, sString);

    return TRUE;
}
