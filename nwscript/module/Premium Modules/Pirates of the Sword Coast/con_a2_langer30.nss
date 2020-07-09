//::///////////////////////////////////////////////
//:: con_a2_langer30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have you talked with the Mayor you've
    convinced him to free Langer and Drop
    the charges.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
