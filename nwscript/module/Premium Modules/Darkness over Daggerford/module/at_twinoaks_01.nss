// player has touched the twin oaks, said the password, so enter the thicket.

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    // spawn tatham
    if (GetLocalInt(OBJECT_SELF, "nTathamSpawned") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nTathamSpawned", 1);
        object oWP = GetWaypointByTag("WP_AR1400_TATHAM");
        object oTatham = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_gull", GetLocation(oWP));
        SetLocalInt(oTatham, "HF_DISABLE_AM", 1);
        AssignCommand(oTatham, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oTatham)-1), oTatham));
    }

    // enter the grove
    TeleportToWaypoint(oPC, "WP_AR1400_GROVE_ENTER", TRUE);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
