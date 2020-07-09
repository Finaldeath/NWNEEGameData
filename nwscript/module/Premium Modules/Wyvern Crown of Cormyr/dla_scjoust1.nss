//::///////////////////////////////////////////////
//:: dla_scjoust1
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   First day tournament and the first joust
   script conditional to check if this is the first joust for the player. If so
     then set a custom token for opponent name and return TRUE
   Use this for the conversation node stating that the player is going
     against a novice jouster AND after all win/lose checks
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    SetCustomToken(2009, DLA_GetOpponentName(GetPCSpeaker()));
    return TRUE;
}
