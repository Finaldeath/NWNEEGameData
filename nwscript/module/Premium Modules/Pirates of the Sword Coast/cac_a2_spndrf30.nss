//::///////////////////////////////////////////////
//:: cac_a2_spndrf30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You can enter the Temple of Umberlee in
    Spindrift and interact with the guards and
    priestesses.

    They speak of Tasina's return with the statue,
    but you’re told that you are not allowed to
    meet with her, as she's engaged in an
    important ritual inside.
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
    object oDoor = GetNearestObjectByTag("a2_tmpl_prtclls");

    int iEXP = GetJournalQuestExperience("a2_spndrf");

    SetLocked(oDoor, FALSE);
    DelayCommand(0.5f, AssignCommand(oDoor, ActionOpenDoor(oDoor)));

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_SPNDRF", 30);
    AddJournalQuestEntry("a2_spndrf", 30, oPC);
}
