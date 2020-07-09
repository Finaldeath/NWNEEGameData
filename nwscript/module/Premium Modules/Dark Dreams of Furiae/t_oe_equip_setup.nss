#include "ddf_util"

void DoPlotItemDestruction(object oPC);
void destroyPlotItems(object oPC, object oInvItem);
void DoNormalItemRemoval(object oPC);

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) == FALSE) return;

    if(GetLocalInt(oPC, "ddf_equipped") == TRUE) return;

    // Up or Down grade to LEVEL 5
    int currentXP = GetXP(oPC);
    if(currentXP < 10000)
    {
        SetXP(oPC, 10000);
    }
    else if(currentXP >= 15000)
    {
        SetXP(oPC, 14999);
    }

    // Remove all equipment
    // TODO
    //debug("Removing all character inventory...");
    //DoPlotItemDestruction(oPC);
    //DoNormalItemRemoval(oPC);


    // Give starting equipment
    // 3 Potions of healing
    object oPotions = CreateItemOnObject("nw_it_mpotion001", oPC, 3);
    if(GetIsObjectValid(oPotions) == FALSE) debug("Error giving potions.");

    object oDagger = CreateItemOnObject("nw_wswdg001", oPC, 1);
    if(GetIsObjectValid(oDagger) == FALSE) debug("Error giving dagger.");

    // Give starting GOLD.
    // 2019-09-03
    // https://app.asana.com/0/842177838074622/1137753423513119
    int iCurrentGold = GetGold();
    int iGoldToGive = 2000 - iCurrentGold;
    if(iGoldToGive > 0) GiveGoldToCreature(oPC, iGoldToGive);


    SetLocalInt(oPC, "ddf_equipped", TRUE);
}

void DoNormalItemRemoval(object oEnteringPC)
{
    object oInvItem;
    // Make sure the object is a PC
    if (GetIsPC(oEnteringPC))
    {
        // Only clear inventory if we haven't already done it before
        if (GetLocalInt(oEnteringPC, "CLEAR_INV_SCENE1") == 0)
        {
            oInvItem = GetFirstItemInInventory(oEnteringPC);
            while (oInvItem != OBJECT_INVALID)
            {
                //ActionTakeItem(oInvItem, oEnteringPC);
                DestroyObject(oInvItem);
                oInvItem = GetNextItemInInventory(oEnteringPC);
            }
            // Since GetNextItemInInvetory() seems to not return equipped items,
            // we need to manually remove them one by one.
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_BELT, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_NECK, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oEnteringPC))  )
                DestroyObject(oInvItem);
            if ( OBJECT_INVALID != (oInvItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oEnteringPC))  )
                DestroyObject(oInvItem);
            // Make sure this script doesn't run anymore for the current PC
            SetLocalInt(oEnteringPC, "CLEAR_INV_SCENE1", 1);
        }
    }
}

void DoPlotItemDestruction(object oPC)
{
   object oSlot;
    oSlot = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot= GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot= GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot= GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot= GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot= GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot= GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    oSlot = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
    // Destroy the equiped plot item
    destroyPlotItems(oPC, oSlot);
    object currentItemInInv;
    //////////////////////////////////////////////////////////////////////
    // Now loop through everything in the Inventory.
    //
    //////////////////////////////////////////////////////////////////////
    object firstItemInInv;
    firstItemInInv = GetNextItemInInventory(oPC);
    currentItemInInv = firstItemInInv;
    // Insure they have at least one object
    if(currentItemInInv != OBJECT_INVALID)
    {
        do{
            // Check for destrtoying plot items.
            destroyPlotItems(oPC, currentItemInInv);
            // get next item
            currentItemInInv = GetNextItemInInventory(oPC);
        // loop while we have a new item to check
        }while(currentItemInInv != OBJECT_INVALID &&
               currentItemInInv != firstItemInInv);
    }
}


void destroyPlotItems(object oPC, object oInvItem)
{
    //////////////////////////////////////////////////////////////////////////
    //
    // sPlotItemTagStartingKeyword
    //  Set this var to the starting characters you want all your plot
    //  items to start with. It is case sensitive. Any other plot items
    //  that do not start with  sPlotItemTagStartingKeyword will be destroyed
    //  example:
    //    if:
    //      sPlotItemTagStartingKeyword = "ForgottenSoul"
    //    Then the following items would be kept.
    //      ForgottenSoul's Wicked Ale
    //      ForgottenSoul
    //      ForgottenSoul Ring of the Maji
    //
    //    Then the following items would be deleted (note its case sensitive)
    //       forgottenSoul's Wicked Ale
    //       My super Powerful Cheat weapon
    //       Forgotten Soul Ring of the Maji
    //
    // If this var is left blank, then all plot items are detroyed.
    //
    string sPlotItemTagStartingKeyword = "";
    // Check to see if a valid object was passed
    if(oInvItem != OBJECT_INVALID)
    {
        //
        // Destroy object if:
        //   It is a plot item AND Either of the following is true:
        //     The item DOEST NOT start with the text defined in var
        //     sPlotItemTagStartingKeyword
        //   OR
        //     sPlotItemTagStartingKeyword equals ""
        //
        if(GetPlotFlag(oInvItem) == TRUE &&
           (sPlotItemTagStartingKeyword !=
           GetStringLeft(GetTag(oInvItem),GetStringLength(sPlotItemTagStartingKeyword)) ||
           sPlotItemTagStartingKeyword == ""))
         {
            // Be nice an inform player why items is gone
            SendMessageToPC(oPC,"Plot Object:");
            SendMessageToPC(oPC,GetName(oInvItem));
            SendMessageToPC(oPC,"has been removed because plot items have been known to " +
                                "be super/cheat weapons.");
            // it is a plot item. Destroy it.
            DestroyObject(oInvItem);
        }
    }
}
