//::///////////////////////////////////////////////
//:: No Mount Area OnEnter Event
//:: dla_nmount_enter
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Mark the creaturing entering the no mount area
   dismount any horse currently mounted by itself and henchmen
   also mark the create as not being able to ride a horse
   while on no mount area.
*/

//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Dec 9, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"
#include "dla_i0_horseai"
#include "dla_i0_mount"
#include "cu_functions"

void main()
{

    object oPC = GetEnteringObject();

    int bWarned;
    object oHorse;
    object oHitchingPost = GetNearestObjectByTag(DLA_TAG_HITCHING_POST);
    SetLocalInt(oPC, "DLA_CANT_MOUNT", TRUE);

    // Deva Winblood - 8/03/2006
    DLA_NoHorseTransition(oPC,OBJECT_INVALID,TRUE,TRUE,oHitchingPost);

   /* if (DLA_GetIsMounted(oPC))
    {
       FloatingTextStringOnCreature("Horses are now tied to nearby hitching post", oPC, FALSE);
       bWarned=TRUE;
       DLA_Dismount(oPC);
    }


    if (DLA_RemoveAllHenchmenHorses(oPC, oHitchingPost) && !bWarned )
    {
          FloatingTextStringOnCreature("Horses are now tied to nearby hitching post", oPC, FALSE);
          bWarned=TRUE;
    }*/
}
