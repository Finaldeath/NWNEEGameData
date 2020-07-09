#include "ddf_util"

int StartingConditional()
{
    int nDay = GetCurrentDay();

    if (nDay == 4)
    {
        return TRUE;
    }
    return FALSE;
}
