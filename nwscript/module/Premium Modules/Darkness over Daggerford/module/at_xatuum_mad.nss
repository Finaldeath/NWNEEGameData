// xatuum goes hostile towards the player

#include "NW_I0_GENERIC"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();
    GiveQuestXPToCreature(oPC, "j95");

    // go hostile
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);
    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
    DetermineCombatRound();
}
