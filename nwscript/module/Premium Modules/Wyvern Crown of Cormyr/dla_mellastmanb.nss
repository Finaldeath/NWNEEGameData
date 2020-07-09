/*
    DLA_MELLASTMANB.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player is last man standing and lost
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    object pc = GetPCSpeaker();
    DeleteLocalInt(pc, DLA_JUST_FINISH_BOUT);
    int i;
    if (GetLocalInt(pc, DLA_OUTCOME) & DLA_OUTCOME_LAST_MAN) i = TRUE;
    return i;
}

//::///////////////////////////////////////////////
//:: dla_mellastmanb
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, that display the node only if the
   PC was the last man standing and lost, and he didn't talk
   to the Melee Master yet after winning.
*/
//:://////////////////////////////////////////////
//:: Create By: B W-Husey
//:: Created On: Jan 20, 2006
//:://////////////////////////////////////////////
/*
 #include "dla_mel_inc"

int StartingConditional()
{
   object oPC = GetPCSpeaker();
      DeleteLocalInt(oPC, nMeleeJustFinish);
    // Inspect local variables
    if(GetLocalInt(oPC, "nLastManStand") == 1)
        return TRUE;

    return FALSE;
}


