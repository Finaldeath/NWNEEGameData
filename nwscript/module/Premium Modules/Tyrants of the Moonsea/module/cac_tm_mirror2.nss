//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_mirror2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Apply visual effect to player and drain some
//       HP.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();

ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);

ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(40, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL), oPC);
}
