#include "inc_id1_utility"
#include "inc_id1_camp"

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
        // determine spell and set its custom token
        int nSpellID;
        int nSpellID2;
        int nSpellLevel = GetLocalInt(oDungeon, "n" + sVariable + "SpellLevel");
        string sSpell;
        int nSpell = 3;
        nSpellID = GetLocalInt(oDungeon, "n" + sVariable + "Spell" + IntToString(nSpell));
        DebugMessage("  n" + sVariable + "Spell" + IntToString(nSpell) + " is " + IntToString(nSpellID));
        nSpellID2 = GetCasterSpellNumberAtLevel(nSpellLevel, nSpellID);
        DebugMessage("  Actual spell is " + IntToString(nSpellID2));

        sSpell = GetSpellName(nSpellID2);
        SetCustomToken(5089 + nSpell, sSpell);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
