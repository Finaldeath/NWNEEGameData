//::///////////////////////////////////////////////
//:: con_a2_redtipl30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC NOT Defeated Redtip in the ring?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_REDTIP");

    if(iPlot < 30)
    {
        return TRUE;
    }

    return FALSE;

}
