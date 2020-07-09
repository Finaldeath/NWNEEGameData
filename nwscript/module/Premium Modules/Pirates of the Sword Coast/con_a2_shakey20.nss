//::///////////////////////////////////////////////
//:: con_a2_shakey20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC failed to successfully intimidate
    Shaky?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SHAKEY");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
