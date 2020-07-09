//::///////////////////////////////////////////////
//:: cac_a2_redtip30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Red-Tip has been defeated once talked to
    he will join the crew.
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
    object oRedTip = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_redtip");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_REDTIP", 30);
    AddJournalQuestEntry("a2_redtip", 30, oPC);
}
