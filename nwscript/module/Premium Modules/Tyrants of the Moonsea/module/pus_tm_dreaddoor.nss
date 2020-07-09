//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: phb_tm_dreaddoor
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Apply shadow and darkness effects to door.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), OBJECT_SELF);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_DARKNESS), OBJECT_SELF);
}
