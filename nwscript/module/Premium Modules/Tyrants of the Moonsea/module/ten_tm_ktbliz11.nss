//Elf and Blizzard will start following PC if present but not initially conversed with

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && PlotLevelGet("Blizzard") == 10)
    {
        PlotLevelSet("Blizzard", 11);
    }

    if(GetIsPC(oPC) && PlotLevelGet("Elf") == 15)
    {
        PlotLevelSet("Elf", 16);
    }
}
