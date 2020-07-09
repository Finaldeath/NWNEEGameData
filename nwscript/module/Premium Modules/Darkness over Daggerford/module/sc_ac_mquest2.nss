//::///////////////////////////////////////////////
//:: FileName sc_ac_mquest1
//:: Check to see if player has met Fernd the Mad Miller
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_met_miller") == 1))
        return FALSE;

    return TRUE;
}
