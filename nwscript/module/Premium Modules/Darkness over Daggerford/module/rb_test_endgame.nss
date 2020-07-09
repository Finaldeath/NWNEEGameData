#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(GetModule(), "pm_inforcdone", 1);
    SetLocalInt(GetModule(), "pm_endgame_start", 1);
    SetLocalInt(oPC, "CS_END", 1);
    BlackScreen(oPC);
    DelayCommand(1.5, TeleportToWaypoint(oPC, "WP_AR0401_CUT1_START"));
}
