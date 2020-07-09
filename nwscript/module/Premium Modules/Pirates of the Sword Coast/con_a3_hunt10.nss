//::///////////////////////////////////////////////
//:: con_a3_hunt10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has gained the maps where the
    solutions to the maps have been buried.

    During the exchange Old Tom started to act
    strangely and gave the PC a strange amulet,
    saying something about "needing it more
    then the maps to survive this".
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_HUNT");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
