//::///////////////////////////////////////////////
//:: exe_a3_water10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have exited the hold of the Skull and
    bones to find you've pulled up along side the
    Midnight Rose
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a3_water");
    iEXP = ConvertPercent(iEXP, 0.10f);
    int iDoOnce = GetLocalInt(oModule, "exe_a3_water10");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "exe_a3_water10", TRUE);
        SetLocalInt(oModule, "A3_WATER", 10);
        AddJournalQuestEntry("a3_water", 10, oPC);
    }
}
