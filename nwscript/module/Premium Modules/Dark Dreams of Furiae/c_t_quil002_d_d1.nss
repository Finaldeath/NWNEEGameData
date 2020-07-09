#include "ddf_util"

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "dlg_quill_002_done") == TRUE && GetCurrentDay() == 1)
        return TRUE;

    return FALSE;
}
