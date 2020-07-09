//::///////////////////////////////////////////////
//:: dla_scjoustmatch
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Returns TRUE if the PC already has accepted a joust match but hasn't
    started it yet.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return (DLA_GetHasJoustMatch(oPC) &&
            DLA_JoustGetCanJoust(oPC));
}
