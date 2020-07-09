/*
    DLA_ATMEL20GP.nss
    gaoneng erick            June 24, 2006

    give gold to pc
*/

void main()
{
    object oPC = GetPCSpeaker();
//    DeleteLocalInt(pc, GN_OUTCOME);
    GiveGoldToCreature(oPC, 20);
}

/*
// January 2006
// B W-Husey
// Generic script gives 20 gold.

#include "dla_mel_inc"
void main()
{
      object oPC = GetPCSpeaker();
      DeleteLocalInt(oPC, "nLastManStand");
    GiveGoldToCreature(oPC,20);
}
