//::///////////////////////////////////////////////
//:: FileName sc_ac_g_killmaz
//:: Check whether player talked to Gravia after killing them in maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:06:37 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_kill_maze") == 1))
        return FALSE;

    return TRUE;
}
