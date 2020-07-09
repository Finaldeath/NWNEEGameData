// when portal dies...

void main()
{
    location lLoc = GetLocation(OBJECT_SELF);

    effect eEvil = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eSum = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEvil, lLoc);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSum, lLoc);
}
