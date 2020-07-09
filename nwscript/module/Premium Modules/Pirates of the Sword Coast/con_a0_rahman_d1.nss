//::///////////////////////////////////////////////
//:: con_a0_rahman_d1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Return true if this is the first time speaking
    to Rahman the Wizard.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSpeaker = OBJECT_SELF;

    int iDoOnce = GetLocalInt(oSpeaker, "con_a0_alybld_d1");
    int iResult;

    // Return true if this hasn't happened before
    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSpeaker, "con_a0_alybld_d1", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
