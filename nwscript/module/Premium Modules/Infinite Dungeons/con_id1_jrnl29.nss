#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // secret area reward chance
    nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_AREA_PERCENTAGE);
    sString += "Proportional chance of a puzzle opening a secret area is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // treasure reward chance
    nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_PERCENTAGE);
    sString += "Proportional chance of a puzzle giving a treasure reward is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // experience reward chance
    nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_EXPERIENCE_PERCENTAGE);
    sString += "Proportional chance of a puzzle giving an experience reward is " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_VALUE);
    sString += "The value of a puzzle treasure reward is " + IntToString(nTemp) + "% of normal.";

    SetCustomToken(5100, sString);

    return TRUE;
}
