// the beggar heads to the pub

#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
