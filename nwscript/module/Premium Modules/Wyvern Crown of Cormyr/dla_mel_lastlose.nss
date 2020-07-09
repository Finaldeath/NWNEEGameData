/*
    DLA_MEL_LASTLOSE.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player has fought before but lost the last fight
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    int i;
    int outcome = GetLocalInt(GetPCSpeaker(), DLA_OUTCOME);
    if ((outcome & DLA_OUTCOME_FOUGHT_BEFORE) && !(outcome & DLA_OUTCOME_WIN)) i = TRUE;
    return i;
}

//::///////////////////////////////////////////////
//:: dla_mel_lastlose
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, that display the node only if the
   PC has lose his last fight, and he did talk to
   the Melee Master already after losing.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"

//Display this conversation node if, last time the PC entered the fight, he lose.

int StartingConditional()
{
   return GetLocalInt(GetPCSpeaker(), nMeleeOutcome) == 1;
}
