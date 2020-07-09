//::///////////////////////////////////////////////
//:: con_a2_redtip_bl
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC lost a bet.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 14/05
//:://////////////////////////////////////////////
#include "inc_global"

int StartingConditional()
{
    if( GetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_REDTIP_SAY_1LINER) &&
        !GetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_PLAYER_WON_BET) )
    {
        return TRUE;
    }
    else return FALSE;
}
