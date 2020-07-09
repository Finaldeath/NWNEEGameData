//::///////////////////////////////////////////////
//:: cac_a2_redtip10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have met the optional crewman Red Tip.
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

    int iEXP = GetJournalQuestExperience("a2_redtip");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_redtip10");
    int iPlot = GetLocalInt(oModule, "A2_REDTIP");

    if ((iDoOnce == FALSE) && (iPlot < 10))
    {
        SetLocalInt(oModule, "cac_a2_redtip10", TRUE);
        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A2_REDTIP", 10);
        AddJournalQuestEntry("a2_redtip", 10, oPC);
    }
}
