//::///////////////////////////////////////////////
//:: FileName sc_fred2_orcdone
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/10/2005 21:51:37
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "pm_inforcdone") == 1))
        return FALSE;

    return TRUE;
}