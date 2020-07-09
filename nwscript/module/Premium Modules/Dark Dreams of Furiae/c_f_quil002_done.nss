#include "ddf_util"

int StartingConditional()
{
    // if we have skipped to day two, probably for testing
    // ignore this check.
    if(GetCurrentDay() > 1) return FALSE;

    if (GetLocalInt(GetModule(), "dlg_quill_002_done"))
        return FALSE;

    return TRUE;
}
