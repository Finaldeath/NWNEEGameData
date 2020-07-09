#include "nw_i0_plot"

int StartingConditional()
{
    int bSuccess = GetLocalInt(GetModule(), "ddf_rag_persuade");

    if(bSuccess == TRUE) return TRUE;

    return FALSE;
}
