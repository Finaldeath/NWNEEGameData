// December 2005
// B W-Husey
// Generic conditional. PC can NOT afford selected horse
#include "dla_i0_horse"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
      int iHorseVar = GetLocalInt(GetPCSpeaker(), "iHorseVar");
      int iPrice = DLA_GetHorsePrice(iHorseVar);

    // Make sure the PC speaker has these items in their inventory
    if(GetGold(oPC) < iPrice)
        return TRUE;

    return FALSE;
}
