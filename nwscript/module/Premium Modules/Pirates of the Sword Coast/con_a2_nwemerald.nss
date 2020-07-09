//::///////////////////////////////////////////////
//:: con_a2_nwemerald
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the Midnight Rose's Emerald?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oEmerald = GetItemPossessedBy(oPC, "a2_nwemerald");
    int iResult = FALSE;

    if (GetIsObjectValid(oEmerald) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
