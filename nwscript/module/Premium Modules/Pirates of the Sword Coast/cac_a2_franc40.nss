//::///////////////////////////////////////////////
//:: cac_a2_franc40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player gotten the impression that
    Pete actually stole his ring from francis
    and is still in possession of it?
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

    int iDoOnce = GetLocalInt(oModule, "cac_a2_franc40");
    int iEXP = GetJournalQuestExperience("a2_franc");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_franc40", TRUE);
        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A2_FRANC", 40);
        AddJournalQuestEntry("a2_franc", 40, oPC);
    }
}
