//::///////////////////////////////////////////////
//:: FileName sc_ac_lorubk1
//:: Check to see if player found Loru's journal
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_loru_diary") == 1))
        return FALSE;

    return TRUE;
}
