//January 2006
// B W-Husey
// Opening the door removes the beam effects
#include "x0_i0_petrify"
void main()
{
        object oDoor1 =  OBJECT_SELF;
        object oTarget2 = GetObjectByTag("CWBTarget2");

        //First, remove all effects
        RemoveEffectOfType(oTarget2,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oDoor1,EFFECT_TYPE_BEAM);
}
