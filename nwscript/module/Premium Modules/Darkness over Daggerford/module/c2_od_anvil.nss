/////////////////////////////////////////
// Place this script on the on damaged event of the anvile to give the effect of sparks

void main()
{
object oTarget = OBJECT_SELF;
effect eVisual = EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL);

ApplyEffectToObject(DURATION_TYPE_INSTANT , eVisual, oTarget);
}
