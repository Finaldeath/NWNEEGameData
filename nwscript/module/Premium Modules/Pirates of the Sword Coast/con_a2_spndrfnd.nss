//::///////////////////////////////////////////////
//:: con_a2_spndrfnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Tasina not yet fled the island on the
    midnight rose? (There is still a great
    storm at sea.)
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if((iPlot > 0) && (iPlot < 70))
    {
        return TRUE;
    }

    return FALSE;
}
