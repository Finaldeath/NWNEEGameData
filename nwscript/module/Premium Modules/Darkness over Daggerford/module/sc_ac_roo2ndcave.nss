//::///////////////////////////////////////////////
//:: FileName sc_ac_roo2ndcave
//:: Roo has gone to 2nd cave
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 8:18:23 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_roo_2ndcave") == 1))
        return FALSE;

    return TRUE;
}
