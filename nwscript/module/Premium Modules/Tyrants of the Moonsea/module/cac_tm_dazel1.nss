//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_dazel1
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Shift alignment 5 points to good, update journal,
//       and Bron's Deputy faction to hostile.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();

    AdjustPlayerAlignment(oPC, ALIGNMENT_GOOD, 5);

    AddJournalQuestEntry("LocktowerRescue", 80, oPC);

    AdjustReputation(oPC, OBJECT_SELF, -100);
    DetermineCombatRound(oPC);
}
