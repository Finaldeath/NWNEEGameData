// dla_trigmarshout
// May 2006
// B W-Husey
// Leaving marsh area, remove slowness.
#include "x0_i0_petrify"

void main()
{
    RemoveEffectOfType(GetExitingObject(),EFFECT_TYPE_MOVEMENT_SPEED_DECREASE);
}
