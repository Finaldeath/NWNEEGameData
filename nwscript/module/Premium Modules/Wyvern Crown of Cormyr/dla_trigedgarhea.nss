//March 2006
// B W-Husey
// Injures Edgar and sets him to start recovering (for look only)
#include "cu_functions"
void main()
{
    effect eDam = EffectDamage(10);
    effect eReg = EffectRegenerate(1,20.0);
    object oEdgar = GetNearestObjectByTag("Edgar");
    if (GetIsDefPC(GetEnteringObject()))
    {
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oEdgar);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eReg,oEdgar,200.0);
    DestroyObject(OBJECT_SELF);
    }
}
