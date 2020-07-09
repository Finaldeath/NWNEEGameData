
/* Old script - remove
// August 2005
// B W-Husey
// Castle Wyvernwater sinking effects
// Uses TileMagic to set up the water

#include "x2_inc_toollib"

void main()
{
    if (GetArea(GetFirstPC()) != OBJECT_SELF) return;

    if (GetLocalInt(OBJECT_SELF,"nShaker")<1) //switch
    {
    object oPC = GetEnteringObject();
    float fWater = GetLocalFloat(oPC,"fHWater");
    //Set max and min water levels
    if (fWater<5.8) fWater=5.8;
    if (fWater>7.0) fWater=7.0;
    //declare variables
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    effect eSlow = EffectMovementSpeedDecrease(30);
    effect eSlow2 = EffectMovementSpeedDecrease(50);
    float nDelay = Random(3)*0.0;
    object oSound = GetObjectByTag("PlayCrumble");
    //Play some effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eBump,oPC);
    DelayCommand(nDelay,SoundObjectPlay(oSound));
    DelayCommand(nDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eShake,oPC));
    //Apply Tilemagic
    TLResetAreaGroundTiles(GetArea(OBJECT_SELF),12,8);
    TLChangeAreaGroundTiles(GetArea(OBJECT_SELF), X2_TL_GROUNDTILE_WATER,12,8,fWater);
    SetLocalFloat(oPC,"fHWater",fWater+0.13);
    if (fWater>6.2) ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oPC,6.5);
    if (fWater>6.5) ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow2,oPC,6.5);
    }
}




