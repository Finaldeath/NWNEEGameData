//::///////////////////////////////////////////////
//:: cac_a1_fillbckt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fill one of the players buckets
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oBucket = GetItemPossessedBy(oPC, "a1_bucket_empty");

    if (GetIsObjectValid(oBucket) == TRUE)
    {
        CreateItemOnObject("a1_bucket_full", oPC);
        DestroyObject(oBucket);
    }
}
