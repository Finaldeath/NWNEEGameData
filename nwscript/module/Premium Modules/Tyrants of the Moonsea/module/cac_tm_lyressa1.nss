//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_lyressa
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: PC has talked to Lyressa. Will also set the home
//:: base to The Swords meet inn if not already set.
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

void main()
{
    object oLyressa = OBJECT_SELF;

    if (PlotLevelGet(PLOT_DIALOG_LYRESSA) < 1)
    {
        PlotLevelSet(PLOT_DIALOG_LYRESSA, 1);

        if (GetLocalInt(oLyressa, "HF_HENCHMAN_HOME_DEFINED") == 0)
        {
            object oWaypoint = GetWaypointByTag("WP_C1_HENCH_HOME_LYRESSA");
            HenchmanSetHome(oLyressa, GetLocation(oWaypoint));
        }
    }
}
