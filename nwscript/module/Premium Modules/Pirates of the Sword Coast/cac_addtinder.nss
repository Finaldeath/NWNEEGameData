//::///////////////////////////////////////////////
//:: cac_addtinder
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Remove tinder from the PC's inventory and
    add more fuel to the placable fire object
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    int iFHeight = GetLocalInt(oSelf, "iFIREHEIGHT");
    object oWood = GetItemPossessedBy(oPC, "a1_tinder");

    DestroyObject(oWood);
    SetLocalInt(oSelf, "iFIREHEIGHT", (iFHeight + 5));
}
