//::///////////////////////////////////////////////
//:: FileName sc_ac_gavelich
//:: This indicates the PC gave the lich chest to Mogdor.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_gavelich") == 1))
        return FALSE;

    return TRUE;
}
