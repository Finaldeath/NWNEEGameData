//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Sulzidara tells Player about Creels "preferences"
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("ElfInChains-Creel-Status", 2);
    AddJournalQuestEntry("ElfinChains", 5, oPC);

    TakeGoldFromCreature(5000, oPC);
}
