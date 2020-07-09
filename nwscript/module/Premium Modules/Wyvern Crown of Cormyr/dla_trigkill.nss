#include "dla_i0_const"

void main()
{
/*
    effect eKill = EffectDamage(500,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWENTY);
    object oEnter = GetEnteringObject();
    if (!GetLocalInt(OBJECT_SELF,"nOff") &&
         GetClassByPosition(1,oEnter)!=CLASS_TYPE_MAGICAL_BEAST)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oEnter);
*/

    SignalEvent(OBJECT_SELF,EventUserDefined(DLA_EVENT_DEATHBEAM_TRIGGER));
}
