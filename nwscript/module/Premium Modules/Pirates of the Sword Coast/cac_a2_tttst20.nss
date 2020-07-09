//::///////////////////////////////////////////////
//:: cac_a2_tttst20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have paid the Tattooists bail.
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
    object oFalstaffDoor0 = GetObjectByTag("SpindriftTown_Falstaffs", 0);
    object oFalstaffDoor1 = GetObjectByTag("SpindriftTown_Falstaffs", 1);
    object oCellDoor = GetObjectByTag("a2_door_tttst");

    int iEXP = GetJournalQuestExperience("a2_tttst");

    TakeGoldFromCreature(1000, oPC);

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_TTTST", 20);
    AddJournalQuestEntry("a2_tttst", 20, oPC);

    //Unlock the door(s) to Falstaff's Follies
    SetLocked(oCellDoor, FALSE);
    AssignCommand(oCellDoor, ActionOpenDoor(oCellDoor));

    SetLocked(oFalstaffDoor0, FALSE);
    SetLocked(oFalstaffDoor1, FALSE);
}
