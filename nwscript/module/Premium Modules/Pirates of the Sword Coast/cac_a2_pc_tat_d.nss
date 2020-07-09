//::///////////////////////////////////////////////
//:: Act 2: Player chooses 'Copper Dragon' tattoo
//:: cac_a2_pc_tat_d.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag the player as having selected the 'Copper
     Dragon' tattoo.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalString(oPC, "s_a2_pc_tattoo", "a2_tattoo_dragon");
}
