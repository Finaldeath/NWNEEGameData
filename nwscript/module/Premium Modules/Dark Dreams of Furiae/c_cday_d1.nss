#include "ddf_util"

int StartingConditional()
{
    int nDay = GetCurrentDay();

    if (nDay == 1)
    {
        return TRUE;
    }
    return FALSE;
}
