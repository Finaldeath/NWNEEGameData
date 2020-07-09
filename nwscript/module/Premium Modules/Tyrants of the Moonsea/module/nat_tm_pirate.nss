//Pirate on Pirate Ship dies on attack

void main()
{
    effect eBlood = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);

    DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlood, OBJECT_SELF));
    DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF));

    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }
}
