//::///////////////////////////////////////////////
//:: FileName sc_ac_mquest1
//:: Check to see if player is on Mad Miller quest
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_miller_quest") == 1))
        return FALSE;

    return TRUE;
}
