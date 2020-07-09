//::///////////////////////////////////////////////
//:: con_driftstick
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This scripts checks to see if the object the
    PC is conversing with contains a stick. This is
    used exclusively in the camp fire dialogs.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oStickS = GetItemPossessedBy(OBJECT_SELF, "a1_stick");
    object oStickL = GetItemPossessedBy(OBJECT_SELF, "a1_stick_long");

    int iResult = FALSE;

    if ((GetIsObjectValid(oStickS) == TRUE)
      || ((GetIsObjectValid(oStickL) == TRUE)))
    {
        iResult = TRUE;
    }

    return iResult;
}
