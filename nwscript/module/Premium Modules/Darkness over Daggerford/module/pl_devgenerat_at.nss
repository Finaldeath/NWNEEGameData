// player has attacked the mephit generator in Edalseye's tower
// .. show some VFX since the generator is protected by a force field

void main()
{
    effect eVis = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
}
