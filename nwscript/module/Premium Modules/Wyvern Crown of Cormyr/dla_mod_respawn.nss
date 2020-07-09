//::///////////////////////////////////////////////
//:: Module Respawn Event
//:: dla_horse_onresp
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Currenly does the following:
     -Basic respawn (using nw_o0_respawn)
     -Resets Increased movement speed.
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: June 6, 2005
//:: Modified by: B W-Husey to execute respawning behaviour for PCs
//:://////////////////////////////////////////////

#include "dla_i0_horse"
#include "nw_i0_plot"

void main()
{
    object oRespawner = GetLastRespawnButtonPresser();

    //DON NOT REMOVE
    ExecuteScript("misc_respawn", OBJECT_SELF);

    //some settings not persistent, need to reset on PCs respawning
    DLA_RefreshMovementSpeed(oRespawner);
}
