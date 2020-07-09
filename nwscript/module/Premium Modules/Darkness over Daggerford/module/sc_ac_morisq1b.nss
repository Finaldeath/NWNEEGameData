//::///////////////////////////////////////////////
//:: FileName sc_ac_morisq1
//:: Check whether Moris quest is on
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "moris_quest") >= 1))
        return FALSE;

    return TRUE;
}
