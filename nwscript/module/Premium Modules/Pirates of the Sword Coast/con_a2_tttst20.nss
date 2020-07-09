//::///////////////////////////////////////////////
//:: con_a2_tttst20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have paid the Tattooists bail.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_TTTST");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
