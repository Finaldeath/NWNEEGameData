//Valda and Forsaken leave the area
#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 4);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
