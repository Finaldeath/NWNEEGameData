// the player uses the secret forge door

#include "hf_in_npc"

void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        TeleportToWaypoint(oPC, "WP_AR2501E_FORGE_ENTER", TRUE);
        DelayCommand(3.0, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    }
}
