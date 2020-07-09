// player gets second reward (tanaruk body) from Redeye.

#include "x0_i0_position"

void main()
{
    object oPC = GetPCSpeaker();
    object oChest = GetNearestObjectByTag("ks_redeye_body", oPC);
    if (!GetIsObjectValid(oChest))
    {
        PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.0);
        location lLoc = GetStepRightLocation(OBJECT_SELF);
        CreateObject(OBJECT_TYPE_PLACEABLE, "ks_redeye_body", lLoc);
    }
}
