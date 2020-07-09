// is the player holding a melee weapon?

#include "x2_inc_itemprop"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (GetIsObjectValid(oWeapon))
    {
        if (IPGetIsMeleeWeapon(oWeapon))
        {
            string sName = GetName(oWeapon);
            SetCustomToken(100, sName);
            return(FALSE);
        }
    }
    return(TRUE);
}
