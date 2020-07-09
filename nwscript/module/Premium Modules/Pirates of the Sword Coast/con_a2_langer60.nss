//::///////////////////////////////////////////////
//:: con_a2_langer60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Langer has been notified of his freedom and
    can be found at the Monkey’s cutless
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if(iPlot >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
