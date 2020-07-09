//::///////////////////////////////////////////////
//:: FileName sc_ac_morisq5
//:: Check whether Elveronne killed one or both sisters
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "moris_quest") == 5))
        return FALSE;

    return TRUE;
}
