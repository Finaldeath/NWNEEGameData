//::///////////////////////////////////////////////
//:: FileName sc_ac_burnasbar3
//:: This checks to see if the PC has agreed to go on Burnas' quest.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_burnas_bard") == 3))
        return FALSE;

    return TRUE;
}
