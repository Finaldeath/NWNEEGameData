/*
    DLA_MEL_EVENLOSE.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player has equal number of kills with combatant
    winner but is not last man standing.
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    int i = FALSE;
    int outcome = GetLocalInt(GetPCSpeaker(), DLA_OUTCOME);
    if ((outcome & DLA_OUTCOME_DRAW) && !(outcome & DLA_OUTCOME_LAST_MAN)) i = TRUE;
    return i;
}

//::///////////////////////////////////////////////
//:: dla_mel_evenlose
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, PC and winner had = number of kills
    (Used when PC lost the fight with kills = to winner, but winner was still standing)
*/
//:://////////////////////////////////////////////
//:: Create By: B W-Husey
//:: Created On: Jan 21, 2006
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"
#include "cu_functions"

int StartingConditional()
{
   object oPC = GetPCSpeaker();

   if (DLA_GetNumTeamKills(oPC)==DLA_GetLastFightWinnerTKills(oPC))
    return TRUE;
    return FALSE;
}
