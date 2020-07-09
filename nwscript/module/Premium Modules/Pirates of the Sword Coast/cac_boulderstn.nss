//::///////////////////////////////////////////////
//:: cac_boulderstn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Remove all of the objects in the inventory of
    the boulder and place copies in the PC
    Speakers inventory
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oStone = GetFirstItemInInventory(oSelf);

    //cycle through the object inventroy make copies
    //of the items in the PC's inventory then destroy the
    //originals
    while (GetIsObjectValid(oStone) == TRUE)
    {
        CopyItem(oStone, oPC);
        DestroyObject(oStone);
        oStone = GetNextItemInInventory(oSelf);
    }
}
