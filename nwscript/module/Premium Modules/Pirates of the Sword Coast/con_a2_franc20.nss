//::///////////////////////////////////////////////
//:: con_a2_franc20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned the Sir Francis is looking
    for a Ring?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
