//::///////////////////////////////////////////////
//:: con_a2_tttstl20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have you met that tattooist but not freed him?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_TTTST");

    if((iPlot < 20) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
