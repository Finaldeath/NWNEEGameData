//::///////////////////////////////////////////////
//:: Module OnEnter Event
//:: dla_horse_onent
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    This event is used to make sure the right amount of penalty
    is applied, as it recheck the penaulty to take in account if
    the PC has taken the feat Mounted Archery
    Resets using ranged weapon while mounted penaulty
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Dec 3, 2005
//:://////////////////////////////////////////////

#include "cu_functions"

void main()
{
    object oPC = GetPCLevellingUp();

    //Gale 3 Dec 2005
    //Apply penaulty if using ranged weapon and is mounted.
    //Take in account mounted archery feat penaulty reduction
    AssignCommand(oPC, DLA_RefreshMountedArcheryPenalty());

    LevelUpXP1Henchman(oPC);

}
