#include "inc_id1_utility"
#include "x0_i0_henchman"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    string sNode = GetLocalString(OBJECT_SELF, "sNode");

    // get number of monster selected
    int nBoughtNum = GetLocalInt(OBJECT_SELF, "nBoughtNum");

    // subtract gold
    DebugMessage("Monster seller sVariable is " + sVariable);
    DebugMessage("Monster seller sNode is " + sNode);
    int nMonsterCost = GetLocalInt(oDungeon, "n" + sNode + "MonsterCost");
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(nBoughtNum * nMonsterCost, oPC, TRUE);

    // for each monster, make them a follower of the player
    int nMonsterNum = GetLocalInt(oDungeon, "n" + sNode + "MonsterNum");
    int nMonster = 1;
    object oMonster;
    int bDead;
    string sMonster;
    while ((nMonster <= nMonsterNum) && (nBoughtNum > 0))
    {
        sMonster = sNode + "Monster" + IntToString(nMonster);
        bDead = GetLocalInt(oDungeon, "b" + sMonster + "Dead");
        DebugMessage("  " + sMonster + "Dead is " + IntToString(bDead));
        if (bDead == FALSE)
        {
            SetLocalInt(oDungeon, "b" + sMonster + "Dead", TRUE);
            nBoughtNum--;

            oMonster = GetLocalObject(OBJECT_SELF, "oMonster" + IntToString(nMonster));
            if (oMonster != OBJECT_INVALID)
            {
                SetLocalInt(oMonster, "bFollower", TRUE);

                AddHenchman(oPC, oMonster);
                SetAssociateState(NW_ASC_DISTANCE_2_METERS, TRUE, oMonster);
            }
        }

        // cycle to next monster
        nMonster++;
    }
}
