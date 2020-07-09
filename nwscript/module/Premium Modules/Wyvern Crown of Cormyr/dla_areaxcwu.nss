// January 2006
// B W-Husey
// Leaving underwater area.
#include "x0_i0_petrify"

void main()
{

     object oPC = GetExitingObject();
     int nType, nSubtype;

    SetLocalInt(OBJECT_SELF,"nDrownArea",0); //switch off area heartbeat
    RemoveEffectOfType(oPC,EFFECT_TYPE_MOVEMENT_SPEED_DECREASE);
    //Find and remove the bubble effect
     effect eEffect = GetFirstEffect(oPC);
     while(GetIsEffectValid(eEffect))
     {
         nType = GetEffectType(eEffect);
         nSubtype = GetEffectSubType(eEffect);
         if(nType == EFFECT_TYPE_VISUALEFFECT && nSubtype == SUBTYPE_SUPERNATURAL)
         {
             RemoveEffect(oPC, eEffect);
         }
         eEffect = GetNextEffect(oPC);
     }
}


