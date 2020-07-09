//::///////////////////////////////////////////////
//:: FileName sc_ac_killmaze1
//:: Check if player killed Jonas Jr. in maze
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/4/2005 2:38:39 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_kill_maze") == 1))
        return FALSE;

    return TRUE;
}
