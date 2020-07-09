// area enter script for zhentil keep warzone

#include "hf_in_plot"
#include "hf_in_spawn"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        // automatically explore this urban area
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);

            //Create some walls of fire throughout the city
            AssignCommand(GetObjectByTag("KTWZFireball"),
                ApplyEffectAtLocation(DURATION_TYPE_PERMANENT,
                                      EffectAreaOfEffect(AOE_PER_WALLFIRE),
                                      GetLocation(GetWaypointByTag("WP_ZK2_WALLOFFIRE"))));
            AssignCommand(GetObjectByTag("KTWZFireball"),
                ApplyEffectAtLocation(DURATION_TYPE_PERMANENT,
                                      EffectAreaOfEffect(AOE_PER_WALLFIRE),
                                      GetLocation(GetWaypointByTag("WP_ZK2_WALLOFFIRE2"))));
            AssignCommand(GetObjectByTag("KTWZFireball"),
                ApplyEffectAtLocation(DURATION_TYPE_PERMANENT,
                                      EffectAreaOfEffect(AOE_PER_WALLFIRE),
                                      GetLocation(GetWaypointByTag("WP_ZK2_WALLOFFIRE3"))));

            //Spawn encounters
            SpawnEnter(oPC);

            SetLocalInt(OBJECT_SELF, "nEntered", 1);
        }

        //Switch on visual effects around the city
        if(PlotLevelGet("ZKWarVFX") == 0)
        {
            PlotLevelSet("ZKWarVFX", 1);
            ExecuteScript("exe_tm_zkwarvfx", OBJECT_SELF);
        }

        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 18)
            PlotLevelSet(PLOT_HENCH_DIALOG, 18);
    }
}
