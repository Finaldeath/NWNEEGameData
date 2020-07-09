//::///////////////////////////////////////////////
//:: ten_a1_native10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has stumbled across the corpse of
    a fellow sailor.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = GetEnteringObject();
    int iEXP = GetJournalQuestExperience("a1_natives");
    int iDoOnce = GetLocalInt(oModule, "ten_a1_native10");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "ten_a1_native10", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_NATIVES", 10);
        AddJournalQuestEntry("a1_natives", 10, oPC);
    }
}
