//::///////////////////////////////////////////////
//:: exe_a1_escp30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have aquired some plans for a raft.

    With some sturdy would you could escape
    the island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();
    int iEXP = GetJournalQuestExperience("a1_escp");
    iEXP = ConvertPercent(iEXP, 0.30f);
    int iDoOnce = GetLocalInt(oModule, "exe_a1_escp30");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a1_escp30", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_ESCP", 30);
        AddJournalQuestEntry("a1_escp", 30, oPC);
    }
}
