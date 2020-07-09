#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentDay() != 2) return FALSE;
    if(GetLocalInt(GetModule(), "ddf_forv_spoke") == TRUE) return FALSE;

    return TRUE;
}
