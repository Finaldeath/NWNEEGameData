#include "inc_id1_utility"

int StartingConditional()
{
    // if the number of available monsters is above zero
    string sVariable = GetLocalString(OBJECT_SELF, "sNode");
    DebugMessage("Monster seller sVariable is " + sVariable);

    object oDungeon = GetCurrentDungeon();

    // search through monster list and find how many not dead
    int nMonsterNum = GetLocalInt(oDungeon, "n" + sVariable + "MonsterNum");
    int bDead;
    int nCurrentNum = 0;
    int nMonster = 1;
    string sMonster;
    while (nMonster <= nMonsterNum)
    {
        sMonster = sVariable + "Monster" + IntToString(nMonster);
        bDead = GetLocalInt(oDungeon, "b" + sMonster + "Dead");
        DebugMessage("  " + sMonster + "Dead is " + IntToString(bDead));

        if (bDead == FALSE)
        {
            nCurrentNum++;
        }

        nMonster++;
    }
    DebugMessage("The current number of monsters is " + IntToString(nCurrentNum));

    // if the seller has monsters available
    if (nCurrentNum > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
