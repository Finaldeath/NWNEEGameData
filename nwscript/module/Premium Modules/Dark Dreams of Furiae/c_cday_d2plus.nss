#include "ddf_util"

int StartingConditional()
{
    int nDay = GetCurrentDay();

    if (nDay >= 2)
    {
        return TRUE;
    }
    return FALSE;
}
