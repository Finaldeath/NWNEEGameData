// dla_scall2hench
// B W-Husey
// May 12th 2006
// Checks to see if the PC has the max number of henchmen allowed ( currently 2) already.
// This can be changed on dla_i0_switches

#include "cu_functions"
#include "dla_i0_switches"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return GetIsObjectValid(ReturnHenchman(oPC,DLA_MAX_NPC_HENCHMEN));
}
