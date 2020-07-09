//::///////////////////////////////////////////////
//:: exe_a1_escp10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has awoken on a desserted Island
    on the Sea of Swords.

    You must Escape.
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
    int iDoOnce = GetLocalInt(oModule, "exe_a1_escp10");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a1_escp10", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_ESCP", 10);
        AddJournalQuestEntry("a1_escp", 10, oPC);
    }
}
