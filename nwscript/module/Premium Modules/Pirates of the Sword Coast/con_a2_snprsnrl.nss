//::///////////////////////////////////////////////
//:: con_a2_snprsnrl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC seen the prisoners in the prison
    and Langer is not yet free?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(oModule, "A2_LANGER");
    int iSeen = GetLocalInt(oModule, "PC_SEEN_PRISONERS");
    int iResult;

    if((iSeen == TRUE) && (iPlot < 30))
    {
        return TRUE;
    }

    return FALSE;
}
