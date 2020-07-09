void main()
{
if (GetLocalInt(OBJECT_SELF,"do_once")==1) return;
SetLocalInt(OBJECT_SELF,"do_once",1);
effect eL = EffectVisualEffect(515);
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eL, OBJECT_SELF));
DelayCommand(4.0,DestroyObject(OBJECT_SELF));
}
