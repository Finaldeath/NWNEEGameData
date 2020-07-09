//::///////////////////////////////////////////////
//:: con_boulderstn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This scripts checks to see if the object the
    PC is conversing with contains stones. This is
    used exclusively in the camp fire dialogs.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oStone = GetItemPossessedBy(OBJECT_SELF, "a1_stone");
    int iResult = FALSE;

    if (GetIsObjectValid(oStone) == TRUE)
    {
        iResult = TRUE;
    }
    return iResult;
}
