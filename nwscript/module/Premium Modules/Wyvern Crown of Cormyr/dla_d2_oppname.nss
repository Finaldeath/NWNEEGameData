//::///////////////////////////////////////////////
//:: dla_d2_oppname
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Shows the opponent name on the tourney
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Feb 3, 2005
//:://////////////////////////////////////////////
//Syrsnein 26 Feb 2006:  Changed for conversation node order
// 5th March 2006: Modified (variable spelling correction) B W-Husey
// 28 Mar 2006: Modified to use Joust State calls

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nJoustState = DLA_GetJoustState(oPC);

    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_2))
    {
        SetCustomToken(2009, DLA_GetOpponentName(oPC));
        return TRUE;
    }
    return FALSE;
}
