// pirates of the moonsea:
// after speaking with meldonder, the party returns to their ship

#include "hf_in_plot"
#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("AdmiralMeldonder", 2);

    TeleportToWaypoint(oPC, "WP_RA_NAVY_PLAYER3", TRUE);
    object oKettia = GetNearestObjectByTag("CaptainKettia");
    if (GetIsObjectValid(oKettia))
    {
        object oWP = GetWaypointByTag("WP_RA_NAVY_KETTIA3");
        location lLoc = GetLocation(oWP);
        AssignCommand(oKettia, JumpToLocation(lLoc));
    }

    // player can use the navigation cabin again
    object oDoor = GetNearestObjectByTag("dt_ship_navicabi", oPC);
    SetLocked(oDoor, FALSE);
}
