/*
    DLA_MEL_START.nss
    gaoneng erick            June 24, 2006

    starts the melee tournament.
*/

#include "dla_mel_inc2"

void main()
{
    dla_StartMeleeTournament(GetPCSpeaker());
}

//::///////////////////////////////////////////////
//:: dla_mel_start
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
     Start a melee fight, using default parameters
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"

void main()
{
    if (DLA_GetNumMembersOnTeam(GetPCSpeaker()) <= DLA_MEL_MAX_PC_PARTY_SIZE)
        DLA_StartMeleeFight(GetPCSpeaker(), 16);
}

