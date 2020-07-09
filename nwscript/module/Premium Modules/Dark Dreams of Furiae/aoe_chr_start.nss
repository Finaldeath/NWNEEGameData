///
/// OnEnter of 'Starting Area'
///

#include "ddf_util"
void RemoveInventory(object oPlayer);
void CreateItemOnObjectWrapper(string resref, object target, int slots = 1);

void main()
{
    debug("aoe_chr_start");

   // start the dialog via
    object oPC = GetEnteringObject();

    // make oPC level 5.

    int nLevel = 5;
    int nRequiredXP = (nLevel * (nLevel - 1)) * 500;
    int nPlayerXP = GetXP(oPC);

    if(nPlayerXP != nRequiredXP)
    {
        debug("xp: " + IntToString(nPlayerXP) + " -> " + IntToString(nRequiredXP));
        SetXP(oPC, nRequiredXP);
    }

    // remove all items OTHER THEN CLOTHS
    RemoveInventory(oPC);


    // give characters default items
    // 3 Cure Light Wounds potions
    DelayCommand(3.0, CreateItemOnObjectWrapper("nw_it_mpotion001", oPC, 3));

    // 1 Dagger
    DelayCommand(4.0, CreateItemOnObjectWrapper("nw_wswdg001", oPC));


    // Party Background Check....
    int nBackgroundFlag = GetLocalInt(GetModule(), "ddf_background_flag");
    if(nBackgroundFlag == BG_COP)
    {
        DelayCommand(3.0, CreateItemOnObjectWrapper("furiaebadge", oPC));
    }
    else if(nBackgroundFlag == BG_REVOLUTIONARY)
    {
        DelayCommand(3.0, CreateItemOnObjectWrapper("revolutionaryrin", oPC));
    }
    else if(nBackgroundFlag == BG_INDIE)
    {
        DelayCommand(3.0, CreateItemOnObjectWrapper("primeworldgem", oPC));
    }

    // Gold XXX
    int nGold = GetGold(oPC);
    AssignCommand(oPC, TakeGoldFromCreature(nGold, oPC, TRUE));
    //TakeGoldFromCreature(nGold, oPC, TRUE);
    AssignCommand(oPC, GiveGoldToCreature(oPC, 500));
}

void CreateItemOnObjectWrapper(string resref, object target, int slots = 1)
{
    CreateItemOnObject(resref, target, slots);
}

void RemoveInventory(object oPlayer)
{
    object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oPlayer);
    if(TRUE == FALSE)
    {
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
        oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oPlayer);
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
        oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPlayer);
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
        oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPlayer);
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
        oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oPlayer);
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
        oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPlayer);
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
        oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oPlayer);
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
        oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oPlayer);
        if(GetIsObjectValid(oGear))
            DestroyObject(oGear);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
    if(GetIsObjectValid(oGear))
        DestroyObject(oGear);
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPlayer);
    if(GetIsObjectValid(oGear))
        DestroyObject(oGear);
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
    if(GetIsObjectValid(oGear))
        DestroyObject(oGear);
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPlayer);
    if(GetIsObjectValid(oGear))
        DestroyObject(oGear);

// Removing PC's inventory.
    object oStuff = GetFirstItemInInventory(oPlayer);
    while(GetIsObjectValid(oStuff))
    {
        DestroyObject(oStuff);
        oStuff = GetNextItemInInventory(oPlayer);
    }
}
