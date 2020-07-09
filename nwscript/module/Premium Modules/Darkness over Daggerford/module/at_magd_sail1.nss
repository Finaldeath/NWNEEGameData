#include "hf_in_npc"

void main()
{
    // teleport the pc
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2500_PC_START");

    // despawn the dwarves from the quayside
    object oMagdaren = GetNearestObjectByTag("db_magdaren", oPC);
    object oVeiti = GetNearestObjectByTag("db_veiti", oPC);
    DestroyObject(oMagdaren, 0.5);
    DestroyObject(oVeiti, 0.5);
}
