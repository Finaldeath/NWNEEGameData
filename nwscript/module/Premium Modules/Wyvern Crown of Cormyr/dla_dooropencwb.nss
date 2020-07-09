//January 2006
// B W-Husey
// Opening the door removes the beam effects
#include "x0_i0_petrify"
void main()
{
        object oDoor1 =  GetObjectByTag("CWBDoorPuzzle2");//Note this is reversed
        object oDoor2 =  GetObjectByTag("CWBDoorPuzzle1");
        object oRelay = GetObjectByTag("CWBRelay");
        object oTarget1 = GetObjectByTag("CWBTarget1");
        object oTarget2 = GetObjectByTag("CWBTarget2");

        //First, remove all effects
        RemoveEffectOfType(oTarget1,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oTarget2,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oDoor1,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oDoor2,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oRelay,EFFECT_TYPE_BEAM);
}
