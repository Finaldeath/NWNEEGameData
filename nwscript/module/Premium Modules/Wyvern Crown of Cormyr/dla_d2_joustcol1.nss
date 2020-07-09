////////////////////////////////////////////////////////////////////////////////
// dla_d2_joustcol1
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Check that the player is not wearing any of the borrowed joust armor
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Syrsnein
// Created On: 13 July 2006
////////////////////////////////////////////////////////////////////////////////
/*
 Change History
 Date
 year/mm/dd | Author     | Change
 -----------+------------+------------------------------------------------------
 */

#include "dla_i0_joust"

int StartingConditional()
{
    object oChest = GetObjectByTag(DLA_TAG_JOUST_ARMOR_CHEST);
    int bArmor  = FALSE;
    int bHelmet = FALSE;
    int bShield = FALSE;

    DLA_JoustDebug("<dla_d2_joustcol1>");
    if (GetLocalInt(oChest, "nUsed"))
    {
        object oPC = GetPCSpeaker();
        object oHelm    = GetLocalObject(oPC, DLA_VAR_BORROWED_HELMET);
        object oArmor   = GetLocalObject(oPC, DLA_VAR_BORROWED_ARMOR);
        object oShield  = GetLocalObject(oPC, DLA_VAR_BORROWED_SHIELD);
        if (GetIsObjectValid(oHelm) && GetItemInSlot(INVENTORY_SLOT_HEAD, oPC)==oHelm)
        {
            DLA_JoustDebug("   Wearing borrowed helmet.");
            bHelmet = TRUE;
        }
        if (GetIsObjectValid(oArmor) && GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)==oArmor)
        {
            DLA_JoustDebug("   Wearing borrowed armor.");
            bArmor = TRUE;
        }
        if (GetIsObjectValid(oShield) && GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)==oShield)
        {
            DLA_JoustDebug("   Wearing borrowed shield.");
            bShield = TRUE;
        }
    }
    DLA_JoustDebug("   Returning " + IntToString(bHelmet || bArmor || bShield));
    DLA_JoustDebug("----------------------------");
    return (bHelmet || bArmor || bShield);
}
