// December 2005
// B G P Hughes (B W-Husey)
// Area transition within the same area that takes associates too
// Place on the event AreaTransitionClick event of a door.
// Move the camera so the gatehouse is not in the way.

#include "cu_functions"
#include "cu_cameras"

void main()
{
object oPC = GetEnteringObject();
object oTarget = GetTransitionTarget(OBJECT_SELF);
SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
//AssignCommand(oPC,ClearAllActions());
GroupTransition(oPC,oTarget);
DelayCommand(0.5,WCCameraMove(0.0,270.0,30.0,50.0,125.0,30.0,50.0,3.0,60.0,oPC,1));
}
