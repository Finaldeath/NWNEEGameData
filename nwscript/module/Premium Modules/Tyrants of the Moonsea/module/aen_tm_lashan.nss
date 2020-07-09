//Area OnEnter for Lashan's Home

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
         //Spawn Lashan if appropriate
        if(PlotLevelGet("LashanHome") == 1 &&
           GetLocalInt(OBJECT_SELF, "nLashanSpawned") == 0)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "lashanstocks",
                             GetLocation(GetWaypointByTag("WP_Lashan_Home")));
            SetLocalInt(OBJECT_SELF, "nLashanSpawned", 1);
        }
    }
}
