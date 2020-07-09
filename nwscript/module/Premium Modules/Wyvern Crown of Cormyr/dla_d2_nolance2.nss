//::///////////////////////////////////////////////
//:: dla_d2_nolance2
//:: DLA Wyvern Crown of Cormyr
//:://////////////////////////////////////////////
/*
    Conditional script for lance selection to tell us if the player can carry a
    lance so that he actually equips it when it is time.  Creates a place holder
    and tries to give it to the player.
*/
//:://////////////////////////////////////////////
//:: Created By: Dave Musser (Syrsnein)
//:: Created On: 31 July 2006
//:://////////////////////////////////////////////
/* Change History

 Date
 year/mm/dd | Author   | Change
 -----------+----------+--------------------------------------------------------
 2006/8/15 - additional HasItem check - B G P Hughes
 2006/10/22   Syrsnein  Added shield check.
 */

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int bNoLance = TRUE;
    int bNoShield = TRUE;

    object oLanceHolder = CreateItemOnObject(DLA_TAG_JOUST_LANCEHOLDER, oPC);
    object oShieldHolder = CreateItemOnObject(DLA_TAG_JOUST_SHIELDHOLDER, oPC);

    // Lance Check
    if (GetIsObjectValid(oLanceHolder))
    {
        bNoLance = FALSE;
        DestroyObject(oLanceHolder, 0.1);
    }
    // Added BGP to make the fullinventory check work
    if (!HasItem(oPC,GetTag(oLanceHolder)))
    {
        bNoLance = TRUE;
        DestroyObject(oLanceHolder, 0.1);
    }
    // end Lance Check

    // Shield Check
    if (GetIsObjectValid(oShieldHolder))
    {
        bNoShield = FALSE;
        DestroyObject(oShieldHolder, 0.1);
    }
    if (!HasItem(oPC,GetTag(oShieldHolder)))
    {
        bNoShield = TRUE;
        DestroyObject(oShieldHolder, 0.1);
    }
    // end Shield Check
    return bNoLance;
}
