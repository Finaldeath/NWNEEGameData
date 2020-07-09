// feynemonee tells player where bloodstone is hidden

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j86", 6, oPC);
    PlotLevelSet("ks_feynemonee", 1);
}
