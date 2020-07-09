//::///////////////////////////////////////////////
//:: FileName sc_ac_g_escmaze
//:: Check whether player talked to Gravia after escaping maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:56:45 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_werewolf") == 4))
        return FALSE;

    return TRUE;
}
