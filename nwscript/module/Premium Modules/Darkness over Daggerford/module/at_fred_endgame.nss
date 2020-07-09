// the player teleports to the endgame area for the final battle

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();

    // need delay to cope with the autosave; otherwise the entire
    // .. game audio system crashes (?)
    DelayCommand(2.0, TeleportToWaypoint(oPC, "WP_AR0100_PLAYER_START", FALSE));
    DoSinglePlayerAutoSave();
}
