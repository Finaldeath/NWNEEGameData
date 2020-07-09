#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    int nHolder = GetLocalInt(OBJECT_SELF, "nHolder");

    // EDIT: add fixed checks

    int nValue;
    int bFixed;
    string sToken;
    if (nHolder == 1)
    {
        nValue = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X);
        sToken = "Dungeon width is FIXED at " + IntToString(nValue) + ".";
    } else if (nHolder == 2)
    {
        nValue = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y);
        sToken = "Dungeon height is FIXED at " + IntToString(nValue) + ".";
    } else
    {
        nValue = GetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH);
        sToken = "Dungeon depth is FIXED at " + IntToString(nValue) + ".";
    }

    sToken = AddLineBreak(sToken);
    sToken += "What would you like to change it to?";

    SetCustomToken(5100, sToken);

    // EDIT: change to dynamic tokens
    int nTemp = 1;
    while (nTemp <= 10)
    {
        sToken = IntToString(nTemp);

        if (nValue == nTemp)
        {
            sToken += MakeTextGreen(" [Current]");
        }

        SetCustomToken(5100 + nTemp, sToken);

        nTemp++;
    }
}
