void explode(object oSelf)
{
    // explode
    location lSelf = GetLocation(oSelf);
    if(GetLocalInt(GetModule(), "iDisableOilBarrels") == 0)
    {
        SignalEvent(GetArea(OBJECT_SELF), EventUserDefined(1));
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), lSelf);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE), lSelf);
    object oFire = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lSelf, FALSE, "_ar2001_fire");
    SetPlotFlag(oFire, TRUE);
    object oSmoke = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", lSelf);
    SetPlotFlag(oSmoke, TRUE);

    // damage all nearby objects
    object o = GetFirstObjectInShape(SHAPE_SPHERE, 2.0, lSelf, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(o))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6(), DAMAGE_TYPE_FIRE), o);
        o = GetNextObjectInShape(SHAPE_SPHERE, 2.0, lSelf, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

    // activate nearby "fire" trigger
    object oFireTrigger = GetNearestObjectByTag("ks_trg_fire", OBJECT_SELF);
    if (GetIsObjectValid(oFireTrigger))
    {
        SetLocalInt(oFireTrigger, "nActive", 1);
    }

    // change fog to make smoke
    object oArea = GetArea(oSelf);
    SetFogColor(FOG_TYPE_ALL, FOG_COLOR_BLACK, oArea);
    SetFogAmount(FOG_TYPE_ALL, 15, oArea);
}

void main()
{
    object oSelf = OBJECT_SELF;
    location lSelf = GetLocation(oSelf);

    int nDmg = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
    if (nDmg > 0)
    {
        explode(oSelf);
    }
    else
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE), lSelf);
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_weathmark", lSelf);
    }
}
