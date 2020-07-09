// Returns true is Quill has made a payment today

#include "ddf_util"

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_quill_paid") == TRUE)
        return TRUE;

    return FALSE;
}
