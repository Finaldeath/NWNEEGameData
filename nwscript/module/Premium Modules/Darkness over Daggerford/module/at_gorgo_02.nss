void main()
{
    object oOrc = GetNearestObjectByTag("ks_lair_general", OBJECT_SELF);
    location lLoc = GetLocation(oOrc);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), OBJECT_SELF);
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2);
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE), oOrc));
    DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_FIRE), oOrc));
    DelayCommand(0.3, AssignCommand(GetModule(), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), oOrc)));
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", lLoc);
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamesmall", lLoc);
}
