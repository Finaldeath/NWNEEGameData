#include "ddf_util"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFactionLeader = GetFactionLeader(oPC);
    debug("Player: " + GetPCPlayerName(oPC) + " faction leader: " + GetPCPlayerName(oFactionLeader));

    if(oPC == oFactionLeader) return TRUE;

    // this is so new players that are not the faction leader
    // can still change their alignment...
    int bg = GetLocalInt(GetModule(), "ddf_background_flag");
    if(bg != 0) return TRUE;

    return FALSE;
}
