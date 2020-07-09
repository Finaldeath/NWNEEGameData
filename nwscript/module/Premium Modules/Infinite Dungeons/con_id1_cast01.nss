#include "inc_id1_utility"

int StartingConditional()
{
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    object oDungeon = GetCurrentDungeon();
    int nCR = GetLocalInt(oDungeon, "n" + sVariable + "CR");
    int nSpellCost = nCR * 100;

    object oPC = GetPCSpeaker();
    int nPlayerGold = GetGold(oPC);

    // if the player can afford a spell
    if (nPlayerGold >= nSpellCost)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
