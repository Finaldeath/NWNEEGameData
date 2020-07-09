//::///////////////////////////////////////////////
//:: FileName sc_ac_gates_rand
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/20/2005 11:05:48 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "pm_endgame_start") == 1))
        return FALSE;

    // Add the randomness
    if(Random(3) >= 1)
        return FALSE;

    return TRUE;
}
