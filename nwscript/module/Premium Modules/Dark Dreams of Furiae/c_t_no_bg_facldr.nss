#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    int bgFlag = GetLocalInt(oModule, "ddf_background_flag");

    // if bg has been picked, do not show this
    if(bgFlag != 0) return FALSE;

    object oPC = GetPCSpeaker();
    object oFactionLeader = GetFactionLeader(oPC);

    // if you are the faction leader, do not show.
    if(oPC == oFactionLeader) return FALSE;

    return TRUE;
}
