// player accepts stegil's offer (kill 4 fowls and bring hearts)

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("ks_stegil", 1);
    AddJournalQuestEntry("j86", 7, oPC);
}
