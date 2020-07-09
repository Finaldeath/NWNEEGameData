// B W-Husey
// September 2005
// Transition script for doors with multiple transitions - use in conversation.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetObjectByTag("CWDoorTransitS");
    GroupTransition(oPC,oTarget);
}
