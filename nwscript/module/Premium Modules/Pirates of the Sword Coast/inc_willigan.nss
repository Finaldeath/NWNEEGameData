//::///////////////////////////////////////////////
//:: inc_willigan.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    These functions were initially implemented
    in inc_global, but as I kept making more I
    realized it would be cleaner if I moved them
    to their own include file.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 31, 2005
//:://////////////////////////////////////////////

#include "inc_global"

#include "x0_i0_henchman"

// Function declarations
////////////////////////

// Willigan plot - deactivates all the item mapnote waypoints in his manor
void A2WillyChestMapnoteReset();

// Willigan plot - activates the mapnote of nType nearest oChest
// sWPTag: Use a2w_Willigan_Chest_* constants.
//       is automatically called when using A2WillyChestSpawnItem() and
//       A2WillyChestMapnoteReset().
void A2WillyChestSetMapnote(object oChest, string sWPTag, int nEnabled=TRUE);

// Willigan plot - create one of the Willigan items in a random chest in
// his manor.
// sItemTag: Use a2i_Willigan_* constants.
// Note: As a failsafe, it will double-check all the chests to make
//       sure only one is placed. Also note that this function automatically
//       activates the appropriate mapnote.
void A2WillyChestSpawnItem(string sItemTag);

// Willigan plot - checks all the chests to see if one contains the item.
// sItemTag: Use a2i_Willigan_* constants.
// Returns: The number of the chest, to be used with GetObjectByTag(<tag>, nNth)
//          Returns -1 if no chest contains the item.
// Note: This function is used by A2WillyChestSpawnItem() and probably does
//       not need to be called directly.
int A2WillyChestCheckForItem(string sItemTag);

// Willigan plot - This function makes Willy equip whatever items he has
// been given so far. Note: A2WillyTakeItem() calls this function, so if you
// used that, you don't need to call this as well.
void A2WillyEquipItems(object oWilly=OBJECT_SELF);

// Willigan plot - This function will take sItemTag from oPC. If for whatever
// reason it can't find the item on oPC, it'll find the first one it can,
// wherever it is, and destroy it. Because wherever it is, it's not supposed
// to be there. :) It also makes Willy equip it right away.
// sItemTag: Use a2i_Willigan_* constants.
void A2WillyTakeItem(string sItemTag, object oPC, object oWilly=OBJECT_SELF);

// henchmen are removed from the party when searching for Willigan's items.
// this function is used in a couple of places to restore them
void A2WillyRestoreHenchmen(object oPC);


// Function implementations
///////////////////////////

// Willigan plot - cycles through all chests in his manor, and sets all
// mapnotes as enabled or disabled as appropriate
void A2WillyChestMapnoteReset()
{
    int nIndex;
    object oChest = GetObjectByTag(a2p_Willigan_Chest, 0);
    while(GetIsObjectValid(oChest))
    {
        int bBoots = GetIsObjectValid(GetItemPossessedBy(oChest, a2i_Willigan_Boots));
        int bCutlass = GetIsObjectValid(GetItemPossessedBy(oChest, a2i_Willigan_Cutlass));
        int bGarb = GetIsObjectValid(GetItemPossessedBy(oChest, a2i_Willigan_Garb));

        A2WillyChestSetMapnote(oChest, a2w_Willigan_Chest_Boots, bBoots);
        A2WillyChestSetMapnote(oChest, a2w_Willigan_Chest_Cutlass, bCutlass);
        A2WillyChestSetMapnote(oChest, a2w_Willigan_Chest_Garb, bGarb);

        nIndex++;
        oChest = GetObjectByTag(a2p_Willigan_Chest, nIndex);
    }
}

// Willigan plot - activates the mapnote of nType nearest oChest
// sWPTag: Use a2w_Willigan_Chest_* constants.
// Note: This function probably does not need to be called directly, as it
//       is automatically called when using A2WillyChestSpawnItem() and
//       A2WillyChestMapnoteReset().
void A2WillyChestSetMapnote(object oChest, string sWPTag, int nEnabled=TRUE)
{
    object oWP = GetNearestObjectByTag(sWPTag, oChest);
    if(GetDistanceBetween(oWP, oChest) < 5.0)
    {
        SetMapPinEnabled(oWP, nEnabled);
    }
}

