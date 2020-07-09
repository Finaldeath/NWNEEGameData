//::///////////////////////////////////////////////
//:: cac_a1dcstrtfire
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start a small fire in the placable fire pit.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oWPFire = GetNearestObjectByTag("a1_cavefire");
    object oTinder = GetItemPossessedBy(oSelf, "a1_tinder");

    location lFire = GetLocation(oWPFire);

    object oPC = GetPCSpeaker();
    ExecuteScript("exe_a1_surviv30", oPC);

    DestroyObject(oTinder);
    SetLocalInt(oSelf, "iFIREHEIGHT", 5);
    CreateObject(OBJECT_TYPE_PLACEABLE, "a1_firesmall", lFire, TRUE,  "a1_currfire");
}
