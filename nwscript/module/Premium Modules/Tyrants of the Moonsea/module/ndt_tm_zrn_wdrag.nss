//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_zrn_wdrag
//::////////////////////////////////////////////////////
//:: Zhentil Keep: Ancient White Dragon encounter
//:: Makes sure this only triggers once
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    PlotLevelSet("zhentrn_enc_wdrag_done", 1);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
