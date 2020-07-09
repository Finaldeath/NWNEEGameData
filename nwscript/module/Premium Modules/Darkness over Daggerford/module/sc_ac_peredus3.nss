//::///////////////////////////////////////////////
//:: FileName sc_ac_peredus3
//:: This indicates that Peredus is exiting
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_peredus") == 3))
        return FALSE;

    return TRUE;
}
