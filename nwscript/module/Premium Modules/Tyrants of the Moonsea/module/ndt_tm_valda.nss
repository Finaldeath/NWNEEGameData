//Indicate Valda is dead triggering Forsaken to exit area

#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 3);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
