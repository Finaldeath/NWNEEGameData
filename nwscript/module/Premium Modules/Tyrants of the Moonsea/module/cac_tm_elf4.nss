//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Finishes Quest "Hillsfar Arena: Elf"
//::////////////////////////////////////////////////////
//:: Elf is alive, he will be teleported to Melvaunt
//:: upon leaving the arena
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "cut_tm_arena_inc"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(NPC_TAG_ELF, 7);

    AddJournalQuestEntry("HillsfarArenaElf", 30, oPC);
    GiveXPToCreature(oPC, GetJournalQuestExperience("HillsfarArenaElf"));
}
