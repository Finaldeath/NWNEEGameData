#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentDay() != 3) return FALSE;
    if(GetLocalInt(GetModule(), "ddf_forv_spoke") == TRUE) return FALSE;

    return TRUE;
}
