// teleport the player using a placeable "use" event

#include "hf_in_npc"

void main()
{
    object oPC = GetLastUsedBy();
    string sDestTag = GetLocalString(OBJECT_SELF, "HF_DESTINATION");
    if (sDestTag == "")
    {
        sDestTag = GetTag(OBJECT_SELF) + "_DST";
    }
    object oDest = GetObjectByTag(sDestTag);
    TeleportToObject(oPC, oDest, TRUE);
}
