//::///////////////////////////////////////////////
//:: a1_cavefiredonce
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checking to see if the fire has ever been lit.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oSelf, "a1_cavefiredonce");
    int iResult = FALSE;

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSelf, "a1_cavefiredonce", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
