// player has solved julap's first riddle
// .. baerwyn must vanish

#include "hf_in_plot"

void Banish(object o)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), GetLocation(o));
    DestroyObject(o);
}

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    SetLocalInt(oArea, "nJulapRiddleNumber", 2);
    PlotLevelSet(GetTag(OBJECT_SELF), 4);

    object o = GetNearestObjectByTag("ks_baerwyn", oPC);
    Banish(o);
}
