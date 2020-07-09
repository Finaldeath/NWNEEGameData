//::///////////////////////////////////////////////
//:: FileName con_ac_mquest1
//:: Set Maerovyna quest to complete
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 8:08:58 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "ac_miller_quest", 5);
GiveXPToCreature(GetPCSpeaker(),600);
}
