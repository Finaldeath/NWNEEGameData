/*
    DLA_MEL_JUSTWONB.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player has won but was not last man standing
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    object pc = GetPCSpeaker();
    int i = FALSE;
    int outcome = GetLocalInt(pc, DLA_OUTCOME);
    if (GetLocalInt(pc, DLA_JUST_FINISH_BOUT) &&
        (outcome & DLA_OUTCOME_WIN) &&
        !(outcome & DLA_OUTCOME_LAST_MAN)) i = TRUE;
    return i;
}

//::///////////////////////////////////////////////
//:: dla_mel_justwon
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, that display the node only if the
   PC has won his last fight and was NOT last man standing, and he didn't talk
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

//Display this conversation node if last time the PC entered the fight, he won, and was the last man standing

int StartingConditional()
{
   object oPC = GetPCSpeaker();

   SetCustomToken(5000, IntToString(DLA_GetNumIndividualKills(oPC)));
   SetCustomToken(5001, IntToString(DLA_GetNumTeamKills(oPC)));
   SetCustomToken(5005,"");
   SetCustomToken(5006, IntToString(GetLocalInt(oPC, "DLA_mel_timesday")));
    if (ReturnHenchman(oPC,1)!=OBJECT_INVALID)   SetCustomToken(5005, "and your companions");

   int iResult = GetLocalInt(oPC , nMeleeOutcome) == 2 &&
                 GetLocalInt(oPC , nMeleeJustFinish) == 1 &&
                 GetLocalInt(oPC, nLastManStand) == 0;
//   if (iResult)
//      DeleteLocalInt(oPC, nMeleeJustFinish); //Don't remove until after prize given
   return iResult;
}
