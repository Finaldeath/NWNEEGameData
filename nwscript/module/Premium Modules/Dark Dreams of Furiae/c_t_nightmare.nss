#include "ddf_util"

int StartingConditional()
{
    int nDay = GetCurrentDay();

    if (nDay == 4 || nDay == 5)
    {
        return TRUE;
    }

    return FALSE;
}
