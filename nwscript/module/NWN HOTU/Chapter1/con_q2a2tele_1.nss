//::///////////////////////////////////////////////
//:: FileName con_q2a2tele_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/29/2002 2:04:49 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "nUniTelescopeUsed") != 1))
        return FALSE;

    return TRUE;
}