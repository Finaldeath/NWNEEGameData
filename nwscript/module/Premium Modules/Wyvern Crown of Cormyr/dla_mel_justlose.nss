/*
    DLA_MEL_JUSTLOSE.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player has lost
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    object pc = GetPCSpeaker();
    int i = FALSE;
    if (GetLocalInt(pc, DLA_JUST_FINISH_BOUT) &&
        !(GetLocalInt(pc, DLA_OUTCOME) & DLA_OUTCOME_WIN)) i = TRUE;
    if (i) DeleteLocalInt(pc, DLA_JUST_FINISH_BOUT);
    return i;
}

//::///////////////////////////////////////////////
//:: dla_mel_justlose
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, that display the node only if the
   PC has lose his last fight, and he didn't talk
   to the Melee Master yet after losing.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:: Modified: B W-Husey
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"
#include "cu_functions"

int StartingConditional()
{
   object oPC = GetPCSpeaker();

   SetCustomToken(5000, IntToString(DLA_GetNumIndividualKills(oPC)));
   SetCustomToken(5001, IntToString(DLA_GetNumTeamKills(oPC)));
   SetCustomToken(5002, DLA_GetLastFightWinnerName(oPC)); //2 nome
   SetCustomToken(5003, IntToString(DLA_GetLastFightWinnerIKills(oPC))); //3 individual
   SetCustomToken(5004, IntToString(DLA_GetLastFightWinnerTKills(oPC))); //4 equipe
   SetCustomToken(5005,"");
    if (ReturnHenchman(oPC,1)!=OBJECT_INVALID)   SetCustomToken(5005, "and your companions");


   int iResult = GetLocalInt(oPC , nMeleeOutcome) == 1 &&
                 GetLocalInt(oPC , nMeleeJustFinish) == 1;
   if (iResult)
      DeleteLocalInt(oPC, nMeleeJustFinish);
   return iResult;
}
