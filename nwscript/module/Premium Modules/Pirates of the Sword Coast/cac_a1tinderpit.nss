//::///////////////////////////////////////////////
//:: con_a1tinderpit
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Remove a tinder object from the inventory of
    the PC object and place it in the inventory
    of the fire pit.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oFireWood = GetItemPossessedBy(oPC, "a1_tinder");

    if (GetIsObjectValid(oFireWood) == TRUE)
    {
        CopyItem(oFireWood, oSelf);
        DestroyObject(oFireWood);
    }
}
