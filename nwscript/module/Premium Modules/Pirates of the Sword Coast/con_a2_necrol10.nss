//::///////////////////////////////////////////////
//:: con_a2_necrol10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player not yet agreed to help crew the
    Necromatic Pirates ship?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NECRO");

    if(iPlot < 10)
    {
        return TRUE;
    }

    return FALSE;

}
