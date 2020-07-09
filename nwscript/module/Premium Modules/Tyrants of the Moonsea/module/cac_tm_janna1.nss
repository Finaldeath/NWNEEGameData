//Baerimel and Jannatha have been met; spawn ogre jailer

#include "hf_in_plot"

void main()
{
    PlotLevelSet("Baerimel", 1);
    PlotLevelSet("Jannatha", 1);

    CreateObject(OBJECT_TYPE_CREATURE, "creature006",
                 GetLocation(GetWaypointByTag("WP_KurTharsuJailer_01")));
}
