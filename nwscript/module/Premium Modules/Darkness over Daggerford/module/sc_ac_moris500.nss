//::///////////////////////////////////////////////
//:: FileName sc_ac_moris500
//:: See if Moris reward  = 500
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:59:31 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "moris_reward") == 500))
        return FALSE;

    return TRUE;
}
