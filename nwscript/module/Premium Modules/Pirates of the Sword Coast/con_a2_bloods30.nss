//::///////////////////////////////////////////////
//:: con_a2_bloods30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Vengaul has the Scepter, he will now wait in
    the Monkey's cutless for you to set sail.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_BLOODS");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
