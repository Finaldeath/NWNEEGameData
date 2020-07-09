#include "x2_inc_cutscene"
void main()
{
    object oPC = GetFirstPC();
    object oOpp = GetLocalObject(oPC,"oMyPreviousDartOpponent");
    effect eGhost = GetFirstEffect(oOpp);
    while(GetIsEffectValid(eGhost))
    {
        if(GetEffectType(eGhost)==EFFECT_TYPE_CUTSCENEGHOST)
        {
            RemoveEffect(oOpp,eGhost);
        }
        eGhost = GetNextEffect(oOpp);
    }
    CutSetCamera(0.0f,oPC,CAMERA_MODE_TOP_DOWN,135.0,10.0f,50.0f,0);
}
