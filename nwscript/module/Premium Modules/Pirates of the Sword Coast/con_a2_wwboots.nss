//::///////////////////////////////////////////////
//:: con_a2_wwboots
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Willigans Boots?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBoots = GetItemPossessedBy(oPC, "a2_wwboots");
    int iResult = FALSE;

    if (GetIsObjectValid(oBoots) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
