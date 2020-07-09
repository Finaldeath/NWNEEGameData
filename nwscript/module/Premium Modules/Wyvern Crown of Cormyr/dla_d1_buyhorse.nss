//::///////////////////////////////////////////////
//:: dla_d1_buyhorse
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
  Charge for the horse being bought and create it
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: June 10, 2005
//:: Updated By: DirgeSinger
//:: Updated On: June 17, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"

void main()
{
    object oPC = GetPCSpeaker();
    int iHorseVar = GetLocalInt (oPC, "iHorseVar");
    int iBarding  = GetLocalInt (oPC, "iHorseBarding");
    int iTexture  = GetLocalInt (oPC, "iHorseTexture");

    DLA_BuyHorse(iHorseVar, oPC, iBarding, iTexture);

    //get rid of the localvars now that we have it.
//    DeleteLocalInt(oPC, "iHorseVar");
//    DeleteLocalInt(oPC, "iHorseBarding");
//    DeleteLocalInt(oPC, "iHorseTexture");

}
