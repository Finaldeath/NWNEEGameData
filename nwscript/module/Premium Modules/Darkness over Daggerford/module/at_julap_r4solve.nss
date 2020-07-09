// the player has solved julap's fourth riddle
// .. Togrunk must vanish

#include "hf_in_plot"

void Banish(object o)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), GetLocation(o));
    DestroyObject(o);
}

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(GetTag(OBJECT_SELF), 7);

    object o = GetNearestObjectByTag("ks_togrunk", oPC);
    Banish(o);
}
