// December 2005
// B W-husey
// This script strips the calling object, placing their inventory in Polter's Fort
// Need a function to check capacity/item size

// Functions copies incoming PC's items then destroys them on the PC
void CopyAndDestroy(object oItem,object oStorage)
{
    CopyItem(oItem,oStorage);
    DestroyObject(oItem);
}


#include "cu_functions"
void main()
{
            object oPC = OBJECT_SELF;
            object oStorage = GetObjectByTag("Stored_Items");
            object oStorage2 = GetObjectByTag("Stored_Items2");
            //strip equipped items and store them
            object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
            if(GetIsObjectValid(oGear)) CopyAndDestroy(oGear,oStorage);
            //strip inventory items and store them
        object oStuff = GetFirstItemInInventory(oPC);
        int n=0;
        while(GetIsObjectValid(oStuff))
           {
            if (GetTag(oStuff) != "PlotWand" && n<15) CopyAndDestroy(oStuff,oStorage);
            else if (GetTag(oStuff) != "PlotWand") CopyAndDestroy(oStuff,oStorage2);
            oStuff = GetNextItemInInventory(oPC);
            n++;
           }
        TakeGold(GetGold(oPC),oPC,TRUE);
}