// Willigan plot - create one of the Willigan items in a random chest in
// his manor.
// sItemTag: Use a2i_Willigan_* constants.
// Note: As a failsafe, it will double-check all the chests to make
//       sure only one is placed. Also note that this function automatically
//       activates the appropriate mapnote.
void A2WillyChestSpawnItem(string sItemTag)
{
    object oModule = GetModule();

    // First I need to figure out how many chests we have, and make an array
    // to make things easier. This is only done once, if we've done it before
    // obviously no point in doing it again.
    int nNumChests = GetLocalInt(oModule, g_n_A2_WILLIGAN_CHESTS_NUM);
    if(!nNumChests)
    {
        nNumChests = 0;
        object oChest = GetObjectByTag(a2p_Willigan_Chest, 0);
        while(GetIsObjectValid(oChest))
        {
            SetObjectArray(oModule, g_oa_A2_WILLIGAN_CHESTS, nNumChests, oChest);
            nNumChests++;
            oChest = GetObjectByTag(a2p_Willigan_Chest, nNumChests);
        }
        SetLocalInt(oModule, g_n_A2_WILLIGAN_CHESTS_NUM, nNumChests);
    }

    // make sure we found at least one chest
    if(nNumChests < 1) return;

    int nChestWithBoots = A2WillyChestCheckForItem(a2i_Willigan_Boots);
    int nChestWithCutlass = A2WillyChestCheckForItem(a2i_Willigan_Cutlass);
    int nChestWithGarb = A2WillyChestCheckForItem(a2i_Willigan_Garb);

    // if we found the item we want to spawn, return without doing anything
    if( (nChestWithBoots != -1) && (sItemTag == a2i_Willigan_Boots) ) return;
    if( (nChestWithCutlass != -1) && (sItemTag == a2i_Willigan_Cutlass) ) return;
    if( (nChestWithGarb != -1) && (sItemTag == a2i_Willigan_Garb) ) return;

    int nChestToUse = Random(nNumChests);
    int nAlternateChest = nChestToUse;

    // we only care about finding a unique chest if there are at least three of them
    if(nNumChests > 2)
    {
        while(TRUE)
        {
            // the currently selected chest does not have one of the three items
            // so we can use it
            if( (nAlternateChest != nChestWithBoots) &&
                (nAlternateChest != nChestWithCutlass) &&
                (nAlternateChest != nChestWithGarb) )
            {
                nChestToUse = nAlternateChest;
                break;
            }

            // the currently selected chest does have one of the items, so
            // let's move on to the next one
            nAlternateChest++;
            if(nAlternateChest == nNumChests) nAlternateChest = 0;

            // ok, for some reason we've wrapped all the way around, so
            // screw it, just use the originally selected chest.
            if(nAlternateChest == nChestToUse) break;
        }
    }

    // finally, create the item in the chosen chest
    object oChest = GetObjectArray(oModule, g_oa_A2_WILLIGAN_CHESTS, nChestToUse);
    CreateItemOnObject(sItemTag, oChest);

    // and activate the appropriate mapnote
    if(sItemTag == a2i_Willigan_Boots) A2WillyChestSetMapnote(oChest, a2w_Willigan_Chest_Boots);
    else if(sItemTag == a2i_Willigan_Cutlass) A2WillyChestSetMapnote(oChest, a2w_Willigan_Chest_Cutlass);
    else if(sItemTag == a2i_Willigan_Garb) A2WillyChestSetMapnote(oChest, a2w_Willigan_Chest_Garb);
}

// Willigan plot - checks all the chests to see if one contains the item.
// sItemTag: Use a2i_Willigan_* constants.
// Returns: The number of the chest, to be used with GetObjectByTag(<tag>, nNth)
//          Returns -1 if no chest contains the item.
// Note: This function is used by A2WillyChestSpawnItem() and probably does
//       not need to be called directly.
int A2WillyChestCheckForItem(string sItemTag)
{
    object oModule = GetModule();
    int nNumChests = GetLocalInt(oModule, g_n_A2_WILLIGAN_CHESTS_NUM);

    int nChest;
    for(nChest = 0; nChest < nNumChests; nChest++)
    {
        object oChest = GetObjectArray(oModule, g_oa_A2_WILLIGAN_CHESTS, nChest);
        object oItem = GetItemPossessedBy(oChest, sItemTag);
        if(GetIsObjectValid(oItem)) return nChest;
    }
    return -1;
}

