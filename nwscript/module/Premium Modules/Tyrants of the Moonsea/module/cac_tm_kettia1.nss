// teleport player to ship navigation cabin to use the world map

#include "inc_navicabi"
#include "hf_in_horse"
#include "hf_in_plot"


const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";
const string PLOT_HENCH_NUM_TRAVELS  = "hench_dialog_num_trv";


// translates the current area tag into a world map area tag (short form)
string GetReturnArea(object oPC)
{
    object oArea = GetArea(oPC);
    string sArea = GetTag(oArea);
    if (sArea == "MelvauntSY") return "MelvauntSY";
    if (sArea == "ThentiaE") return "ThentiaE";
    if (sArea == "ZhentilKeep") return "ZhentilOC";
    if (sArea == "zhentkeepwar") return "ZhentilOC";
    if (sArea == "MulmasterD") return "MulmasterD";
    if (sArea == "Elmwood") return "Elmwood";
    return "Unknown";
}

// returns the tag of the ship exit waypoint in the player's area
string GetReturnWaypoint(object oPC)
{
    object oArea = GetArea(oPC);
    string sArea = GetTag(oArea);
    if (sArea == "MelvauntSY") return "WP_ME_SHIP_EXIT";
    if (sArea == "ThentiaE") return "WP_TH_SHIP_EXIT";
    if (sArea == "ZhentilKeep") return "WP_ZK_SHIP_EXIT";
    if (sArea == "zhentkeepwar") return "WP_ZK2_SHIP_EXIT";
    if (sArea == "MulmasterD") return "WP_MU_SHIP_EXIT";
    if (sArea == "Elmwood") return "WP_EL_SHIP_EXIT";
    return "Unknown";
}

// move the party into the ship's cabin
void EnterShipCabin(object oPC)
{
    string sArea = GetReturnArea(oPC);
    string sWaypoint = GetReturnWaypoint(oPC);
    NaviCabiSetStartArea(oPC, sArea);
    NaviCabiEnter(oPC, sArea, sWaypoint);
}

void main()
{
    object oPC = GetPCSpeaker();
    float fDelay = HorsePartyHitchHorses(oPC);
    DelayCommand(fDelay, EnterShipCabin(oPC));

    // Dialog related stuff
    int nNumTravels = PlotLevelGet(PLOT_HENCH_NUM_TRAVELS);
    PlotLevelSet(PLOT_HENCH_NUM_TRAVELS, nNumTravels+1);
    if (PlotLevelGet(PLOT_HENCH_DIALOG) < 9)
        PlotLevelSet(PLOT_HENCH_DIALOG, 9);
}
