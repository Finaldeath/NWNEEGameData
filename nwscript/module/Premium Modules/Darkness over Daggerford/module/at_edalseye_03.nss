// remove edalseye's "silver eyes" effect

void RemoveAllEffects(object o)
{
    effect e = GetFirstEffect(o);
    while (GetIsEffectValid(e))
    {
        RemoveEffect(o, e);
        e = GetNextEffect(o);
    }
}

void main()
{
    RemoveAllEffects(OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), OBJECT_SELF);
}
