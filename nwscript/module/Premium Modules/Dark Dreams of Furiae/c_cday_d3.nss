#include "ddf_util"

int StartingConditional()
{
    int nDay = GetCurrentDay();

    if (nDay == 3)
    {
        return TRUE;
    }
    return FALSE;
}
