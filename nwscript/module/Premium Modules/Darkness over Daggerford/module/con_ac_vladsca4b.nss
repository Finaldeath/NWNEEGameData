//::///////////////////////////////////////////////
//:: FileName con_ac_vladscav4
//:: Set completion for Vlad scavenger quest
//::  because player turned it down
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:32:52 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "ac_vlad_scav_quest", 4);
//GiveXPToCreature(GetPCSpeaker(),250);
}
