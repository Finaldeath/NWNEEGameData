#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_berry_1", oPC, 1);

    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 1);
}
