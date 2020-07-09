//Area OnEnter for Temple of the Moon

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    //Spawn Jannatha and Baerimel if they have been rescued from Kur-Tharsu
    if(GetIsPC(oPC) && PlotLevelGet("HighPriestessSureene") == 2 &&
       GetLocalInt(OBJECT_SELF, "nSistersSpawned") == 0)
    {
        CreateObject(OBJECT_TYPE_CREATURE, "baerimel",
                     GetLocation(GetWaypointByTag("POST_Baerimel")));

        CreateObject(OBJECT_TYPE_CREATURE, "jannatha",
                     GetLocation(GetWaypointByTag("POST_Jannatha")));

        SetLocalInt(OBJECT_SELF, "nSistersSpawned", 1);
    }
}
