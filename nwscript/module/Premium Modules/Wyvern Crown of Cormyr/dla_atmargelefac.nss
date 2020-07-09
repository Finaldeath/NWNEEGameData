// B W-Husey
// May 2006
// Make Eleanor actually face her mother
#include "x0_i0_position"

void main()
{
    object oEleanor = GetNearestObjectByTag("Eleanor");
    TurnToFaceObject(oEleanor,OBJECT_SELF);
}
