//::///////////////////////////////////////////////
//:: FileName c_dlg_quill_1_t
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2018-10-04 9:56:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if((GetLocalInt(GetModule(), "dlg_quill_001_done") == TRUE))
        return TRUE;

    return FALSE;
}
