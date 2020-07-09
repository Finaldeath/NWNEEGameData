//::///////////////////////////////////////////////
//:: FileName sc_ac_roopostbat
//:: Roo after the battle with the rats
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 8:18:23 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_roo_2ndcave") == 2))
        return FALSE;

    return TRUE;
}
