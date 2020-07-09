//::///////////////////////////////////////////////
//:: con_a0_tasdslike
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC was mean to Tasina during the escort
    mission.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "POTSC_A0_TASINADISLIKE");
    int iResult = FALSE;

    if (iFlag == TRUE)
    {
        iResult == FALSE;
    }

    return iResult;
}
