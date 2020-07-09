//::///////////////////////////////////////////////
//:: dla_atgoomgiveh
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
  Charge for the horse being bought and create it
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: April 23, 2006
//:://////////////////////////////////////////////

#include "dla_i0_horse"

void main()
{
    object oPC    = GetPCSpeaker();
    int iHorseVar = GetLocalInt (oPC, "iHorseVar");
    int iBarding  = GetLocalInt (oPC, "iHorseBarding");
    int iTexture  = GetLocalInt (oPC, "iHorseTexture");

    DLA_BuyHorse(iHorseVar, oPC, DLA_HORSE_BARDING_TYPE_4, iTexture, TRUE);

    // Set quest variables (free horse already awarded)
    SetLocalInt(oPC, "nFreeHorse", 2);

    //get rid of the localvars now that we have it.
    DeleteLocalInt(oPC, "iHorseVar");
    DeleteLocalInt(oPC, "iHorseBarding");
    DeleteLocalInt(oPC, "iHorseTexture");

}
