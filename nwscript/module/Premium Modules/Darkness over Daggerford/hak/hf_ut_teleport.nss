// teleport the player using a dialog

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    string sDestTag = GetLocalString(OBJECT_SELF, "HF_DESTINATION");
    if (sDestTag == "")
    {
        sDestTag = GetTag(OBJECT_SELF) + "_DST";
    }
    object oDest = GetObjectByTag(sDestTag);
    TeleportToObject(oPC, oDest, TRUE);
}
