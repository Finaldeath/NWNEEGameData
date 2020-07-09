//::///////////////////////////////////////////////
//:: exe_a0_siege35
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has found the small porcelain cup that
    will allow them to listen in at Captain
    Allendry's door.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a0_siege");
    iEXP = ConvertPercent(iEXP, 0.0f);
    int iDoOnce = GetLocalInt(oModule, "exe_a0_siege35");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a0_siege35", TRUE);
        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A0_SIEGE", 35);
        AddJournalQuestEntry("a0_siege", 35, oPC);
    }
}
