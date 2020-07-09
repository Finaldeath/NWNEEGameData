// B W-Husey
// September 2005
// Transition script for doors with multiple transitions - use in conversation.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetObjectByTag("PFEastTowerNorth");
//    SendMessageToPC(oPC,"I did execute this script");
    GroupTransition(oPC,oTarget);
}
