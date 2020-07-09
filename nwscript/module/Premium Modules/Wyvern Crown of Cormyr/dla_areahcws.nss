// August 2005
// B W-Husey
// Castle Wyvernwater sinking effects
// Uses TileMagic to set up the water

#include "x2_inc_toollib"
#include "cu_functions"

//Gale 17 April 2006: Changed water level storage to area object.
//changed calls to tilemagic to use correct area object
//removed switch to turn it on/off
void main()
{
     //Make sure it's a non-DM PC in the area
     object oPC = GetFirstPC();
     while (GetIsObjectValid(oPC))
     {
        if (GetIsDefPC(oPC))
        {
//           //*******debug line************
//           SendMessageToPC(oPC,"Found a PC");
           break;
        }
        oPC = GetNextPC();
     }
//    if (!GetIsObjectValid(oPC)) return; //else quit this script
    if (GetArea(oPC) != OBJECT_SELF) return; //else quit this script

//    if (GetLocalInt(OBJECT_SELF,"nShaker")>0) //switch
    {
        float fWater = GetLocalFloat(OBJECT_SELF,"fHWater");
        //Set max and min water levels
        if (fWater<5.8) fWater=5.8;
        if (fWater>7.0) fWater=7.0;
        //declare variables
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
        effect eSlow = EffectMovementSpeedDecrease(30);
        effect eSlow2 = EffectMovementSpeedDecrease(50);
        float nDelay = Random(3)*0.1;
        object oSound = GetObjectByTag("PlayCrumble");
        //Play some effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eBump,oPC);
        DelayCommand(nDelay,SoundObjectPlay(oSound));
        DelayCommand(nDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eShake,oPC));
        //Apply Tilemagic
        TLResetAreaGroundTiles(OBJECT_SELF,12,8);
        TLChangeAreaGroundTiles(OBJECT_SELF, X2_TL_GROUNDTILE_WATER,12,8,fWater);
        SetLocalFloat(OBJECT_SELF,"fHWater",fWater+0.13);
        //Slow creatures as the water gets higher
        if (fWater>6.2) ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oPC,6.5);
        if (fWater>6.5) ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow2,oPC,6.5);
    }
}




