// B W-Husey
// November 2005
// Transition script for secret statue.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetObjectByTag("TP_SecretStat");
//    SendMessageToPC(oPC,"I did execute this script");
    AssignCommand(oPC,ActionJumpToObject(oTarget));
}
