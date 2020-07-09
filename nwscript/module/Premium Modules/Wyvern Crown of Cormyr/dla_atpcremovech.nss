//::///////////////////////////////////////////////
//:: FileName dla_atpcremovech
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 07/01/2006 16:54:07
//:://////////////////////////////////////////////
void main()
{
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "MerchantsChart");
    if(GetIsObjectValid(oItemToTake))
        DestroyObject(oItemToTake);
}
