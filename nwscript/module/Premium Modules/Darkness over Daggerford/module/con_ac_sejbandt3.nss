//::///////////////////////////////////////////////
//:: FileName con_ac_sejbandt3
//:: Set player to have collected reward from Sejellus.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/31/2005 4:47:28 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "ac_sej_bandit", 3);
GiveXPToCreature(GetPCSpeaker(),100);
}
