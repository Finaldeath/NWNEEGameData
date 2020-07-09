//::///////////////////////////////////////////////
//:: con_a1_noichor
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC out of Ichor?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oIchor = GetItemPossessedBy(oPC, "a1_ichor");

    int iResult = FALSE;

    if (GetIsObjectValid(oIchor) != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
