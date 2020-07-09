//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_dazel12
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Update journal and Bron's Deputy faction to hostile.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("LocktowerRescue", 80, oPC);

    AdjustReputation(oPC, OBJECT_SELF, -100);
    DetermineCombatRound(oPC);
}
