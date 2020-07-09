//::///////////////////////////////////////////////
//:: con_a2_langer10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard about Langer from the
    executioner?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
