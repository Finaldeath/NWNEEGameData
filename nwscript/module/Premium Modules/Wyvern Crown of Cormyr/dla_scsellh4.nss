////////////////////////////////////////////////////////////////////////////////
// dla_scsellh4 - This makes sure the PC does not try to sell a paladin mount
// Scripted By: Deva B. Winblood   8/5/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"


int StartingConditional()
{
    object oHorse=GetLocalObject(OBJECT_SELF,"oInterested");
    if (DLA_GetIsPaladinMount(oHorse)) return TRUE;
    return FALSE;
}
