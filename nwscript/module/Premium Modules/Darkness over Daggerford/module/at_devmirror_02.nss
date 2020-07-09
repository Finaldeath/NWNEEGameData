// the player has used the magic mirror in Edalseye's bedroom to reach the roof

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "nPlayCutscene", 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    TeleportToWaypoint(oPC, "WP_AR1100_CUT1_START", FALSE);
}
