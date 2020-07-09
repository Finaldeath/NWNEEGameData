/*
    DLA_MEL_LASTWON.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player has won the last time he fought
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    int i = FALSE;
    if (GetLocalInt(GetPCSpeaker(), DLA_OUTCOME) & DLA_OUTCOME_WIN) i = TRUE;
    return i;
}

//::///////////////////////////////////////////////
//:: dla_mel_lastwon
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, that display the node only if the PC
   has won his last fight, and he did talk to the
   Melee Master already after winning.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"

//Display this conversation node if, last time the PC entered the fight, he won.

int StartingConditional()
{
   return GetLocalInt(GetPCSpeaker(), nMeleeOutcome) == 2;
}
