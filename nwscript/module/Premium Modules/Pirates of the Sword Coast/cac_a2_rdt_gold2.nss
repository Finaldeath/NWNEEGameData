//::///////////////////////////////////////////////
//:: cac_a2_rdt_gold2
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Redtip gives 100 gold back to the player.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 11/05
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    GiveGoldToCreature(oPC, 100);
}
