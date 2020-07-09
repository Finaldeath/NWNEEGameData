// Tiggers harmless rockfall.

void main()
{
    effect eDust = EffectVisualEffect(353);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDust,GetEnteringObject());
}
