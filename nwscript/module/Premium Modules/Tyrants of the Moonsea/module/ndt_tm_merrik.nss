//Merrik OnDeath
#include "hf_in_plot"

void main()
{
    PlotLevelSet("MerrickDead", 1);
    //Set appropriate variables on Merrik's Zhent Officer wife
    if(PlotLevelGet("IyraurothDead") == 0)
    {
        PlotLevelSet("IyraurothZhentarimOfficer", 3);
    }
    else
    {
        PlotLevelSet("IyraurothZhentarimOfficer", 4);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
