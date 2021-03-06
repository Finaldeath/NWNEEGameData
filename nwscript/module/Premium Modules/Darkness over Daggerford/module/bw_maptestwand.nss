//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "inc_bw_worldmap"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    // SendMessageToPC(GetFirstPC(),IntToString(nEvent));

    // * This code runs when the item has the OnHitCastSpell: Unique power property
    // * and it hits a target(weapon) or is being hit (armor)
    // * Note that this event fires for non PC creatures as well.
    if (nEvent == X2_ITEM_EVENT_ONHITCAST)
    {
        oItem  =  GetSpellCastItem();                  // The item casting triggering this spellscript
        object oSpellOrigin = OBJECT_SELF ;
        object oSpellTarget = GetSpellTargetObject();
        oPC = OBJECT_SELF;
    }

    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        // make all areas in world map visible
        object oModule = GetModule();

        //SetLocalInt(oModule, "nWM_c1ar0100_status", nWM_VISIBLE);
        //SetLocalInt(oModule, "nWM_c1ar0200_status", nWM_VISIBLE);
        //SetLocalInt(oModule, "nWM_c1ar0300_status", nWM_VISIBLE);
        //SetLocalInt(oModule, "nWM_c1ar0400_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar0500_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar0600_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar0700_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar0800_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar0900_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1000_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1100_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1200_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1300_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1400_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1500_status", nWM_VISIBLE);
        //SetLocalInt(oModule, "nWM_c1ar1600_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1700_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1800_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar1900_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar2000_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar2100_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar2200_status", nWM_VISIBLE);
        //SetLocalInt(oModule, "nWM_c1ar2300_status", nWM_VISIBLE);
        //SetLocalInt(oModule, "nWM_c1ar2400_status", nWM_VISIBLE);
        SetLocalInt(oModule, "nWM_c1ar2500_status", nWM_VISIBLE);
    }

    // * This code runs when the item is equipped
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_EQUIP)
    {
        oPC = GetPCItemLastEquippedBy();
        oItem = GetPCItemLastEquipped();
    }

    // * This code runs when the item is unequipped
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_UNEQUIP)
    {
        oPC    = GetPCItemLastUnequippedBy();
        oItem  = GetPCItemLastUnequipped();
    }
    // * This code runs when the item is acquired
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        oPC = GetModuleItemAcquiredBy();
        oItem  = GetModuleItemAcquired();
    }

    // * This code runs when the item is unaquire d
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
    {
        oPC = GetModuleItemLostBy();
        oItem  = GetModuleItemLost();
    }

    //* This code runs when a PC or DM casts a spell from one of the
    //* standard spellbooks on the item
    else if (nEvent == X2_ITEM_EVENT_SPELLCAST_AT)
    {
        oPC = GetLastSpellCaster();
        oItem  = GetSpellTargetObject();
    }
}
