// the player has solved julap's second riddle
// .. gergrick and aliel must vanish

#include "hf_in_plot"

void Banish(object o)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), GetLocation(o));
    DestroyObject(o);
}

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(GetPCSpeaker());

    SetLocalInt(oArea, "nJulapRiddleNumber", 3);
    PlotLevelSet(GetTag(OBJECT_SELF), 5);

    object o = GetNearestObjectByTag("ks_gergrick", oPC);
    Banish(o);
    o = GetNearestObjectByTag("ks_aliel", oPC);
    Banish(o);
}
