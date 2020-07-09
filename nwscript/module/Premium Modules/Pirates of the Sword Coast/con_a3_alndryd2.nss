//:://////////////////////////////////////////////
//:: con_a3_alndryd2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC has sworne the oath to
    alledry's ghost yet.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oSelf, "cac_a3_alndryd2");
    int iResult = FALSE;

    if (iDoOnce == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
