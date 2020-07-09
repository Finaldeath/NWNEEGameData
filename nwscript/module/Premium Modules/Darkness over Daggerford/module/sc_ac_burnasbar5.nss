//::///////////////////////////////////////////////
//:: FileName sc_ac_burnasbar5
//:: This checks to see if Burnas is waiting for the PC to go down the well.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_burnas_bard") == 5))
        return FALSE;

    return TRUE;
}
