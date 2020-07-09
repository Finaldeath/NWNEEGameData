#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    string sNode = GetLocalString(OBJECT_SELF, "sNode");

    string sString;
    int nNum;

    DebugMessage("Monster seller sVariable is " + sVariable);
    DebugMessage("Monster seller sNode is " + sNode);

    // if the seller has monsters available
    int nMonsterNum = GetLocalInt(oDungeon, "n" + sNode + "MonsterNum");
    int bDead;
    int nCurrentNum = 0;
    int nMonster = 1;
    string sMonster;
    while (nMonster <= nMonsterNum)
    {
        sMonster = sNode + "Monster" + IntToString(nMonster);
        bDead = GetLocalInt(oDungeon, "b" + sMonster + "Dead");
        DebugMessage("  " + sMonster + "Dead is " + IntToString(bDead));

        if (bDead == FALSE)
        {
            nCurrentNum++;
        }

        nMonster++;
    }
    DebugMessage("The current number of monsters is " + IntToString(nCurrentNum));
    SetLocalInt(OBJECT_SELF, "nCurrentNum", nCurrentNum);

    // get monster name
    int nCreature = GetLocalInt(oDungeon, "n" + sNode + "Monster");
    string sMonsterName;
    if (nCurrentNum > 1)
    {
        sMonsterName = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreature) + "NamePlural");
        if (sMonsterName == "")
        {
            sMonsterName = "Penguins";
        }
    } else
    {
        sMonsterName = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreature) + "NameSingular");
        if (sMonsterName == "")
        {
            sMonsterName = "Penguin";
        }
    }
    sString += " I have " + IntToString(nCurrentNum) + " " + sMonsterName + " available for ";

    // get monster price
    int nMonsterCost = GetLocalInt(oDungeon, "n" + sNode + "MonsterCost");
    sString += IntToString(nMonsterCost) + " gold";
    if (nCurrentNum > 1)
    {
        sString += " each.";
    } else
    {
        sString += ".";
    }

    // get player gold
    object oPC = GetPCSpeaker();
    int nPlayerGold = GetGold(oPC);
    int nBuyNum;
    if (nPlayerGold > 0)
    {
        nBuyNum = nPlayerGold / nMonsterCost;
    } else
    {
        nBuyNum = 0;
    }

    if (nBuyNum > nCurrentNum)
    {
        nBuyNum = nCurrentNum;
    }
    if (nBuyNum < 0)
    {
        nBuyNum = 0;
    }

    // if the player can afford any
    if (nBuyNum > 0)
    {
        sString += " You can afford " + IntToString(nBuyNum) + ".";

        // purchase line
        nNum = GetLocalInt(oDungeon, "n" + sVariable + "LinePurchase");
        sString += " " + GetLocalString(GetModule(), "sLinesSellerPurchase" + IntToString(nNum));
    } else // if the player can't afford any
    {
        // not enough gold line
        nNum = GetLocalInt(oDungeon, "n" + sVariable + "LinePoor");
        sString += " " + GetLocalString(GetModule(), "sLinesSellerPoor" + IntToString(nNum));
    }

    SetCustomToken(5071, sString);
}
