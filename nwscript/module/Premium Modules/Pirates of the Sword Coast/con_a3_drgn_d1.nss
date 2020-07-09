//:://////////////////////////////////////////////
//:: con_a3_drgn_d1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Do once check for meeting the underwater
    dragon for the first time.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oSelf, "cac_a3_drgn_d1");
    int iResult = FALSE;

    if (iDoOnce == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
