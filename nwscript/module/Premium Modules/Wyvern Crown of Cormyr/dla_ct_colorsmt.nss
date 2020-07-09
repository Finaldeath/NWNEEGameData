// dla_ct_colorsmt - Speaker is mounted on a warhorse returns true.
// By Deva B. Winblood  6/30/2006
#include "dla_i0_horse"


int StartingConditional()
{
    object oPC=GetPCSpeaker();
    object oHorse=GetLocalObject(oPC,"oDLAMyMount");
    if (DLA_GetIsMounted(oPC)&&DLA_GetIsWarhorse(oHorse)) return TRUE;
    return FALSE;
}
