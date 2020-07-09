// gorlax the many eyed: sparrow tells the player to meet in front of the orphanage

#include "hf_in_plot"

void main()
{
    PlotLevelSet("Sparrow", 3);
    object oWP = GetWaypointByTag("WP_ZKEP_ZKAO_SPARROW");
    CreateObject(OBJECT_TYPE_CREATURE, GetResRef(OBJECT_SELF), GetLocation(oWP));
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
