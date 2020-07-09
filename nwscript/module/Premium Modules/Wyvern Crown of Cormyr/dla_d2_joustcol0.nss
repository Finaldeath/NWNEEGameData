////////////////////////////////////////////////////////////////////////////////
// dla_d2_joustcol0
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Does the player have armor to return?
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
        if (GetIsObjectValid(oHelm)  ||
            GetIsObjectValid(oArmor) ||
            GetIsObjectValid(oShield))
        {
            return TRUE;
        }
    }
    return FALSE;
}
