//::///////////////////////////////////////////////
//:: FileName sc_ac_burnasbar4
//:: This checks to see if the PC is meeting Burnas at well.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_burnas_bard") == 4))
        return FALSE;

    return TRUE;
}
