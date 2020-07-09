//::///////////////////////////////////////////////
//:: con_a2_sweet10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has met the optional crewman Sweet
    Marie.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
