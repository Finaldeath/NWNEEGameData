//Fire a pirate catapult at a random ship location
#include "hf_in_plot"
#include "inc_ktgate"

void main()
{
    if(PlotLevelGet("Kramer") == 1)
    {
        int nSpell = SPELLABILITY_BOLT_FIRE;
        location lMiss = GetRandomMissLocation(
                            GetNearestObjectByTag("WP_MOBT_PIRATE_CATAPULT", OBJECT_SELF, d3()));
        effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);

        ActionCastFakeSpellAtLocation(nSpell, lMiss, PROJECTILE_PATH_TYPE_BALLISTIC);

        float fDist = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), lMiss);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);

        DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMiss));
    }
}
