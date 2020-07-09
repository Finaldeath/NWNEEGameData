#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    string sTag = GetTag(OBJECT_SELF);
    PlotLevelSet(sTag, 1);
    CreateItemOnObject("nw_it_mring031", oPC, 1);
}
