//::///////////////////////////////////////////////
//:: exe_a2_scepter20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has Aquired the scepter. Update the
    required plot states.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = OBJECT_SELF;

    int iBLKPlot = GetLocalInt(oModule, "A2_BLACKR");
    int iBLDPlot = GetLocalInt(oModule, "A2_BLOODS");

    int iBLDAlly = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
    int iBRBAlly = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");

    int iBLK_EXP = GetJournalQuestExperience("a2_blackr");
    int iBLD_EXP = GetJournalQuestExperience("a2_bloods");
    int iDoOnce = GetLocalInt(oModule, "exe_a2_scepter");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a2_scepter", TRUE);
        if (iBRBAlly == TRUE)
        {
            SetLocalInt(oModule, "A2_BLACKR", 20);
            AddJournalQuestEntry("a2_blackr", 20, oPC);
            HandoutQuestXP(oPC, iBLK_EXP);
        }
        else
        {
            SetLocalInt(oModule, "A2_BLOODS", 20);
            AddJournalQuestEntry("a2_bloods", 20, oPC);
            HandoutQuestXP(oPC, iBLD_EXP);
        }
    }
}
