//::///////////////////////////////////////////////
//:: FileName sc_ac_mquest3
//:: Check to see if player killed Loru the slaad
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_kill_loru") == 1))
        return FALSE;

    return TRUE;
}