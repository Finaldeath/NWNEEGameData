//::///////////////////////////////////////////////
//:: FileName sc_ac_burnasbar2
//:: This indicates the PC has heard the tale of Peredus the Great.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_burnas_bard") == 2))
        return FALSE;

    return TRUE;
}
