// player is using one of edalseye's portals to teleport within the tower
// .. the destination waypoints are defined in variables on the portal:
// .. DESTINATION_UP
// .. DESTINATION_DOWN
// the up/down function is stored in a variable set in dialog: HF_ARG
// .. HF_ARG = 1 = down
// .. HF_ARG = 2 = up

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();

    // are we going up or down?
    string sDestVar = "DESTINATION_DOWN";
    int nDir = GetLocalInt(OBJECT_SELF, "HF_ARG");
    if (nDir == 2)
        sDestVar = "DESTINATION_UP";

    // fetch the up/down destination
    string sDest = GetLocalString(OBJECT_SELF, sDestVar);
    if (sDest == "")
    {
        SendMessageToPC(oPC, "ERROR: invalid portal DESTINATION '"+sDestVar+"'");
        return;
    }

    // teleport to the destination
    object oDest = GetWaypointByTag(sDest);
    if (!GetIsObjectValid(oDest))
    {
        SendMessageToPC(oPC, "ERROR: portal DESTINATION '" + sDest + "' does not exist.");
        return;
    }
    AssignCommand(oPC, PlaySound("as_mg_telepout1"));
    if (GetLocalInt(OBJECT_SELF, "NOFADE") == 0)
    {
        TeleportToWaypoint(oPC, sDest, TRUE);
    }
    else
    {
        TeleportToWaypoint(oPC, sDest, FALSE);
    }
}
