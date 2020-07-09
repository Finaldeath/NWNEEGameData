//::///////////////////////////////////////////////
//:: pds_a2_willchest
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnDisturbed script for Willigan's chests.
    This will make sure the mapnotes for this
    chest are set appropriately.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 30, 2005
//:://////////////////////////////////////////////
#include "inc_willigan"

void main()
{
    int bBoots = GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF, a2i_Willigan_Boots));
    int bCutlass = GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF, a2i_Willigan_Cutlass));
    int bGarb = GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF, a2i_Willigan_Garb));

    A2WillyChestSetMapnote(OBJECT_SELF, a2w_Willigan_Chest_Boots, bBoots);
    A2WillyChestSetMapnote(OBJECT_SELF, a2w_Willigan_Chest_Cutlass, bCutlass);
    A2WillyChestSetMapnote(OBJECT_SELF, a2w_Willigan_Chest_Garb, bGarb);
}
