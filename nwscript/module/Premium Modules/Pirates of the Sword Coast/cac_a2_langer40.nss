//::///////////////////////////////////////////////
//:: cac_a2_langer40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    After paying Langers Bail the Mayor has given
    Langer his Freedom.
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
    object oDest = GetObjectByTag("WP_A2_PRISON_FREE");
    object oLanger = GetNearestObjectByTag("a2_langer1");

    int iEXP = GetJournalQuestExperience("a2_langer");

    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));

    // pay the bail and jump Langer to the lobby
    TakeGoldFromCreature(10000, oPC);
    AssignCommand(oLanger, JumpToObject(oDest));

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_LANGER", 40);
    AddJournalQuestEntry("a2_langer", 40, oPC);
}
