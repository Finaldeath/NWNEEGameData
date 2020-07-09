//::///////////////////////////////////////////////
//:: con_drifttinder
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This scripts checks to see if the object the
    PC is conversing with contains tinder. This is
    used exclusively in the camp fire dialogs.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oTinder = GetItemPossessedBy(OBJECT_SELF, "a1_tinder");
    int iResult = FALSE;

    if (GetIsObjectValid(oTinder) == TRUE)
    {
        iResult = TRUE;
    }
    return iResult;
}
