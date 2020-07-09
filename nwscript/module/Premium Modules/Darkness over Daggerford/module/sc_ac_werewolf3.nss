//::///////////////////////////////////////////////
//:: FileName sc_ac_werewolf3
//:: Player at start of maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:36:51 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "ac_werewolf") == 3))
        return FALSE;

    return TRUE;
}
