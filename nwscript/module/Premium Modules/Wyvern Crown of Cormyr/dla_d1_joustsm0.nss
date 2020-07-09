//::///////////////////////////////////////////////
//:: dla_d1_joustsm0
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Removes the visual effect showing the shield aim regions
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 22, 2006
//:://////////////////////////////////////////////
//Syrsnein, modified to set a conversation token based on DLA_VAR_STUN_CONDITION
// Modified 30th March to correct conditional

#include "dla_i0_joust"

int StartingConditional()
{
    object oMap = GetObjectByTag("dla_joust_shieldm");
    DestroyObject(oMap);

    int nStun = DLA_GetStunCondition(GetPCSpeaker());
    if (nStun == DLA_JOUST_CONDITION_SHAKEN)
        SetCustomToken(1101, "You have been shaken from the violent hit you took in the last round.  You are restricted to defensive seating until you recover.");
    else if (nStun == DLA_JOUST_CONDITION_STUNNED)
        SetCustomToken(1101, "You have taken two violent hits in succession.  You are restricted to a steady seat until you recover.");
    else SetCustomToken(1101, "");
    return TRUE;
}



