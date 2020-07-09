//::///////////////////////////////////////////////
//:: FileName sc_ac_werewolf1
//:: See if player sitting on stool
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:31:19 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "ac_werewolf") == 2))
        return FALSE;

    return TRUE;
}
