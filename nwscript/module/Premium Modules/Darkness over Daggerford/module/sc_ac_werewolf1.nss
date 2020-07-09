//::///////////////////////////////////////////////
//:: FileName sc_ac_werewolf1
//:: Check Jonas variable to see if player on quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:31:19 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "ac_werewolf") == 1))
        return FALSE;

    return TRUE;
}
