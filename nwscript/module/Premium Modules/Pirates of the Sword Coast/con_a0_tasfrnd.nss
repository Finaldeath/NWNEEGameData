//::///////////////////////////////////////////////
//:: con_a0_tasfrnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC was nice to tasina and let her throw
    him in the ocean to die without a fight.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "POTSC_A0_TASINAFRIENDLY");
    int iResult = FALSE;

    if (iFlag == TRUE)
    {
        iResult == FALSE;
    }

    return iResult;
}
