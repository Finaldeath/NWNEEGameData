//::///////////////////////////////////////////////
//:: cac_a2_franc80
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Francis is now free of his debit and will
    join the PC's crew.
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
    object oFrancis = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_franc");
    object oRing = GetItemPossessedBy(oPC, "a2_petering");
    iEXP = ConvertPercent(iEXP, 1.00f);

    if (GetIsObjectValid(oRing) == TRUE)
    {
        DestroyObject(oRing);

        AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));
        SetLocalInt(oFrancis, "EXIT_TO_CUTLESS", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_FRANC", 80);
        AddJournalQuestEntry("a2_franc", 80, oPC);
    }
}