// Willigan plot - This function make Willy equip whatever items he has
// been given so far. Note: A2WillyTakeItem() calls this function, so if you
// used that, you don't need to call this as well.
void A2WillyEquipItems(object oWilly=OBJECT_SELF)
{
    object oBoots = GetItemPossessedBy(oWilly, a2i_Willigan_Boots);
    object oCutlass = GetItemPossessedBy(oWilly, a2i_Willigan_Cutlass);
    object oGarb = GetItemPossessedBy(oWilly, a2i_Willigan_Garb);

    int bHasBoots = GetIsObjectValid(oBoots);
    int bHasCutlass = GetIsObjectValid(oCutlass);
    int bHasGarb = GetIsObjectValid(oGarb);

    // cutlass is simple
    if(bHasCutlass) AssignCommand(oWilly, ActionEquipItem(oCutlass, INVENTORY_SLOT_RIGHTHAND));

    // has boots, but not garb, equip special outfit
    if( bHasBoots && !bHasGarb)
    {
        object oOutfit = GetItemPossessedBy(oWilly, a2i_Willigan_Outfit_NoGarb_Boots);
        if(!GetIsObjectValid(oOutfit)) oOutfit = CreateItemOnObject(a2i_Willigan_Outfit_NoGarb_Boots, oWilly);
        AssignCommand(oWilly, ActionEquipItem(oOutfit, INVENTORY_SLOT_CHEST));
    }
    // has garb, but not boots, equip special outfit
    else if ( !bHasBoots && bHasGarb)
    {
        object oOutfit = GetItemPossessedBy(oWilly, a2i_Willigan_Outfit_Garb_NoBoots);
        if(!GetIsObjectValid(oOutfit)) oOutfit = CreateItemOnObject(a2i_Willigan_Outfit_Garb_NoBoots, oWilly);
        AssignCommand(oWilly, ActionEquipItem(oOutfit, INVENTORY_SLOT_CHEST));
    }
    // has both garb and boots, equip full garb
    else if ( bHasBoots && bHasGarb)
    {
        AssignCommand(oWilly, ActionEquipItem(oGarb, INVENTORY_SLOT_CHEST));
        // search inventory for special outfits, and destroy them
        object oOutfit = GetItemPossessedBy(oWilly, a2i_Willigan_Outfit_NoGarb_Boots);
        DestroyObject(oOutfit);
        oOutfit = GetItemPossessedBy(oWilly, a2i_Willigan_Outfit_Garb_NoBoots);
        DestroyObject(oOutfit);
    }
}

// Willigan plot - This function will take sItemTag from oPC. If for whatever
// reason it can't find the item on oPC, it'll find the first one it can,
// wherever it is, and destroy it. Because wherever it is, it's not supposed
// to be there. :) It also makes Willy equip it right away.
// sItemTag: Use a2i_Willigan_* constants.
void A2WillyTakeItem(string sItemTag, object oPC, object oWilly=OBJECT_SELF)
{
    object oItem = GetItemPossessedBy(oPC, sItemTag);
    if(!GetIsObjectValid(oItem))
    {
        // player got sneaky, and did something with the item in between
        // the point where we displayed the dialogue option, and the point
        // where they selected it. so let's just find one and destroy it instead
        oItem = GetObjectByTag(sItemTag);
    }
    if(GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }
    CreateItemOnObject(sItemTag, oWilly);
    DelayCommand(0.1, A2WillyEquipItems(oWilly));
}

void A2WillyRestoreHenchmen(object oPC)
{
    int nIndex = 0;
    object oHench = GetObjectArray(oPC, g_oa_A2_WILLIGAN_HENCH, nIndex);
    while(GetIsObjectValid(oHench))
    {
        // if the henchman still doesn't have a master (ie. another player
        // didn't pick them up), then re-add them to player's party, and
        // jump them to the player
        if(!GetIsObjectValid(GetMaster(oHench)))
        {
            HireHenchman(oPC, oHench);
            //AddHenchman(oPC, oHench);
            AssignCommand(oHench, ClearAllActions(TRUE));
            DelayCommand(1.0, AssignCommand(oHench, ActionJumpToObject(oPC)));
        }
        nIndex++;
        oHench = GetObjectArray(oPC, g_oa_A2_WILLIGAN_HENCH, nIndex);
    }
    DeleteObjectArray(oPC, g_oa_A2_WILLIGAN_HENCH, nIndex);

}
