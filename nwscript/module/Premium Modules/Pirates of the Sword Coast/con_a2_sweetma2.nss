//::///////////////////////////////////////////////
//:: con_a2_sweetma2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has Started the Sweet Maries Plot
    but has not left the second act.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(oModule, "A2_SWEET");
    int iAct2 = GetLocalInt(oModule, "A2_SPNDRF");

    if ((iPlot > 0) && (iAct2 < 70) && (iAct2 > 0))
    {
        return TRUE;
    }

    return FALSE;

}
