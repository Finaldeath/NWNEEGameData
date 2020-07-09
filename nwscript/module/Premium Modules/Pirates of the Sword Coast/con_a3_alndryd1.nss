//:://////////////////////////////////////////////
//:: con_a3_alndryd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC has met alledry's ghost
    before.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oSelf, "cac_a3_alndryd1");
    int iResult = FALSE;

    if (iDoOnce == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
