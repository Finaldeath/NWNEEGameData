// January 2006
// B W-Husey
// Castle Wyvernwater submerged
// Uses TileMagic to set up the water

#include "x2_inc_toollib"

void main()
{
    object oPC = GetEnteringObject();
    effect eSlow = EffectMovementSpeedDecrease(30);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSlow,oPC);
    if (GetIsPC(oPC) && GetLocalInt(OBJECT_SELF,"nSumer")==0)
    {
    //Tilemagic
    TLResetAreaGroundTiles(GetArea(OBJECT_SELF),6,6);
    TLChangeAreaGroundTiles(GetArea(OBJECT_SELF), X2_TL_GROUNDTILE_WATER,6,6,1.3);
    SetLocalInt(OBJECT_SELF,"nSumer",1);
    }
}
