//::///////////////////////////////////////////////
//:: con_a2_nwctls20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC obtained the monkey's cutless?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NWCTLS");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
