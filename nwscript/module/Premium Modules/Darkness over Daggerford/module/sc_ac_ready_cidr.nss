//::///////////////////////////////////////////////
//:: FileName sc_ac_ready_cidr
//:: Player ready to drink cider now?
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:34:44 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetObjectByTag("ac_jonas1"), "ac_notready_cider") == 1))
        return FALSE;

    return TRUE;
}
