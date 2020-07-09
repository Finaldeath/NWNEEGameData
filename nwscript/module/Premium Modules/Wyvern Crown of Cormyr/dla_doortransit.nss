// April 2005
// B G P Hughes (B W-Husey)
// Area transition within the same area that takes associates too
// Place on the event AreaTransitionClick event of a door.

#include "cu_functions"

void main()
{
object oPC = GetEnteringObject();
object oTarget = GetTransitionTarget(OBJECT_SELF);
SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
GroupTransition(oPC,oTarget);
}
