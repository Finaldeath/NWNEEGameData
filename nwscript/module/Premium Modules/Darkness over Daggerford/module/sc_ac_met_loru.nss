//::///////////////////////////////////////////////
//:: FileName sc_ac_mquest1
//:: Check to see if PC has met Loru the slaad.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/29/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_met_loru") == 1))
        return FALSE;

    return TRUE;
}
