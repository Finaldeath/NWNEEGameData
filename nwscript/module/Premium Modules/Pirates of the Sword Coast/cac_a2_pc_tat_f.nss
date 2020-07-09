//::///////////////////////////////////////////////
//:: Act 2: Player chooses 'Flaming Skull' tattoo
//:: cac_a2_pc_tat_f.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag the player as having selected the 'Flaming
     Skull' tattoo.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalString(oPC, "s_a2_pc_tattoo", "a2_tattoo_flame");
}
