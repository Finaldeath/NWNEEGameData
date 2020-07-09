//::///////////////////////////////////////////////
//:: FileName sc_ac_perfumed
//:: See if player is perfumed
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/27/2005 11:29:58 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "perfumed") == 1))
        return FALSE;

    return TRUE;
}
