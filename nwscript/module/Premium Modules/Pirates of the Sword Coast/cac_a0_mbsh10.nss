//::///////////////////////////////////////////////
//:: cac_a0_mbsh10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has met Dela and has heard of her
    shop in the alley way by the docks
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oWayPoint = GetWaypointByTag("MP_DELACON");
    object oDocks = GetObjectByTag("Map_M1Q4A");
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_cargo");
    iEXP = ConvertPercent(iEXP, 0.20f);

    //ExploreAreaForPlayer(oDocks, oPC);
    HandoutQuestXP(oPC, iEXP);

    AddJournalQuestEntry("a0_ambush", 10, oPC);
    SetLocalInt(GetModule(), "A0_AMBUSH", 10);
    SetMapPinEnabled(oWayPoint, TRUE);
}
