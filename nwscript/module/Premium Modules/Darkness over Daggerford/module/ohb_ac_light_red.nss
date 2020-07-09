void main()
{
if (GetLocalInt(OBJECT_SELF,"do_once")==1) return;
SetLocalInt(OBJECT_SELF,"do_once",1);
effect eL = EffectVisualEffect(VFX_DUR_LIGHT_RED_5);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eL, OBJECT_SELF);
}
