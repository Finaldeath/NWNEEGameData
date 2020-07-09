//::///////////////////////////////////////////////
//:: Generic Give Equipped Weapon
//:: cac_give_weapon.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Have the NPC give their currently equipped
     weapon to the player.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 22, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    ActionGiveItem(oWeapon, oPC);
}
