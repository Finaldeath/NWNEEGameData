//::///////////////////////////////////////////////
//:: FileName con_ac_takeroosk
//:: Blanche takes Roo's skin from player
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 8:33:56 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ac_itm_rooskin");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
GiveXPToCreature(GetPCSpeaker(),350);
}
