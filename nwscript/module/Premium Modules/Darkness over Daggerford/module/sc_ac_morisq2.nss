//::///////////////////////////////////////////////
//:: FileName sc_ac_morisq2
//:: Check whether Moris is angry
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "moris_quest") == 2))
        return FALSE;

    return TRUE;
}
