//::///////////////////////////////////////////////
//:: con_a2_sweetnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sweet Maries quest has been started but not
    Completed.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if((iPlot > 0) && (iPlot < 50))
    {
        return TRUE;
    }

    return FALSE;

}
