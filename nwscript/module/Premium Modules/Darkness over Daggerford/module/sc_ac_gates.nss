//::///////////////////////////////////////////////
//:: FileName sc_ac_endgamesta
//:: See if player had talked to Duke yet
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/20/2005 11:17:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "pm_endgame_start") == 1))
        return FALSE;

    return TRUE;
}
