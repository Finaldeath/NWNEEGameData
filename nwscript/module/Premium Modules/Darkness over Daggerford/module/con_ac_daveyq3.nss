//::///////////////////////////////////////////////
//:: FileName con_ac_daveyq3
//:: Set Davey quest to complete
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 2:16:59 PM
//:://////////////////////////////////////////////
void main()
{
// Set the variables
SetLocalInt(GetPCSpeaker(), "ac_davey_quest", 3);
GiveXPToCreature(GetPCSpeaker(),500);
}
