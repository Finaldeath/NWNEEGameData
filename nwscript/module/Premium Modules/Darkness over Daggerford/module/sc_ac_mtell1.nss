//::///////////////////////////////////////////////
//:: FileName sc_ac_mtell1
//:: Check to see if player told Maerovyna of the journal
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_maero_tell") == 1))
        return FALSE;

    return TRUE;
}
