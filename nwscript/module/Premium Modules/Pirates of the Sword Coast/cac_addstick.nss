//::///////////////////////////////////////////////
//:: cac_addstick
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Remove a stick from the PC's inventory and
    add a lot more fuel to the placable fire object
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    object oStick = GetItemPossessedBy(oPC, "a1_stick");
    object oLStick = GetItemPossessedBy(oPC, "a1_stick_long");

    int iFHeight = GetLocalInt(oSelf, "iFIREHEIGHT");

    if (GetIsObjectValid(oStick) == TRUE)
    {
        DestroyObject(oStick);
        SetLocalInt(oSelf, "iFIREHEIGHT", (iFHeight + 10));
    }
    else if (GetIsObjectValid(oLStick) == TRUE)
    {
        DestroyObject(oLStick);
        SetLocalInt(oSelf, "iFIREHEIGHT", (iFHeight + 15));
    }
}
