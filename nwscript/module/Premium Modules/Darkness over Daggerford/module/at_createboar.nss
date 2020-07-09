#include "hf_in_plot"

void main()
{
    PlotLevelSet("pm_Maerovyna", 4);
    PlotLevelSet("ac_farmersam", 1);
    PlotLevelSet("ac_farmerjoe", 1);
    SetLocalInt(GetModule(), "iShownMaerovynaNote", 1);
    CreateObject(OBJECT_TYPE_CREATURE, "rb_deadboar",
                 GetLocation(GetWaypointByTag("WP_DEAD_BOAR")));
}
