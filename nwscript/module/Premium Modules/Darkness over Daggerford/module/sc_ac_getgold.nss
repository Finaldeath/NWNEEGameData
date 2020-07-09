//::///////////////////////////////////////////////
//:: FileName sc_ac_getgold
//:: Checks to see whether player had agreed to come back with gold for sheet music.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/21/2006 7:05:47 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "get_gold") == 1))
        return FALSE;

    return TRUE;
}
