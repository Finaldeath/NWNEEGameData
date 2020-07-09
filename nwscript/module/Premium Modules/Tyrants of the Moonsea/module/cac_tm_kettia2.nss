// pirates of the moonsea:
// kettia teleports the party onto admiral meldonder's ship

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_RA_NAVY_PLAYER2", TRUE);

    object oKettia = OBJECT_SELF;
    if (GetIsObjectValid(oKettia))
    {
        object oWP = GetWaypointByTag("WP_RA_NAVY_KETTIA2");
        location lLoc = GetLocation(oWP);
        AssignCommand(oKettia, JumpToLocation(lLoc));
    }
}
