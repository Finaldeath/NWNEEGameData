//::///////////////////////////////////////////////
//:: con_a1_utnald1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Return true if this is the first time speaking
    to Utnal the Troglodyte.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Dec, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSpeaker = OBJECT_SELF;

    int iDoOnce = GetLocalInt(oSpeaker, "con_a1_utnald1");
    int iResult;

    // Return true if this hasn't happened before
    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSpeaker, "con_a1_utnald1", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
