//::///////////////////////////////////////////////
//:: FileName at_ericthefin
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 15/11/2005 12:53:36
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "a2_pm_impchest");
    if(GetIsObjectValid(oItemToTake) != 0)
        ActionTakeItem(oItemToTake, GetPCSpeaker());
    SetLocalInt(GetModule(), "nGaveChestToErik", 1);
}
