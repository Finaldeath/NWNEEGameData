//::///////////////////////////////////////////////
//:: dla_d1_joustnew
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation action script to set the PC to no matches and no wins.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 14 Mar 2006
//:://////////////////////////////////////////////


#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    DLA_SetTourneyMatches(oPC, 0);
    DLA_SetTourneyWins(oPC, 0);
}
