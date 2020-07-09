// player sharpens a weapon in the stronghold

#include "x2_inc_itemprop"

void SharpenWeapon(object oPC, object oWeapon)
{
    float fDur = 120.0;
    itemproperty ip = ItemPropertyAttackBonus(1);
    IPSafeAddItemProperty(oWeapon, ip, fDur);
    FloatingTextStringOnCreature("... Weapon Sharpened ...", oPC);
}

void main()
{
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (GetIsObjectValid(oWeapon))
    {
        if (IPGetIsMeleeWeapon(oWeapon))
        {
            AssignCommand(oPC, PlaySound("as_cv_smithhamr1"));
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 5.0));
            DelayCommand(5.1, SharpenWeapon(oPC, oWeapon));
        }
    }
}
