/*
    DLA_MEL_TOOBIG.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player's party size is larger than the allowed
    limit. Summonables and Possessed do not count toward party size
    (those will be removed before entering the arena) but henchmen,
    familiars and animal companions do.
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    return dla_ReturnPCPartySize(GetPCSpeaker()) > DLA_MAX_PCPARTYSIZE;
}

//::///////////////////////////////////////////////
//:: dla_mel_start
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
     Shows this conversation node if the PC's party
     is too big to enter the melee fight
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"

int StartingConditional()
{
    return DLA_GetNumMembersOnTeam(GetPCSpeaker()) > DLA_MEL_MAX_PC_PARTY_SIZE;
}
