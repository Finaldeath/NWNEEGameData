//::///////////////////////////////////////////////
//:: dla_x0_inventory
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Takes all equiped items away from henchman
    and puts them in the container.
    Made based on x0_i0_henchman with slight modifications
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 5 Feb 2006
//:://////////////////////////////////////////////

#include "nw_i0_generic"

// * will attempt to equip the specific item
// * in one of its misc slots
void AttemptToEquipItem(object oItem, object oHench)
{
    int nBaseType = GetBaseItemType(oItem);
    int nSlot = -99;

    switch (nBaseType)
    {
        case BASE_ITEM_BRACER: nSlot = INVENTORY_SLOT_ARMS; break;
        case BASE_ITEM_AMULET: nSlot = INVENTORY_SLOT_NECK; break;
        case BASE_ITEM_RING: nSlot = INVENTORY_SLOT_RIGHTRING; break;
        case BASE_ITEM_BELT: nSlot = INVENTORY_SLOT_BELT; break;
        case BASE_ITEM_BOOTS: nSlot = INVENTORY_SLOT_BOOTS; break;
        case BASE_ITEM_CLOAK: nSlot = INVENTORY_SLOT_CLOAK; break;
        case BASE_ITEM_HELMET: nSlot = INVENTORY_SLOT_HEAD; break;
        case BASE_ITEM_ARMOR: nSlot = INVENTORY_SLOT_CHEST; break; // * this allows clothing to be equipped
    }
    object oCurrentItem = GetItemInSlot(nSlot);

    int nValue = 0;
    if (GetIsObjectValid(oCurrentItem) == TRUE)
    {
       nValue = GetGoldPieceValue(oCurrentItem);
    }
    int nNewValue = GetGoldPieceValue(oItem);
    // * only equip if new item is more expensive than old item
    if ( (nNewValue > nValue) && !(nSlot == -99) )
    {
//        SpeakString("Equipping " + GetName(oItem) + " oldcost " + IntToString(nValue) +
//          " newcost " + IntToString(nNewValue));
        AssignCommand(oHench, ActionEquipItem(oItem, nSlot));
    }
}
// * Copy equipped items from oHench to oContainer
void CopyEquipped(object oContainer, object oHench)
{
    int i = 0;
    object oItem = OBJECT_INVALID;
    AssignCommand(oHench, ClearAllActions());
    for (i=INVENTORY_SLOT_HEAD; i<=INVENTORY_SLOT_BOLTS; i++)
    {
        oItem = GetItemInSlot(i, oHench);
        if (GetItemCursedFlag(oItem))
            continue;
        CopyItem(oItem, oContainer);
    }
}
// * destroy all equipped items when henchmen inventory is returned.
void DestroyEquipped(object oHench)
{
    int i = 0;
    object oItem = OBJECT_INVALID;
    for (i=INVENTORY_SLOT_HEAD; i<=INVENTORY_SLOT_BOLTS; i++)
    {
        oItem = GetItemInSlot(i, oHench);
        if (GetItemCursedFlag(oItem))
            continue;
        DestroyObject(oItem);
    }
  //  AssignCommand(oHench, DelayCommand(0.0, ClearAllActions()));

  //Gale 5 Feb 2006: only equip a melee weapon
    AssignCommand(oHench, DelayCommand(0.0,bkEquipMelee(oHench,FALSE)));
    AssignCommand(oHench, DelayCommand(0.0,ActionEquipMostEffectiveArmor()));// Armor now equipped in EquipAllItems
}

// * copy unequipped items from henchman to 'invisible container'
void CopyUnequipped(object oContainer, object oHench)
{
    object oItem = GetFirstItemInInventory(oHench);

    AssignCommand(oHench, ClearAllActions());

    while (GetIsObjectValid(oItem) == TRUE)
    {
        CopyItem(oItem, oContainer);
        DestroyObject(oItem, 0.1);
        oItem = GetNextItemInInventory(oHench);
    }
}
//* copies equipment back to henchmen
void CopyBack(object oContainer, object oHench)
{
    object oItem = GetFirstItemInInventory(oContainer);

    AssignCommand(oHench, ClearAllActions());

    while (GetIsObjectValid(oItem) == TRUE)
    {
        object oNewItem = CopyItem(oItem, oHench);
        DestroyObject(oItem, 0.1);
        AttemptToEquipItem(oNewItem, oHench);
        oItem = GetNextItemInInventory(oContainer);
    }
}
