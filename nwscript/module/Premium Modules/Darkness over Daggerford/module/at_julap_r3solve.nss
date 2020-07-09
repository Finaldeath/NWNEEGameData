// player has solved julap's third riddle
// .. Jesup, Elwryn, and Bappi must vanish

#include "hf_in_plot"

void Banish(object o)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), GetLocation(o));
    DestroyObject(o);
}

void main()
{
    object oArea = GetArea(GetPCSpeaker());
    object oPC = GetPCSpeaker();

    SetLocalInt(oArea, "nJulapRiddleNumber", 4);
    PlotLevelSet(GetTag(OBJECT_SELF), 6);

    object o = GetNearestObjectByTag("ks_jesup", oPC);
    Banish(o);
    o = GetNearestObjectByTag("ks_elwryn", oPC);
    Banish(o);
    o = GetNearestObjectByTag("ks_bappi", oPC);
    Banish(o);
}
