//::///////////////////////////////////////////////
//:: ndt_a0_seigeboss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A a0 seige boss has died.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
        PLAYER_CHAR_IS_PC, oSelf);

    string sComplete = GetLocalString(oArea, "COMPLETE_NOTE");
    string sInComplete = GetLocalString(oArea, "INCOMPLETE_NOTE");

    object oComplete = GetObjectByTag(sComplete);
    object oInComplete = GetObjectByTag(sInComplete);

    SetMapPinEnabled(oComplete, TRUE);
    SetMapPinEnabled(oInComplete, FALSE);

    ExecuteScript("exe_a0_turfwrinc", oPC);
}
