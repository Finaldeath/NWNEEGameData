#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j81", 1, oPC);
    PlotLevelSet(GetTag(OBJECT_SELF), 2); // searching for stick
}
