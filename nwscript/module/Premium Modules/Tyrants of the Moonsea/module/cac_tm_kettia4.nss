// pirates of the moonsea:
// kettia teleports the party onto burak's ship

#include "hf_in_npc"
#include "hf_in_friend"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_RA_BRAK_PLAYER2", TRUE);

    object oKettia = OBJECT_SELF;
    if (GetIsObjectValid(oKettia))
    {
        FriendSetMaster(oPC, oKettia);
        object oWP = GetWaypointByTag("WP_RA_BRAK_KETTIA2");
        location lLoc = GetLocation(oWP);
        AssignCommand(oKettia, JumpToLocation(lLoc));
    }
}
