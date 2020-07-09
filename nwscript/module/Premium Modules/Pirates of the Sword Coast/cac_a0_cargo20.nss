//::///////////////////////////////////////////////
//:: cac_a0_cargo20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has initiated the Statue Plot. The PC
    knows Martins is missing and that he must seek
    Martins out at the Seedy Tavern.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oSpawnLoc = GetWaypointByTag("wp_spwn_martins");
    location lSpawnLoc = GetLocation(oSpawnLoc);
    int iDoOnce = GetLocalInt(OBJECT_SELF, "cac_a0_cargo20");

    int iEXP = GetJournalQuestExperience("a0_cargo");
    iEXP = ConvertPercent(iEXP, 0.20f);

    if (iDoOnce == FALSE)
    {
        SetLocalInt(OBJECT_SELF, "cac_a0_cargo20", TRUE);
        CreateObject(OBJECT_TYPE_CREATURE, "a0_martins", lSpawnLoc);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A0_CARGO", 20);
        AddJournalQuestEntry("a0_cargo", 20, oPC);
    }
}
