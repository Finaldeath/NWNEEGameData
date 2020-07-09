// the player has used a rope to climb up or down a cliff

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    string sDest = GetLocalString(OBJECT_SELF, "HF_DEST");
    TeleportToWaypoint(oPC, sDest, TRUE);
}
