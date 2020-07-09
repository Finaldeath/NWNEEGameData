//::///////////////////////////////////////////////
//:: Name dla_credwitch1
//:://////////////////////////////////////////////
/*
    Witch Lord deaths have visual effects
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: March 2006
//:://////////////////////////////////////////////

void main()
{
    effect eKill = EffectVisualEffect(496);
    effect eDrain = EffectVisualEffect(VFX_IMP_DEATH);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eKill,OBJECT_SELF);
    DelayCommand(4.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDrain,OBJECT_SELF));
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
