// end the redeye quest (dragon eggs)

#include "hf_in_xp"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j88", 30, oPC);
    GiveQuestXPToCreature(oPC, "j88");
    PlotLevelSet("ks_redeye", 3);
}
