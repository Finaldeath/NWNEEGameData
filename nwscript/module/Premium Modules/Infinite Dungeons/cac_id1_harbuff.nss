#include "inc_id1_utility"
void main()
{
    object oDungeon = GetCurrentDungeon();
    int nLevel = GetLocalInt(oDungeon, "nBossLevel");
    int nSpell;
    if (nLevel <= 1) // level 1 - protection from good
    {
        nSpell = SPELL_PROTECTION_FROM_GOOD;
    } else if (nLevel <= 3) // level 2 - bull's strength
    {
        nSpell = SPELL_BULLS_STRENGTH;
    } else if (nLevel <= 5) // level 3 - haste
    {
        nSpell = SPELL_HASTE;
    } else if (nLevel <= 7) // level 4 - stoneskin
    {
        nSpell = SPELL_STONESKIN;
    } else if (nLevel <= 9) // level 5 - monstrous regeneration
    {
        nSpell = SPELL_MONSTROUS_REGENERATION;
    } else if (nLevel <= 11) // level 6 - owls insight
    {
        nSpell = SPELL_OWLS_INSIGHT;
    } else if (nLevel <= 13) // level 7 - true seeing
    {
        nSpell = SPELL_TRUE_SEEING;
    } else if (nLevel <= 15) // level 8 - spell resistance
    {
        nSpell = SPELL_SPELL_RESISTANCE;
    } else if (nLevel >= 16) // level 9 - regenerate
    {
        nSpell = SPELL_REGENERATE;
    }

    ActionPauseConversation();

    DebugMessage("Harat buffing.");
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 2.0);

    object oPC = GetFirstPC();
    object oArea = GetArea(OBJECT_SELF);
    object oPCArea;
    while (oPC != OBJECT_INVALID)
    {
        oPCArea = GetArea(oPC);
        DebugMessage("  Found PC " + GetName(oPC) + " in area " + GetTag(oPCArea));
        if (oPCArea == oArea)
        {
            DebugMessage("    Casting spell on PC.");

            // apply spell effect
            // apply visual effect
            ActionCastSpellAtObject(nSpell, oPC, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
        }

        oPC = GetNextPC();
    }
    DelayCommand(2.0, ActionResumeConversation());
}
