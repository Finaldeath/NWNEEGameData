//::///////////////////////////////////////////////
//:: cac_a2_midrse10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has learned that the Midnight Rose is
    in Port in Spindrift.
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

    int iEXP = GetJournalQuestExperience("a2_midrose");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_midrse10");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_midrse10", TRUE);

        //HandoutQuestXP(oPC, iEXP);

        ExecuteScript("cac_a2_crew10", OBJECT_SELF);
        SetLocalInt(oModule, "A2_MIDROSE", 10);
        AddJournalQuestEntry("a2_midrose", 10, oPC);
    }
}
