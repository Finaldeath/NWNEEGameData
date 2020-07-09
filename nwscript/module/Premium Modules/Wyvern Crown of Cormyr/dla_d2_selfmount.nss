//::///////////////////////////////////////////////
//:: dla_d2_selfmount
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Check if the creature to wich the player is speaking (OBJECT_SELF)
   is mounted in a horse
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Nov 24, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"

int StartingConditional()
{
    return DLA_GetIsMounted(OBJECT_SELF);
}
