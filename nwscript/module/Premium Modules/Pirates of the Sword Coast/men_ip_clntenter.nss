//::///////////////////////////////////////////////
//:: men_ip_clntenter
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Give the required items to the PC.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "inc_global"
#include "inc_balance"
#include "inc_bootysystem"
#include "inc_safepoint"
#include "inc_undead"

void VerifyInventory(object oPC);
void CheckItem (object oItem);
int TotalWorth (object oPC);
void RecurEquipB (object oPC, object oItem, int iSlot);

void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC) && !GetIsDM(oPC))
        return;

    PrintString(GetName(oPC)+" has entered and passed a PC/DM check.");

    object oCursor = OBJECT_INVALID;
    object oCostume = OBJECT_INVALID;
    object oWeapon = OBJECT_INVALID;
    object oDMWand = OBJECT_INVALID;
    object oDMIsland = GetWaypointByTag("WP_DMIsland");
    object oWPSafePoint = OBJECT_INVALID;
    object oModule = GetModule();

    object oGarm = GetObjectByTag("a1_hench_garm");
    object oNisar0 = GetObjectByTag("a0_hench_nisar");
    object oNisar2 = GetObjectByTag("a2_hench_nisar");
    object oTasina = GetObjectByTag("a0_tasina");

    object oArea1 = GetObjectByTag("a3mrbelowdecks");
    object oArea2 = GetObjectByTag("a0_mrbelowdeck");
    object oArea3 = GetObjectByTag("BelowDeck_MidnightRose_AtSea");
    object oArea4 = GetObjectByTag("a3iodskllbns");
    object oArea5 = GetObjectByTag("a3sklbnsbdeck");

    int iPlayerCount = 0;
    int iEXP = GetXP(oPC);
    int iGold = TotalWorth(oPC);
    int iStartUOff = GetLocalInt(oModule, "strip_pc_" + GetName(oPC) + "_" + GetPCPlayerName(oPC));

    PrintString("Value of iStartUOff variable: " + IntToString(iStartUOff)+ ".");
    int bIsDM = FALSE;

    object oHide;

    if (GetIsPC(oPC))
    {
        ReCalcGlobalDif();

        //Explore all Belowdeck areas for the incoming player.
        ExploreAreaForPlayer(oArea1, oPC);
        ExploreAreaForPlayer(oArea2, oPC);
        ExploreAreaForPlayer(oArea3, oPC);
        ExploreAreaForPlayer(oArea4, oPC);
        ExploreAreaForPlayer(oArea5, oPC);
        PrintString("Below deck areas explored.");
        if (iStartUOff == 0)
        {
            PrintString("Script says iStartUOff is equal to zero.");
            SetLocalInt(oModule, "strip_pc_" + GetName(oPC) + "_" + GetPCPlayerName(oPC), 1);

            // Calculate the bonus for the minimum player level and value
            if (iEXP < 10000)
            {
                iEXP = 10000 - iEXP;
                GiveXPToCreature(oPC, iEXP);
            }
            if (iGold < 1500)
            {
                iGold = 1500 - iGold;
                GiveGoldToCreature(oPC, iGold);
            }

            RemoveUndead(oPC);
            VerifyInventory(oPC);

            //Delete any previous creature hides
            oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
            DestroyObject(oHide);

            // Give the Player some equipment.
            oWeapon = CreateItemOnObject("trs_g_jnk_090", oPC);
            oCostume = CreateItemOnObject("sailorsuniform", oPC);

            AssignCommand(oPC, ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND));
            AssignCommand(oPC, ActionEquipItem(oCostume, INVENTORY_SLOT_CHEST));

            //Create the new hide on the player and make them equip it.
            oHide = CreateItemOnObject("potsc_pc_hide", oPC);
            RecurEquipB(oPC, oHide, INVENTORY_SLOT_CARMOUR);
        }
        else
        {
            // This player has already been playing this game
            // so check for multiplayer
            oCursor = GetFirstPC();
            while (GetIsObjectValid(oCursor) == TRUE)
            {
                if (GetIsDM(oCursor) == TRUE)
                {
                    bIsDM = TRUE;
                }

                iPlayerCount++;
                oCursor = GetNextPC();
            }

            //If a DM is present in the module, jump incoming players to DM Island and
            //send a message to all DMs.
            if (bIsDM == TRUE)
            {
                AssignCommand(oPC, JumpToObject(oDMIsland));
            }
            // If the game is multiplayer jump them to the current Safe Point
            else if (iPlayerCount > 1)
            {
                AssignCommand(oPC, ClearAllActions(TRUE));
                MoveToSafeLoc(oPC);
            }
        }

        // For testing purposes, display version #
        //DelayCommand(2.0, SendMessageToPC(oPC,
        //    "Islands of Peril - Act 0 : Version " + GetGlobalString("VERSION")));
    }
    else if (GetIsDM(oPC))
    {
        oDMWand = GetItemPossessedBy(oPC, "potsc_dmwand");

        // if its a DM without a DM wand, create one.
        if (GetIsObjectValid(oDMWand) != TRUE)
        {
            CreateItemOnObject("potsc_dmwand", oPC);
        }

        //Jump all incoming DMs to DM Island
        AssignCommand(oPC, JumpToObject(oDMIsland));
    }
    else
    {
        // Do nothing
    }

}

