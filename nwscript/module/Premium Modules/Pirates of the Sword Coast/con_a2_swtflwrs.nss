//::///////////////////////////////////////////////
//:: con_a2_swtflwrs
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Sweet Maries flowers?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFlowers = GetItemPossessedBy(oPC, "a2_flowers");
    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if (GetIsObjectValid(oFlowers) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
