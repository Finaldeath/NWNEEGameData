//::///////////////////////////////////////////////
//:: con_a1_hasbcktf
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a full bucket in their
    inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFBucket = GetItemPossessedBy(oPC, "a1_bucket_full");
    int iResult = FALSE;

    // Does a Bucket exist in the PC's inventory?
    if (GetIsObjectValid(oFBucket) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
