// bugo gives the player the quest

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j101", 1, oPC);
    CreateItemOnObject("pm_bugo_letter", oPC, 1);
    SetLocalInt(GetModule(), "pm_bugo_letter", 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
