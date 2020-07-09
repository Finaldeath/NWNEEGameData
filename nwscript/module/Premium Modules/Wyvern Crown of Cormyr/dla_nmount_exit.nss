//::///////////////////////////////////////////////
//:: No Mount Area OnExit Event
//:: dla_nmount_exit
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Mark the creaturing exiting the no mount area
   as being able to ride (and have horses) again.
*/

//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Dec 9, 2005
//:://////////////////////////////////////////////

#include "dla_i0_const"
#include "dla_i0_feats"

void main()
{
    object oPC = GetExitingObject();
    DeleteLocalInt(oPC, "DLA_CANT_MOUNT");
}

