// skully opens the portal back from the roof

void main()
{
    object oPC = GetFirstPC();

    // create the portal from the roof to the bedroom
    location lLoc = GetLocation(OBJECT_SELF);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", lLoc);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
    SetLocalString(oPortal, "DESTINATION_DOWN", "WP_AR1108_MIRROR_EXIT");
    AssignCommand(oPC, PlaySound("sim_shwngodd1"));

    // create the portal from the bedroom to the basement
    object oWP = GetWaypointByTag("WP_AR1108_PORTAL2");
    lLoc = GetLocation(oWP);
    object oPortal2 = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", lLoc);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
    SetLocalString(oPortal2, "DESTINATION_DOWN", "WP_AR1109_PORTAL_EXIT");

    // the voice goes away now
    DestroyObject(OBJECT_SELF);
}
