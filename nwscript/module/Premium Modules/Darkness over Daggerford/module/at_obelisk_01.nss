// the player teleports inside the tomb of telarthir

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "wp_c1ar1400_c1ar1402_exit", TRUE);
}
