//Teleport Orcus next to Maganus
void main()
{
    object oOrcus = GetNearestObjectByTag("OrcusDemonPrinceoftheUndead");
    effect eVFX = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE );
    location lOrcus = GetLocation(GetWaypointByTag("WP_THKTUF_ORCUS_JUMP"));

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lOrcus);
    AssignCommand(oOrcus, JumpToLocation(lOrcus));
}
