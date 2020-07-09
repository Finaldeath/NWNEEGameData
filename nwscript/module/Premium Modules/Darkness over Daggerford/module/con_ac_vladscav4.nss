//::///////////////////////////////////////////////
//:: FileName con_ac_vladscav4
//:: Set completion for Vlad scavenger quest
//:: and take all related items from player
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:32:52 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "ac_vlad_scav_quest", 4);
    object oItem;

    // Loop through inventory to take items
    oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "ac_sheetmusic"
        || GetTag(oItem) == "ac_uthgardttotem"
        || GetTag(oItem) == "ac_chalice")
        {
        DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }
GiveXPToCreature(GetPCSpeaker(),500);

}
