//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: phb_tm_portal
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Portal glows ghostly white.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT), OBJECT_SELF, 6.0);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_WHITE), OBJECT_SELF, 6.0);
}
