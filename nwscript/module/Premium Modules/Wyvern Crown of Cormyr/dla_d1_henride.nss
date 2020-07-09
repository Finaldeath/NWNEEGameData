//::///////////////////////////////////////////////
//:: dla_d1_henride
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Command OBJECT_SELF to mount one of it's horses.
    if no horse self owned is avaible, then try to
    mount one of the master's horse.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Dec 10, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"

void main()
{
    object oHorse = DLA_GetHorseHenchman(OBJECT_SELF, 1);
    if (!GetIsObjectValid(oHorse))
        oHorse = DLA_GetHorseHenchman(GetPCSpeaker(), 1);

    if(GetIsObjectValid(oHorse))
    {
        if (!DLA_GetIsMounted(OBJECT_SELF))
        {
                DLA_UnequipShield(OBJECT_SELF);
                DLA_UnequipForbiddenWeapon(OBJECT_SELF);
                //Delay to avoid being cleaned by the ClearAllActions called inside of
                //both DLA_Unequip functions.
                DelayCommand(0.1, DLA_Mount(OBJECT_SELF, oHorse));
        }
    }
    else
    {
        //When PC horses gets removed after conversation node is showed
        FloatingTextStringOnCreature("You don't have a horse available.", GetPCSpeaker(), FALSE);
    }
}
