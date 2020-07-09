//::///////////////////////////////////////////////
//:: cac_addsticks
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Remove a short stick from the players
    inventory and use it to feed the fire.
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
    int iFHeight = GetLocalInt(oSelf, "iFIREHEIGHT");

    if (GetIsObjectValid(oStick) == TRUE)
    {
        DestroyObject(oStick);
    }

    SetLocalInt(oSelf, "iFIREHEIGHT", (iFHeight + 10));
}
