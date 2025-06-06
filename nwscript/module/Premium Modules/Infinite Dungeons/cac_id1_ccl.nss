#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // treasure level
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_LEVEL);
    sString += "Treasure is";
    if (nTemp != 0)
    {
        sString += " " + IntToString(nTemp);
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

    // treasure value
    nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE);
    sString += "Treasure chests will drop treasure with " + IntToString(nTemp) + "% treasure value.";
    sString = AddLineBreak(sString);

    // encounter value
    nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE);
    sString += "Creatures will drop treasure with " + IntToString(nTemp) + "% treasure value.";
    sString = AddLineBreak(sString);

    // boss value
    nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE);
    sString += "Bosses will drop treasure with " + IntToString(nTemp) + "% treasure value.";

    SetCustomToken(5100, sString);
}
