// horse utility functions
// .. some of this code comes from nw_g0_transition

#include "x3_inc_horse"

const float fX3_MOUNT_MULTIPLE = 1.0;

// returns true if at least one party member is mounted
int HorsePartyIsMounted(object oPC)
{
    if (HorseGetIsMounted(oPC))
    {
        return TRUE;
    }

    int i = 1;
    object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
    while(GetIsObjectValid(oHench))
    {
        if (HorseGetIsMounted(oHench))
        {
            return TRUE;
        }
        oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, ++i);
    }
    return FALSE;
}

// returns true if the party owns at least one horse
int HorsePartyHasHorse(object oPC)
{
    if (HorseGetIsMounted(oPC)) return TRUE;
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        if (HorseGetIsMounted(oHench)) return TRUE;
        if (HorseGetIsAMount(oHench)) return TRUE;
        oHench = GetHenchman(oPC, ++i);
    }
    return FALSE;
}

// instantly hitch the party's horses to a nearby post
// warning: this only works if the party is not mounted
float HorsePartyHitchHorses(object oPC)
{
    if (HorsePartyHasHorse(oPC))
    {
        object oHitch = GetNearestObjectByTag("X3_HITCHING_POST", oPC);
        if (GetIsObjectValid(oHitch))
        {
            location lPost = GetLocation(oHitch);
            HorseHitchHorses(oHitch, oPC, lPost);
            return 0.5;
         }
     }
     return 0.0;
}

// force the party to mount their horses
// returns the number of seconds that the mounting animations require
float HorsePartyMount(object oPC, int bAnim, int bInstant)
{
    float fDelay = 0.0;

    // player mounts
    if (!HorseGetIsMounted(oPC) && HorseGetHasAHorse(oPC))
    {
        object oHorse = HorseGetHorse(oPC);
        AssignCommand(oPC, HorseMount(oHorse, bAnim, bInstant));
        fDelay += 0.2 * fX3_MOUNT_MULTIPLE;
    }

    // henchmen mount
    int i = 1;
    object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
    while(GetIsObjectValid(oHench))
    {
        if (!HorseGetIsMounted(oHench) && HorseGetHasAHorse(oHench))
        {
            object oHorse = HorseGetHorse(oHench);
            DelayCommand(fDelay, AssignCommand(oHench, HorseMount(oHorse, bAnim, bInstant)));
            fDelay += 0.2 * fX3_MOUNT_MULTIPLE;
        }
        oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, ++i);
    }

    // even without animations, mounting seems to take at least 3 seconds
    if (fDelay > 0.0 && fDelay < 3.0)
    {
        fDelay = 3.0;
    }
    return fDelay;
}

