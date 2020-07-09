//::///////////////////////////////////////////////
//:: cac_a2_whipd30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Willigan expains the situation to the PC and
    tells them about each item that needs to
    be recovered.
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

    int iEXP = GetJournalQuestExperience("a2_whipd");

    ExecuteScript("exe_a2_wwgarb10", oPC);
    ExecuteScript("exe_a2_wwboot10", oPC);
    ExecuteScript("exe_a2_wwctls10", oPC);

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_WHIPD", 30);
    AddJournalQuestEntry("a2_whipd", 30, oPC);
}
