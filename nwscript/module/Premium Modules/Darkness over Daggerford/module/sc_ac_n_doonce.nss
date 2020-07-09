//::///////////////////////////////////////////////
//:: FileName sc_ac_n_doonce
//:: Make sure this option hasn't already been selected
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/22/2006 7:31:05 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "do_once") != 1))
        return FALSE;

    return TRUE;
}
