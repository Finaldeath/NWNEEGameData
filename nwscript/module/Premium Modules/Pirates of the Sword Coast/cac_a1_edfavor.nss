//::///////////////////////////////////////////////
//:: Act 1: Player Obtains Favor from Edgrimm
//:: cac_a1_edfavor.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     The player has successfully bartered for
     better prices from Edgrimm's store.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 6, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "A1_EDGRIMMFAVOR", TRUE);
}
