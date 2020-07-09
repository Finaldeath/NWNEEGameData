//::///////////////////////////////////////////////
//:: con_a1_hasbckt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a bucket in their inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBucket = GetItemPossessedBy(oPC, "a1_bucket_empty");
    object oFBucket = GetItemPossessedBy(oPC, "a1_bucket_full");
    int iResult = FALSE;

    // Does a Bucket exist in the PC's inventory?
    if ((GetIsObjectValid(oBucket) == TRUE)
      || (GetIsObjectValid(oFBucket) == TRUE))
    {
        iResult = TRUE;
    }

    return iResult;
}
