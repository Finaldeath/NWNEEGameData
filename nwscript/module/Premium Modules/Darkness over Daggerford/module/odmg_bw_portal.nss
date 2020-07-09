// on damage

void main()
{
    effect ePulse = EffectVisualEffect(VFX_IMP_PULSE_FIRE);

    DelayCommand(0.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, OBJECT_SELF));
}
