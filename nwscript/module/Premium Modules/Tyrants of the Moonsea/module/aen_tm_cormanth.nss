// on enter event for cormanthor forest

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // secrets: the bird dies if you abandon it in the hunter's trap
        if (PlotLevelGet("pl_secret_hunter") == 1)
        {
            PlotLevelSet("pl_secret_hunter", 3);
        }
    }
}
