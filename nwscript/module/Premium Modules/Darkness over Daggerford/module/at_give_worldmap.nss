#include "hf_in_xp"
void main()
{
    object oPC = GetPCSpeaker();
    //give the player the inventory version of the world map
    //COMMENTED OUT AS WE DO NOT HAVE PATCH FUNCTIONALITY YET
    //CreateItemOnObject("bw_inv_map", oPC, 1);
    //now give the player LOTS of xp for completing the Daggerford quests
    GiveQuestXPToCreature(oPC, "j201", 100.0);
}
