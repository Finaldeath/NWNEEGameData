//::///////////////////////////////////////////////
//:: con_a2_langer70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Langer has successfully undergone the Extreme
    pirate makeover. Now he can be found at the
    monkey's cutless
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if(iPlot >= 70)
    {
        return TRUE;
    }

    return FALSE;

}
