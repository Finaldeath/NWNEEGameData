// reveal trap door behind altar

#include "hf_in_plot"

void main()
{
    PlotLevelSet("ks_bhaal_altar", 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
}
