//::///////////////////////////////////////////////
//:: FileName sc_ac_g_killmaze
//:: Check whether player talked to Gravia about killing them before the maze.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:52:34 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_kill_nonmaze") == 1))
        return FALSE;

    return TRUE;
}
