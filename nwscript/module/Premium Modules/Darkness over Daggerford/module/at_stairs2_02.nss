#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    string sDest = GetTag(OBJECT_SELF) + "_DEST";
    TeleportToWaypoint(oPC, sDest, TRUE);
}
