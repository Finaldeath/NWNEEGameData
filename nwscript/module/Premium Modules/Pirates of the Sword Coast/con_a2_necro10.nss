//::///////////////////////////////////////////////
//:: con_a2_necro10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Captain of the Skull and bones offered
    the PC passage if he can fill his crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NECRO");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
