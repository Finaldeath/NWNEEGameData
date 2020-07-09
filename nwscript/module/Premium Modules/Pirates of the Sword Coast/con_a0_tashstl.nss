//::///////////////////////////////////////////////
//:: con_a0_tashstl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC attempted to preserve his life when
    Tasina killed his friends and respected
    leader.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "POTSC_A0_TASINAHOSTILE");
    int iResult = FALSE;

    if (iFlag == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
