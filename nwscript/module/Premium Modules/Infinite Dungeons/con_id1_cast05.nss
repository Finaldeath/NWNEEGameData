#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sString = "";
    int nNum;

    // spells line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineSpells");
    sString += GetLocalString(GetModule(), "sLinesCasterSpells" + IntToString(nNum));

    // spell cost
    DebugMessage("Spellcaster sVariable is " + sVariable);
    int nCR = GetLocalInt(oDungeon, "n" + sVariable + "CR");
    int nSpellCost = nCR * 100;
    sString += " Each spell costs me time and energy, so you must compensate me with " + IntToString(nSpellCost) + " gold for each one.";

    object oPC = GetPCSpeaker();
    int nPlayerGold = GetGold(oPC);

    // if the player can afford a spell
    if (nPlayerGold >= nSpellCost)
    {
        sString += " The spells will only last a limited duration.";

        // EDIT: choice line
        sString += " Which would you like me to cast?";
    } else // if the player can't afford a spell
    {
        // EDIT: too poor line
        sString += " Unfortunately, you don't seem to have enough gold.";
    }

    SetCustomToken(5083, sString);

    return TRUE;
}
