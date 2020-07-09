// B W-Husey
// October 2005
// Hawklin's plot variable used in section 1 of the module (see plot variable doc) is set to 3
// The PC has entered the joust and bested 2 enemies.
// This is set in the jousting conversation - NOT IN USE

#include "cu_functions"

void main()
{
//    object oPC = GetPCSpeaker();
    object oPC = GetLastUsedBy();
    AllParty("nHawklinPlot1",oPC,3);
//    AllParty("nQRing",oPC,2);
}
