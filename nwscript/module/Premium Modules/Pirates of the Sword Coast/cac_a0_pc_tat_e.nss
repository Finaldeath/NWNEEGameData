//::///////////////////////////////////////////////
//:: Act 0: Player chooses 'Eye & Tears' tattoo
//:: cac_a0_pc_tat_e.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag the player as having selected the 'Eye
     & Tears' tattoo.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalString(oPC, "s_a0_pc_tattoo", "a0_tattoo_eye");
}
