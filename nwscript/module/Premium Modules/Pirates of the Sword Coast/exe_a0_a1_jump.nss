//::///////////////////////////////////////////////
//:: exe_a0_a1_jump
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Jump the players from Act 0 to Act 1.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_bootysystem"
#include "inc_polymorphfix"
#include "inc_balance"

void ClearInventory(object oPC);
void DestroyItem(object oItem);

void main()
{
    object oPC = OBJECT_INVALID;
    object oWP_Act1 = GetWaypointByTag("WP_A1_START");
    location lTarget = GetLocation(oWP_Act1);

    // Recalculate the global difficulty for the next act
    ReCalcGlobalDif();

    oPC = GetFirstPC();
    while(GetIsObjectValid(oPC) == TRUE)
    {
        RemovePolymorph(oPC);
        ClearInventory(oPC);

        oPC = GetNextPC();
    }

    JumpPCsToLocation(lTarget, 2);
}

void RecurEquip (object oPC, object oItem, int iSlot)
{
    if (GetItemInSlot(iSlot, oPC) != oItem)
    {
        //SendMessageToPC(oPC, "Forcing '" + GetTag(oItem) + "' into a slot.");
        AssignCommand(oPC, ActionEquipItem(oItem, iSlot));
        DelayCommand(1.0f, RecurEquip(oPC, oItem, iSlot));
    }
}

void ClearInventory(object oPC)
{
    //Destroy Inventroy
    object oItem = OBJECT_INVALID;
    string sItem = "";
    object oUtnlChest = GetObjectByTag("a1_chsttnls");
    int iGold = GetGold(oPC);

    //CreateItemOnObject("potsc_goldpiece", oUtnlChest, iGold);
    //TakeGoldFromCreature(iGold, oPC, TRUE);

    oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    //Destroy their brand new sailor's uniform
    if (GetTag(oItem) == "a0_sailorsuniform")
        DestroyObject(oItem);
    else
        DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    DestroyItem(oItem);

    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
    DestroyItem(oItem);

    oItem = GetFirstItemInInventory(oPC);
    while(oItem != OBJECT_INVALID)
    {
        sItem = GetTag(oItem);

        //Don't transfer uniform to Utnal's trove (Destroy it utterly).
        if (sItem == "a0_sailorsuniform")
        {
            DestroyObject(oItem, 0.2);
        }
        //Preserve tattoos
        else if ((sItem != "a0_tattoo_eye") && (sItem != "a0_tattoo_gnaked")
         && (sItem != "a0_tattoo_heart") && (sItem != "a0_tattoo_anchor")
         && (sItem != "a2_tattoo_pirate") && (sItem != "a2_tattoo_dragon")
         && (sItem != "a2_tattoo_flame") && (sItem != "a2_tattoo_waves"))
        {
            DestroyItem(oItem);
        }

        oItem = GetNextItemInInventory(oPC);
    }

    CreateBootyOnObject(oUtnlChest, BOOTY_GENERIC);
    CreateBootyOnObject(oUtnlChest, BOOTY_GENERIC);
    CreateBootyOnObject(oUtnlChest, BOOTY_GENERIC);
    CreateBootyOnObject(oUtnlChest, BOOTY_GENERIC);

    oItem = CreateItemOnObject("a1_ruineduniform", oPC);

    RecurEquip(oPC, oItem, INVENTORY_SLOT_CHEST);
}

void DestroyItem(object oItem)
{
    object oUtnlChest = GetObjectByTag("a1_chsttnls");
    if (GetTag(oItem) != "ww1_chisel")
    {
        CopyItem(oItem, oUtnlChest, TRUE);

        // Clear anything that may interfere with the destruction.
        SetPlotFlag(oItem, FALSE);
        AssignCommand(oItem, SetIsDestroyable(TRUE, FALSE, FALSE));
        DestroyObject(oItem, 0.2);
    }
}
