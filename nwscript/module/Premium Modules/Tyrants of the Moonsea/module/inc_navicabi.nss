// ship navigation cabin uses the world map to select a port
// the cabin exit door destination transition is dynamic based on the port

#include "hf_in_npc"
#include "hf_in_plot"
#include "hf_in_worldmap"

// reset all world map variables related to the navigation cabin
void NaviCabiClear(object oPC)
{
    DeleteLocalString(oPC, "sNaviCabiDestArea");
    DeleteLocalString(oPC, "sNaviCabiDestWaypoint");
    DeleteLocalInt(oPC, "nWM_SelectionMode");
    DeleteLocalString(oPC, "sWM_SelectionExit");
    DeleteLocalString(oPC, "sWM_SelectionArea");
}

// set the starting area (should not be done for random encounters)
void NaviCabiSetStartArea(object oPC, string sAreaTag)
{
    SetLocalString(oPC, "sNaviCabiStartArea", sAreaTag);
}

// set the cabin door exit transition to the given waypoint
void NaviCabiSetExitTransition(object oPC, string sDestinationWaypoint)
{
    object oDoor = GetObjectByTag("dt_navicabi_exit");
    if (GetIsObjectValid(oDoor))
    {
        object oTarget = GetWaypointByTag(sDestinationWaypoint);
        if (GetIsObjectValid(oTarget))
        {
            SetTransitionTarget(oDoor, oTarget);
        } else {
            SendMessageToPC(oPC, "Invalid waypoint: " + sDestinationWaypoint);
        }
    }
}

// given a map area tag, return its ship exit waypoint tag
string NaviCabiGetExitTag(string sDestinationArea)
{
    if (sDestinationArea == "ZhentilOC")
    {
        if (PlotLevelGet("PirateBlockade") == 3)
        {
            return "WP_ZK2_SHIP_EXIT";
        }
        else
        {
            return "WP_ZK_SHIP_EXIT";
        }
    }
    if (sDestinationArea == "ThentiaE") return "WP_TH_SHIP_EXIT";
    if (sDestinationArea == "MelvauntSY") return "WP_ME_SHIP_EXIT";
    if (sDestinationArea == "MulmasterD") return "WP_MU_SHIP_EXIT";
    return "WP_EL_SHIP_EXIT";
}

// called from conversations to jump the party into the navigation cabin
void NaviCabiEnter(object oPC, string sFromAreaTag, string sFromWaypointTag)
{
    SetLocalString(oPC, "sNaviCabiDestArea", sFromAreaTag);
    SetLocalString(oPC, "sNaviCabiDestWaypoint", sFromWaypointTag);
    TeleportToWaypoint(oPC, "WP_NAVI_PLAYER");
}

// after selecting a port on the map, update the cabin exit door destination
void NaviCabiOnSelected(object oPC, string sSelectedArea)
{
    // fade screen in
    FadeFromBlack(oPC);

    // play some sounds if we switched areas
    string sPreviousArea = GetLocalString(oPC, "sNaviCabiDestArea");
    if (sSelectedArea != sPreviousArea)
    {
        DelayCommand(0.0, AssignCommand(oPC, PlaySound("as_pl_sailorm1")));
        DelayCommand(1.0, AssignCommand(oPC, PlaySound("as_cv_bellship1")));
        DelayCommand(2.0, AssignCommand(oPC, PlaySound("as_cv_shipsail1")));
    }

    // setup the door to exit
    string sTarget = NaviCabiGetExitTag(sSelectedArea);
    NaviCabiSetExitTransition(oPC, sTarget);
}

// called whenever a PC enters the cabin
void NaviCabiOnEnter(object oPC)
{
    // make sure that the exit door goes back to where we just came from
    string sTarget = GetLocalString(oPC, "sNaviCabiDestWaypoint");
    if (sTarget != "")
    {
        NaviCabiSetExitTransition(oPC, sTarget);
    }
    DeleteLocalString(oPC, "sNaviCabiDestWaypoint");

    // when returning from the map area, process the selected area
    string sSelectedArea = GetLocalString(oPC, "sWM_SelectionArea");
    if (sSelectedArea != "")
    {
        NaviCabiOnSelected(oPC, sSelectedArea);
    }

    // clear our variables
    DeleteLocalInt(oPC, "nWM_SelectionMode");
    DeleteLocalString(oPC, "sWM_SelectionExit");
    DeleteLocalString(oPC, "sWM_SelectionArea");
    DeleteLocalInt(oPC, "nWM_ShipTravel");
}

// called when the placeable map is used: show the world map in "select mode"
void NaviCabiShowMap(object oPC, string sReturnWaypoint)
{
    SetLocalInt(oPC, "nWM_ShipTravel", 1);

    // make sure that the icon states are correct (all seaports are available)
    RevealMapLocation("MelvauntSY");
    RevealMapLocation("ThentiaE");
    RevealMapLocation("ZhentilOC");
    RevealMapLocation("MulmasterD");
    RevealMapLocation("Elmwood");
    UpdateWorldMap(oPC);

    // set some variables on pc for world map
    string sAreaTag = GetLocalString(oPC, "sNaviCabiStartArea");
    if (sAreaTag == "") sAreaTag = "Elmwood"; // DEBUG
    SetLocalString(oPC, "sWM_PreviousArea", sAreaTag);
    string sReturnTrig = "WP_NAVI_PLAYER";
    SetLocalString(oPC, "sWM_PreviousTrig", sReturnTrig);
    SetLocalInt(oPC, "nWM_UsedInventoryMap", 0);
    SetLocalInt(oPC, "nWM_SelectionMode", 1);
    SetLocalString(oPC, "sWM_SelectionExit", sReturnWaypoint);
    DeleteLocalString(oPC, "sWM_SelectionArea");

    // enter the map area
    object oTarget = GetWaypointByTag("WP_WORLD_MAP");
    location lTarget = GetLocation(oTarget);
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lTarget));
}

