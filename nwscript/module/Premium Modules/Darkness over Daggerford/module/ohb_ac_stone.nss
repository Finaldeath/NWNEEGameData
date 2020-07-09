void main()
{
if (GetLocalInt(OBJECT_SELF,"do_once")==1) return;
SetLocalInt(OBJECT_SELF,"do_once",1);
effect eL = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eL, OBJECT_SELF);
}
