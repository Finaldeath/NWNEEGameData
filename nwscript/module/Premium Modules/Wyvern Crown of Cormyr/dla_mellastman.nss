/*
    DLA_MELLASTMAN.nss
    gaoneng erick            June 24, 2006

    returns TRUE if player is last man standing
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    int i;
    if (GetLocalInt(GetPCSpeaker(), DLA_OUTCOME) & DLA_OUTCOME_LAST_MAN) i = TRUE;
    return i;
}

//::///////////////////////////////////////////////
//:: dla_mellastman
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional, that display the node only if the
   PC was the last man standing, and he didn't talk
   to the Melee Master yet after winning.
*/
//:://////////////////////////////////////////////
//:: Create By: B W-Husey
//:: Created On: Jan 20, 2006
//:://////////////////////////////////////////////
/*
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nLastManStand") == 1))
        return FALSE;

    return TRUE;
}


