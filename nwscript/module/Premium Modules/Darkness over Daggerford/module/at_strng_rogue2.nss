// player poisons a weapon in the stronghold

#include "x2_inc_itemprop"

void PoisonWeapon(object oPC, object oWeapon)
{
    float fDur = 120.0;
    itemproperty ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON, IP_CONST_ONHIT_SAVEDC_14, IP_CONST_POISON_1D2_STRDAMAGE);
    IPSafeAddItemProperty(oWeapon, ip, fDur);
    FloatingTextStringOnCreature("... Weapon Poisoned ...", oPC);
}
void main()
{
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (GetIsObjectValid(oWeapon))
    {
        if (IPGetIsMeleeWeapon(oWeapon))
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0));
            DelayCommand(2.1, PoisonWeapon(oPC, oWeapon));
        }
    }
}
