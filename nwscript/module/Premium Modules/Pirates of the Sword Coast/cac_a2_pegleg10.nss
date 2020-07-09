//::///////////////////////////////////////////////
//:: cac_a2_pegleg10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have met Peg-Leg Paulson, a regular of
    the Monkeys Sabre. Apparently he's a sailor
    of some reputation, if only you could convince
    him to join the crew of the Skull and Bones.
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

    int iEXP = GetJournalQuestExperience("a2_pegleg");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_pegleg10");
    int iPlot = GetLocalInt(oModule, "A2_PEGLEG");

    if ((iDoOnce == FALSE) && (GetGender(oPC) == GENDER_FEMALE) && (iPlot < 10))
    {
        SetLocalInt(oModule, "cac_a2_pegleg10", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_PEGLEG", 10);
        AddJournalQuestEntry("a2_pegleg", 10, oPC);
    }
}
