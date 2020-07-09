//::///////////////////////////////////////////////
//:: con_a1_noleather
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC out of leather?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oLeather = GetItemPossessedBy(oPC, "a1_leather");

    int iResult = FALSE;

    if (GetIsObjectValid(oLeather) != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
