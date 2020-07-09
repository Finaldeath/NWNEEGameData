//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_elfchn_e1
//:: DATE: February 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Elf In Chains - Elf Dialog
//:: Finishes quest
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(GetTag(OBJECT_SELF), 12); // Dialog branch
    PlotLevelSet("ElfInChains-Status", 4); // Ends quest
    AddJournalQuestEntry("ElfinChains", 12, oPC);
    GiveXPToCreature(oPC, GetJournalQuestExperience("ElfinChains"));
}
