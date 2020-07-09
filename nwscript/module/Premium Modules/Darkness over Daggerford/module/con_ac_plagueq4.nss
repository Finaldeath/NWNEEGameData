//::///////////////////////////////////////////////
//:: FileName con_ac_plagueq4
//:: Set plague to completed and acknowledged by Liam and give reward
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:50:50 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "ac_plague_quest", 4);
    // Give the speaker the items
    CreateItemOnObject("ac_favorlathand", GetPCSpeaker(), 1);
GiveXPToCreature(GetPCSpeaker(),750);
}
