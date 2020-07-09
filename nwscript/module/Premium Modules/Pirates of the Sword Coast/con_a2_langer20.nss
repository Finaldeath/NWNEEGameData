//::///////////////////////////////////////////////
//:: con_a2_langer20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have you met Langer and has he's told you
    his story.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
