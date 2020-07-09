//::///////////////////////////////////////////////
//:: cac_a2_sweet30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've learned of Sweet Maries love of wild
    flowers, if you can bring her some she'll
    surely join your crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    object oWayPoint = GetWaypointByTag("A2_WPFLOWERS");
    int iEXP = GetJournalQuestExperience("a2_sweet");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_sweet30");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_sweet30", TRUE);

        CreateItemOnObject("map_flower", oPC);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_SWEET", 30);
        AddJournalQuestEntry("a2_sweet", 30, oPC);
    }
}
