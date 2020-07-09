// player enters the wagon outside of voonlar

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (PlotLevelGet("MadoctheUncouth") < 4)
        {
            PlotLevelSet("MadoctheUncouth", 4);
        }
    }
}
