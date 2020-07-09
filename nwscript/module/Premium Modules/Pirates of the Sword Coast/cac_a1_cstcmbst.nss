//::///////////////////////////////////////////////
//:: cac_a1_cstcmbst
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cast spell on fire place object.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
void CreateFire(location lFire);

void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    object oWPFire = GetNearestObjectByTag("a1_cavefire");
    object oTinder = GetItemPossessedBy(oSelf, "a1_tinder");

    location lFire = GetLocation(oWPFire);

    ExecuteScript("exe_a1_surviv30", oPC);

    AssignCommand(oPC, ActionCastSpellAtObject(SPELL_COMBUST, oSelf));
    DestroyObject(oTinder);
    SetLocalInt(oSelf, "iFIREHEIGHT", 5);
    DelayCommand(2.0f, CreateFire(lFire));
}

void CreateFire(location lFire)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "a1_firesmall", lFire, TRUE, "a1_currfire");
}
