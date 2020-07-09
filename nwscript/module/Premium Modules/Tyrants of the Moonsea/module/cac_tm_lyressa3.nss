//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_lyressa2
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: Used in Lyressa interjection when trying to leave
//:: Voonlar without talking to her first.
//:: - Makes lyressa leave (hf_exit)
//:: - Sets the dialog branch to 0 (= never talked to)
//:: - Create lyressa at Boring Pig
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

const string NPC_RESREF_LYRESSA = "lyressa";
const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_BORINGPIT_INIT = "WP_voon_bpi_lyressa";


void main()
{
    // Set Dialog to 0, so that the introduction dialog in the tavern is
    // played correctly
    PlotLevelSet(PLOT_DIALOG_LYRESSA, 0);
    SetLocalInt(OBJECT_SELF, "HF_EXIT_RUN", 1);

    ExecuteScript("hf_cs_exit", OBJECT_SELF);

    // Restore Lyressa to the Boring Pit
    object oWaypoint = GetWaypointByTag(WP_TAG_LYRESSA_BORINGPIT_INIT);
    object oLyressa = GetNearestObjectByTag(NPC_TAG_LYRESSA, oWaypoint);
    if (!GetIsObjectValid(oLyressa))
        oLyressa = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_LYRESSA, GetLocation(oWaypoint));
}
