//::///////////////////////////////////////////////
//:: cac_a2_langer30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    After talking with the Mayor you've convinced
    him to free Langer and Drop the charges.
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
    object oDoor = GetObjectByTag("a2_door_langer");
    int iEXP = GetJournalQuestExperience("a2_langer");

    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));

    TakeGoldFromCreature(100, oPC);
    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_LANGER", 30);
    AddJournalQuestEntry("a2_langer", 30, oPC);
}
