// julap summons the guests to his party

#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 2);

    object oWP;
    effect eVfx = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);

    oWP = GetWaypointByTag("WP_AR1107_JESUP");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_jesup", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));

    oWP = GetWaypointByTag("WP_AR1107_ALIEL");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_aliel", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));

    oWP = GetWaypointByTag("WP_AR1107_TOGRUNK");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_togrunk", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));

    oWP = GetWaypointByTag("WP_AR1107_BAERWYN");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_baerwyn", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));

    oWP = GetWaypointByTag("WP_AR1107_GERGRICK");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_gergrick", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));

    oWP = GetWaypointByTag("WP_AR1107_ELWRYN");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_elwryn", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));

    oWP = GetWaypointByTag("WP_AR1107_MINEDI");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_minedi", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));

    oWP = GetWaypointByTag("WP_AR1107_BAPPI");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_bappi", GetLocation(oWP));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oWP));
}
