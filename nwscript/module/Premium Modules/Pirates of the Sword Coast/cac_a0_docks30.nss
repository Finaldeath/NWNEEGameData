//::///////////////////////////////////////////////
//:: cac_a0_docks30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Captain Is ready to set sail. Finish
    up your business before you go.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oAllendry = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a0_docks");
    int iDoOnce = GetLocalInt(oModule, "A0_ESCORTPLOTDONE");

    if (iDoOnce == FALSE)
    {
        //Flag the DoOnce
        SetLocalInt(oModule, "A0_ESCORTPLOTDONE", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A0_DOCKS", 30);
        AddJournalQuestEntry("a0_docks", 30, oPC);
    }
}
