//::///////////////////////////////////////////////
//:: exe_a1_escp40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have aquired both the Plans for a raft
    and the Wood to build it.

    Now all you need to do is put them together.
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
    int iDoOnce = GetLocalInt(oModule, "exe_a1_escp40");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a1_escp40", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_ESCP", 40);
        AddJournalQuestEntry("a1_escp", 40, oPC);
    }
}
