#include "inc_id1_utility"
#include "inc_id1_camp"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    DebugMessage("Spellcaster sVariable is " + sVariable);
    int nCR = GetLocalInt(oDungeon, "n" + sVariable + "CR");
    int nSpellCost = nCR * 100;

    // get which spell number to cast
    int nSpell = GetLocalInt(OBJECT_SELF, "nCasting");
    int nSpellLevel = GetLocalInt(oDungeon, "n" + sVariable + "SpellLevel");
    int nSpellID = GetLocalInt(oDungeon, "n" + sVariable + "Spell" + IntToString(nSpell));
    DebugMessage("  n" + sVariable + "Spell" + IntToString(nSpell) + " is " + IntToString(nSpellID));
    int nSpellID2 = GetCasterSpellNumberAtLevel(nSpellLevel, nSpellID);
    DebugMessage("  Actual spell is " + IntToString(nSpellID2));

    // cast the spell
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(nSpellCost, oPC, TRUE);

    ActionPauseConversation();
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 2.0);
    ActionCastSpellAtObject(nSpellID2, oPC, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    DelayCommand(2.0, ActionResumeConversation());
}
