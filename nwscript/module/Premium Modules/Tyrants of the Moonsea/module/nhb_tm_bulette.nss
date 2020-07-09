//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: nsp_tm_bulette
//::////////////////////////////////////////////////////
//:: Bulette Heartbeat script
//:: Uses SetObjectVisualTransform() to remove
//:: Z-Offset to unburrow
//::////////////////////////////////////////////////////


const float Z_OFFSET = -2.65f;


int GetIsPCNearby(object oTarget, float fDistance = 20.0f)
{
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);
    if (GetIsObjectValid(oPC))
        return (GetDistanceBetween(oTarget, oPC) <= fDistance);
    return FALSE;
}


void ApplyBurrowVFX(object oTarget)
{
    effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);

    location lTarget = GetLocation(oTarget);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, lTarget);
}


void DoBurrow(object oTarget)
{
    if (GetLocalInt(oTarget, "bulette_isburrowed") == 0)
    {
        SetLocalInt(oTarget, "bulette_isburrowed", 1);

        ApplyBurrowVFX(oTarget);

        SetObjectVisualTransform(oTarget, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, Z_OFFSET);
    }
}


void main()
{
    if (!GetIsPCNearby(OBJECT_SELF))
    {
        DoBurrow(OBJECT_SELF);
    }

    ExecuteScript("x2_def_heartbeat", OBJECT_SELF);
}
