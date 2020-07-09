//::////////////////////////////////////////////////////////////////////////////
//:: itm_id1_masbone
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Item Event handler for Masterius' bone. Using the bone summons two Undead
    minions who heal their master as they damage opponents.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:
//::////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"
#include "inc_id1_masteriu"
#include "x0_i0_henchman"

void main()
{
//    int nEvent = GetUserDefinedItemEventNumber();

    // Item activated event.
//    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
//    {
        // Gather user, item and target location.
        object oUser = GetItemActivator();
        effect eVFX = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
        location lTarget = GetItemActivatedTargetLocation();

        // Flashy effects.
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lTarget);

        // Create a ghoul reaper and make him a follower.
        object oGhoul = DB_CreateObject(OBJECT_TYPE_CREATURE, GHOUL_RESREF, lTarget);

        // Set level up information for the ghoul's on spawn events.
        int nHD = GetHitDice(oUser);

        SetLocalInt(oGhoul, "nCreatureType", 3);
        SetLocalInt(oGhoul, "nCR", nHD);
        SetLocalInt(oGhoul, "nBaseHD", 1);
        SetLocalInt(oGhoul, "nClass", -1);

        object oClawL = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oGhoul);
        object oClawR = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oGhoul);
        object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oGhoul);

        int nBonus = nHD / 5;

        itemproperty ipEnhance = ItemPropertyEnhancementBonus(nBonus);
        itemproperty ipAC = ItemPropertyACBonus(nBonus);

        AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhance, oClawL);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhance, oClawR);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipAC, oSkin);

        AddHenchman(oUser, oGhoul);
        SetAssociateState(NW_ASC_DISTANCE_2_METERS, TRUE, oGhoul);

        // Set the recipient of the health the ghoul drains.
        SetLocalObject(oGhoul, "oMaster", oUser);
//    }
}
