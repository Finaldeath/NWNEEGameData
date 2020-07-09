//::///////////////////////////////////////////////
//:: FileName sc_ac_peredus2
//:: This indicates the PC dropped Peredus' bones in the stream.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_peredus") == 2))
        return FALSE;

    return TRUE;
}
