//::///////////////////////////////////////////////
//:: con_a0_check
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player still in Act 0?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iAct0End = GetLocalInt(oModule, "A0_SEIGE");
    int iResult = FALSE;

    if (iAct0End < 40)
    {
        iResult = TRUE;
    }

    return iResult;
}
