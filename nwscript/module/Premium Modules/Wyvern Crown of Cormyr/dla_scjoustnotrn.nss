//::///////////////////////////////////////////////
//:: dla_scjoustnotrn
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation conditional script to determine if the player is able to
    do a training match.  Returns TRUE if the player has already started but not
    completed a tournament.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    return DLA_GetIsEnteredInLists(GetPCSpeaker());
}
