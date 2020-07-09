// B W-Husey
// May 2006
// Make Kathryn actually face her father
#include "x0_i0_position"

void main()
{
    object oKat = GetNearestObjectByTag("Kathryn");
    TurnToFaceObject(oKat,OBJECT_SELF);
}
