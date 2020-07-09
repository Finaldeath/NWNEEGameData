// player pulls lever to enter bhaal's hidden vault

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR1301A_VAULT", TRUE);
}
