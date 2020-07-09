//::///////////////////////////////////////////////
//:: con_a1_surviv10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    To survive the harsh island that is now your
    prison you will need to find a place to camp
    and light a fire.

    There should be some sutable places on the
    island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A1_SURVIV");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
