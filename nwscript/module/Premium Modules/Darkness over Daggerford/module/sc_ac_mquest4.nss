//::///////////////////////////////////////////////
//:: FileName sc_ac_mquest4
//:: Check to see if player killed the mad miller
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_kill_miller") == 1))
        return FALSE;

    return TRUE;
}
