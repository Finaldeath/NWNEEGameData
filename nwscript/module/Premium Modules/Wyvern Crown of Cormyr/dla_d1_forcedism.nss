//::///////////////////////////////////////////////
//:: dla_d2_ismounted
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Force caller object to dismount from horse
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Nov 24, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"

void main()
{
            if(DLA_GetIsMounted(OBJECT_SELF))
                DLA_Dismount(OBJECT_SELF);
}