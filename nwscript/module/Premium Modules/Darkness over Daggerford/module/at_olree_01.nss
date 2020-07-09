// olree tells the player about the hidden sea caves

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    // the map really isn't important
    CreateItemOnObject("ks_olree_map", oPC, 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    PlotLevelSet("dt_ar2000_to_ar2001", 1);

    // give the journal
    AddJournalQuestEntry("j85", 6, oPC);

    // enable the map pin for the sea caves
    ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
    object oMapPin = GetNearestObjectByTag("MN_AR2000_CAVES", oPC);
    SetMapPinEnabled(oMapPin, TRUE);
}
