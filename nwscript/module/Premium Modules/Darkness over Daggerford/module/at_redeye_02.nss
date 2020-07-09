// player gets first reward (chest of misc. items) from Redeye.

#include "x0_i0_position"

location GetStepLeftBackLocation(object oTarget)
{
    float fDir = GetFacing(oTarget);
    float fAngle = GetLeftDirection(fDir);
    return GenerateNewLocation(oTarget, DISTANCE_TINY, fAngle, GetOppositeDirection(fDir));
}

void main()
{
    object oPC = GetPCSpeaker();
    object oChest = GetNearestObjectByTag("ks_redeye_chest", oPC);
    if (!GetIsObjectValid(oChest))
    {
        PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.0);
        location lLoc = GetStepLeftBackLocation(OBJECT_SELF);
        CreateObject(OBJECT_TYPE_PLACEABLE, "ks_redeye_chest", lLoc);
    }
}
