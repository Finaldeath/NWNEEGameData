//::///////////////////////////////////////////////
//:: FileName sc_ac_morisq6
//:: See whether Moris has acknowledged the completion of the quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "moris_quest") == 6))
        return FALSE;

    return TRUE;
}
