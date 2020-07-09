// secret: genie vanishes

void main()
{
    location lLoc = GetLocation(OBJECT_SELF);
    effect eSmoke = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lLoc);
    DestroyObject(OBJECT_SELF);
}
