//::///////////////////////////////////////////////
//:: con_a2_midrse10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC has heard the Midnight Rose is
    in Port in Spindrift"


*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_MIDROSE");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
