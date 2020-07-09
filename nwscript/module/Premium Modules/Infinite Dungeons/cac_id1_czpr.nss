#include "inc_id1_flags"
#include "inc_id1_text"

void main()
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

    SetCustomToken(5100, sString);
}
