//::///////////////////////////////////////////////
//:: con_a0_turfwr30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Bandits have fallen to the cunning of
    the player but in the fonfusion the local
    Blood sailors have fallen under the
    assumption that the Player is a member
    of the bandit gang.

    You must defend yourself and end the turf war.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
