//::///////////////////////////////////////////////
//:: dla_scjoustwin
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation conditional script calling DLA_JoustMatchEnd to clean up
    the last joust match and return TRUE if oPC is the winner.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nPCScore  = DLA_GetScoreOnMatch(oPC, FALSE);
    int nNPCScore = DLA_GetScoreOnMatch(oPC, TRUE );
    if (nPCScore > nNPCScore)
    {
        DLA_JoustMatchEnd(oPC);
        return TRUE;
    }
    return FALSE;
}
