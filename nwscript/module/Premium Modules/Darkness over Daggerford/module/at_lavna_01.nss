// lavna the shepherd gives the one-eyed worg quest

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j84", 1, oPC);
    object oWP = GetWaypointByTag("WP_AR1500_WORG");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_worg", GetLocation(oWP));
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
