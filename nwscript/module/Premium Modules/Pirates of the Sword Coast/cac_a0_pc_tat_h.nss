//::///////////////////////////////////////////////
//:: Act 0: Player chooses 'Heart & Arrow' tattoo
//:: cac_a0_pc_tat_h.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag the player as having selected the 'Heart
     & Arrow' tattoo.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalString(oPC, "s_a0_pc_tattoo", "a0_tattoo_heart");
}
