//::///////////////////////////////////////////////
//:: FileName sc_ac_burnaswait
//:: This checks to see if Burnas is waiting for the PC to change his mind.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/25/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_burnas_wait") == 1))
        return FALSE;

    return TRUE;
}
