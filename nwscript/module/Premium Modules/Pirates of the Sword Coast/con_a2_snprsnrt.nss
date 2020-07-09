//::///////////////////////////////////////////////
//:: con_a2_snprsnrt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC seen the prisoners in the prison
    and the Tattooist is not yet free?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(GetModule(), "A2_TTTST");
    int iResult;

    if((GetLocalInt(oModule, "PC_SEEN_PRISONERS") == TRUE) && (iPlot < 20))
    {
        return TRUE;
    }

    return FALSE;
}
