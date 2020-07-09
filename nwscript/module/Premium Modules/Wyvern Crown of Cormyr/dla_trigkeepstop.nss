// January 2006
// B W-Husey
// This trigger is to stop the keeper running onto a trap.
#include "x0_i0_anims"
void main()
{
    object oEnter = GetEnteringObject();
    if (GetTag(oEnter)=="Keeper")
    {
       AssignCommand(oEnter,ClearAllActions());
       WalkWayPoints();
    }
}
