//January 2006
// B W-Husey
// Opening the door removes the beam effects
#include "x0_i0_petrify"
void main()
{
        object oDoor1 =  OBJECT_SELF;
        object oRelay = GetObjectByTag("CWBRelay");
        object oTarget1 = GetObjectByTag("CWBTarget1");

        //First, remove all effects
        RemoveEffectOfType(oTarget1,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oDoor1,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oRelay,EFFECT_TYPE_BEAM);
}
