//::///////////////////////////////////////////////
//:: FileName con_ac_morisq6
//:: Set Moris acknowledged completion of quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:08:58 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "moris_quest", 6);
GiveXPToCreature(GetPCSpeaker(),500);
}
