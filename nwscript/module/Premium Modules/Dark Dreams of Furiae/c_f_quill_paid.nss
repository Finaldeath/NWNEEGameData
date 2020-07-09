// Returns true if Quill has NOT made a payment today

#include "ddf_util"

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_quill_paid") == TRUE)
        return FALSE;

    return TRUE;
}
