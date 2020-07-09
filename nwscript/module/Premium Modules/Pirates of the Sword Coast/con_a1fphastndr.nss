//::///////////////////////////////////////////////
//:: con_a1fphastndr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the objecct the
    pc is speaking too has a  tinder object
    in their inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    object oTinder = GetItemPossessedBy(oSelf, "a1_tinder");
    int iResult = FALSE;

    if (GetIsObjectValid(oTinder) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
