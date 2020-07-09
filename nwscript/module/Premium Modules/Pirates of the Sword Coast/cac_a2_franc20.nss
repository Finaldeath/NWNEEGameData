//::///////////////////////////////////////////////
//:: cac_a2_franc20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have met sir Francis and have learned
    that he is looking for a ring.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oWPPetes = GetWaypointByTag("a2_peteplace");
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_franc");

    SetMapPinEnabled(oWPPetes, TRUE);
    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_FRANC", 20);
    AddJournalQuestEntry("a2_franc", 20, oPC);
}
