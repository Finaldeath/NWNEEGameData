//::///////////////////////////////////////////////
//:: con_a3_tasmfrnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC let Tasina leave while she
    was in Spindrift and the PC is Male.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    int iFlag = GetLocalInt(oModule, "POTSC_A2_TASINAFRIENDLY");
    int iResult = FALSE;

    if ((iFlag == TRUE) && (GetGender(oPC) == GENDER_MALE))
    {
        iResult == FALSE;
    }

    return iResult;
}
