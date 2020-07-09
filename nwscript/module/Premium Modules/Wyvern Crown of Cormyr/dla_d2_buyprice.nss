//::///////////////////////////////////////////////
//:: dla_d2_buyprice
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
  Sets a custom token with the price of the horse being bought
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: June 10, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"

int StartingConditional()
{
  int iHorseVar = GetLocalInt(GetPCSpeaker(), "iHorseVar");
  int iPrice = DLA_GetHorsePrice(iHorseVar);

  string sPrice = iPrice ? IntToString(iPrice)+" gp" : "free";

  SetCustomToken (DLA_CONVERSATION_CUSTOM_TOKEN1, sPrice);
  return TRUE;
}
