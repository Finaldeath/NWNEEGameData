//::///////////////////////////////////////////////
//:: con_a2_nwcutless
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the Monkey's Cutless?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCutless = GetItemPossessedBy(oPC, "a2_nwcutless");
    int iResult = FALSE;

    if (GetIsObjectValid(oCutless) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
