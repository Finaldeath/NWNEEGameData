/*
    DLA_MEL_WINNER.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player won
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    object pc = GetPCSpeaker();
    int i;
    if (GetLocalInt(pc, DLA_JUST_FINISH_BOUT) &&
        (GetLocalInt(pc, DLA_OUTCOME) & DLA_OUTCOME_WIN)) i = TRUE;
    return i;
}

//::///////////////////////////////////////////////
//:: dla_melwinner
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, that display the node only if the
   PC has won his last fight, and he didn't talk
   to the Melee Master yet after winning.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:: Modified: B W-Husey
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"
#include "cu_functions"

//Display this conversation node if last time the PC entered the fight, he won

int StartingConditional()
{
   object oPC = GetPCSpeaker();
   int iResult = GetLocalInt(oPC , nMeleeOutcome) == 2 &&
                 GetLocalInt(oPC , nMeleeJustFinish) == 1;
//   if (iResult)
//      DeleteLocalInt(oPC, nMeleeJustFinish); //Don't remove until after prize given
   return iResult;
}
