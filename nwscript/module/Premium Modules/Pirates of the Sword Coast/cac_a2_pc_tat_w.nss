//::///////////////////////////////////////////////
//:: Act 2: Player chooses 'Umberlee's Waves' tattoo
//:: cac_a2_pc_tat_w.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag the player as having selected the
     'Umberlee's Waves' tattoo.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalString(oPC, "s_a2_pc_tattoo", "a2_tattoo_waves");
}
