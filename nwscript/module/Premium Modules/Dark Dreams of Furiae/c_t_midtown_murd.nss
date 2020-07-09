#include "ddf_util"

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_midtown_murder") == TRUE) return TRUE;
    return FALSE;
}
