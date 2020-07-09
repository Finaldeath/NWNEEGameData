//Shadovar Assassins start following the PC even if not engagaged with
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        if(PlotLevelGet("ShadovarAssassinKT") == 0)
        {
            PlotLevelSet("ShadovarAssassinKT", 1);
        }
    }
}