int TotalWorth (object oPC)
{
    //Total Inventroy
    object oItem = OBJECT_INVALID;
    int iReturn = GetGold(oPC);

    oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    iReturn = GetGoldPieceValue(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
    iReturn = GetGoldPieceValue(oItem);

    oItem = GetFirstItemInInventory(oPC);

    while(oItem != OBJECT_INVALID)
    {
        iReturn = GetGoldPieceValue(oItem);
        oItem = GetNextItemInInventory(oPC);
    }

    return iReturn;
}

void VerifyInventory(object oPC)   // Instead destroys plot items and wrecks your game
{
    //Destroy Inventroy
     object oItem = OBJECT_INVALID;

   oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    CheckItem(oItem);
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
    CheckItem(oItem);

    oItem = GetFirstItemInInventory(oPC);

    while(oItem != OBJECT_INVALID)
    {
        CheckItem(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    PrintString("Inventory was verified.");
}

void CheckItem(object oItem)
{
    string sTag = GetTag(oItem);

    if ( (sTag == "a1_sacredwood") || (sTag == "a1_raftplans")
      || (sTag == "a0_rahmansbook")|| (sTag == "a1_edgrimmshead")
      || (sTag == "a1_utnlkey") || (sTag == "a2_nwscepter")
      || (sTag == "a2_petering") || (sTag == "a2_iougbrd")
      || (sTag == "a2_ioumyr") || (sTag == "a2_ioupdh")
      || (sTag == "a2_ioutatt") || (sTag == "a2_iouxctnr")
      || (sTag == "a2_flowers") || (sTag == "a2_astrolabe")
      || (sTag == "a0rm_cup") || (sTag == "a0_rahmanskey")
      || (sTag == "a2_wwboots") || (sTag == "a2_wwcutless")
      || (sTag == "a2_wwgarb") || (sTag == "a3_wdnbrds")
      || (sTag == "potsc_undead") || (sTag == "potsc_undeadclwr")
      || (sTag == "potsc_undeadclwl") || (sTag == "trs_u_sys_map009")
      || (sTag == "trs_u_sys_map010") || (sTag == "trs_u_sys_map011")
      || (sTag == "trs_u_sys_map012") || (sTag == "trs_u_sys_map009")
      || (sTag == "trs_u_sys_map009") || (sTag == "map_flower")
      || (sTag == "map_blkbrd") || (sTag == "map_scepter")
      || (sTag == "trs_u_sys_map001") || (sTag == "trs_u_sys_map002")
      || (sTag == "trs_u_sys_map003") || (sTag == "trs_u_sys_map004")
      || (sTag == "trs_u_sys_map005") || (sTag == "trs_u_sys_map006")
      || (sTag == "trs_u_sys_map007") || (sTag == "trs_u_sys_iotd")
      || (sTag == "a0_tattoo_eye") || (sTag == "a0_tattoo_gnaked")
      || (sTag == "a0_tattoo_heart") || (sTag == "a0_tattoo_anchor")
      || (sTag == "a2_tattoo_pirate") || (sTag == "a2_tattoo_dragon")
      || (sTag == "a2_tattoo_flame") || (sTag == "a2_tattoo_waves")
      || (sTag == "trs_g_jnk_090") || (sTag == "a0_sailorsuniform")
      || (sTag == "a3_talisaman") || (sTag == "a3_sigilkey"))
    {
        PrintString("Object destroyed by script. Name: " + GetName(oItem) + ", Tag: " + GetTag(oItem) + ".");
        DestroyObject(oItem);
    }
    PrintString("Items were checked.");
}

void RecurEquipB (object oPC, object oItem, int iSlot)
{
    if (GetItemInSlot(iSlot, oPC) != oItem)
    {
        //SendMessageToPC(oPC, "Forcing '" + GetTag(oItem) + "' into a slot.");
        AssignCommand(oPC, ActionEquipItem(oItem, iSlot));
        DelayCommand(1.0f, RecurEquipB(oPC, oItem, iSlot));
    }
}
