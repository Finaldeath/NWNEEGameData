//::///////////////////////////////////////////////
//:: con_a1_hasbckte
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a empty bucket in their
    inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBucket = GetItemPossessedBy(oPC, "a1_bucket_empty");
    int iResult = FALSE;

    // Does a Empty Bucket exist in the PC's invetory?
    if (GetIsObjectValid(oBucket) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
