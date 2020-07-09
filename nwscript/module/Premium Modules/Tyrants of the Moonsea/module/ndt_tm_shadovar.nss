// shadovar ninja death effect: shadowy smoke puff

void main()
{
    location lLoc = GetLocation(OBJECT_SELF);
    effect eSmoke = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lLoc);
}
