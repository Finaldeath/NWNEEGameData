// player sends "rex" back home

#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 4);
    PlotLevelSet("HighArtificerHlessen", 6);
    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "WP_THKTMG_REX_EXIT");
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
