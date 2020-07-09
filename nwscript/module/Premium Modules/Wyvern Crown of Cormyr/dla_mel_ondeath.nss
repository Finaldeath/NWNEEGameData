/*
    DLA_MEL_ONDEATH.nss
    gaoneng erick            June 24, 2006

    OnDeath event for the combatants. This tabulates the kill counts and
    execute the end sequence if necessary.
*/

#include "dla_mel_inc2"

void main()
{
    dla_IAmDead();
}


//::///////////////////////////////////////////////
//:: dla_mel_ondeath
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
     Adds one Individual Kill to the Killer of OBJECT_SELF, and one
     Team kill to his team.
     Checks if the Player is the last man standing.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"

void main()
{
    object oPC = GetLastKiller();
    DLA_AddKill(oPC);

    object oMaster = GetMaster(oPC);
    if (GetIsObjectValid(oMaster))
       oPC = oMaster;

    if (GetIsPC(oPC))
       if (DLA_CheckIfPCIsLastMan(oPC))
          DLA_EndFight(oPC);
}
