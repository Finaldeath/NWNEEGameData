#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 9);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
