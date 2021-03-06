//::///////////////////////////////////////////////
//:: cac_a2_spndrf50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have received the Robe and learned that
    a secondary entrance to the temple is hidden
    somewhere in the sewers.
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

    int iEXP = GetJournalQuestExperience("a2_spndrf");
    iEXP = ConvertPercent(iEXP, 0.20f);
    int iDoOnce = GetLocalInt(oModule, "cac_a2_spndrf50");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_spndrf50", TRUE);
        CreateItemOnObject("a2_umbrlntrobe", oPC);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_SPNDRF", 50);
        AddJournalQuestEntry("a2_spndrf", 50, oPC);
    }
}
