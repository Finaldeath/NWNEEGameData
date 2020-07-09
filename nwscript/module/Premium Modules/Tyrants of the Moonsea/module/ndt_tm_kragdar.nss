//Kragdar OnDeath script - set NPC Plot variables

#include "hf_in_plot"

void main()
{
    if(PlotLevelGet("Blizzard") >= 10 && PlotLevelGet("Blizzard") < 15)
    {
        PlotLevelSet("Blizzard", 15);
    }

    if(PlotLevelGet("Elf") >= 15 && PlotLevelGet("Elf") < 19)
    {
        PlotLevelSet("Elf", 19);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
