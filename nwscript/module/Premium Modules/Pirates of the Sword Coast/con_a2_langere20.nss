//::///////////////////////////////////////////////
//:: con_a2_langere20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Heard Langers story?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if(iPlot == 20)
    {
        return TRUE;
    }

    return FALSE;

}
