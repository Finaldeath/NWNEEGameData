// on enter event for elmwood area

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";
const string PLOT_HENCH_HOME = "hench_home_base";

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // Set Henchman dialog status (to entered Elmwood)
        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 6)
            PlotLevelSet(PLOT_HENCH_DIALOG, 6);

        // automatically explore this urban area
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            object oHenchman;
            object oWPHome;

            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);

            //Set Chapter 4 Henchman home waypoints
            oHenchman = GetObjectByTag("Lyressa");
            oWPHome = GetWaypointByTag("WP_C4_HENCH_HOME_LYRESSA");
            HenchmanSetHome(oHenchman, GetLocation(oWPHome));
            if(!HenchmanIsMine(oHenchman, oPC))
            {
                HenchmanGoHome(oHenchman);
            }

            oHenchman = GetObjectByTag("SharalynHenchman");
            oWPHome = GetWaypointByTag("WP_C4_HENCH_HOME_SHARALYN");
            HenchmanSetHome(oHenchman, GetLocation(oWPHome));
            if(!HenchmanIsMine(oHenchman, oPC))
            {
                HenchmanGoHome(oHenchman);
            }
            
            // Hench home variable for dialogs
            PlotLevelSet(PLOT_HENCH_HOME, 30); // 30 = Elmwood
        }

        // secrets: after digging up the corpse, a chicken spawns to chew at it
        int nCorpseLevel = PlotLevelGet("pl_secret_grave");
        if (nCorpseLevel == 1 || nCorpseLevel == 9)
        {
            PlotLevelSet("pl_secret_grave", 10);
            object oWP = GetWaypointByTag("WP_EL_SECRET_GRAVE");
            object oBird = CreateObject(OBJECT_TYPE_CREATURE, "nw_chicken", GetLocation(oWP));
        }
    }
}
