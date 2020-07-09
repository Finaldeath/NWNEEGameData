// sidequest: pirates of the moonsea
// .. ilandra has been persuaded to hand-over her ring instead of her head

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("item025", oPC);
    PlotLevelSet("IlandraPirate", 2);
    AddJournalQuestEntry("PiratesoftheMoonsea", 60, oPC, TRUE, FALSE, TRUE);
}
