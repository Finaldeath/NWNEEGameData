//::///////////////////////////////////////////////
//:: con_a2_langerl30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
   is the langer quest active but not complete?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if((iPlot < 30) && (iPlot > 10))
    {
        return TRUE;
    }

    return FALSE;

}
