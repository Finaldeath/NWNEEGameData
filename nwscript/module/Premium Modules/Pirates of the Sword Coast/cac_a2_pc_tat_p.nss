//::///////////////////////////////////////////////
//:: Act 2: Player chooses 'Skull & Crossbones' tattoo
//:: cac_a2_pc_tat_p.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag the player as having selected the 'Skull
     & Crossbones' tattoo.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalString(oPC, "s_a2_pc_tattoo", "a2_tattoo_pirate");
}
