// player enters the ruins of candlemas

#include "hf_in_plot"
#include "hf_in_spawn"

// spawn a corpse of the given resref at the given waypoint
void spawnCorpse(string sResRef, string sWaypoint)
{
    object oWP = GetWaypointByTag(sWaypoint);
    object oCorpse = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oWP));
    SetPlotFlag(oCorpse, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oCorpse);
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", GetLocation(oWP));
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // sidequest: "Thentia Resistance Army" - the player finds bale's corpse here
        if (PlotLevelGet("Bale") == 4)
        {
            PlotLevelSet("Bale", 5);

            spawnCorpse("bale", "WP_THRC_BALE");
            spawnCorpse("resistancenoble1", "WP_THRC_NOBLE_1");
            spawnCorpse("resistancenoble2", "WP_THRC_NOBLE_2");
            spawnCorpse("resistancenoble3", "WP_THRC_NOBLE_3");
            spawnCorpse("resistancenoble4", "WP_THRC_NOBLE_4");
        }

        // spawn encounters
        SpawnEnter(oPC);

        // run the standard transform script
        ExecuteScript("aen_tm_transform", OBJECT_SELF);
    }
}
