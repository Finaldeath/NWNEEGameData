//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ncr_tm_bulette
//::////////////////////////////////////////////////////
//:: Bulette combat round end script
//:: Uses SetObjectVisualTransform() to remove
//:: Z-Offset to unburrow
//::////////////////////////////////////////////////////


void ApplyUnburrowVFX(object oTarget)
{
    effect eRocks = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);
    effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);

    vector vPos = GetPosition(oTarget);

    location lLoc1 = Location(GetArea(oTarget), vPos, 0.0);
    vPos.z += 1.2;
    location lLoc2 = Location(GetArea(oTarget), vPos, 0.0);
    vPos.z += 1.2;
    location lLoc3 = Location(GetArea(oTarget), vPos, 0.0);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, lLoc1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eRocks, lLoc1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eRocks, lLoc2);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eRocks, lLoc3);
}


void DoUnburrow(object oTarget)
{
    if (GetLocalInt(oTarget, "bulette_isburrowed") == 1)
    {
        SetLocalInt(oTarget, "bulette_isburrowed", 0);

        ApplyUnburrowVFX(oTarget);

        SetObjectVisualTransform(oTarget, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 0.0);
    }
}


void main()
{
    if (GetIsInCombat(OBJECT_SELF))
    {
        DoUnburrow(OBJECT_SELF);
    }

    ExecuteScript("x2_def_endcombat", OBJECT_SELF);
}

