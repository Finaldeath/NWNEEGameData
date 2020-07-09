#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    string sNode = GetLocalString(OBJECT_SELF, "sNode");

    string sString;
    int nNum;

    // greeting line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineGreeting");
    sString += GetLocalString(GetModule(), "sLinesSellerGreeting" + IntToString(nNum));

    DebugMessage("Monster seller sVariable is " + sVariable);
    DebugMessage("Monster seller sNode is " + sNode);

    // search through monster list and find how many not dead
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

    // if the seller has monsters available
    if (nCurrentNum > 0)
    {
        DebugMessage("  Seller has monsters available.");

        // get monster name
        int nCreature = GetLocalInt(oDungeon, "n" + sNode + "Monster");
        string sMonsterNamePlural = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreature) + "NamePlural");
        if (sMonsterNamePlural == "")
        {
            sMonsterNamePlural = "Penguins";
        }
        sString += " I sell " + sMonsterNamePlural + " for ";

        // get monster price
        int nMonsterCost = GetLocalInt(oDungeon, "n" + sNode + "MonsterCost");
        sString += IntToString(nMonsterCost) + " gold each.";

        // get asking line
        nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineAsking");
        sString += " " + GetLocalString(GetModule(), "sLinesSellerAsking" + IntToString(nNum));
    } else // if the seller has sold all monsters
    {
        DebugMessage("  Seller does not have monsters available.");

        // EDIT: nothing left line
        sString += " Unfortunately, I have nothing left to sell.";
    }

    SetCustomToken(5070, sString);
}
