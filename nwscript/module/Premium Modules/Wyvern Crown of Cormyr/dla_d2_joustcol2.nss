////////////////////////////////////////////////////////////////////////////////
// dla_d2_joustcol2
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Reset the joust armor chest and destroy the joust armor
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
    if (GetLocalInt(oChest, "nUsed"))
    {
        object oPC = GetPCSpeaker();
        object oHelm    = GetLocalObject(oPC, DLA_VAR_BORROWED_HELMET);
        object oArmor   = GetLocalObject(oPC, DLA_VAR_BORROWED_ARMOR);
        object oShield  = GetLocalObject(oPC, DLA_VAR_BORROWED_SHIELD);
        if (GetIsObjectValid(oHelm))
        {
            DLA_DestroyObject(oHelm);
        }
        if (GetIsObjectValid(oArmor))
        {
            DLA_DestroyObject(oArmor);
        }
        if (GetIsObjectValid(oShield))
        {
            DLA_DestroyObject(oShield);
        }
        DeleteLocalObject(oPC, DLA_VAR_BORROWED_HELMET);
        DeleteLocalObject(oPC, DLA_VAR_BORROWED_ARMOR);
        DeleteLocalObject(oPC, DLA_VAR_BORROWED_SHIELD);
        DeleteLocalInt(oChest, "nUsed");
        SetLocalInt(oPC, "bJoustArmorReturned", TRUE);
//        SetLocked(oChest, TRUE);
        return TRUE;
    }
    return FALSE;
}
