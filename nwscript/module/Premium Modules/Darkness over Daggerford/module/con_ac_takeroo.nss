//::///////////////////////////////////////////////
//:: FileName con_ac_takeroo
//:: Blanche takes Roo (Rat in a Sack) from player
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 8:33:56 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ac_ratinsack");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
GiveXPToCreature(GetPCSpeaker(),350);
}
