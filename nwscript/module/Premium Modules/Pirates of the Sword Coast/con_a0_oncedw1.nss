//::///////////////////////////////////////////////
//:: con_a0_oncedw1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script sets a DO ONCE variable on the dock
    workers in the Silver Sails.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iDoOnce = GetLocalInt(oPC, "cac_a0_oncedw1");
    int iResult = FALSE;

    if  (iDoOnce == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
