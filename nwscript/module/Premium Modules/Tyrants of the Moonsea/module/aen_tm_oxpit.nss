// area enter script for the oxpit tavern in mulmaster

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (PlotLevelGet("GreedyBeggar") == 1)
        {
            PlotLevelSet("GreedyBeggar", 2);
            object oWP = GetWaypointByTag("WP_MUOX_BEGGAR");
            CreateObject(OBJECT_TYPE_CREATURE, "greedybeggar", GetLocation(oWP));
        }
    }
}
