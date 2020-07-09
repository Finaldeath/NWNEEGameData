//::///////////////////////////////////////////////
//:: cac_a2_redtip20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Red Tip has told you that the only way he'll
    leave Spindrift is if you beat him in the
    ring.
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
    int iDoOnce = GetLocalInt(oModule, "cac_a2_redtip20");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_redtip20", TRUE);
        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A2_REDTIP", 20);
        AddJournalQuestEntry("a2_redtip", 20, oPC);
    }
}
