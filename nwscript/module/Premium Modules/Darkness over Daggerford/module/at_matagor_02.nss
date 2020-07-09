// player has talked to bugo after dealing with nakoto

#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j101", 3, oPC);
    GiveQuestXPToCreature(oPC, "j101");
    string sTag = GetTag(OBJECT_SELF);
    PlotLevelSet(sTag, 2);
}
