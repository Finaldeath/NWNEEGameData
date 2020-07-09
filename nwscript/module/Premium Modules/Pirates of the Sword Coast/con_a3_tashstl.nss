//::///////////////////////////////////////////////
//:: con_a3_tashstl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC attempted to Attack Tasina while she
    was in Spindrift.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "POTSC_A2_TASINAHOSTILE");
    int iResult = FALSE;

    if (iFlag == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
