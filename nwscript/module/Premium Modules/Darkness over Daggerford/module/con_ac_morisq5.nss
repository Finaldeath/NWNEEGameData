//::///////////////////////////////////////////////
//:: FileName con_ac_moris5
//:: Elveronne goes to kill sisters
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/20/2005 11:59:20 PM
//:://////////////////////////////////////////////

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "moris_quest", 5);
    TeleportToWaypoint(oPC, "WP_AR0701A_CUT1_START");
}
