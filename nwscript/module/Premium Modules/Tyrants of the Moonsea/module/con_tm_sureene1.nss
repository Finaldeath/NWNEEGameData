//return TRUE if Jannatha has not yet been rescued from Kur-Tharsu

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet(GetTag(OBJECT_SELF)) < 2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
