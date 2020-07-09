#include "inc_id1_utility"

int StartingConditional()
{
    // get monster cost
    string sVariable = GetLocalString(OBJECT_SELF, "sNode");
    object oDungeon = GetCurrentDungeon();
    int nMonsterCost = GetLocalInt(oDungeon, "n" + sVariable + "MonsterCost");

    // get player gold
    object oPC = GetPCSpeaker();
    int nGold = GetGold(oPC);

    if ((GetLocalInt(OBJECT_SELF, "nCurrentNum") >= 4) && (nGold >= nMonsterCost * 4))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
