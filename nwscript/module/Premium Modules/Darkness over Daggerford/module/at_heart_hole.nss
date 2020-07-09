// the player enters the heart hole in illefarn
// .. veiti will never come with the player down here

#include "hf_in_plot"
#include "hf_in_npc"
#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();

    // veiti refuses to enter the pool
    object oVeiti = GetNearestObjectByTag("db_veiti", oPC);
    if (GetIsObjectValid(oVeiti))
    {
        if (HenchmanIsMine(oVeiti, oPC))
        {
            SetLocalInt(oPC, "VEITI_REJOIN", 1);
            HenchmanFire(oVeiti, oPC);
        }
    }

    // advance the plot convo so that veiti doesn't repeat herself
    PlotLevelSet(GetTag(OBJECT_SELF), 1);

    // move the player
    TeleportToWaypoint(oPC, "WP_AR2501C_HOLE_ENTER", TRUE);
}
