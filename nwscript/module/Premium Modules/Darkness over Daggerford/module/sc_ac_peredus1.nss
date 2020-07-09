//::///////////////////////////////////////////////
//:: FileName sc_ac_peredus1
//:: This indicates the PC is trying to locate peredus bones.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_peredus") == 1))
        return FALSE;

    return TRUE;
}
