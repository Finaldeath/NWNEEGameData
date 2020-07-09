//::///////////////////////////////////////////////
//:: pus_a1_bucket
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Create an empty bucket in the player's
     inventory and destroy the placeable version.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: Jan 7, 2005
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    int bDoOnce = GetLocalInt(oSelf, "pus_a1_bucket");

    if ((bDoOnce == FALSE) && (GetIsPC(oPC) == TRUE))
    {
        SetLocalInt(oSelf, "pus_a1_bucket", TRUE);
        if (GetIsPC(oPC) == TRUE)
        {
            CreateItemOnObject("a1_bucket_empty", oPC, 1);
        }

        DestroyObject(oSelf, 0.1);

    }
}
