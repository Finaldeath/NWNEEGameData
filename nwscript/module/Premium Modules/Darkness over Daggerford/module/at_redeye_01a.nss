// redeye gives player the quest to "dump dragon eggs in lizard village"

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    CreateItemOnObject("ks_dragon_eggs", oPC, 1);
    AddJournalQuestEntry("j88", 20, oPC);
    PlotLevelSet("ks_redeye", 2);
}
